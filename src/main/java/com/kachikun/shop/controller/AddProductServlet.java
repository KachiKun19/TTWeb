package com.kachikun.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Brand;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.dao.BrandDAO;

@WebServlet("/addProduct")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private BrandDAO brandDAO = new BrandDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra đăng nhập và quyền admin
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
        
        // Lấy danh sách category và brand để hiển thị trong form
        List<Category> categories = categoryDAO.getAllCategories();
        List<Brand> brands = brandDAO.getAllBrands();
        
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        
        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra đăng nhập và quyền admin
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
        
        // Lấy thông tin từ form
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String image = request.getParameter("image");
        String stockStr = request.getParameter("stock");
        String connectionType = request.getParameter("connectionType");
        String material = request.getParameter("material");
        String size = request.getParameter("size");
        String categoryIdStr = request.getParameter("categoryId");
        String brandIdStr = request.getParameter("brandId");
        
        if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tên sản phẩm và giá là bắt buộc!");
            doGet(request, response);
            return;
        }
        
        try {
            double price = Double.parseDouble(priceStr);
            int stock = stockStr != null && !stockStr.trim().isEmpty() ? Integer.parseInt(stockStr) : 0;
            int categoryId = categoryIdStr != null && !categoryIdStr.trim().isEmpty() ? Integer.parseInt(categoryIdStr) : 0;
            int brandId = brandIdStr != null && !brandIdStr.trim().isEmpty() ? Integer.parseInt(brandIdStr) : 0;
            
            // Tạo đối tượng Product
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setImage(image);
            product.setStock(stock);
            product.setConnectionType(connectionType);
            product.setMaterial(material);
            product.setSize(size);
            
            if (categoryId > 0) {
                Category category = new Category();
                category.setId(categoryId);
                product.setCategory(category);
            }
            
            if (brandId > 0) {
                Brand brand = new Brand();
                brand.setId(brandId);
                product.setBrand(brand);
            }
            boolean success = productDAO.insertProduct(product);
            
            if (success) {
                // Thành công, chuyển hướng về trang quản lý sản phẩm
            	response.sendRedirect("adminProducts?page=1&success=true");
            } else {
                // Thất bại, hiển thị thông báo lỗi
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm sản phẩm!");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Giá hoặc số lượng không hợp lệ!");
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
    }
}