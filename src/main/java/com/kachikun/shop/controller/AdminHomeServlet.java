package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.model.User;

@WebServlet("/adminHome")
public class AdminHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Kiểm tra quyền admin
        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            // Nếu không phải admin, chuyển về trang user
            response.sendRedirect("home");
            return;
        }
        
        // Nếu là admin, chuyển đến trang admin
        request.getRequestDispatcher("adminHome.jsp").forward(request, response);
    }
}