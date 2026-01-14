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

	}

	@Override
	public void init() throws ServletException {

		try {
			productDAO = new ProductDAO();
			brandDAO = new BrandDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cateId = request.getParameter("category");
		String indexPage = request.getParameter("index");

		if (indexPage == null) {
			indexPage = "1";
		}
		int index = Integer.parseInt(indexPage);

		List<Product> listProduct = new ArrayList<>();
		int count = 0;

		if (cateId == null || cateId.isEmpty()) {

			count = productDAO.getTotalProducts();
			listProduct = productDAO.pagingProduct(index);
		} else {

			count = productDAO.countProductsByCategory(cateId);
			listProduct = productDAO.pagingProductByCategory(cateId, index);
		}

		int endPage = count / 3;
		if (count % 3 != 0) {
			endPage++;
		}

		List<Brand> listBrand = brandDAO.getAllBrands();

		request.setAttribute("products", listProduct);
		request.setAttribute("brands", listBrand);
		request.setAttribute("currentCategory", cateId);

		request.setAttribute("endP", endPage);
		request.setAttribute("tag", index);

		request.getRequestDispatcher("product.jsp").forward(request, response);
	}
}