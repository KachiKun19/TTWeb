package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

        //Kiểm tra mật khẩu
        if(!pass.equals(rePass)) {
            request.setAttribute("registerError", "Mật khẩu nhập lại không khớp!");
            //forward về login.jsp để hiện lỗi
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        //Gọi DAO
        User u = new User();
        u.setUsername(user);
        u.setPassword(pass);
        u.setEmail(email);
        u.setFullName(fullname);
        u.setRole(0);

        UserDAO dao = new UserDAO();
        boolean isSuccess = dao.register(u);

        if(isSuccess) {
            // Thành công -> Redirect về login.jsp kèm thông báo
            response.sendRedirect("login.jsp?msg=Dang ky thanh cong! Moi dang nhap.");
        } else {
            // Thất bại
            request.setAttribute("registerError", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
