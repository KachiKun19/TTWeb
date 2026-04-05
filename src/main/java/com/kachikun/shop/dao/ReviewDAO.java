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
                while (rs.next()) {
                    list.add(mapReview(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // check user đã review sp chưa?
    public boolean hasReviewed(int productId, int userId, int orderId) {
        String sql = "SELECT COUNT(*) FROM ProductReviews "
                + "WHERE product_id = ? AND user_id = ? AND order_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.setInt(3, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // check user có mua sp ko?
    public boolean hasPurchased(int productId, int userId) {
        String sql = "SELECT COUNT(*) FROM OrderDetails od "
                + "INNER JOIN Orders o ON od.order_id = o.id "
                + "WHERE od.product_id = ? AND o.user_id = ? "
                + "AND o.status IN (N'Đã giao', N'Hoàn thành')";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy order_id chưa review để gắn vào review mới
    public int getEligibleOrderId(int productId, int userId) {
        String sql = "SELECT TOP 1 o.id FROM Orders o "
                + "INNER JOIN OrderDetails od ON od.order_id = o.id "
                + "WHERE od.product_id = ? AND o.user_id = ? "
                + "AND o.status IN (N'Đã giao', N'Hoàn thành') "
                + "AND o.id NOT IN ("
                + "    SELECT order_id FROM ProductReviews "
                + "    WHERE product_id = ? AND user_id = ?"
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

    //review mới
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

    // số Sao
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
                    if (star >= 1 && star <= 5) {
                        dist[star] = rs.getInt("cnt");
                    }
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