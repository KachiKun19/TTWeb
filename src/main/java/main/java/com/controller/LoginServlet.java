package main.java.com.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import main.java.com.dao.UserDAO;
import main.java.com.model.User;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu người dùng gõ URL /login, chuyển hướng về trang jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy dữ liệu từ form
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        // 2. Gọi DAO kiểm tra
        UserDAO dao = new UserDAO();
        User account = dao.checkLogin(user, pass);
        
        if (account != null) {
            // 3. Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("acc", account); // Lưu object User vào session
            
            // Chuyển hướng sang trang chủ (hoặc trang admin tùy role)
            response.sendRedirect("Home.jsp");
        } else {
            // 4. Đăng nhập thất bại
            request.setAttribute("mess", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}