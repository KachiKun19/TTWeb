package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.Product;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CategoryDAO cateDAO = new CategoryDAO();

	private ProductDAO productDAO = new ProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Product> list = productDAO.getAllProducts();
		List<Category> listC = cateDAO.getAllCategories();

		System.out.println("====================================");
		System.out.println("DEBUG: Đang chạy HomeServlet");
		System.out.println("DEBUG: Số lượng sản phẩm lấy được: " + list.size());
		if (list.size() > 0) {
			System.out.println("DEBUG: Sản phẩm đầu tiên là: " + list.get(0).getName());
		}
		System.out.println("====================================");

		request.setAttribute("products", list);

		request.setAttribute("listCategories", listC);

		request.getRequestDispatcher("home.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}