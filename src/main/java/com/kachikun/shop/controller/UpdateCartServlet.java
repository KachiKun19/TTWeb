package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.model.CartItem;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idStr = request.getParameter("id");
		String modStr = request.getParameter("mod");

		if (idStr != null && modStr != null) {
			int id = Integer.parseInt(idStr);
			int mod = Integer.parseInt(modStr);

			HttpSession session = request.getSession();
			List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

			if (cart != null) {
				for (int i = 0; i < cart.size(); i++) {
					CartItem item = cart.get(i);

					if (item.getProduct().getId() == id) {

						int newQuantity = item.getQuantity() + mod;

						if (newQuantity > 0) {
							item.setQuantity(newQuantity);
						} else {

							cart.remove(i);
						}
						break;
					}
				}
			}

			session.setAttribute("cart", cart);
		}

		response.sendRedirect("cart");
	}
}