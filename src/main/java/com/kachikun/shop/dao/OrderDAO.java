package com.kachikun.shop.dao;

import com.kachikun.shop.model.User;
import com.kachikun.shop.model.DailyStat;
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.Order;
import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.utils.DBConnection;

import java.sql.Statement;
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
	public boolean createOrder(User user, List<CartItem> cart, double totalPrice, String fullname, String phone, String address, String paymentMethod) {
        String sqlOrder = "INSERT INTO Orders (user_id, total_price, status, order_date, recipient_name, recipient_phone, shipping_address, payment_method) VALUES (?, ?, N'Đang xử lý', GETDATE(), ?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO OrderDetails (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
        String sqlUpdateStock = "UPDATE Products SET stock_quantity = stock_quantity - ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
                 PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
                 PreparedStatement psStock = conn.prepareStatement(sqlUpdateStock)) {
                
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

	public boolean updateStatus(int orderId, String status) {
		String sql = "UPDATE Orders SET status = ? WHERE id = ?";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, status);
			ps.setInt(2, orderId);

			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<OrderDetail> getOrderDetail(int orderId) {
		List<OrderDetail> list = new ArrayList<>();

		String sql = "SELECT d.*, p.name, p.image " + "FROM OrderDetails d "
				+ "INNER JOIN Products p ON d.product_id = p.id " + "WHERE d.order_id = ? ";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);

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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Order> getAllOrders() {
		List<Order> list = new ArrayList<>();
		String sql = "SELECT * FROM Orders ORDER BY order_date DESC";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Order o = new Order();
				o.setId(rs.getInt("id"));
				o.setTotalPrice(rs.getDouble("total_price"));
				o.setStatus(rs.getString("status"));
				o.setOrderDate(rs.getDate("order_date"));

				o.setRecipientName(rs.getString("recipient_name"));
				o.setRecipientPhone(rs.getString("recipient_phone"));
				o.setShippingAddress(rs.getString("shipping_address"));
				o.setPaymentMethod(rs.getString("payment_method"));

				User u = new User();
				u.setId(rs.getInt("user_id"));
				o.setUser(u);

				list.add(o);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Order getOrderById(int id) {
		String sql = "SELECT * FROM Orders WHERE id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Order o = new Order();
				o.setId(rs.getInt("id"));
				o.setTotalPrice(rs.getDouble("total_price"));
				o.setStatus(rs.getString("status"));
				o.setOrderDate(rs.getDate("order_date"));
				o.setRecipientName(rs.getString("recipient_name"));
				o.setRecipientPhone(rs.getString("recipient_phone"));
				o.setShippingAddress(rs.getString("shipping_address"));
				o.setPaymentMethod(rs.getString("payment_method"));

				User u = new User();
				u.setId(rs.getInt("user_id"));
				o.setUser(u);
				return o;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi ở OrderDAO: " + e.getMessage());
		}
		return null;
	}

	public List<Order> getOrdersByUserId(int userId) {
		List<Order> list = new ArrayList<>();
		String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY id DESC";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Order o = new Order();
				o.setId(rs.getInt("id"));
				o.setOrderDate(rs.getDate("order_date"));
				o.setTotalPrice(rs.getDouble("total_price"));
				o.setStatus(rs.getString("status"));
				o.setRecipientName(rs.getString("recipient_name"));
				o.setRecipientPhone(rs.getString("recipient_phone"));
				o.setShippingAddress(rs.getString("shipping_address"));
				o.setPaymentMethod(rs.getString("payment_method"));
				list.add(o);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean userCancelOrder(int orderId, int userId) {
        String sql = "UPDATE Orders SET status = N'Đã hủy' WHERE id = ? AND user_id = ? AND status = N'Đang xử lý'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

	public Map<String, Double> getRevenueLast12Months() {

		Map<String, Double> map = new LinkedHashMap<>();

		String sql = "SELECT FORMAT(order_date, 'MM/yyyy') as month_year, SUM(total_price) as total " + "FROM Orders "
				+ "WHERE status IN (N'Đã giao', N'Hoàn thành') "
				+ "GROUP BY FORMAT(order_date, 'MM/yyyy'), YEAR(order_date), MONTH(order_date) "
				+ "ORDER BY YEAR(order_date) DESC, MONTH(order_date) DESC";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				map.put(rs.getString("month_year"), rs.getDouble("total"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	public int getTodayOrdersCount() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM Orders WHERE CAST(order_date AS DATE) = ? AND status IN (N'Đã giao', N'Hoàn thành')";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			LocalDate today = LocalDate.now();
			ps.setDate(1, Date.valueOf(today));

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public double getTodayRevenue() {
		double revenue = 0.0;
		String sql = "SELECT SUM(total_price) FROM Orders WHERE CAST(order_date AS DATE) = ? AND status IN (N'Đã giao', N'Hoàn thành')";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			LocalDate today = LocalDate.now();
			ps.setDate(1, Date.valueOf(today));

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				revenue = rs.getDouble(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return revenue;
	}

	public Map<String, Double> getMonthlyRevenue(int months) {
		Map<String, Double> monthlyRevenue = new LinkedHashMap<>();
		String sql = "SELECT FORMAT(order_date, 'yyyy-MM') as month, SUM(total_price) as revenue " + "FROM Orders "
				+ "WHERE status IN (N'Đã giao', N'Hoàn thành') " + "AND order_date >= DATEADD(month, -?, GETDATE()) "
				+ "GROUP BY FORMAT(order_date, 'yyyy-MM') " + "ORDER BY month DESC";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, months);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String month = rs.getString("month");
				double revenue = rs.getDouble("revenue");
				monthlyRevenue.put(month, revenue);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return monthlyRevenue;
	}

	public int getLastMonthOrdersCount() {
		int count = 0;
		String sql = "SELECT COUNT(*) as count FROM Orders "
				+ "WHERE MONTH(order_date) = MONTH(DATEADD(month, -1, GETDATE())) "
				+ "AND YEAR(order_date) = YEAR(DATEADD(month, -1, GETDATE())) "
				+ "AND status IN (N'Đã giao', N'Hoàn thành')";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public List<DailyStat> getDailyStatistics(int month, int year) {
		List<DailyStat> list = new ArrayList<>();

		String sql = "SELECT DAY(order_date) as day, COUNT(id) as count, SUM(total_price) as total " + "FROM Orders "
				+ "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ? " + "AND status IN (N'Đã giao', N'Hoàn thành') "
				+ "GROUP BY DAY(order_date) " + "ORDER BY day ASC";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, month);
			ps.setInt(2, year);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new DailyStat(rs.getInt("day"), rs.getInt("count"), rs.getDouble("total")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Order> getOrdersByMonthYear(int month, int year) {
		List<Order> list = new ArrayList<>();

		String sql = "SELECT * FROM Orders " + "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ? "
				+ "ORDER BY order_date DESC";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, month);
			ps.setInt(2, year);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Order o = new Order();
				o.setId(rs.getInt("id"));

				User u = new User();
				if (hasColumn(rs, "user_id")) {
					u.setId(rs.getInt("user_id"));

				}
				o.setUser(u);

				o.setOrderDate(rs.getDate("order_date"));

				o.setTotalPrice(rs.getDouble("total_price"));
				o.setStatus(rs.getString("status"));

				o.setRecipientName(rs.getString("recipient_name"));
				o.setRecipientPhone(rs.getString("recipient_phone"));

				if (hasColumn(rs, "address")) {
					o.setShippingAddress(rs.getString("address"));
				} else if (hasColumn(rs, "shipping_address")) {
					o.setShippingAddress(rs.getString("shipping_address"));
				}

				if (hasColumn(rs, "payment_method")) {
					o.setPaymentMethod(rs.getString("payment_method"));
				}

				list.add(o);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	private boolean hasColumn(ResultSet rs, String columnName) {
		try {
			rs.findColumn(columnName);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}