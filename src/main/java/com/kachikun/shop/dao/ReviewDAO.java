package com.kachikun.shop.dao;

import com.kachikun.shop.model.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO extends BaseDAO {

    // Lấy tất cả review của một sản phẩm
    public List<Review> getReviewsByProductId(int productId) {
        String sql = "SELECT r.*, u.username, u.full_name "
                + "FROM ProductReviews r "
                + "INNER JOIN Users u ON r.user_id = u.id "
                + "WHERE r.product_id = ? "
                + "ORDER BY r.created_at DESC";

        List<Review> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapReview(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy order_id hợp lệ cac đơn đã giao
    public int getEligibleOrderId(int productId, int userId) {
        String sql = "SELECT TOP 1 o.id FROM Orders o "
                + "INNER JOIN OrderDetails od ON od.order_id = o.id "
                + "WHERE od.product_id = ? AND o.user_id = ? "
                + "AND o.status = N'Đã giao' "
                + "AND NOT EXISTS ("
                + "    SELECT 1 FROM ProductReviews pr "
                + "    WHERE pr.product_id = ? AND pr.user_id = ? AND pr.order_id = o.id"
                + ") "
                + "ORDER BY o.id DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            ps.setInt(4, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // check user đã review sp chưa
    public boolean isAllProductsReviewed(int orderId, int userId) {
        String sql = "SELECT COUNT(*) FROM OrderDetails od "
                + "WHERE od.order_id = ? "
                + "AND NOT EXISTS ("
                + "    SELECT 1 FROM ProductReviews pr "
                + "    WHERE pr.product_id = od.product_id "
                + "    AND pr.user_id = ? "
                + "    AND pr.order_id = ?"
                + ")";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            ps.setInt(3, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) == 0; // 0 = không còn sp nào chưa review
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách sản phẩm chưa review
    public List<Integer> getUnreviewedProductIds(int orderId, int userId) {
        String sql = "SELECT od.product_id FROM OrderDetails od "
                + "WHERE od.order_id = ? "
                + "AND NOT EXISTS ("
                + "    SELECT 1 FROM ProductReviews pr "
                + "    WHERE pr.product_id = od.product_id "
                + "    AND pr.user_id = ? "
                + "    AND pr.order_id = ?"
                + ")";

        List<Integer> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            ps.setInt(3, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(rs.getInt("product_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm review mới
    public boolean insertReview(Review review) {
        String sql = "INSERT INTO ProductReviews (product_id, user_id, order_id, rating, comment) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getProductId());
            ps.setInt(2, review.getUserId());
            ps.setInt(3, review.getOrderId());
            ps.setInt(4, review.getRating());
            ps.setString(5, review.getComment());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Phân bố sao
    public int[] getRatingDistribution(int productId) {
        String sql = "SELECT rating, COUNT(*) AS cnt FROM ProductReviews "
                + "WHERE product_id = ? GROUP BY rating";

        int[] dist = new int[6];
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int star = rs.getInt("rating");
                    if (star >= 1 && star <= 5) dist[star] = rs.getInt("cnt");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dist;
    }

    private Review mapReview(ResultSet rs) throws Exception {
        Review r = new Review();
        r.setId(rs.getInt("id"));
        r.setProductId(rs.getInt("product_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setOrderId(rs.getInt("order_id"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        r.setUsername(rs.getString("username"));
        r.setFullName(rs.getString("full_name"));
        return r;
    }
}