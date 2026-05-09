package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.dao.FeaturedProductDAO;
import com.kachikun.shop.model.Product;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CategoryDAO cateDAO = new CategoryDAO();
    private ProductDAO productDAO = new ProductDAO();
    private FeaturedProductDAO featuredDAO = new FeaturedProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> list = productDAO.getAllProducts();
        List<Category> listC = cateDAO.getAllCategories();
        List<Product> featuredProducts = featuredDAO.getFeaturedProducts();

        request.setAttribute("products", list);
        request.setAttribute("listCategories", listC);
        request.setAttribute("featuredProducts", featuredProducts);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}