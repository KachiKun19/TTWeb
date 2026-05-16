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

		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

		try {
			int productId = Integer.parseInt(productIdStr);
			boolean success = productDAO.deleteProduct(productId);

			if (isAjax) {
				response.setContentType("application/json;charset=UTF-8");
				response.getWriter().write("{\"success\":" + success + "}");
				return;
			}

			if (pageParam != null && !pageParam.isEmpty()) {
				response.sendRedirect("adminProducts?page=" + pageParam + (success ? "&success=delete_success" : "&error=delete_failed"));
			} else {
				response.sendRedirect("adminProducts?" + (success ? "success=delete_success" : "error=delete_failed"));
			}

		} catch (NumberFormatException e) {
			if (isAjax) {
				response.setContentType("application/json;charset=UTF-8");
				response.getWriter().write("{\"success\":false}");
			} else {
				response.sendRedirect("adminProducts?error=invalid_id_format");
			}
		} catch (Exception e) {
			e.printStackTrace();
			if (isAjax) {
				response.setContentType("application/json;charset=UTF-8");
				response.getWriter().write("{\"success\":false}");
			} else {
				response.sendRedirect("adminProducts?error=server_error");
			}
		}
	}
}