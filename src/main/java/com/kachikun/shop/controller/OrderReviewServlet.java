package com.kachikun.shop.controller;

import com.kachikun.shop.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/order-review")
public class OrderReviewServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        System.out.println("🔍 OrderReviewServlet received orderId = " + orderIdStr); // Debug

        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu orderId");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);

            var order = orderDAO.getOrderById(orderId);
            var orderDetails = orderDAO.getOrderDetail(orderId);

            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng");
                return;
            }

            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);

            request.getRequestDispatcher("orderReview.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "orderId không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
}