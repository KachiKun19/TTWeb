package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.model.Order;
import com.kachikun.shop.model.User;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");

        // 2. Xử lý Hủy đơn hàng (nếu user bấm nút Hủy)
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        
        if ("cancel".equals(action) && idStr != null) {
            int orderId = Integer.parseInt(idStr);
            boolean cancelled = orderDAO.userCancelOrder(orderId);
            if (cancelled) {
                request.setAttribute("msg", "Đã hủy đơn hàng #" + orderId + " thành công.");
            } else {
                request.setAttribute("error", "Không thể hủy đơn hàng này (Đã giao hoặc đang vận chuyển).");
            }
        }

        // 3. Lấy danh sách đơn hàng của User này
        List<Order> myOrders = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("myOrders", myOrders);

        request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
    }
}