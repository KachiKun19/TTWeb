package com.kachikun.shop.controller;

import com.kachikun.shop.dao.ContactDAO;
import com.kachikun.shop.model.ContactMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/adminReply")
public class ReplyContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.getWriter().println("Lỗi: ID bị null!");
            return;
        }

        int id = Integer.parseInt(idStr);
        String reply = request.getParameter("reply");

        ContactDAO dao = new ContactDAO();
        dao.updateReply(id, reply);

        response.sendRedirect("adminContacts");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idStr = req.getParameter("id");

        if (idStr == null) {
            resp.sendRedirect("adminContacts");
            return;
        }

        int id = Integer.parseInt(idStr);

        ContactDAO dao = new ContactDAO();
        ContactMessage c = dao.getById(id);

        req.setAttribute("contact", c);
        req.getRequestDispatcher("adminReply.jsp").forward(req, resp);

    }
}

