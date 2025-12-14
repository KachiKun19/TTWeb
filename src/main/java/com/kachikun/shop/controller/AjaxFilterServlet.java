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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        //Lấy danh sách các Brand ID được tích
        String[] brandIds = request.getParameterValues("brand");
        String[] connections = request.getParameterValues("connection");
        String[] materials = request.getParameterValues("material");
        String[] sizes = request.getParameterValues("size"); // Mới thêm

        ProductDAO dao = new ProductDAO();
        // Gọi hàm DAO mới (nhớ sửa bên DAO nhận 4 tham số nhé)
        List<Product> list = dao.filterProducts(brandIds, connections, materials, sizes);
        
        //Trả về HTML 
        PrintWriter out = response.getWriter();
        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));

        if(list.isEmpty()){
             out.println("<div class='col-span-3 text-center py-12'>Không tìm thấy sản phẩm nào phù hợp.</div>");
        }

        for (Product p : list) {
            out.println("<div class='product-card border rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-shadow duration-300 group product-item'>");
            
            // Phần ảnh và nút chọn nhanh 
            out.println("<div class='relative block'>");
            out.println("<img src='images/" + p.getImage() + "' class='w-full h-56 object-contain p-4' />");
            // Nút chọn nhanh 
            out.println("<div class='absolute inset-x-4 bottom-4'>");
            out.println("<a href='add-to-cart?id=" + p.getId() + "' class='block w-full bg-blue-600 text-white font-semibold py-2 rounded-lg text-center opacity-0 group-hover:opacity-100 transition-opacity duration-300'>+ Chọn nhanh</a>");
            out.println("</div>");
            out.println("</div>"); 
            
            // Phần thông tin tên giá
            out.println("<div class='p-4'>");
            out.println("<h3 class='font-semibold text-base h-16 overflow-hidden line-clamp-2'>" + p.getName() + "</h3>");
            out.println("<p class='text-lg font-bold text-gray-800 mt-2'>" + nf.format(p.getPrice()) + "₫</p>");
            out.println("</div>");
            
            out.println("</div>");
        }
    }
}