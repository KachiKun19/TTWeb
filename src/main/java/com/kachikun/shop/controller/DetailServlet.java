package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.dao.ReviewDAO;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.Review;
import com.kachikun.shop.model.User;

import java.util.List;

@WebServlet("/product-detail")
public class DetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ReviewDAO reviewDAO = new ReviewDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null) {
            response.sendRedirect("home");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(id);

            if (p == null) {
                response.sendRedirect("home");
                return;
            }

            // ds review
            List<Review> reviews = reviewDAO.getReviewsByProductId(id);
            //sô sao
            int[] ratingDist = reviewDAO.getRatingDistribution(id);
            //check user đã mua và có thể review không
            HttpSession session = request.getSession(false);
            boolean canReview = false;
            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                canReview = reviewDAO.getEligibleOrderId(id, user.getId()) != -1;
            }

            request.setAttribute("detail", p);
            request.setAttribute("reviews", reviews);
            request.setAttribute("ratingDist", ratingDist);
            request.setAttribute("canReview", canReview);
            request.getRequestDispatcher("detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
}