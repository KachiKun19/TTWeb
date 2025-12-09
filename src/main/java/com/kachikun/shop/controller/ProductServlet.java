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
		// lấy tham số từ category(chuột, bàn phím cơ)
		String cateId = request.getParameter("category");
		
		List<Product> listProduct = new ArrayList<>();
		if(cateId == null || cateId.isEmpty()) {
			listProduct = productDAO.getAllProducts();
		} else {
			//test hàm lọc
			listProduct = productDAO.findByCategoryName(cateId);
		}
		
		// cột thương hiệu 
		List<Brand> listBrand = brandDAO.getAllBrands();
		// Đẩy sang jsp
		request.setAttribute("products", listProduct);
		request.setAttribute("brands", listBrand);
		// gửi category hiện tại cho jsp để xác định đang ở trang nào
		request.setAttribute("currentCategory", cateId);
		// chuyển hướng qua cho product.jsp
		request.getRequestDispatcher("product.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
