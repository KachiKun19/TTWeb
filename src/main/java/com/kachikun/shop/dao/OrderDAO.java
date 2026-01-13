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
	public boolean createOrder(User user, List<CartItem> cart, double totalPrice, String fullname, String phone,
			String address, String paymentMethod) {
		Connection conn = null;
		PreparedStatement psOrder = null;
		PreparedStatement psDetail = null;
		PreparedStatement psStock = null; // --- [MỚI] Khai báo thêm cái này
		boolean result = false;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // Bắt đầu Transaction

			// 1. INSERT VÀO BẢNG ORDERS
			String sqlOrder = "INSERT INTO Orders (user_id, total_price, status, order_date, recipient_name, recipient_phone, shipping_address, payment_method) VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?)";

			psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
			psOrder.setInt(1, user.getId());
			psOrder.setDouble(2, totalPrice);
			psOrder.setString(3, "Đang xử lý");
			psOrder.setString(4, fullname);
			psOrder.setString(5, phone);
			psOrder.setString(6, address);
			psOrder.setString(7, paymentMethod);

			psOrder.executeUpdate();

			// Lấy ID đơn hàng vừa tạo
			ResultSet rs = psOrder.getGeneratedKeys();
			int orderId = 0;
			if (rs.next()) {
				orderId = rs.getInt(1);
			}

			// 2. INSERT VÀO ORDER DETAILS VÀ TRỪ KHO
			if (orderId > 0 && cart != null) {
				String sqlDetail = "INSERT INTO OrderDetails (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";

				// --- [MỚI] Chuẩn bị câu lệnh trừ kho
				String sqlUpdateStock = "UPDATE Products SET stock_quantity = stock_quantity - ? WHERE id = ?";

				psDetail = conn.prepareStatement(sqlDetail);
				psStock = conn.prepareStatement(sqlUpdateStock); // --- [MỚI]

				for (CartItem item : cart) {
					// A. Lưu chi tiết đơn hàng
					psDetail.setInt(1, orderId);
					psDetail.setInt(2, item.getProduct().getId());
					psDetail.setDouble(3, item.getProduct().getPrice());
					psDetail.setInt(4, item.getQuantity());
					psDetail.addBatch(); // Gom lệnh lại chạy 1 lần

					// B. --- [MỚI] TRỪ TỒN KHO ---
					psStock.setInt(1, item.getQuantity()); // Trừ đi số lượng khách mua
					psStock.setInt(2, item.getProduct().getId()); // Của sản phẩm ID này
					psStock.executeUpdate(); // Chạy lệnh trừ ngay lập tức
				}

				psDetail.executeBatch(); // Chạy batch insert details
			}

			// Mọi thứ ok thì lưu lại (Commit)
			conn.commit();
			result = true;
			System.out.println("Tạo đơn hàng thành công! Mã đơn: " + orderId);

		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (conn != null)
					conn.rollback();
				System.out.println("Đơn hàng đã bị hủy do lỗi.");
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} finally {
			// Đóng kết nối
			try {
				if (psStock != null)
					psStock.close();
				if (psDetail != null)
					psDetail.close();
				if (psOrder != null)
					psOrder.close();
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return result;
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

				// Set thông tin người nhận
				o.setRecipientName(rs.getString("recipient_name"));
				o.setRecipientPhone(rs.getString("recipient_phone"));
				o.setShippingAddress(rs.getString("shipping_address"));
				o.setPaymentMethod(rs.getString("payment_method"));

				// Xử lý user (chỉ cần lấy ID để biết user nào đặt, nếu cần tên account thì join
				// thêm)
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

	// Lấy thông tin 1 đơn hàng
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
		String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY id DESC"; // Đơn mới nhất lên đầu
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

	public boolean userCancelOrder(int orderId) {
		String sql = "UPDATE Orders SET status = N'Đã hủy' WHERE id = ? AND status = N'Đang xử lý'";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, orderId);
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static void main(String[] args) {
		OrderDAO dao = new OrderDAO();
//		User u = new User();
//		u.setId(1);
//		
//		List<OrderDetail> giohang = new ArrayList<>();
//		
//		Product iphone = new Product();
//		iphone.setId(1);
//		
//		OrderDetail item = new OrderDetail();
//		item.setProduct(iphone);
//		item.setPrice(30000);
//		item.setQuantity(2);
//		
//		giohang.add(item);
//		
//		dao.createOrder(u, giohang, 60000);

		int orderxem = 1;
		List<OrderDetail> detail = dao.getOrderDetail(orderxem);
		System.out.println("--- Chi tiết đơn hàng: ---");
		for (OrderDetail d : detail) {
			System.out.println("Sản phẩm: " + d.getProduct().getName());
			System.out.println("Số lượng: " + d.getQuantity());
			System.out.println("Giá lúc mua: " + d.getPrice());
			System.out.println("-----------------");
		}
	}
	
	public Map<String, Double> getRevenueLast12Months() {
	    // LinkedHashMap để giữ thứ tự tháng (Tháng cũ trước, tháng mới sau hoặc ngược lại)
	    Map<String, Double> map = new LinkedHashMap<>();
	    
	    // Query lấy 12 tháng gần nhất, tính tổng tiền những đơn "Hoàn thành" hoặc "Đã giao"
	    String sql = "SELECT FORMAT(order_date, 'MM/yyyy') as month_year, SUM(total_price) as total " +
	                 "FROM Orders " +
	                 "WHERE status IN (N'Đã giao', N'Hoàn thành') " +
	                 "GROUP BY FORMAT(order_date, 'MM/yyyy'), YEAR(order_date), MONTH(order_date) " +
	                 "ORDER BY YEAR(order_date) DESC, MONTH(order_date) DESC";
	    
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
			ps.setDate(1, Date.valueOf(today)); // Chuyển LocalDate sang SQL Date

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
	    
	    // Query: Gom nhóm theo NGÀY trong tháng được chọn
	    String sql = "SELECT DAY(order_date) as day, COUNT(id) as count, SUM(total_price) as total " +
	                 "FROM Orders " +
	                 "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ? " +
	                 "AND status IN (N'Đã giao', N'Hoàn thành') " +
	                 "GROUP BY DAY(order_date) " +
	                 "ORDER BY day ASC";
	    
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, month);
	        ps.setInt(2, year);
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            list.add(new DailyStat(
	                rs.getInt("day"),
	                rs.getInt("count"),
	                rs.getDouble("total")
	            ));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public List<Order> getOrdersByMonthYear(int month, int year) {
	    List<Order> list = new ArrayList<>();
	    
	    // Câu lệnh SQL lấy dữ liệu
	    String sql = "SELECT * FROM Orders " +
	                 "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ? " +
	                 "ORDER BY order_date DESC";
	    
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, month);
	        ps.setInt(2, year);
	        
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Order o = new Order();
	            o.setId(rs.getInt("id"));
	            
	            // 1. SỬA LỖI USER: Tạo đối tượng User giả để hứng ID
	            // (Vì model của bạn là private User user)
	            User u = new User();
	            if (hasColumn(rs, "user_id")) {
	                u.setId(rs.getInt("user_id"));
	                // Nếu muốn lấy cả tên user thì phải JOIN bảng, 
	                // nhưng tạm thời chỉ cần ID để link hoặc export là đủ.
	            }
	            o.setUser(u); // Set đối tượng User vào Order

	            // 2. SỬA LỖI NGÀY THÁNG: Dùng rs.getDate để khớp với java.sql.Date
	            o.setOrderDate(rs.getDate("order_date")); 
	            
	            o.setTotalPrice(rs.getDouble("total_price"));
	            o.setStatus(rs.getString("status"));
	            
	            // Các thông tin người nhận
	            o.setRecipientName(rs.getString("recipient_name"));
	            o.setRecipientPhone(rs.getString("recipient_phone"));
	            
	            // 3. SỬA LỖI ĐỊA CHỈ: Dùng setShippingAddress
	            // (Kiểm tra xem trong DB cột tên là 'address' hay 'shipping_address')
	            if (hasColumn(rs, "address")) {
	                o.setShippingAddress(rs.getString("address"));
	            } else if (hasColumn(rs, "shipping_address")) {
	                o.setShippingAddress(rs.getString("shipping_address"));
	            }

	            // Payment method
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

	// Hàm phụ trợ check cột (Giữ nguyên như cũ)
	private boolean hasColumn(ResultSet rs, String columnName) {
	    try {
	        rs.findColumn(columnName);
	        return true;
	    } catch (Exception e) {
	        return false;
	    }
	}
}