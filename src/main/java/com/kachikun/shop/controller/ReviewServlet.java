package com.kachikun.shop.controller;

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        // thông tin từ dánh giá
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
            response.sendRedirect("product-detail?id=" + productId + "&reviewError=invalid");
            return;
        }

        if (!reviewDAO.hasPurchased(productId, user.getId())) {
            response.sendRedirect("product-detail?id=" + productId + "&reviewError=notPurchased");
            return;
        }

        //Lấy order_id chưa review
        int orderId = reviewDAO.getEligibleOrderId(productId, user.getId());
        if (orderId == -1) {
            // Đã review tất cả đơn có sản phẩm này
            response.sendRedirect("product-detail?id=" + productId + "&reviewError=alreadyReviewed");
            return;
        }
        // lưu review vào database
        Review review = new Review();
        review.setProductId(productId);
        review.setUserId(user.getId());
        review.setOrderId(orderId);
        review.setRating(rating);
        review.setComment(comment != null ? comment.trim() : "");

        boolean ok = reviewDAO.insertReview(review);

        if (ok) {
            response.sendRedirect("product-detail?id=" + productId + "&reviewSuccess=1");
        } else {
            response.sendRedirect("product-detail?id=" + productId + "&reviewError=failed");
        }
    }
}