package com.kachikun.shop.dao;

import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FeaturedProductDAO extends BaseDAO {

    public List<Product> getFeaturedProducts() {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name "
                + "FROM FeaturedProducts fp "
                + "INNER JOIN Products p ON fp.product_id = p.id "
                + "INNER JOIN Categories c ON p.category_id = c.id "
                + "INNER JOIN Brands b ON p.brand_id = b.id "
                + "ORDER BY fp.created_at ASC";

        List<Product> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock_quantity"));
                p.setSoldCount(rs.getInt("sold_count"));
                p.setAverageRating(rs.getDouble("average_rating"));
                p.setReviewCount(rs.getInt("review_count"));

                Category cat = new Category();
                cat.setId(rs.getInt("category_id"));
                cat.setName(rs.getString("cat_name"));
                p.setCategory(cat);

                Brand brand = new Brand();
                brand.setId(rs.getInt("brand_id"));
                brand.setName(rs.getString("brand_name"));
                p.setBrand(brand);

                list.add(p);
            }
        } catch (Exception e) {
            System.err.println("Lỗi lấy sản phẩm nổi bật: " + e.getMessage());
        }
        return list;
    }

    public boolean addFeaturedProduct(int productId) {
        String sql = "INSERT INTO FeaturedProducts (product_id) VALUES (?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Lỗi thêm sản phẩm nổi bật: " + e.getMessage());
            return false;
        }
    }

    public boolean removeFeaturedProduct(int productId) {
        String sql = "DELETE FROM FeaturedProducts WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Lỗi xóa sản phẩm nổi bật: " + e.getMessage());
            return false;
        }
    }

    public boolean isFeatured(int productId) {
        String sql = "SELECT COUNT(*) FROM FeaturedProducts WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.err.println("Lỗi kiểm tra sản phẩm nổi bật: " + e.getMessage());
        }
        return false;
    }

    public List<Integer> getFeaturedProductIds() {
        String sql = "SELECT product_id FROM FeaturedProducts";
        List<Integer> ids = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) ids.add(rs.getInt("product_id"));
        } catch (Exception e) {
            System.err.println("Lỗi lấy danh sách ID sản phẩm nổi bật: " + e.getMessage());
        }
        return ids;
    }
}
