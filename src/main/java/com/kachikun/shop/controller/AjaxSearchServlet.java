package com.kachikun.shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
//lấy ảnh từ ajax search
public class AjaxSearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        //Lấy từ khóa
        String txtSearch = request.getParameter("txt");
        
        //Gọi DAO tìm kiếm
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.findByName(txtSearch);
        
        PrintWriter out = response.getWriter();
        
        //Trả về jsp (Vẽ giao diện sản phẩm ngay tại đây)
        if (list.isEmpty()) {
            out.println("<p class='text-center text-gray-500 py-4'>Không tìm thấy sản phẩm nào!</p>");
        } else {
            // Định dạng tiền tệ
            NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
            
            for (Product p : list) {
                out.println("<a href='detail?pid=" + p.getId() + "' class='flex items-center gap-4 p-3 hover:bg-gray-100 rounded-lg transition border-b border-gray-100'>");
                
                // Cột Ảnh
                out.println("  <img src='images/" + p.getImage() + "' alt='" + p.getName() + "' class='w-16 h-16 object-cover rounded'>");
                
                // Cột Thông tin
                out.println("  <div>");
                out.println("    <h4 class='text-sm font-semibold text-gray-800'>" + p.getName() + "</h4>");
                out.println("    <p class='text-red-600 font-bold text-sm'>" + nf.format(p.getPrice()) + "₫</p>");
                out.println("  </div>");
                
                out.println("</a>");
            }
        }
    }
}