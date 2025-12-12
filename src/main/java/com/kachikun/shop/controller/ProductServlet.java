package com.kachikun.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.dao.BrandDAO;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Product;


@WebServlet("/products")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private ProductDAO productDAO;
    private BrandDAO brandDAO;
    
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public void init() throws ServletException {
        // 2. New ở trong này. Nếu lỗi database, nó sẽ báo lỗi nhưng Server vẫn cố khởi động được
        try {
            productDAO = new ProductDAO();
            brandDAO = new BrandDAO();
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra màn hình Console để đọc
        }
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cateId = request.getParameter("category");
        String indexPage = request.getParameter("index");

        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        List<Product> listProduct = new ArrayList<>();
        int count = 0; // Tổng số sản phẩm tìm được

        //KIỂM TRA ĐANG Ở CHẾ ĐỘ NÀO ĐỂ LẤY DỮ LIỆU
        if (cateId == null || cateId.isEmpty()) {
            //Xem tất cả (Home -> Xem thêm)
            count = productDAO.getTotalProducts();     // Đếm tất cả
            listProduct = productDAO.pagingProduct(index); // Phân trang tất cả
        } else {
            //Đang lọc theo danh mục
            count = productDAO.countProductsByCategory(cateId); // Đếm theo danh mục
            listProduct = productDAO.pagingProductByCategory(cateId, index); // Phân trang theo danh mục
        }

        //tính số trang
        int endPage = count / 3;
        if (count % 3 != 0) {
            endPage++;
        }

        List<Brand> listBrand = brandDAO.getAllBrands();

        // đưa qua sql
        request.setAttribute("products", listProduct);
        request.setAttribute("brands", listBrand);
        request.setAttribute("currentCategory", cateId);
        
        request.setAttribute("endP", endPage); // Tổng số trang
        request.setAttribute("tag", index);    // Trang hiện tại

        request.getRequestDispatcher("product.jsp").forward(request, response);
    }
}