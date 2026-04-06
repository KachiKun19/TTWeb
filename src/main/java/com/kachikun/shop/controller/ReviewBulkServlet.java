package com.kachikun.shop.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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
                JsonObject revJson = reviewsArray.get(i).getAsJsonObject();
                
                Review r = new Review();
                r.setOrderId(orderId);
                r.setUserId(user.getId());
                r.setProductId(revJson.get("productId").getAsInt());
                r.setRating(revJson.get("rating").getAsInt());
                r.setComment(revJson.get("comment").getAsString());

                boolean ok = reviewDAO.insertReview(r);
                if (!ok) allSuccess = false;
            }

            response.setContentType("application/json");
            if (allSuccess) {
                response.getWriter().write("{\"status\": \"success\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\": \"partial_error\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}