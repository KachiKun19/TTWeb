package com.kachikun.shop.dao;

import com.kachikun.shop.model.User;
import com.kachikun.shop.model.DailyStat;
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.Order;
import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.utils.DBConnection;

import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO {

	// ── Tạo đơn hàng mới ──────────────────────────────────────────────────────
	public boolean createOrder(User user, List<CartItem> cart, double totalPrice,
							   String fullname, String phone, String address,
							   String paymentMethod) {
		String sqlOrder  = "INSERT INTO Orders (user_id, total_price, status, order_date, "
				+ "recipient_name, recipient_phone, shipping_address, payment_method) "
				+ "VALUES (?, ?, N'Đang xử lý', GETDATE(), ?, ?, ?, ?)";
		String sqlDetail = "INSERT INTO OrderDetails (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
		String sqlStock  = "UPDATE Products SET stock_quantity = stock_quantity - ? WHERE id = ?";

		try (Connection conn = DBConnection.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement psOrder  = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
				 PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
				 PreparedStatement psStock  = conn.prepareStatement(sqlStock)) {

				psOrder.setInt(1, user.getId());
				psOrder.setDouble(2, totalPrice);
				psOrder.setString(3, fullname);
				psOrder.setString(4, phone);
				psOrder.setString(5, address);
				psOrder.setString(6, paymentMethod);
				psOrder.executeUpdate();

				ResultSet rs = psOrder.getGeneratedKeys();
				if (rs.next()) {
					int orderId = rs.getInt(1);
					for (CartItem item : cart) {
						psDetail.setInt(1, orderId);
						psDetail.setInt(2, item.getProduct().getId());
						psDetail.setDouble(3, item.getProduct().getPrice());
						psDetail.setInt(4, item.getQuantity());
						psDetail.addBatch();

						psStock.setInt(1, item.getQuantity());
						psStock.setInt(2, item.getProduct().getId());
						psStock.addBatch();
					}
					psDetail.executeBatch();
					psStock.executeBatch();
				}
				conn.commit();
				return true;
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) { e.printStackTrace(); }
		return false;
	}

	// ── Admin cập nhật trạng thái (có validate flow hợp lệ) ──────────────────
	/**
	 * Chuyển trạng thái đơn hàng theo đúng chiều flow:
	 *   Đang xử lý → Đang giao hàng → Đã giao → Hoàn thành
	 * Ghi nhận shipped_at / delivered_at tự động.
	 * Trả về false nếu chuyển sai chiều hoặc không tìm thấy đơn.
	 */
	public boolean adminUpdateStatus(int orderId, String newStatus) {
		// 1. Lấy status hiện tại
		String currentStatus = getStatusById(orderId);
		if (currentStatus == null) return false;

		// 2. Validate chiều chuyển trạng thái hợp lệ
		if (!isValidTransition(currentStatus, newStatus)) return false;

		// 3. Build câu UPDATE kèm timestamp nếu cần
		StringBuilder sql = new StringBuilder("UPDATE Orders SET status = ?");
		if (Order.STATUS_SHIPPING.equals(newStatus)) {
			sql.append(", shipped_at = GETDATE()");
		} else if (Order.STATUS_DELIVERED.equals(newStatus)
				|| Order.STATUS_COMPLETED.equals(newStatus)) {
			sql.append(", delivered_at = GETDATE()");
		}
		sql.append(" WHERE id = ?");

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			ps.setString(1, newStatus);
			ps.setInt(2, orderId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/** Kiểm tra chuyển trạng thái có hợp lệ không */
	private boolean isValidTransition(String current, String next) {
		switch (current) {
			case "Đang xử lý":    return "Đang giao hàng".equals(next) || "Đã hủy".equals(next);
			case "Đang giao hàng": return "Đã giao".equals(next);
			case "Đã giao":        return "Hoàn thành".equals(next);
			default: return false; // Đã hủy / Hoàn thành không thể chuyển tiếp
		}
	}

	/** Lấy trạng thái hiện tại của đơn */
	private String getStatusById(int orderId) {
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(
					 "SELECT status FROM Orders WHERE id = ?")) {
			ps.setInt(1, orderId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) return rs.getString("status");
		} catch (Exception e) { e.printStackTrace(); }
		return null;
	}

	// ── updateStatus (giữ lại tương thích với code cũ) ────────────────────────
	public boolean updateStatus(int orderId, String status) {
		return adminUpdateStatus(orderId, status);
	}

	// ── User hủy đơn (chỉ khi "Đang xử lý") + hoàn stock ────────────────────
	public boolean userCancelOrder(int orderId, int userId) {
		return userCancelOrder(orderId, userId, null);
	}

	public boolean userCancelOrder(int orderId, int userId, String reason) {
		String sqlUpdate   = "UPDATE Orders SET status = N'Đã hủy', cancel_reason = ? "
				+ "WHERE id = ? AND user_id = ? AND status = N'Đang xử lý'";
		String sqlGetItems = "SELECT product_id, quantity FROM OrderDetails WHERE order_id = ?";
		String sqlRestock  = "UPDATE Products SET stock_quantity = stock_quantity + ? WHERE id = ?";

		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			// 1. Cập nhật trạng thái + lý do hủy
			try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
				ps.setString(1, reason != null ? reason : "Khách hủy đơn");
				ps.setInt(2, orderId);
				ps.setInt(3, userId);
				if (ps.executeUpdate() == 0) { conn.rollback(); return false; }
			}

			// 2. Lấy danh sách sản phẩm trong đơn
			List<OrderDetail> items = new ArrayList<>();
			try (PreparedStatement ps = conn.prepareStatement(sqlGetItems)) {
				ps.setInt(1, orderId);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					OrderDetail d = new OrderDetail();
					Product p = new Product();
					p.setId(rs.getInt("product_id"));
					d.setProduct(p);
					d.setQuantity(rs.getInt("quantity"));
					items.add(d);
				}
			}

			// 3. Hoàn kho từng sản phẩm (batch)
			try (PreparedStatement ps = conn.prepareStatement(sqlRestock)) {
				for (OrderDetail item : items) {
					ps.setInt(1, item.getQuantity());
					ps.setInt(2, item.getProduct().getId());
					ps.addBatch();
				}
				ps.executeBatch();
			}

			conn.commit();
			return true;

		} catch (Exception e) {
			if (conn != null) try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return false;
	}

	// ── Admin hủy đơn (mọi trạng thái trừ Đã giao / Hoàn thành) + hoàn stock ─
	public boolean adminCancelOrder(int orderId, String reason) {
		String sqlUpdate   = "UPDATE Orders SET status = N'Đã hủy', cancel_reason = ? "
				+ "WHERE id = ? AND status NOT IN (N'Đã giao', N'Hoàn thành', N'Đã hủy')";
		String sqlGetItems = "SELECT product_id, quantity FROM OrderDetails WHERE order_id = ?";
		String sqlRestock  = "UPDATE Products SET stock_quantity = stock_quantity + ? WHERE id = ?";

		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
				ps.setString(1, reason != null ? reason : "Admin hủy đơn");
				ps.setInt(2, orderId);
				if (ps.executeUpdate() == 0) { conn.rollback(); return false; }
			}

			List<OrderDetail> items = new ArrayList<>();
			try (PreparedStatement ps = conn.prepareStatement(sqlGetItems)) {
				ps.setInt(1, orderId);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					OrderDetail d = new OrderDetail();
					Product p = new Product();
					p.setId(rs.getInt("product_id"));
					d.setProduct(p);
					d.setQuantity(rs.getInt("quantity"));
					items.add(d);
				}
			}

			try (PreparedStatement ps = conn.prepareStatement(sqlRestock)) {
				for (OrderDetail item : items) {
					ps.setInt(1, item.getQuantity());
					ps.setInt(2, item.getProduct().getId());
					ps.addBatch();
				}
				ps.executeBatch();
			}

			conn.commit();
			return true;
		} catch (Exception e) {
			if (conn != null) try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
			e.printStackTrace();
		} finally {
			if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return false;
	}

	// ── Lấy chi tiết đơn hàng ────────────────────────────────────────────────
	public List<OrderDetail> getOrderDetail(int orderId) {
		List<OrderDetail> list = new ArrayList<>();
		String sql = "SELECT d.*, p.name, p.image "
				+ "FROM OrderDetails d "
				+ "INNER JOIN Products p ON d.product_id = p.id "
				+ "WHERE d.order_id = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, orderId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				OrderDetail detail = new OrderDetail();
				detail.setId(rs.getInt("id"));
				detail.setPrice(rs.getDouble("price"));
				detail.setQuantity(rs.getInt("quantity"));

				Product p = new Product();
				p.setId(rs.getInt("product_id"));
				p.setName(rs.getString("name"));
				p.setImage(rs.getString("image"));
				detail.setProduct(p);
				list.add(detail);
			}
		} catch (Exception e) { e.printStackTrace(); }
		return list;
	}

	// ── Map helper: đọc 3 cột mới vào Order ────────────────────────────────
	private Order mapOrder(ResultSet rs) throws Exception {
		Order o = new Order();
		o.setId(rs.getInt("id"));
		o.setTotalPrice(rs.getDouble("total_price"));
		o.setStatus(rs.getString("status"));
		o.setOrderDate(rs.getDate("order_date"));
		o.setRecipientName(rs.getString("recipient_name"));
		o.setRecipientPhone(rs.getString("recipient_phone"));
		o.setShippingAddress(rs.getString("shipping_address"));
		o.setPaymentMethod(rs.getString("payment_method"));

		// Các cột mới — dùng try/catch phòng khi chưa migrate DB
		try { o.setShippedAt(rs.getTimestamp("shipped_at")); }    catch (Exception ignored) {}
		try { o.setDeliveredAt(rs.getTimestamp("delivered_at")); } catch (Exception ignored) {}
		try { o.setCancelReason(rs.getString("cancel_reason")); }  catch (Exception ignored) {}

		User u = new User();
		try { u.setId(rs.getInt("user_id")); } catch (Exception ignored) {}
		o.setUser(u);
		return o;
	}

	// ── Lấy tất cả đơn (Admin) ───────────────────────────────────────────────
	public List<Order> getAllOrders() {
		List<Order> list = new ArrayList<>();
		String sql = "SELECT * FROM Orders ORDER BY order_date DESC";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) list.add(mapOrder(rs));
		} catch (Exception e) { e.printStackTrace(); }
		return list;
	}

	// ── Lấy đơn theo ID ─────────────────────────────────────────────────────
	public Order getOrderById(int id) {
		String sql = "SELECT * FROM Orders WHERE id = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) return mapOrder(rs);
		} catch (Exception e) { e.printStackTrace(); }
		return null;
	}

	// ── Lấy đơn của user (lịch sử mua hàng) ─────────────────────────────────
	public List<Order> getOrdersByUserId(int userId) {
		List<Order> list = new ArrayList<>();
		String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY id DESC";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) list.add(mapOrder(rs));
		} catch (Exception e) { e.printStackTrace(); }
		return list;
	}

	// ── Lấy đơn theo tháng / năm (Export) ───────────────────────────────────
	public List<Order> getOrdersByMonthYear(int month, int year) {
		List<Order> list = new ArrayList<>();
		String sql = "SELECT * FROM Orders "
				+ "WHERE MONTH(order_date)=? AND YEAR(order_date)=? "
				+ "ORDER BY order_date DESC";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, month);
			ps.setInt(2, year);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) list.add(mapOrder(rs));
		} catch (Exception e) { e.printStackTrace(); }
		return list;
	}

	// ── Thống kê ─────────────────────────────────────────────────────────────
	public Map<String, Double> getRevenueLast12Months() {
		Map<String, Double> map = new LinkedHashMap<>();
		String sql = "SELECT FORMAT(order_date,'MM/yyyy') as month_year, SUM(total_price) as total "
				+ "FROM Orders "
				+ "WHERE status IN (N'Đã giao',N'Hoàn thành') "
				+ "GROUP BY FORMAT(order_date,'MM/yyyy'), YEAR(order_date), MONTH(order_date) "
				+ "ORDER BY YEAR(order_date) DESC, MONTH(order_date) DESC";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) map.put(rs.getString("month_year"), rs.getDouble("total"));
		} catch (Exception e) { e.printStackTrace(); }
		return map;
	}

	public int getTodayOrdersCount() {
		String sql = "SELECT COUNT(*) FROM Orders "
				+ "WHERE CAST(order_date AS DATE)=? AND status IN (N'Đã giao',N'Hoàn thành')";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDate(1, Date.valueOf(LocalDate.now()));
			ResultSet rs = ps.executeQuery();
			if (rs.next()) return rs.getInt(1);
		} catch (Exception e) { e.printStackTrace(); }
		return 0;
	}

	public double getTodayRevenue() {
		String sql = "SELECT SUM(total_price) FROM Orders "
				+ "WHERE CAST(order_date AS DATE)=? AND status IN (N'Đã giao',N'Hoàn thành')";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDate(1, Date.valueOf(LocalDate.now()));
			ResultSet rs = ps.executeQuery();
			if (rs.next()) return rs.getDouble(1);
		} catch (Exception e) { e.printStackTrace(); }
		return 0;
	}

	public List<DailyStat> getDailyStatistics(int month, int year) {
		List<DailyStat> list = new ArrayList<>();
		String sql = "SELECT DAY(order_date) as day, COUNT(id) as count, SUM(total_price) as total "
				+ "FROM Orders "
				+ "WHERE MONTH(order_date)=? AND YEAR(order_date)=? "
				+ "AND status IN (N'Đã giao',N'Hoàn thành') "
				+ "GROUP BY DAY(order_date) ORDER BY day ASC";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, month);
			ps.setInt(2, year);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				list.add(new DailyStat(rs.getInt("day"), rs.getInt("count"), rs.getDouble("total")));
		} catch (Exception e) { e.printStackTrace(); }
		return list;
	}

	public int getLastMonthOrdersCount() {
		String sql = "SELECT COUNT(*) FROM Orders "
				+ "WHERE MONTH(order_date)=MONTH(DATEADD(month,-1,GETDATE())) "
				+ "AND YEAR(order_date)=YEAR(DATEADD(month,-1,GETDATE())) "
				+ "AND status IN (N'Đã giao',N'Hoàn thành')";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			if (rs.next()) return rs.getInt(1);
		} catch (Exception e) { e.printStackTrace(); }
		return 0;
	}

	public Map<String, Double> getMonthlyRevenue(int months) {
		Map<String, Double> map = new LinkedHashMap<>();
		String sql = "SELECT FORMAT(order_date,'yyyy-MM') as month, SUM(total_price) as revenue "
				+ "FROM Orders "
				+ "WHERE status IN (N'Đã giao',N'Hoàn thành') "
				+ "AND order_date >= DATEADD(month,-?,GETDATE()) "
				+ "GROUP BY FORMAT(order_date,'yyyy-MM') ORDER BY month DESC";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, months);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) map.put(rs.getString("month"), rs.getDouble("revenue"));
		} catch (Exception e) { e.printStackTrace(); }
		return map;
	}
}