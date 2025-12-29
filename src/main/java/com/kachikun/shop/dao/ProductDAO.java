package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.utils.DBConnection;
import com.kachikun.shop.model.Category;

public class ProductDAO {
	public List<Product> getAllProducts() {
		List<Product> list = new ArrayList<>();
		String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " + "FROM Products p "
				+ "INNER JOIN Categories c ON p.category_id = c.id " + "INNER JOIN Brands b ON p.brand_id = b.id";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
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

	// vd tìm mouse từ Category từ việc lấy hết thông tin Product
	public List<Product> findByCategoryName(String categoryName) {
		List<Product> list = new ArrayList<>();
		String sql = "SELECT p.* FROM Products p " + "INNER JOIN Categories c ON p.category_id = c.id "
				+ "WHERE c.name LIKE ? ";

		try {
			Connection conn = new DBConnection().getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			// tìm thành phần có chưa mouse
			ps.setString(1, "%" + categoryName + "%");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				// tạo category
				Category c = new Category();
				c.setId(rs.getInt("category_id"));
				// tạo brand
				Brand b = new Brand();
				b.setId(rs.getInt("brand_id"));
				// tạo product
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
						rs.getDouble("price"), rs.getString("image"), rs.getInt("stock_quantity"), b, c);
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
		String sql = "SELECT p.*, c.name as cat_name FROM Products p "
				+ "INNER JOIN Categories c ON p.category_id = c.id " + "WHERE p.name LIKE ?";

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

				p.setImage(rs.getString("image")); // Cột image -> set cho Image
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


	public List<Product> pagingProduct(int index) {
		List<Product> list = new ArrayList<>();
		// SQL Server dùng OFFSET ... FETCH NEXT thay vì LIMIT
		// Dùng LEFT JOIN để lỡ sản phẩm thiếu Brand/Category vẫn hiện ra được
		String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " + "FROM Products p "
				+ "LEFT JOIN Categories c ON p.category_id = c.id " + "LEFT JOIN Brands b ON p.brand_id = b.id "
				+ "ORDER BY p.id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
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
		String sql = "SELECT count(*) FROM Products p " + "INNER JOIN Categories c ON p.category_id = c.id "
				+ "WHERE c.name LIKE ?";
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
		String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " + "FROM Products p "
				+ "LEFT JOIN Categories c ON p.category_id = c.id " + "LEFT JOIN Brands b ON p.brand_id = b.id "
				+ "WHERE c.name LIKE ? " + "ORDER BY p.id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
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

	// Hàm lấy chi tiết sản phẩm theo ID (Dùng cho Giỏ hàng)
	public Product getProductById(int id) {
		String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " + "FROM Products p "
				+ "INNER JOIN Categories c ON p.category_id = c.id " + "INNER JOIN Brands b ON p.brand_id = b.id "
				+ "WHERE p.id = ?";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescription(rs.getString("description"));
				p.setImage(rs.getString("image"));
				p.setStock(rs.getInt("stock_quantity"));
				p.setPrice(rs.getDouble("price"));
				p.setConnectionType(rs.getString("connection_type"));
				p.setMaterial(rs.getString("material"));
				p.setSize(rs.getString("product_size"));

				Category c = new Category();
				c.setId(rs.getInt("category_id"));
				c.setName(rs.getString("cat_name"));
				p.setCategory(c);

				Brand b = new Brand();
				b.setId(rs.getInt("brand_id"));
				b.setName(rs.getString("brand_name"));
				b.setLogo(rs.getString("brand_logo"));
				p.setBrand(b);

				return p;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// hàm filterProducts lọc sản phẩm theo nhiều tiêu chí
	public List<Product> filterProducts(String[] brandIds, String[] connections, String[] materials, String[] sizes,
			String category, int index) {
		List<Product> list = new ArrayList<>();

		// Câu lệnh SQL gốc
		StringBuilder sql = new StringBuilder(
				"SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " + "FROM Products p "
						+ "INNER JOIN Categories c ON p.category_id = c.id "
						+ "INNER JOIN Brands b ON p.brand_id = b.id WHERE 1=1");

		// LỌC DANH MỤC (CATEGORY)
		if (category != null && !category.isEmpty()) {
			sql.append(" AND c.name LIKE N'%").append(category).append("%'");
		}

		// LỌC THƯƠNG HIỆU (BRAND)
		if (brandIds != null && brandIds.length > 0) {
			sql.append(" AND brand_id IN (");
			for (int i = 0; i < brandIds.length; i++) {
				sql.append(brandIds[i]);
				if (i < brandIds.length - 1)
					sql.append(",");
			}
			sql.append(")");
		}

		// LỌC KẾT NỐI (CONNECTION)
		if (connections != null && connections.length > 0) {
			sql.append(" AND (");
			for (int i = 0; i < connections.length; i++) {
				sql.append("connection_type LIKE '%").append(connections[i]).append("%'");
				if (i < connections.length - 1)
					sql.append(" OR ");
			}
			sql.append(")");
		}

		// LỌC CHẤT LIỆU (MATERIAL)
		if (materials != null && materials.length > 0) {
			sql.append(" AND (");
			for (int i = 0; i < materials.length; i++) {
				sql.append("material LIKE '%").append(materials[i]).append("%'");
				if (i < materials.length - 1)
					sql.append(" OR ");
			}
			sql.append(")");
		}

		// LỌC KÍCH THƯỚC (SIZE)
		if (sizes != null && sizes.length > 0) {
			sql.append(" AND (");
			for (int i = 0; i < sizes.length; i++) {
				sql.append("product_size = '").append(sizes[i]).append("'");
				if (i < sizes.length - 1)
					sql.append(" OR ");
			}
			sql.append(")");
		}
		// phân trang khi lọc
		sql.append(" ORDER BY p.id OFFSET ").append((index - 1) * 3).append(" ROWS FETCH NEXT 3 ROWS ONLY");

		try {
			Connection conn = DBConnection.getConnection();
			java.sql.Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql.toString());

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

				try {
					p.setConnectionType(rs.getString("connection_type"));
				} catch (Exception e) {
				}
				try {
					p.setMaterial(rs.getString("material"));
				} catch (Exception e) {
				}
				try {
					p.setSize(rs.getString("product_size"));
				} catch (Exception e) {
				}

				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Đếm tổng số sản phẩm sau khi lọc (để tính số trang)
	public int countFilteredProducts(String[] brandIds, String[] connections, String[] materials, String[] sizes,
			String category) {
		StringBuilder sql = new StringBuilder(
				"SELECT count(*) FROM Products p " + "INNER JOIN Categories c ON p.category_id = c.id "
						+ "INNER JOIN Brands b ON p.brand_id = b.id WHERE 1=1");

		// lọc ở categories
		if (category != null && !category.isEmpty()) {
			// categoryName trong DB của bạn là tiếng Việt (Chuột Gaming...), nên dùng
			// N'...' nếu cần, hoặc like
			sql.append(" AND c.name LIKE N'%").append(category).append("%'");
		}

		// lọc ở products
		if (brandIds != null && brandIds.length > 0) {
			sql.append(" AND brand_id IN (");
			for (int i = 0; i < brandIds.length; i++) {
				sql.append(brandIds[i]).append(i < brandIds.length - 1 ? "," : "");
			}
			sql.append(")");
		}

		if (connections != null && connections.length > 0) {
			sql.append(" AND (");
			for (int i = 0; i < connections.length; i++) {
				sql.append("connection_type LIKE '%").append(connections[i]).append("%'");
				if (i < connections.length - 1)
					sql.append(" OR ");
			}
			sql.append(")");
		}
		if (materials != null && materials.length > 0) {
			sql.append(" AND (");
			for (int i = 0; i < materials.length; i++) {
				sql.append("material LIKE '%").append(materials[i]).append("%'");
				if (i < materials.length - 1)
					sql.append(" OR ");
			}
			sql.append(")");
		}
		if (sizes != null && sizes.length > 0) {
			sql.append(" AND (");
			for (int i = 0; i < sizes.length; i++) {
				sql.append("product_size = '").append(sizes[i]).append("'");
				if (i < sizes.length - 1)
					sql.append(" OR ");
			}
			sql.append(")");
		}

		try {
			Connection conn = DBConnection.getConnection();
			java.sql.Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql.toString());
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public boolean insertProduct(Product product) {
	    String sql = "INSERT INTO Products (name, description, price, image, stock_quantity, " +
	                 "connection_type, material, product_size, category_id, brand_id) " +
	                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        
	        ps.setString(1, product.getName());
	        ps.setString(2, product.getDescription());
	        ps.setDouble(3, product.getPrice());
	        ps.setString(4, product.getImage());
	        ps.setInt(5, product.getStock());
	        ps.setString(6, product.getConnectionType());
	        ps.setString(7, product.getMaterial());
	        ps.setString(8, product.getSize());
	        
	        // Xử lý category_id
	        if (product.getCategory() != null && product.getCategory().getId() > 0) {
	            ps.setInt(9, product.getCategory().getId());
	        } else {
	            ps.setNull(9, java.sql.Types.INTEGER);
	        }
	        
	        // Xử lý brand_id
	        if (product.getBrand() != null && product.getBrand().getId() > 0) {
	            ps.setInt(10, product.getBrand().getId());
	        } else {
	            ps.setNull(10, java.sql.Types.INTEGER);
	        }
	        
	        int rowsAffected = ps.executeUpdate();
	        conn.commit();
	        return rowsAffected > 0;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	// Thêm vào ProductDAO.java, sau phương thức insertProduct
	public boolean deleteProduct(int productId) {
	    String sql = "DELETE FROM Products WHERE id = ?";
	    
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, productId);
	        
	        int rowsAffected = ps.executeUpdate();
	        conn.commit();
	        return rowsAffected > 0;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public static void main(String[] args) {
		ProductDAO dao = new ProductDAO();
		List<Product> list = dao.getAllProducts();

		System.out.println("--- DANH SÁCH SẢN PHẨM TỪ SQL ---");
		for (Product p : list) {
			System.out.println("ID: " + p.getId());
			System.out.println("Name: " + p.getName());
			System.out.println("Price: " + p.getPrice());
			if (p.getCategory() != null) {
				System.out.println("Category: " + p.getCategory().getName());
			}
			if (p.getBrand() != null) {
				System.out.println("Brand: " + p.getBrand().getName());
			}
			System.out.println("Stock: " + p.getStock());
			System.out.println("-------------------------");
		}
	}

	// Thêm phương thức này vào ProductDAO.java
	// Sửa phương thức getProductsByPage trong ProductDAO.java
	public List<Product> getProductsByPage(int page, int pageSize) {
	    List<Product> list = new ArrayList<>();
	    
	    // Tính OFFSET (SQL Server syntax)
	    int offset = (page - 1) * pageSize;
	    
	    String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name " +
	                 "FROM Products p " +
	                 "LEFT JOIN Categories c ON p.category_id = c.id " +
	                 "LEFT JOIN Brands b ON p.brand_id = b.id " +
	                 "ORDER BY p.id ASC " +  // Sửa: sắp xếp từ nhỏ đến lớn (từ 1 về sau)
	                 "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
	    
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, offset);
	        ps.setInt(2, pageSize);
	        
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            Product p = new Product();
	            p.setId(rs.getInt("id"));
	            p.setName(rs.getString("name"));
	            p.setDescription(rs.getString("description"));
	            p.setImage(rs.getString("image"));
	            p.setStock(rs.getInt("stock_quantity"));
	            p.setPrice(rs.getDouble("price"));
	            
	            // Category
	            Category c = new Category();
	            c.setId(rs.getInt("category_id"));
	            c.setName(rs.getString("cat_name"));
	            p.setCategory(c);
	            
	            // Brand
	            Brand b = new Brand();
	            b.setId(rs.getInt("brand_id"));
	            b.setName(rs.getString("brand_name"));
	            p.setBrand(b);
	            
	            list.add(p);
	        }
	        
	        System.out.println("DAO: Fetched " + list.size() + " products for page " + page + " (offset=" + offset + ")");
	        
	    } catch (Exception e) {
	        System.err.println("Error in getProductsByPage: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return list;
	}

	// Đảm bảo phương thức getTotalProducts hoạt động đúng
	public int getTotalProducts() {
	    String sql = "SELECT COUNT(*) as total FROM Products";
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            int total = rs.getInt("total");
	            System.out.println("Total products in database: " + total);
	            return total;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    System.out.println("Error getting total products, returning 0");
	    return 0;
	}
}
