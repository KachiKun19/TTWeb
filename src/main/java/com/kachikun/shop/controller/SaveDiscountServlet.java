package com.kachikun.shop.controller;

import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/save-discount")
public class SaveDiscountServlet extends HttpServlet {
    private final DiscountDAO discountDAO = new DiscountDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Vui lòng đăng nhập để lưu mã!\"}");
            return;
        }

        User user = (User) session.getAttribute("user");
        String discountIdStr = request.getParameter("discountId");

        if (discountIdStr == null || discountIdStr.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Mã không hợp lệ!\"}");
            return;
        }

        try {
            int discountId = Integer.parseInt(discountIdStr);
            boolean saved = discountDAO.saveForUser(user.getId(), discountId);
            if (saved) {
                response.getWriter().write("{\"status\":\"ok\",\"message\":\"Đã lưu mã thành công!\"}");
            } else {
                response.getWriter().write("{\"status\":\"already\",\"message\":\"Bạn đã lưu mã này rồi!\"}");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Mã không hợp lệ!\"}");
        }
    }
}
