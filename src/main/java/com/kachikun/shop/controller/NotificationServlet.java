package com.kachikun.shop.controller;

import com.kachikun.shop.dao.ContactDAO;
import com.kachikun.shop.dao.ReplyDAO;
import com.kachikun.shop.model.Reply;
import com.kachikun.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        ReplyDAO dao = new ReplyDAO();
        dao.markAsRead(user.getEmail());

        List<Reply> list = dao.getRepliesByUser(user.getEmail());

        request.setAttribute("list", list);
        request.getRequestDispatcher("notifications.jsp").forward(request, response);
    }
}

