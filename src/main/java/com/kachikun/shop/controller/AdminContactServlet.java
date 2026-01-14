package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // Quan trọng: Dòng này định nghĩa đường dẫn
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.ContactDAO;
import com.kachikun.shop.model.ContactMessage;
import com.kachikun.shop.model.User;

@WebServlet("/adminContacts") 
public class AdminContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContactDAO contactDAO = new ContactDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        
        if ("markRead".equals(action) && idStr != null) {
            contactDAO.updateStatus(Integer.parseInt(idStr), "Đã xem");
            response.sendRedirect("adminContacts"); 
            return;
        }

        List<ContactMessage> list = contactDAO.getAllMessages();
        
        request.setAttribute("messages", list);
        request.getRequestDispatcher("adminContacts.jsp").forward(request, response);
    }
}