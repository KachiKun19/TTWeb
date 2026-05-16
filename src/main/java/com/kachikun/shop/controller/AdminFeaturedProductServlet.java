package com.kachikun.shop.controller;

import com.kachikun.shop.dao.FeaturedProductDAO;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/adminFeaturedProducts")
public class AdminFeaturedProductServlet extends HttpServlet {

    private final FeaturedProductDAO featuredDAO = new FeaturedProductDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() != 1) {
            response.sendRedirect("login");
            return;
        }

        List<Product> allProducts = productDAO.getAllProducts();
        List<Integer> featuredIds = featuredDAO.getFeaturedProductIds();

        Map<String, List<Product>> productsByCategory = new LinkedHashMap<>();
        for (Product p : allProducts) {
            String catName = p.getCategory() != null ? p.getCategory().getName() : "Khác";
            productsByCategory.computeIfAbsent(catName, k -> new ArrayList<>()).add(p);
        }

        request.setAttribute("productsByCategory", productsByCategory);
        request.setAttribute("featuredIds", featuredIds);
        request.getRequestDispatcher("adminFeaturedProducts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() != 1) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");

        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect("adminFeaturedProducts?error=invalid");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("adminFeaturedProducts?error=invalid");
            return;
        }

        if ("add".equals(action)) {
            boolean ok = featuredDAO.addFeaturedProduct(productId);
            response.sendRedirect("adminFeaturedProducts?" + (ok ? "success=added" : "error=add_failed"));
        } else if ("remove".equals(action)) {
            boolean ok = featuredDAO.removeFeaturedProduct(productId);
            response.sendRedirect("adminFeaturedProducts?" + (ok ? "success=removed" : "error=remove_failed"));
        } else {
            response.sendRedirect("adminFeaturedProducts?error=invalid");
        }
    }
}
