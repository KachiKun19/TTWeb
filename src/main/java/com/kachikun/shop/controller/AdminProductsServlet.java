package com.kachikun.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;

@WebServlet("/adminProducts")
public class AdminProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        // -- Tham số trang
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try { currentPage = Math.max(1, Integer.parseInt(pageParam)); }
            catch (NumberFormatException ignored) {}
        }

        // -- Tham số danh mục (rỗng = tất cả)
        String category = request.getParameter("category");
        if (category == null) category = "";

        int pageSize = 10;
        int totalProducts;
        List<Product> productList;

        if (!category.isEmpty()) {
            totalProducts = productDAO.countProductsByCategoryExact(category);
            productList   = productDAO.getProductsByPageAndCategory(category, currentPage, pageSize);
        } else {
            totalProducts = productDAO.getTotalProducts();
            productList   = productDAO.getProductsByPage(currentPage, pageSize);
        }

        int totalPages = (totalProducts > 0) ? (int) Math.ceil((double) totalProducts / pageSize) : 0;
        if (totalPages > 0 && currentPage > totalPages) currentPage = totalPages;

        // -- Danh sách danh mục cho tab bar
        List<Category> categories = categoryDAO.getAllCategories();

        // -- Encode category cho URL (tránh lỗi ký tự tiếng Việt)
        String encodedCategory = URLEncoder.encode(category, "UTF-8");

        request.setAttribute("productList",      productList);
        request.setAttribute("currentPage",      currentPage);
        request.setAttribute("totalPages",       totalPages);
        request.setAttribute("totalProducts",    totalProducts);
        request.setAttribute("categories",       categories);
        request.setAttribute("currentCategory",  category);
        request.setAttribute("encodedCategory",  encodedCategory);

        request.getRequestDispatcher("adminProducts.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
