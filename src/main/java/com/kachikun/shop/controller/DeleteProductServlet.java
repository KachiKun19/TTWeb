package com.kachikun.shop.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import com.kachikun.shop.model.User;
import com.kachikun.shop.dao.ProductDAO;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO = new ProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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

		String productIdStr = request.getParameter("id");
		String pageParam = request.getParameter("page");

		if (productIdStr == null || productIdStr.trim().isEmpty()) {
			response.sendRedirect("adminProducts?error=invalid_id");
			return;
		}

		try {
			int productId = Integer.parseInt(productIdStr);

			boolean success = productDAO.deleteProduct(productId);

			if (pageParam != null && !pageParam.isEmpty()) {
				if (success) {
					response.sendRedirect("adminProducts?page=" + pageParam + "&success=delete_success");
				} else {
					response.sendRedirect("adminProducts?page=" + pageParam + "&error=delete_failed");
				}
			} else {
				if (success) {
					response.sendRedirect("adminProducts?success=delete_success");
				} else {
					response.sendRedirect("adminProducts?error=delete_failed");
				}
			}

		} catch (NumberFormatException e) {
			response.sendRedirect("adminProducts?error=invalid_id_format");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("adminProducts?error=server_error");
		}
	}
}