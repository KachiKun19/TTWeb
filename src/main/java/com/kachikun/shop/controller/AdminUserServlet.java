package com.kachikun.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.UserDAO;

@WebServlet("/adminUsers")
public class AdminUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra đăng nhập và quyền admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User adminUser = (User) session.getAttribute("user");
        if (adminUser.getRole() != 1) {
            response.sendRedirect("home");
            return;
        }
        
        // Lấy danh sách người dùng theo vai trò
        List<User> adminList = userDAO.getUsersByRole(1); // Admin
        List<User> userList = userDAO.getUsersByRole(0); // Người dùng thường
        
        // Truyền dữ liệu sang JSP
        request.setAttribute("adminList", adminList);
        request.setAttribute("userList", userList);
        
        // Chuyển đến trang quản lý người dùng
        request.getRequestDispatcher("adminUsers.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra đăng nhập và quyền admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User adminUser = (User) session.getAttribute("user");
        if (adminUser.getRole() != 1) {
            response.sendRedirect("home");
            return;
        }
        
        // Xác định hành động
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            handleAddUser(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteUser(request, response);
        } else if ("updateRole".equals(action)) {
            handleUpdateRole(request, response);
        } else {
            // Nếu không có action hợp lệ, chuyển về trang danh sách
            response.sendRedirect("adminUsers");
        }
    }
    
    private void handleAddUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String roleStr = request.getParameter("role");
        
        // Validate dữ liệu
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tên đăng nhập và mật khẩu là bắt buộc!");
            doGet(request, response);
            return;
        }
        
        try {
            int role = Integer.parseInt(roleStr);
            
            // Tạo đối tượng User mới
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setFullName(fullName);
            newUser.setEmail(email);
            newUser.setRole(role);
            
            // Thêm vào database
            boolean success = userDAO.register(newUser);
            
            if (success) {
                response.sendRedirect("adminUsers?success=add_success");
            } else {
                response.sendRedirect("adminUsers?error=add_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("adminUsers?error=invalid_role");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminUsers?error=server_error");
        }
    }
    
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Lấy ID người dùng cần xóa
        String userIdStr = request.getParameter("id");
        
        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            response.sendRedirect("adminUsers?error=invalid_id");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdStr);
            
            // Không cho phép xóa chính mình
            HttpSession session = request.getSession(false);
            User currentUser = (User) session.getAttribute("user");
            if (currentUser.getId() == userId) {
                response.sendRedirect("adminUsers?error=cannot_delete_self");
                return;
            }
            
            // Xóa người dùng
            boolean success = userDAO.deleteUser(userId);
            
            if (success) {
                response.sendRedirect("adminUsers?success=delete_success");
            } else {
                response.sendRedirect("adminUsers?error=delete_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("adminUsers?error=invalid_id_format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminUsers?error=server_error");
        }
    }
    
    private void handleUpdateRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Lấy thông tin cập nhật
        String userIdStr = request.getParameter("id");
        String newRoleStr = request.getParameter("newRole");
        
        if (userIdStr == null || newRoleStr == null) {
            response.sendRedirect("adminUsers?error=invalid_data");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdStr);
            int newRole = Integer.parseInt(newRoleStr);
            
            // Không cho phép thay đổi vai trò của chính mình
            HttpSession session = request.getSession(false);
            User currentUser = (User) session.getAttribute("user");
            if (currentUser.getId() == userId) {
                response.sendRedirect("adminUsers?error=cannot_change_self_role");
                return;
            }
            
            // Lấy thông tin người dùng
            User user = userDAO.getUserById(userId);
            if (user == null) {
                response.sendRedirect("adminUsers?error=user_not_found");
                return;
            }
            
            // Cập nhật vai trò
            user.setRole(newRole);
            boolean success = userDAO.updateUser(user);
            
            if (success) {
                response.sendRedirect("adminUsers?success=role_updated");
            } else {
                response.sendRedirect("adminUsers?error=role_update_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("adminUsers?error=invalid_data_format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminUsers?error=server_error");
        }
    }
}