package com.kachikun.shop.controller;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("updateInfo".equals(action)) {
            handleUpdateInfo(request, response, session, sessionUser);
        } else {
            response.sendRedirect("profile");
        }
    }

    private void handleUpdateInfo(HttpServletRequest request, HttpServletResponse response,
                                  HttpSession session, User sessionUser)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("infoError", "Họ tên không được để trống!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        if (email == null || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            request.setAttribute("infoError", "Email không đúng định dạng!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        if (!email.equalsIgnoreCase(sessionUser.getEmail())) {
            User existing = userDAO.getUserByEmail(email);
            if (existing != null && existing.getId() != sessionUser.getId()) {
                request.setAttribute("infoError", "Email này đã được sử dụng bởi tài khoản khác!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
        }

        sessionUser.setFullName(fullName.trim());
        sessionUser.setEmail(email.trim());
        boolean ok = userDAO.updateUser(sessionUser);
        if (ok) {
            session.setAttribute("user", sessionUser);
            request.setAttribute("infoSuccess", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("infoError", "Cập nhật thất bại, vui lòng thử lại!");
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

}