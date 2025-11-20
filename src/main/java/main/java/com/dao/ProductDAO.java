package main.java.com.dao;

import main.java.com.model.Product;
import main.java.com.model.Category;
import main.java.com.model.Brand;
import main.java.com.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.categoryName, b.brandName, b.logoUrl " +
                    "FROM Products p " +
                    "JOIN Categories c ON p.categoryId = c.categoryId " +
                    "JOIN Brands b ON p.brandId = b.brandId";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Product product = resultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.categoryName, b.brandName, b.logoUrl " +
                    "FROM Products p " +
                    "JOIN Categories c ON p.categoryId = c.categoryId " +
                    "JOIN Brands b ON p.brandId = b.brandId " +
                    "WHERE p.categoryId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = resultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getFeaturedProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP 8 p.*, c.categoryName, b.brandName, b.logoUrl " +
                    "FROM Products p " +
                    "JOIN Categories c ON p.categoryId = c.categoryId " +
                    "JOIN Brands b ON p.brandId = b.brandId " +
                    "ORDER BY p.productId DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Product product = resultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public Product getProductById(int productId) {
        Product product = null;
        String sql = "SELECT p.*, c.categoryName, b.brandName, b.logoUrl " +
                    "FROM Products p " +
                    "JOIN Categories c ON p.categoryId = c.categoryId " +
                    "JOIN Brands b ON p.brandId = b.brandId " +
                    "WHERE p.productId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                product = resultSetToProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
    
    private Product resultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("productId"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setImageUrl(rs.getString("imageUrl"));
        product.setStock(rs.getInt("stock"));
        
        Category category = new Category();
        category.setCategoryId(rs.getInt("categoryId"));
        category.setCategoryName(rs.getString("categoryName"));
        product.setCategory(category);
        
        Brand brand = new Brand();
        brand.setBrandId(rs.getInt("brandId"));
        brand.setBrandName(rs.getString("brandName"));
        brand.setLogoUrl(rs.getString("logoUrl"));
        product.setBrand(brand);
        
        return product;
    }
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.categoryName, b.brandName, b.logoUrl " +
                    "FROM Products p " +
                    "JOIN Categories c ON p.categoryId = c.categoryId " +
                    "JOIN Brands b ON p.brandId = b.brandId " +
                    "WHERE p.name LIKE ? OR p.description LIKE ? OR b.brandName LIKE ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = resultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getProductsByBrand(int brandId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.categoryName, b.brandName, b.logoUrl " +
                    "FROM Products p " +
                    "JOIN Categories c ON p.categoryId = c.categoryId " +
                    "JOIN Brands b ON p.brandId = b.brandId " +
                    "WHERE p.brandId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, brandId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = resultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public boolean updateProductStock(int productId, int quantity) {
        String sql = "UPDATE Products SET stock = stock - ? WHERE productId = ? AND stock >= ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    

}