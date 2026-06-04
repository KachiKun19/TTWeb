package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Discount;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.dao.FeaturedProductDAO;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CategoryDAO cateDAO = new CategoryDAO();
    private ProductDAO productDAO = new ProductDAO();
    private FeaturedProductDAO featuredDAO = new FeaturedProductDAO();
    private DiscountDAO discountDAO = new DiscountDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> list = productDAO.getAllProducts();
        List<Category> listC = cateDAO.getAllCategories();
        List<Product> featuredProducts = featuredDAO.getFeaturedProducts();
        Boolean sectionVisible = (Boolean) getServletContext().getAttribute("discountSectionVisible");
        List<Discount> activeDiscounts = (sectionVisible != null && sectionVisible) // mặc định ẩn
                ? discountDAO.getActiveDiscounts()
                : java.util.Collections.emptyList();

        request.setAttribute("products", list);
        request.setAttribute("listCategories", listC);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("activeDiscounts", activeDiscounts);

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            Set<Integer> savedIds = discountDAO.getSavedDiscountIdsByUser(user.getId());
            request.setAttribute("savedDiscountIds", savedIds);
        }

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}