package com.kachikun.shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.Product;

@WebServlet("/ajaxFilter")
public class AjaxFilterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String category = request.getParameter("category");
        String[] brandIds = request.getParameterValues("brand");
        String[] connections = request.getParameterValues("connection");
        String[] materials = request.getParameterValues("material");
        String[] sizes = request.getParameterValues("size");

        String sort = request.getParameter("sort");

        String indexPage = request.getParameter("index");
        int index = 1;
        try {
            if (indexPage != null && !indexPage.isEmpty()) {
                index = Integer.parseInt(indexPage);
                if (index < 1)
                    index = 1;
            }
        } catch (Exception e) {
            index = 1;
        }
        // xu ly logic
        ProductDAO dao = new ProductDAO();

        int total = dao.countFilteredProducts(brandIds, connections, materials, sizes, category);
        int endPage = total / 3;
        if (total % 3 != 0)
            endPage++;

        List<Product> list = dao.filterProducts(brandIds, connections, materials, sizes, category, index, sort);

        // dua du lieu qua jsp
        request.setAttribute("products", list);
        request.setAttribute("total", total);
        request.setAttribute("endPage", endPage);
        request.setAttribute("index", index);

        request.getRequestDispatcher("ajaxFilterResult.jsp").forward(request, response);
    }
}