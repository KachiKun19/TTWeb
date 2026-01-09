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

// Dòng này rất quan trọng, nó khớp với cái href="adminContacts" bên JSP
@WebServlet("/adminContacts") 
public class AdminContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContactDAO contactDAO = new ContactDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Kiểm tra quyền Admin
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

        // 2. Xử lý đánh dấu đã xem (nếu có bấm nút V)
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        
        if ("markRead".equals(action) && idStr != null) {
            contactDAO.updateStatus(Integer.parseInt(idStr), "Đã xem");
            // Load lại trang để cập nhật trạng thái
            response.sendRedirect("adminContacts"); 
            return;
        }

        // 3. Lấy danh sách tin nhắn từ Database
        List<ContactMessage> list = contactDAO.getAllMessages();
        
        // 4. Đẩy dữ liệu sang trang JSP để hiển thị
        request.setAttribute("messages", list);
        request.getRequestDispatcher("adminContacts.jsp").forward(request, response);
    }
}