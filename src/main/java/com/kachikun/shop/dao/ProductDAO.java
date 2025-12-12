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
						rs.getString("description"), 
						rs.getDouble("price"),
						rs.getString("image"), 
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
		
		// đếm sản phẩm
	    public int getTotalProducts() {
	        String sql = "SELECT count(*) FROM Products";
	        try {
	            Connection conn = DBConnection.getConnection();
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                return rs.getInt(1); // Trả về số lượng dòng đếm được
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return 0;
	    }
	    
	    public List<Product> pagingProduct(int index) {
	        List<Product> list = new ArrayList<>();
	        // SQL Server dùng OFFSET ... FETCH NEXT thay vì LIMIT
	        // Dùng LEFT JOIN để lỡ sản phẩm thiếu Brand/Category vẫn hiện ra được
	        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " +
	                     "FROM Products p " +
	                     "LEFT JOIN Categories c ON p.category_id = c.id " +
	                     "LEFT JOIN Brands b ON p.brand_id = b.id " +
	                     "ORDER BY p.id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
	        try {
	            Connection conn = DBConnection.getConnection();
	            PreparedStatement ps = conn.prepareStatement(sql);
	            // Công thức tính vị trí bắt đầu: (Trang hiện tại - 1) * 3
	            ps.setInt(1, (index - 1) * 3); 
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
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
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    }
	    
	 // Đếm số lượng sản phẩm theo tên danh mục (để tính tổng trang khi lọc)
	    public int countProductsByCategory(String cateName) {
	        String sql = "SELECT count(*) FROM Products p " +
	                     "INNER JOIN Categories c ON p.category_id = c.id " +
	                     "WHERE c.name LIKE ?"; 
	        try {
	            Connection conn = DBConnection.getConnection();
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, "%" + cateName + "%");
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                return rs.getInt(1);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return 0;
	    }

	    // Lấy sản phẩm theo danh mục CÓ PHÂN TRANG (Limit 3)
	    public List<Product> pagingProductByCategory(String cateName, int index) {
	        List<Product> list = new ArrayList<>();
	        // SQL Server syntax
	        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " +
	                     "FROM Products p " +
	                     "LEFT JOIN Categories c ON p.category_id = c.id " +
	                     "LEFT JOIN Brands b ON p.brand_id = b.id " +
	                     "WHERE c.name LIKE ? " +
	                     "ORDER BY p.id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
	        try {
	            Connection conn = DBConnection.getConnection();
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, "%" + cateName + "%");
	            ps.setInt(2, (index - 1) * 3); // Tính offset
	            
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
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
