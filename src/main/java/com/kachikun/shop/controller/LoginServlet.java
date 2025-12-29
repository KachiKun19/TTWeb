package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Khi người dùng gõ /login -> Hiện trang login.jsp
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	// Khi người dùng bấm nút "Đăng Nhập" ở form
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String u = request.getParameter("username");
		String p = request.getParameter("password");

		UserDAO dao = new UserDAO();
		User user = dao.checkLogin(u, p);

		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			// PHÂN QUYỀN THEO ROLE
			if (user.getRole() == 1) {
				// Admin -> chuyển đến trang admin
				response.sendRedirect("adminHome");
			} else {
				// User thường -> chuyển đến trang chủ
				response.sendRedirect("home");
			}
		} else {
			request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng!");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}