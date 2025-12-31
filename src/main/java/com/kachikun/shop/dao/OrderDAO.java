package com.kachikun.shop.dao;

import com.kachikun.shop.model.User;
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.Order;
import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.utils.DBConnection;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public boolean createOrder(User user, List<CartItem> cart, double totalPrice, String fullname, String phone, String address, String paymentMethod) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        boolean result = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); 

            // 1. INSERT VÀO BẢNG ORDERS
            // Cập nhật SQL thêm 4 cột mới: recipient_name, recipient_phone, shipping_address, payment_method
            String sqlOrder = "INSERT INTO Orders (user_id, total_price, status, order_date, recipient_name, recipient_phone, shipping_address, payment_method) VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?)";
            
            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, user.getId());
            psOrder.setDouble(2, totalPrice);
            psOrder.setString(3, "Đang xử lý"); // Status mặc định
            
            // Set giá trị cho 4 cột mới
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

            // 2. INSERT VÀO ORDER DETAILS
            if (orderId > 0 && cart != null) {
                String sqlDetail = "INSERT INTO OrderDetails (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
                psDetail = conn.prepareStatement(sqlDetail);

                for (CartItem item : cart) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, item.getProduct().getId()); // Lấy ID sản phẩm từ CartItem
                    psDetail.setDouble(3, item.getProduct().getPrice()); // Lấy giá
                    psDetail.setInt(4, item.getQuantity()); // Lấy số lượng

                    psDetail.addBatch();
                }
                psDetail.executeBatch();
            }

            // Mọi thứ ok thì lưu lại (Commit)
            conn.commit();
            result = true;
            System.out.println("Tạo đơn hàng thành công! Mã đơn: " + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // Có lỗi thì hoàn tác
                System.out.println("Đơn hàng đã bị hủy do lỗi.");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {}
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
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public List<OrderDetail> getOrderDetail(int orderId) {
		List<OrderDetail> list = new ArrayList<>();
		
		String sql = "SELECT d.*, p.name, p.image " + 
					 "FROM OrderDetails d " +
					 "INNER JOIN Products p ON d.product_id = p.id " +
					 "WHERE d.order_id = ? ";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			
			ps.setInt(1, orderId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
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
		}
	catch (Exception e) {
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
	        
	        while(rs.next()) {
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
	            
	            // Xử lý user (chỉ cần lấy ID để biết user nào đặt, nếu cần tên account thì join thêm)
	            User u = new User();
	            u.setId(rs.getInt("user_id"));
	            o.setUser(u);
	            
	            list.add(o);
	        }
	    } catch(Exception e) {
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
	        if(rs.next()) {
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
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return null;
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
		for(OrderDetail d : detail) {
			System.out.println("Sản phẩm: " + d.getProduct().getName());
			System.out.println("Số lượng: " + d.getQuantity());
			System.out.println("Giá lúc mua: " + d.getPrice());
			System.out.println("-----------------");
		}
	}
}
