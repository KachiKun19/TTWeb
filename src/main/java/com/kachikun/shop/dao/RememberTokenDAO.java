package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.kachikun.shop.model.RememberToken;

public class RememberTokenDAO extends BaseDAO {

    /**
     * Lưu token mới vào DB
     */
    public void saveToken(RememberToken rememberToken) {
        String sql = "INSERT INTO RememberTokens (user_id, token, expiry) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, rememberToken.getUserId());
            ps.setString(2, rememberToken.getToken());
            ps.setTimestamp(3, rememberToken.getExpiry());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Tìm user_id theo token — chỉ trả về nếu token còn hạn
     */
    public Integer getUserIdByToken(String token) {
        String sql = "SELECT user_id FROM RememberTokens WHERE token = ? AND expiry > GETDATE()";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("user_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Xóa token khi đang xuất
     */
    public void deleteByToken(String token) {
        String sql = "DELETE FROM RememberTokens WHERE token = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Xóa tất cả token của một user — dùng trước khi tạo token mới.
     */
    public void deleteByUserId(int userId) {
        String sql = "DELETE FROM RememberTokens WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
