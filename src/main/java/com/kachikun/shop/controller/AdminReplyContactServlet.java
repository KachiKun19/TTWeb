package com.kachikun.shop.controller;

import com.kachikun.shop.dao.ContactDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/adminReply")
public class AdminReplyContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        String reply = request.getParameter("reply");

        if (idStr == null || idStr.trim().isEmpty() || reply == null || reply.trim().isEmpty()) {
            response.getWriter().println("Thiếu dữ liệu!");
            return;
        }

        int id = Integer.parseInt(idStr);

        ContactDAO dao = new ContactDAO();
        dao.updateReply(id, reply);

        // 👉 quay lại trang admin
        response.sendRedirect("adminContacts");
    }
}