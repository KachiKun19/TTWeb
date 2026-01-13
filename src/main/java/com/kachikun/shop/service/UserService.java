package com.kachikun.shop.service;

import java.util.List;
import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.utils.MD5;

public class UserService {
    private UserDAO userDAO = new UserDAO();
    
    public User login(String username, String password) {
        // Mã hóa mật khẩu người dùng nhập vào trước khi gửi xuống DAO
        String hashedPassword = MD5.encrypt(password);
        return userDAO.checkLogin(username, hashedPassword);
    }
    
 // Trong file UserService.java
    public String register(String username, String password, String email, String fullName, int role) {
        if (username == null || password == null) return "Vui lòng nhập đủ thông tin!";

        // Logic check độ mạnh mật khẩu giữ nguyên (Check trên password gốc)
        if (password.length() < 6) {
             return "Mật khẩu quá ngắn! Phải từ 6 ký tự trở lên.";
        }
        
        // ... (Giữ nguyên đoạn check trùng Username/Email cũ) ...
        if (userDAO.isUsernameExists(username)) return "Tên đăng nhập đã tồn tại!";
        if (userDAO.isEmailExists(email)) return "Email đã được sử dụng!";

        // --- BẮT ĐẦU MÃ HÓA ---
        String hashedPassword = MD5.encrypt(password);
        // ----------------------

        User u = new User();
        u.setUsername(username);
        u.setPassword(hashedPassword); // LƯU MẬT KHẨU ĐÃ MÃ HÓA
        u.setEmail(email);
        u.setFullName(fullName);
        u.setRole(role);

        boolean success = userDAO.register(u);
        
        if (success) {
            return "Success"; 
        } else {
            // Nếu success = false -> Có lỗi SQL
            return "Lỗi hệ thống! Không thể lưu vào Database (Kiểm tra Console Eclipse).";
        }
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public List<User> getAdmins() {
        return userDAO.getUsersByRole(1);
    }
    
    public List<User> getRegularUsers() {
        return userDAO.getUsersByRole(0);
    }
    
    public boolean updateUserRole(int userId, int newRole) {
        User user = userDAO.getUserById(userId);
        if (user != null) {
            user.setRole(newRole);
            return userDAO.updateUser(user);
        }
        return false;
    }
    
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
    
    public boolean recoverPassword(String email, String newPassword) {
        // 1. Dùng đúng thư viện MD5 đang dùng cho Login/Register để đảm bảo đồng bộ
        String hashedPassword = MD5.encrypt(newPassword);
        
        // 2. Gọi DAO để cập nhật
        // (Lưu ý: Bạn cần đảm bảo UserDAO có hàm updatePassword(email, pass) nhé)
        return userDAO.updatePassword(email, hashedPassword);
    }
}