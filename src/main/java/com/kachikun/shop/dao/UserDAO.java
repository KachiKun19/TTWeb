package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.User;
import com.kachikun.shop.utils.DBConnection;

public class UserDAO {
	public User checkLogin(String username, String password) {
		String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, password);

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

	// Thêm phương thức này vào UserDAO.java (nếu chưa có)
	public boolean register(User u) {
	    String sql = "INSERT INTO Users (username, password, full_name, email, role) VALUES (?, ?, ?, ?, ?)";
	    
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        
	        ps.setString(1, u.getUsername());
	        ps.setString(2, u.getPassword());
	        ps.setString(3, u.getFullName());
	        ps.setString(4, u.getEmail());
	        ps.setInt(5, u.getRole());
	        
	        int rowsAffected = ps.executeUpdate();
	        return rowsAffected > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public static void main(String[] args) {
		UserDAO dao = new UserDAO();
		//đăng kí 
		User newUser = new User();
		newUser.setUsername("kachikun");
        newUser.setPassword("123456");
        newUser.setEmail("test@gmail.com");
        newUser.setFullName("Kachikun User");
        
        boolean isRegister = dao.register(newUser);
        if(isRegister) {
        	System.out.println("Đăng kí thành công");
        }else {
        	System.out.println("Đăng kí thất bại");
        }
        
        // test đăng nhập
        User u = dao.checkLogin("kachikun", "123456");
        if(u != null) {
        	System.out.println("Đăng nhập thành công");
        }else {
        	System.out.println("Đăng nhập thất bại");
        }
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
    
}