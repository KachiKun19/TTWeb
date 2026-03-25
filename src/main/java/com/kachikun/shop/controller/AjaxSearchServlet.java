package com.kachikun.shop.controller;

import java.io.IOException;

import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.text.NumberFormat;
import java.util.Locale;

import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.Product;

@WebServlet("/ajaxSearch")
public class AjaxSearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String txtSearch = request.getParameter("txt");

        // xu ly logic
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.findByName(txtSearch);

        // dua du lieu qua jsp
        request.setAttribute("searchResults", list);

        request.getRequestDispatcher("ajaxSearchResult.jsp").forward(request, response);
    }
}