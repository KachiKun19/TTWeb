package com.kachikun.shop.controller;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.dao.ReviewDAO;
import com.kachikun.shop.model.Review;
import com.kachikun.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final OrderDAO  orderDAO  = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String productIdStr = request.getParameter("productId");
        String ratingStr    = request.getParameter("rating");
        String comment      = request.getParameter("comment");

        if (productIdStr == null || ratingStr == null) {
            response.sendRedirect("home");
            return;
        }

        int productId;
        int rating;
        try {
            productId = Integer.parseInt(productIdStr);
            rating    = Integer.parseInt(ratingStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
            return;
        }

        if (rating < 1 || rating > 5) {
            response.sendRedirect("order-history?reviewError=invalid");
            return;
        }

        // Lấy order_id hợp lệ
        int orderId = reviewDAO.getEligibleOrderId(productId, user.getId());
        if (orderId == -1) {
            response.sendRedirect("order-history?reviewError=notEligible");
            return;
        }

        // Lưu review
        Review review = new Review();
        review.setProductId(productId);
        review.setUserId(user.getId());
        review.setOrderId(orderId);
        review.setRating(rating);
        review.setComment(comment != null ? comment.trim() : "");

        boolean ok = reviewDAO.insertReview(review);

        if (ok) {
            if (reviewDAO.isAllProductsReviewed(orderId, user.getId())) {
                orderDAO.completeOrderByUser(orderId, user.getId());
            }
            response.sendRedirect("order-history?reviewSuccess=1");
        } else {
            response.sendRedirect("order-history?reviewError=failed");
        }
    }
}