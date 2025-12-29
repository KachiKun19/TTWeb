package com.kachikun.shop.dao;

import com.kachikun.shop.model.User;
import com.kachikun.shop.utils.DBConnection;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.Product;

public class OrderDAO {
	public boolean createOrder(User user, List<OrderDetail> cart, double totalPrice ) {
		Connection conn = null;
		PreparedStatement psOrder = null;
		PreparedStatement psDetail = null;
		boolean result = false;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			
			String sqlOrder = "INSERT INTO Orders (user_id, total_price, status, order_date) VALUES (?, ?, ?, GETDATE())";
			psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
			psOrder.setInt(1, user.getId());
			psOrder.setDouble(2, totalPrice);
			psOrder.setString(3, "Đang xử lí");
			
			psOrder.executeUpdate();
			
			ResultSet rs = psOrder.getGeneratedKeys();
			int orderId = 0;
			if(rs.next()) {
				orderId = rs.getInt(1);
			}
			
			if(orderId > 0 && cart != null) {
				String sqlDetail = "INSERT INTO OrderDetails (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
				psDetail = conn.prepareStatement(sqlDetail);
				
				for(OrderDetail item : cart) {
					psDetail.setInt(1, orderId);
					psDetail.setInt(2, item.getProduct().getId());
					psDetail.setDouble(3, item.getPrice());
					psDetail.setInt(4, item.getQuantity());
					
					psDetail.addBatch();
				}
				psDetail.executeBatch();
			}
			// ktra có lỗi gì ko rồi mới lưu
			conn.commit();
			result = true;
			System.out.println("Tạo đơn hàng thành công! Mã đơn: " + orderId);
		}
		catch(Exception e) {
			e.printStackTrace();
			// nếu thấy lỗi thì gọi rollback để xóa dữ liệu 
			try {
				if(conn != null) conn.rollback();
				System.out.println("Đơn hàng đã bị hủy");	
			}catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		finally {
			//Đóng kết nối
			try {
				if(conn != null) conn.setAutoCommit(true);
				if(conn != null) conn.close();
			}catch(Exception e){}
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
