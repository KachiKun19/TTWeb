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
import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.User;

@WebServlet("/order-tracking")
public class OrderTrackingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp"); return;
        }
        User user = (User) session.getAttribute("user");

        String idStr = request.getParameter("id");
        if (idStr == null) { response.sendRedirect("order-history"); return; }

        int orderId = Integer.parseInt(idStr);
        Order order = orderDAO.getOrderById(orderId);

        // check đơn có phải của ng dùng ko
        if (order == null
                || (user.getRole() != 1 && order.getUser().getId() != user.getId())) {
            response.sendRedirect("order-history"); return;
        }

        List<OrderDetail> details = orderDAO.getOrderDetail(orderId);
        request.setAttribute("order", order);
        request.setAttribute("details", details);
        request.getRequestDispatcher("orderTracking.jsp").forward(request, response);
    }
}