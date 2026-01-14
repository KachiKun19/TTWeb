package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;
import com.kachikun.shop.service.UserService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService service = new UserService();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String rePass = request.getParameter("repassword");
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");

        // 1. Check Pass nhập lại (Nếu sai thì xóa cả 2 mật khẩu, giữ lại thông tin khác)
        if(!pass.equals(rePass)) {
            request.setAttribute("registerError", "Mật khẩu nhập lại không khớp!");
            request.setAttribute("usernameValue", user);   // Giữ lại tên
            request.setAttribute("emailValue", email);     // Giữ lại email
            request.setAttribute("fullnameValue", fullname);// Giữ lại họ tên
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 2. Gọi Service kiểm tra
        String result = service.register(user, pass, email, fullname, 0);

        if("Success".equals(result)) {
            // --- THÀNH CÔNG ---
            // Dùng URLEncoder như bài trước để không lỗi font
            String msg = java.net.URLEncoder.encode("Đăng ký thành công! Mời đăng nhập.", "UTF-8");
            response.sendRedirect("login.jsp?msg=" + msg);
        } else {
            // --- THẤT BẠI (XỬ LÝ THÔNG MINH Ở ĐÂY) ---
            
            // Bước A: Mặc định là giữ lại TẤT CẢ thông tin
            request.setAttribute("usernameValue", user);
            request.setAttribute("emailValue", email);
            request.setAttribute("fullnameValue", fullname);
            
            // Bước B: Kiểm tra lỗi trùng cái nào thì XÓA cái đó
            if (result.contains("Tên đăng nhập")) {
                // Nếu trùng User -> Xóa User (để trống cho họ nhập lại)
                request.setAttribute("usernameValue", ""); 
            } 
            else if (result.contains("Email")) {
                // Nếu trùng Email -> Xóa Email
                request.setAttribute("emailValue", ""); 
            }
            
            // Bước C: Gửi thông báo lỗi và quay về trang
            request.setAttribute("registerError", result);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
