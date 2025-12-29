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
        // Kiểm tra đăng nhập và quyền admin
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
        
        // Lấy số trang từ tham số, mặc định là trang 1
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
        
        // Số sản phẩm mỗi trang
        int pageSize = 10;
        
        // Lấy tổng số sản phẩm
        int totalProducts = productDAO.getTotalProducts();
        
        // Tính tổng số trang
        int totalPages = 0;
        if (totalProducts > 0) {
            totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        }
        
        // Đảm bảo currentPage không vượt quá totalPages
        if (totalPages > 0 && currentPage > totalPages) {
            currentPage = totalPages;
        }
        
        // Lấy danh sách sản phẩm theo trang
        List<Product> productList = productDAO.getProductsByPage(currentPage, pageSize);
        
        // Debug log
        System.out.println("=== DEBUG: Admin Products Pagination ===");
        System.out.println("Current Page: " + currentPage);
        System.out.println("Total Pages: " + totalPages);
        System.out.println("Total Products: " + totalProducts);
        System.out.println("Product List Size: " + (productList != null ? productList.size() : 0));
        System.out.println("================================");
        
        // Truyền dữ liệu sang JSP
        request.setAttribute("productList", productList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        
        // Chuyển đến trang quản lý sản phẩm
        request.getRequestDispatcher("adminProducts.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}