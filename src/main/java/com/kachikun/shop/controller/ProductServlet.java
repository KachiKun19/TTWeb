package com.kachikun.shop.controller;

import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.utils.AppCache;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ProductDAO productDAO;

	@Override
	public void init() throws ServletException {
		productDAO = new ProductDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String cateId    = request.getParameter("category");
		String indexPage = request.getParameter("index");

		int index = 1;
		if (indexPage != null && !indexPage.isEmpty()) {
			try {
				index = Integer.parseInt(indexPage);
			} catch (NumberFormatException e) {
				index = 1;
			}
		}

		// ✅ Dùng COUNT(*) OVER() — lấy list + total chỉ trong 1 query, tiết kiệm 1 round-trip DB
		ProductDAO.PageResult result;

		if (cateId == null || cateId.isEmpty()) {
			result = productDAO.pagingProductWithCount(index);
		} else {
			result = productDAO.pagingProductByCategoryWithCount(cateId, index);
		}

		List<Product> listProduct = result.products;
		int count                 = result.totalCount;

		int endPage = count / 3 + (count % 3 != 0 ? 1 : 0);

		List<Brand> listBrand = AppCache.getBrands();

		request.setAttribute("products",        listProduct);
		request.setAttribute("brands",          listBrand);
		request.setAttribute("currentCategory", cateId);
		request.setAttribute("endP",            endPage);
		request.setAttribute("tag",             index);

		request.getRequestDispatcher("product.jsp").forward(request, response);
	}
}