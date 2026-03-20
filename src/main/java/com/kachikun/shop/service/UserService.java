package com.kachikun.shop.service;

import java.util.List;
import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.utils.BCryptUtils;

public class UserService {
    private UserDAO userDAO = new UserDAO();

    public User login(String username, String password) {
        User user = userDAO.getUserByUsername(username); 
        
        if (user != null && BCryptUtils.checkPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public String register(String username, String password, String email, String fullName, int role) {
        if (username == null || password == null)
            return "Vui lòng nhập đủ thông tin!";

        if (password.length() < 6) {
            return "Mật khẩu quá ngắn! Phải từ 6 ký tự trở lên.";
        }

        if (userDAO.isUsernameExists(username))
            return "Tên đăng nhập đã tồn tại!";
        if (userDAO.isEmailExists(email))
            return "Email đã được sử dụng!";

        String hashedPassword = BCryptUtils.hashPassword(password);

        User u = new User();
        u.setUsername(username);
        u.setPassword(hashedPassword);
        u.setEmail(email);
        u.setFullName(fullName);
        u.setRole(role);

        boolean success = userDAO.register(u);

        if (success) {
            return "Success";
        } else {
            return "Lỗi hệ thống! Không thể lưu vào Database (Kiểm tra Console Eclipse).";
        }
    }

    public boolean recoverPassword(String email, String newPassword) {
        String hashedPassword = BCryptUtils.hashPassword(newPassword);
        return userDAO.updatePassword(email, hashedPassword);
    }

    public List<User> getAllUsers() { return userDAO.getAllUsers(); }
    public List<User> getAdmins() { return userDAO.getUsersByRole(1); }
    public List<User> getRegularUsers() { return userDAO.getUsersByRole(0); }
    public boolean deleteUser(int userId) { return userDAO.deleteUser(userId); }
}