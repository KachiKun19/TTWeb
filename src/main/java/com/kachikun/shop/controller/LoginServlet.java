package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.kachikun.shop.service.UserService;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String u = request.getParameter("username");
		String p = request.getParameter("password");

		User user = userService.login(u, p);

		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			if (user.getRole() == 1) {
				response.sendRedirect("adminHome");
			} else {
				response.sendRedirect("home");
			}
		} else {
			request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}