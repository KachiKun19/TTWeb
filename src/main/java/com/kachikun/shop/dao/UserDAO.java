package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.User;
import com.kachikun.shop.utils.DBConnection;

public class UserDAO {
	public User checkLogin(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

	public boolean register(User u) {
        String sql = "INSERT INTO Users (username, password, email, full_name, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getFullName());
            ps.setInt(5, u.getRole());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }


	public List<User> getAllUsers() {
		List<User> users = new ArrayList<>();
		String sql = "SELECT * FROM Users ORDER BY id DESC";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setFullName(rs.getString("full_name"));
				u.setEmail(rs.getString("email"));
				u.setRole(rs.getInt("role"));
				users.add(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return users;
	}

	public User getUserById(int id) {
		String sql = "SELECT * FROM Users WHERE id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setFullName(rs.getString("full_name"));
				u.setEmail(rs.getString("email"));
				u.setRole(rs.getInt("role"));
				return u;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateUser(User u) {
		String sql = "UPDATE Users SET full_name = ?, email = ?, role = ? WHERE id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, u.getFullName());
			ps.setString(2, u.getEmail());
			ps.setInt(3, u.getRole());
			ps.setInt(4, u.getId());
			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteUser(int id) {
		String sql = "DELETE FROM Users WHERE id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<User> getUsersByRole(int role) {
		List<User> users = new ArrayList<>();
		String sql = "SELECT * FROM Users WHERE role = ? ORDER BY id DESC";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, role);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setFullName(rs.getString("full_name"));
				u.setEmail(rs.getString("email"));
				u.setRole(rs.getInt("role"));
				users.add(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return users;
	}

	public User getUserByEmail(String email) {
		String sql = "SELECT * FROM Users WHERE email = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setFullName(rs.getString("full_name"));
				u.setEmail(rs.getString("email"));
				u.setRole(rs.getInt("role"));
				return u;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updatePassword(String email, String newPassword) {
		String sql = "UPDATE Users SET password = ? WHERE email = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, newPassword);
			ps.setString(2, email);
			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public int getTotalUsers() {
		int total = 0;
		String sql = "SELECT COUNT(*) as total FROM Users";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				total = rs.getInt("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

	public int getNewUsersToday() {
		int count = 0;
		String sql = "SELECT COUNT(*) as count FROM Users WHERE CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)";

		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

	public boolean isEmailExists(String email) {
		try {
			Connection conn = DBConnection.getConnection();
			String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getInt(1) > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean isFullnameExists(String fullname) {
		try {
			Connection conn = DBConnection.getConnection();
			String sql = "SELECT COUNT(*) FROM Users WHERE full_name = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, fullname);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getInt(1) > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public User getUserByUsername(String username) {
	    String sql = "SELECT * FROM Users WHERE username = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
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
	
	private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setRole(rs.getInt("role"));
        return u;
    }

}