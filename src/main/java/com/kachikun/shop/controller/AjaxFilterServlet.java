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

        ProductDAO dao = new ProductDAO();

        int total = dao.countFilteredProducts(brandIds, connections, materials, sizes, category);
        int endPage = total / 3;
        if (total % 3 != 0)
            endPage++;

        List<Product> list = dao.filterProducts(brandIds, connections, materials, sizes, category, index, sort);

        PrintWriter out = response.getWriter();
        out.println("<input type='hidden' id='ajax-total-res' value='" + total + "' />");

        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));

        if (list.isEmpty()) {
            out.println("<div class='col-span-3 text-center py-12'>Không tìm thấy sản phẩm nào phù hợp.</div>");
        }

        for (Product p : list) {
            out.println(
                    "<div class='product-card border rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-shadow duration-300 group product-item'>");

            out.println("<div class='relative block'>");
            out.println("<a href='product-detail?id=" + p.getId() + "'>"); // Mở thẻ link detail
            out.println("<img src='images/" + p.getImage() + "' class='w-full h-56 object-contain p-4' />");
            out.println("</a>");

            // Nút chọn nhanh
            out.println("<div class='absolute inset-x-4 bottom-4'>");
            out.println("<a href='add-to-cart?id=" + p.getId()
                    + "' class='block w-full bg-blue-600 text-white font-semibold py-2 rounded-lg text-center opacity-0 group-hover:opacity-100 transition-opacity duration-300'>+ Chọn nhanh</a>");
            out.println("</div>");
            out.println("</div>");

            out.println("<div class='p-4'>");
            out.println("<h3 class='font-semibold text-base h-16 overflow-hidden line-clamp-2'>");
            out.println("<a href='product-detail?id=" + p.getId() + "' class='hover:text-blue-600'>" + p.getName()
                    + "</a>");
            out.println("</h3>");
            out.println("<p class='text-lg font-bold text-gray-800 mt-2'>" + nf.format(p.getPrice()) + "₫</p>");
            out.println("</div>");

            out.println("</div>");
        }
        if (endPage > 1) {
            out.println("<div class='col-span-1 sm:col-span-2 lg:col-span-3 flex justify-center mt-8 space-x-2 py-4'>");
            for (int i = 1; i <= endPage; i++) {
                String activeClass = (index == i) ? "bg-pink-600 text-white font-bold"
                        : "bg-white text-gray-700 hover:bg-pink-500 hover:text-white";
                out.println("<button onclick='filterProducts(" + i
                        + ")' class='px-4 py-2 border rounded-lg transition-colors duration-300 " + activeClass + "'>"
                        + i + "</button>");
            }
            out.println("</div>");
        }
    }
}