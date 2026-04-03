package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.User;

public class UserDAO extends BaseDAO {
    public boolean register(User newUser) {
        String sql = "INSERT INTO Users (username, password, email, full_name, role) " + "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newUser.getUsername());
            ps.setString(2, newUser.getPassword());
            ps.setString(3, newUser.getEmail());
            ps.setString(4, newUser.getFullName());
            ps.setInt(5, newUser.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy toàn bộ danh sách người dùng, sắp xếp mới nhất trước.
     */
    public List<User> getAllUsers() {

        String sql = "SELECT * FROM Users ORDER BY id DESC";
        List<User> userList = new ArrayList<>();
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                userList.add(mapUserWithoutPassword(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    /**
     * Tìm người dùng theo ID.
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUserWithoutPassword(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Tìm người dùng theo tên đăng nhập (dùng khi login).
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Tìm người dùng theo email
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUserWithoutPassword(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy danh sách người dùng theo vai trò
     * role 0 = User , 1 = Admin
     */
    public List<User> getUsersByRole(int role) {
        String sql = "SELECT * FROM Users WHERE role = ? ORDER BY id DESC";
        List<User> userList = new ArrayList<>();

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, role);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userList.add(mapUserWithoutPassword(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }

    /**
     * Cập nhật thông tin người dùng
     */
    public boolean updateUser(User updatedUser) {
        String sql = "UPDATE Users SET full_name = ?, email = ?, role = ? WHERE id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, updatedUser.getFullName());
            ps.setString(2, updatedUser.getEmail());
            ps.setInt(3, updatedUser.getRole());
            ps.setInt(4, updatedUser.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Đặt lại mật khẩu mới cho người dùng theo email.
     */
    public boolean updatePassword(String email, String newHashedPassword) {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newHashedPassword);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa người dùng theo ID.
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Kiểm tra tên đăng nhập đã được dùng chưa.
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Kiểm tra email đã được đăng ký chưa.
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Đếm tổng số người dùng trong hệ thống.
     */
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) AS total FROM Users";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt("total");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Có Password
     */
    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getInt("role"));
        return user;
    }

    /**
     * Không có Password
     */
    private User mapUserWithoutPassword(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getInt("role"));
        return user;
    }
}