package com.kachikun.shop.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/review-bulk")
public class ReviewBulkServlet extends HttpServlet {
    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        try {
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(sb.toString(), JsonObject.class);
            int orderId = jsonObject.get("orderId").getAsInt();
            JsonArray reviewsArray = jsonObject.getAsJsonArray("reviews");

            boolean allSuccess = true;

            for (int i = 0; i < reviewsArray.size(); i++) {
                try {
                    JsonObject revJson = reviewsArray.get(i).getAsJsonObject();
                    Review r = new Review();
                    r.setOrderId(orderId);
                    r.setUserId(user.getId());
                    r.setProductId(revJson.get("productId").getAsInt());
                    r.setRating(Integer.parseInt(revJson.get("rating").getAsString()));
                    r.setComment(revJson.get("comment").getAsString());

                    boolean ok = reviewDAO.insertReview(r);
                    if (!ok) {
                        allSuccess = false;
                    }
                } catch (Exception e) {
                    System.out.println("Lỗi xử lý sản phẩm: " + e.getMessage());
                    allSuccess = false;
                }
            }

            if (reviewDAO.isAllProductsReviewed(orderId, user.getId())) {
                orderDAO.completeOrderByUser(orderId, user.getId());

                if (session != null) {
                    session.setAttribute("msg", "Cảm ơn bạn đã đánh giá toàn bộ đơn hàng!");
                }
            } else if (allSuccess) {
                if (session != null) {
                    session.setAttribute("msg", "Đánh giá của bạn đã được ghi nhận.");
                }
            }

            response.setContentType("application/json");
            response.getWriter().write("{\"status\": \"success\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}