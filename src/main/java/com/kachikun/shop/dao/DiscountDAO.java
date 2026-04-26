package com.kachikun.shop.dao;

import com.kachikun.shop.model.Discount;

import java.sql.*;

public class DiscountDAO extends BaseDAO {

    public Discount findByCode(String code) {
        String sql = "SELECT * FROM Discounts WHERE UPPER(code) = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim().toUpperCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapDiscount(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // tang so lan neu da bi su dung
    public boolean incrementUsed(String code) {
        String sql = "UPDATE Discounts SET used_count = used_count + 1 WHERE UPPER(code) = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim().toUpperCase());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Discount mapDiscount(ResultSet rs) throws SQLException {
        Discount d = new Discount();
        d.setId(rs.getInt("id"));
        d.setCode(rs.getString("code"));
        d.setDiscountType(rs.getString("discount_type"));
        d.setDiscountValue(rs.getDouble("discount_value"));
        d.setMinOrderValue(rs.getDouble("min_order_value"));
        int maxUses = rs.getInt("max_uses");
        if (!rs.wasNull()) d.setMaxUses(maxUses);
        d.setUsedCount(rs.getInt("used_count"));
        d.setActive(rs.getBoolean("is_active"));
        d.setExpiresAt(rs.getDate("expires_at"));
        return d;
    }
}
