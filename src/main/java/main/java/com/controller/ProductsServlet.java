package main.java.com.controller;

import main.java.com.dao.ProductDAO;
import main.java.com.dao.CategoryDAO;
import main.java.com.dao.BrandDAO;
import main.java.com.model.Product;
import main.java.com.model.Category;
import main.java.com.model.Brand;


import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private BrandDAO brandDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        brandDAO = new BrandDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get filter parameters
        String categoryParam = request.getParameter("category");
        String brandParam = request.getParameter("brand");
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        String stockParam = request.getParameter("stock");
        String sortParam = request.getParameter("sort");
        String pageParam = request.getParameter("page");
        
        // Get current page (default to 1)
        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        // Set items per page
        int itemsPerPage = 16;
        
        // Get all products (filtered)
        List<Product> allProducts;
        
        if (categoryParam != null && !categoryParam.equals("all") && !categoryParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                allProducts = productDAO.getProductsByCategory(categoryId);
            } catch (NumberFormatException e) {
                allProducts = productDAO.getAllProducts();
            }
        } else if (brandParam != null && !brandParam.equals("all") && !brandParam.isEmpty()) {
            try {
                int brandId = Integer.parseInt(brandParam);
                allProducts = productDAO.getProductsByBrand(brandId);
            } catch (NumberFormatException e) {
                allProducts = productDAO.getAllProducts();
            }
        } else {
            allProducts = productDAO.getAllProducts();
        }
        
        // Apply additional filters (price, stock) here if needed
        // This is simplified - in a real app you would implement full filtering
        
        // Apply sorting
        if (sortParam != null) {
            switch (sortParam) {
                case "price-low":
                    allProducts.sort((p1, p2) -> Double.compare(p1.getPrice(), p2.getPrice()));
                    break;
                case "price-high":
                    allProducts.sort((p1, p2) -> Double.compare(p2.getPrice(), p1.getPrice()));
                    break;
                case "name-asc":
                    allProducts.sort((p1, p2) -> p1.getName().compareToIgnoreCase(p2.getName()));
                    break;
                case "name-desc":
                    allProducts.sort((p1, p2) -> p2.getName().compareToIgnoreCase(p1.getName()));
                    break;
                case "newest":
                default:
                    // Already sorted by newest (productId DESC) in DAO
                    break;
            }
        }
        
        // Calculate pagination
        int totalProducts = allProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / itemsPerPage);
        
        // Ensure current page is valid
        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;
        
        // Get products for current page
        int startIndex = (currentPage - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, totalProducts);
        
        List<Product> productsForPage = allProducts.subList(startIndex, endIndex);
        
        // Get categories and brands for filter sidebar
        List<Category> categories = categoryDAO.getAllCategories();
        List<Brand> brands = brandDAO.getAllBrands();
        
        // Set attributes for JSP
        request.setAttribute("products", productsForPage);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        
        // Forward to JSP
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}