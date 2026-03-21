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

    // Kiểm tra sơ bộ trước khi gửi OTP — không tạo tài khoản
    public String preCheck(String username, String password, String email) {
        if (username == null || username.trim().isEmpty())
            return "Vui lòng nhập tên đăng nhập!";
        if (password == null || password.length() < 8)
            return "Mật khẩu quá ngắn! Phải từ 8 ký tự trở lên.";
        if (!password.matches(".*[A-Z].*"))
            return "Mật khẩu phải chứa ít nhất 1 chữ hoa!";
        if (!password.matches(".*[0-9].*"))
            return "Mật khẩu phải chứa ít nhất 1 chữ số!";
        if (!password.matches(".*[!@#$%^&*].*"))
            return "Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt (!@#$%^&*)!";
        if (email == null || email.trim().isEmpty())
            return "Email không được để trống!";
        if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$"))
            return "Email không đúng định dạng!";
        if (userDAO.isUsernameExists(username))
            return "Tên đăng nhập đã tồn tại!";
        if (userDAO.isEmailExists(email))
            return "Email đã được sử dụng!";
        return "OK";
    }

    public String register(String username, String password, String email, String fullName, int role) {
        if (username == null || password == null)
            return "Vui lòng nhập đủ thông tin!";

        if (password.length() < 6) {
            return "Mật khẩu quá ngắn! Phải từ 6 ký tự trở lên.";
        }

        if (email == null || email.trim().isEmpty())
            return "Email không được để trống!";

        if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$"))
            return "Email không đúng định dạng!";

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