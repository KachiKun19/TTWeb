package com.kachikun.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.model.Order;
import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.User;

@WebServlet("/adminOrders")
public class AdminOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login"); return;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            response.sendRedirect("home"); return;
        }

        String action = request.getParameter("action");

        if ("view".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(orderId);
            List<OrderDetail> details = orderDAO.getOrderDetail(orderId);
            request.setAttribute("order", order);
            request.setAttribute("details", details);
            request.getRequestDispatcher("adminOrderDetail.jsp").forward(request, response);

            // ── Cập nhật trạng thái
        } else if ("update".equals(action)) {
            int    orderId    = Integer.parseInt(request.getParameter("id"));
            String newStatus  = request.getParameter("status");
            String reason     = request.getParameter("cancel_reason"); // chỉ dùng khi hủy

            // Nếu admin hủy đơn thì gọi adminCancelOrder để hoàn stock
            if (Order.STATUS_CANCELLED.equals(newStatus)) {
                boolean ok = orderDAO.adminCancelOrder(orderId, reason);
                if (ok) {
                    response.sendRedirect("adminOrders?success=cancelled");
                } else {
                    response.sendRedirect("adminOrders?error=cannot_cancel&id=" + orderId);
                }
                return;
            }

            boolean ok = orderDAO.adminUpdateStatus(orderId, newStatus);
            if (ok) {
                response.sendRedirect("adminOrders?success=updated");
            } else {
                response.sendRedirect("adminOrders?error=invalid_transition&id=" + orderId);
            }

        } else {
            List<Order> list = orderDAO.getAllOrders();
            request.setAttribute("orders", list);
            request.getRequestDispatcher("adminOrders.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}