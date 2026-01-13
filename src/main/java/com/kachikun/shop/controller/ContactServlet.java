package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.kachikun.shop.dao.ContactDAO;
import com.kachikun.shop.model.ContactMessage;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Quan trọng để nhận tiếng Việt
        
        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        ContactMessage msg = new ContactMessage(name, email, phone, subject, message);
        ContactDAO dao = new ContactDAO();
        
        boolean success = dao.insertMessage(msg);
        
        if (success) {
            request.setAttribute("successMessage", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi sớm nhất.");
        } else {
            request.setAttribute("errorMessage", "Có lỗi xảy ra. Vui lòng thử lại sau!");
        }
        
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}