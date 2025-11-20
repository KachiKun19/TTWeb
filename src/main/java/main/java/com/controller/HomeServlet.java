package main.java.com.controller;

import main.java.com.dao.ProductDAO;
import main.java.com.dao.CategoryDAO;
import main.java.com.model.Product;
import main.java.com.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy danh sách sản phẩm nổi bật
            List<Product> featuredProducts = productDAO.getFeaturedProducts();
            
            // Lấy danh sách danh mục
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Đặt thuộc tính cho request
            request.setAttribute("featuredProducts", featuredProducts);
            request.setAttribute("categories", categories);
            
            // Chuyển hướng đến trang home.jsp   hhhhjhjyh
            request.getRequestDispatcher("/Home.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server");
        }
    }
}