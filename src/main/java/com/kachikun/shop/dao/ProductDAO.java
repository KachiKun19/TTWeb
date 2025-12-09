package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.utils.DBConnection;
import com.kachikun.shop.model.Category;

public class ProductDAO {
	public List<Product> getAllProducts()	{
		List<Product> list = new ArrayList<>();
		String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " +
					 "FROM Products p " +
					 "INNER JOIN Categories c ON p.category_id = c.id " +
					 "INNER JOIN Brands b ON p.brand_id = b.id";
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescription(rs.getString("description"));
				p.setImage(rs.getString("image"));
				p.setStock(rs.getInt("stock_quantity"));
				p.setPrice(rs.getDouble("price"));
				
				Category c = new Category();
				c.setId(rs.getInt("category_id"));
				c.setName(rs.getString("cat_name"));
				p.setCategory(c);
				
				Brand b = new Brand();
				b.setId(rs.getInt("brand_id"));
				b.setName(rs.getString("brand_name"));
				b.setLogo(rs.getString("brand_logo"));
				p.setBrand(b);
				
				list.add(p);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	// vd tìm mouse từ Category từ việc lấy hết thông tin Product
	public List<Product> findByCategoryName(String categoryName)	{
		List<Product> list = new ArrayList<>();
		String sql = "SELECT p.* FROM Products p " +
					 "INNER JOIN Categories c ON p.category_id = c.id " + 
					 "WHERE c.name LIKE ? ";
		
		try {
			Connection conn = new DBConnection().getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			// tìm thành phần có chưa mouse
			ps.setString(1, "%" + categoryName + "%");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				// tạo category
				Category c = new Category();
	            c.setId(rs.getInt("category_id"));
	            // tạo brand
	            Brand b = new Brand();
	            b.setId(rs.getInt("brand_id"));
	            //tạo product
				Product p = new Product(
						rs.getInt("id"), 
						rs.getString("name"), 
						rs.getString("image"), 
						rs.getDouble("price"), 
						rs.getString("description"), 
						rs.getInt("stock_quantity"), b, c);
				list.add(p);
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// làm trong ô search
		public List<Product> findByName(String keyword) {
		    List<Product> list = new ArrayList<>();
		    String sql = "SELECT p.*, c.name as cat_name FROM Products p " +
		                 "INNER JOIN Categories c ON p.category_id = c.id " +
		                 "WHERE p.name LIKE ?";

		    try {
		        Connection conn = DBConnection.getConnection();
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setString(1, "%" + keyword + "%");
		        ResultSet rs = ps.executeQuery();

		        while (rs.next()) {
		            Product p = new Product();
		            
		            p.setId(rs.getInt("id"));
		            p.setName(rs.getString("name"));
		            p.setPrice(rs.getDouble("price"));
		            p.setStock(rs.getInt("stock_quantity"));
		            
		            
		            p.setImage(rs.getString("image"));         // Cột image -> set cho Image
		            p.setDescription(rs.getString("description")); // Cột description -> set cho Description

		            // Xử lý Category
		            Category c = new Category();
		            c.setId(rs.getInt("category_id"));
		            c.setName(rs.getString("cat_name"));
		            p.setCategory(c);
		            
		            // Xử lý Brand
		            Brand b = new Brand();
		            b.setId(rs.getInt("brand_id"));
		            p.setBrand(b);

		            list.add(p);
		        }
		        conn.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return list;
		}
	
	public static void main(String[] args) {
		ProductDAO dao = new ProductDAO();
		List<Product> list = dao.getAllProducts();
		
		System.out.println("--- DANH SÁCH SẢN PHẨM TỪ SQL ---");
		for(Product p : list) {
			System.out.println("ID: " + p.getId());
			System.out.println("Name: " + p.getName());
			System.out.println("Price: " + p.getPrice());
            if (p.getCategory() != null) {
                System.out.println("Category: " + p.getCategory().getName());
            }
            if (p.getBrand() != null) {
                System.out.println("Brand: " + p.getBrand().getName());
            }
            System.out.println("Stock: " +p.getStock());
			System.out.println("-------------------------");
		}
	}
}
