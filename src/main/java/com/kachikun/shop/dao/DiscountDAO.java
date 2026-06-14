package com.kachikun.shop.dao;

import com.kachikun.shop.model.Discount;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

    public boolean delete(int id) {
        String sql = "DELETE FROM Discounts WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

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

    public List<Discount> getByPage(int page, int pageSize) {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM Discounts ORDER BY id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapDiscount(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM Discounts";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean insert(Discount d) {
        String sql = "INSERT INTO Discounts (code, discount_type, discount_value, min_order_value, max_uses, is_active, expires_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, d.getCode().trim().toUpperCase());
            ps.setString(2, d.getDiscountType());
            ps.setDouble(3, d.getDiscountValue());
            ps.setDouble(4, d.getMinOrderValue());
            if (d.getMaxUses() != null) ps.setInt(5, d.getMaxUses());
            else ps.setNull(5, Types.INTEGER);
            ps.setBoolean(6, d.isActive());
            if (d.getExpiresAt() != null) ps.setDate(7, d.getExpiresAt());
            else ps.setNull(7, Types.DATE);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Discount d) {
        String sql = "UPDATE Discounts SET code=?, discount_type=?, discount_value=?, min_order_value=?, max_uses=?, is_active=?, expires_at=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, d.getCode().trim().toUpperCase());
            ps.setString(2, d.getDiscountType());
            ps.setDouble(3, d.getDiscountValue());
            ps.setDouble(4, d.getMinOrderValue());
            if (d.getMaxUses() != null) ps.setInt(5, d.getMaxUses());
            else ps.setNull(5, Types.INTEGER);
            ps.setBoolean(6, d.isActive());
            if (d.getExpiresAt() != null) ps.setDate(7, d.getExpiresAt());
            else ps.setNull(7, Types.DATE);
            ps.setInt(8, d.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Discount> getActiveDiscounts() {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM Discounts WHERE is_active = 1 " +
                     "AND (expires_at IS NULL OR expires_at >= CAST(GETDATE() AS DATE)) " +
                     "AND (max_uses IS NULL OR used_count < max_uses) ORDER BY id DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapDiscount(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean saveForUser(int userId, int discountId) {
        if (isAlreadySaved(userId, discountId)) return false;
        String sql = "INSERT INTO UserSavedDiscounts (user_id, discount_id) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, discountId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean isAlreadySaved(int userId, int discountId) {
        String sql = "SELECT COUNT(*) FROM UserSavedDiscounts WHERE user_id = ? AND discount_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, discountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public Set<Integer> getSavedDiscountIdsByUser(int userId) {
        Set<Integer> ids = new HashSet<>();
        String sql = "SELECT discount_id FROM UserSavedDiscounts WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) ids.add(rs.getInt("discount_id"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return ids;
    }

    public List<Discount> getSavedDiscountsByUser(int userId) {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT d.* FROM Discounts d " +
                     "JOIN UserSavedDiscounts usd ON d.id = usd.discount_id " +
                     "WHERE usd.user_id = ? AND d.is_active = 1 " +
                     "AND (d.expires_at IS NULL OR d.expires_at >= CAST(GETDATE() AS DATE)) " +
                     "AND (d.max_uses IS NULL OR d.used_count < d.max_uses) " +
                     "ORDER BY usd.saved_at DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapDiscount(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2 người dùng cùng lúc mã giảm giá => đếm lần dùng (discount)
    public boolean incrementUsedSafe(String code) {
        String sql = "UPDATE Discounts " +
                "SET used_count = used_count + 1 " +
                "WHERE UPPER(code) = ? " +
                "AND is_active = 1 " +
                "AND (max_uses IS NULL OR used_count < max_uses) " +
                "AND (expires_at IS NULL OR expires_at >= CAST(GETDATE() AS DATE))";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim().toUpperCase());
            return ps.executeUpdate() > 0; // = 0 là hết được sài
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
