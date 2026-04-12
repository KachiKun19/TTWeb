package com.kachikun.shop.controller;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.dao.ReviewDAO;
import com.kachikun.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/order-review")
public class OrderReviewServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final ReviewDAO reviewDAO = new ReviewDAO();

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
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            var order = orderDAO.getOrderById(orderId);

            if (order == null || order.getUser().getId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            List<Integer> unreviewedIds = reviewDAO.getUnreviewedProductIds(orderId, user.getId());

            var allDetails = orderDAO.getOrderDetail(orderId);
            var unreviewedDetails = allDetails.stream()
                    .filter(d -> unreviewedIds.contains(d.getProduct().getId()))
                    .collect(Collectors.toList());

            request.setAttribute("order", order);
            request.setAttribute("orderDetails", unreviewedDetails);

            request.getRequestDispatcher("orderReview.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "orderId không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
}