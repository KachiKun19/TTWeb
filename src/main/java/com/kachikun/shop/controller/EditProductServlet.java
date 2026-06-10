package com.kachikun.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;

import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.BrandDAO;
import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.dao.ProductDAO;

@WebServlet("/editProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 10,
    maxRequestSize    = 1024 * 1024 * 15
)
public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private BrandDAO brandDAO = new BrandDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("adminProducts");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Product product = productDAO.getProductById(id);
            if (product == null) {
                response.sendRedirect("adminProducts?error=not_found");
                return;
            }

            List<Category> categories = categoryDAO.getAllCategories();
            List<Brand> brands = brandDAO.getAllBrands();

            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("brands", brands);
            request.getRequestDispatcher("editProduct.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("adminProducts");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String image = resolveImage(request);
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
            int id = Integer.parseInt(idParam);
            double price = Double.parseDouble(priceStr);
            int stock = stockStr != null && !stockStr.trim().isEmpty() ? Integer.parseInt(stockStr) : 0;
            int categoryId = categoryIdStr != null && !categoryIdStr.trim().isEmpty() ? Integer.parseInt(categoryIdStr) : 0;
            int brandId = brandIdStr != null && !brandIdStr.trim().isEmpty() ? Integer.parseInt(brandIdStr) : 0;

            Product product = new Product();
            product.setId(id);
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

            boolean success = productDAO.updateProduct(product);
            if (success) {
                response.sendRedirect("adminProducts?page=1&success=edit_success");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật sản phẩm!");
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

    private String resolveImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String original = filePart.getSubmittedFileName();
            if (original != null && !original.trim().isEmpty()) {
                String safeName = System.currentTimeMillis() + "_" + original.replaceAll("[^a-zA-Z0-9._-]", "_");
                saveImage(filePart, safeName);
                return safeName;
            }
        }
        return request.getParameter("image");
    }

    private void saveImage(Part filePart, String safeName) throws IOException {
        String uploadDir = System.getenv("UPLOAD_DIR");
        if (uploadDir != null && !uploadDir.trim().isEmpty()) {
            File dir = new File(uploadDir);
            dir.mkdirs();
            filePart.write(new File(dir, safeName).getAbsolutePath());
            return;
        }

        String servingDir = getServletContext().getRealPath("/images/");
        if (servingDir == null) return;
        new File(servingDir).mkdirs();
        filePart.write(servingDir + File.separator + safeName);

        try {
            File sourceDir = new File(servingDir, "../../../../src/main/webapp/images").getCanonicalFile();
            if (sourceDir.exists() && !sourceDir.equals(new File(servingDir).getCanonicalFile())) {
                File dest = new File(sourceDir, safeName);
                if (!dest.exists()) Files.copy(new File(servingDir, safeName).toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (IOException ignored) {}
    }
}
