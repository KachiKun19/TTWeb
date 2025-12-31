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
        
        if ("view".equals(action)) {
            String idStr = request.getParameter("id");
            int orderId = Integer.parseInt(idStr);
            
            Order order = orderDAO.getOrderById(orderId);
            List<OrderDetail> details = orderDAO.getOrderDetail(orderId);
            
            request.setAttribute("order", order);
            request.setAttribute("details", details);
            request.getRequestDispatcher("adminOrderDetail.jsp").forward(request, response);
            
        } else if ("update".equals(action)) {
            String idStr = request.getParameter("id");
            String status = request.getParameter("status"); 
            
            orderDAO.updateStatus(Integer.parseInt(idStr), status);
            response.sendRedirect("adminOrders"); 
            
        } else {
            List<Order> list = orderDAO.getAllOrders();
            request.setAttribute("orders", list);
            request.getRequestDispatcher("adminOrders.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}