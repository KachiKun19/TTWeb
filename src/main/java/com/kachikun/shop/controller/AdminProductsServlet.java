package com.kachikun.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.ProductDAO;

@WebServlet("/adminProducts")
public class AdminProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

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
        
        String pageParam = request.getParameter("page");
        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        int pageSize = 10;
        
        int totalProducts = productDAO.getTotalProducts();
        
        int totalPages = 0;
        if (totalProducts > 0) {
            totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        }
        
        if (totalPages > 0 && currentPage > totalPages) {
            currentPage = totalPages;
        }
        
        List<Product> productList = productDAO.getProductsByPage(currentPage, pageSize);
        
        System.out.println("Current Page: " + currentPage);
        System.out.println("Total Pages: " + totalPages);
        System.out.println("Total Products: " + totalProducts);
        System.out.println("Product List Size: " + (productList != null ? productList.size() : 0));
        System.out.println("================================");
        
        request.setAttribute("productList", productList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        
        request.getRequestDispatcher("adminProducts.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}