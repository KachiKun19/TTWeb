package com.kachikun.shop.controller;

import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.dao.FeaturedProductDAO;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Discount;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;
import com.kachikun.shop.utils.AppCache;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final CategoryDAO categoryDAO       = new CategoryDAO();
    private final FeaturedProductDAO featuredDAO = new FeaturedProductDAO();
    private final DiscountDAO discountDAO        = new DiscountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = AppCache.getCategories();
        List<Product>  featuredProducts  = featuredDAO.getFeaturedProducts();

        Boolean sectionVisible = (Boolean) getServletContext().getAttribute("discountSectionVisible");
        List<Discount> activeDiscounts = (sectionVisible != null && sectionVisible)
                ? AppCache.getDiscounts()
                : java.util.Collections.emptyList();

        request.setAttribute("listCategories",   categories);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("activeDiscounts",  activeDiscounts);

        // Query thêm nếu user đã đăng nhập
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            Set<Integer> savedIds = discountDAO.getSavedDiscountIdsByUser(user.getId());
            request.setAttribute("savedDiscountIds", savedIds);
        }

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}