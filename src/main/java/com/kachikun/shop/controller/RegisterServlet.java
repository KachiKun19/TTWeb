package com.kachikun.shop.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;
import com.kachikun.shop.service.UserService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String user = request.getParameter("username");
		String pass = request.getParameter("password");
		String rePass = request.getParameter("repassword");
		String email = request.getParameter("email");
		String fullname = request.getParameter("fullname");

		if (!pass.equals(rePass)) {
			request.setAttribute("registerError", "Mật khẩu nhập lại không khớp!");
			request.setAttribute("usernameValue", user);
			request.setAttribute("emailValue", email);
			request.setAttribute("fullnameValue", fullname);
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}

		String result = service.register(user, pass, email, fullname, 0);

		if ("Success".equals(result)) {

			String msg = java.net.URLEncoder.encode("Đăng ký thành công! Mời đăng nhập.", "UTF-8");
			response.sendRedirect("login.jsp?msg=" + msg);
		} else {

			request.setAttribute("usernameValue", user);
			request.setAttribute("emailValue", email);
			request.setAttribute("fullnameValue", fullname);

			if (result.contains("Tên đăng nhập")) {

				request.setAttribute("usernameValue", "");
			} else if (result.contains("Email")) {

				request.setAttribute("emailValue", "");
			}

			request.setAttribute("registerError", result);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
