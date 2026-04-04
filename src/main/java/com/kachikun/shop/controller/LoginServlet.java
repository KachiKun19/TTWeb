package com.kachikun.shop.controller;

import java.io.IOException;
import java.security.SecureRandom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.kachikun.shop.service.UserService;
import com.kachikun.shop.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int  MAX_FAIL         = 5;
	private final UserService userService = new UserService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Nếu session vẫn còn trạng thái fail >= 5, hiện lại CAPTCHA
		HttpSession session = request.getSession(false);
		if (session != null) {
			Integer failCount = (Integer) session.getAttribute("loginFailCount");
			if (failCount != null && failCount >= MAX_FAIL) {
				if (session.getAttribute("captchaQuestion") == null) {
					generateAndStoreCaptcha(session);
				}
				request.setAttribute("captchaQuestion", session.getAttribute("captchaQuestion"));
				request.setAttribute("showCaptcha", true);
			}
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String u = request.getParameter("username");
		String p = request.getParameter("password");

		HttpSession session = request.getSession();
		int failCount = session.getAttribute("loginFailCount") == null
				? 0 : (int) session.getAttribute("loginFailCount");

		// ── Kiểm tra CAPTCHA nếu đã sai >= 5 lần ────────────────────────────
		if (failCount >= MAX_FAIL) {
			String  inputCaptcha  = request.getParameter("captcha");
			Integer captchaAnswer = (Integer) session.getAttribute("captchaAnswer");

			boolean captchaOk = captchaAnswer != null
					&& inputCaptcha != null
					&& String.valueOf(captchaAnswer).equals(inputCaptcha.trim());

			if (!captchaOk) {
				generateAndStoreCaptcha(session);
				request.setAttribute("captchaQuestion", session.getAttribute("captchaQuestion"));
				request.setAttribute("showCaptcha", true);
				request.setAttribute("error", "Mã xác nhận không đúng. Vui lòng thử lại!");
				request.setAttribute("loginUsername", u);
				request.getRequestDispatcher("login.jsp").forward(request, response);
				return;
			}

			// CAPTCHA đúng → xóa, cho phép kiểm tra tài khoản
			session.removeAttribute("captchaAnswer");
			session.removeAttribute("captchaQuestion");
		}

		// ── Kiểm tra tài khoản ───────────────────────────────────────────────
		User user = userService.login(u, p);

		if (user != null) {
			session.invalidate();
			HttpSession newSession = request.getSession(true);
			newSession.setAttribute("user", user);
			if (user.getRole() == 1) {
				response.sendRedirect("adminHome");
			} else {
				response.sendRedirect("home");
			}
		} else {
			failCount++;
			session.setAttribute("loginFailCount", failCount);

			if (failCount >= MAX_FAIL) {
				generateAndStoreCaptcha(session);
				request.setAttribute("captchaQuestion", session.getAttribute("captchaQuestion"));
				request.setAttribute("showCaptcha", true);
			}

			request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
			request.setAttribute("loginUsername", u);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

	// ── Helper ───────────────────────────────────────────────────────────────

	private void generateAndStoreCaptcha(HttpSession session) {
		SecureRandom random = new SecureRandom();
		int a = random.nextInt(10) + 1; // 1–10
		int b = random.nextInt(10) + 1; // 1–10
		String question;
		int    answer;
		if (random.nextBoolean()) {
			question = a + " + " + b + " = ?";
			answer   = a + b;
		} else {
			if (a < b) { int tmp = a; a = b; b = tmp; } // đảm bảo kết quả >= 0
			question = a + " - " + b + " = ?";
			answer   = a - b;
		}
		session.setAttribute("captchaQuestion", question);
		session.setAttribute("captchaAnswer",   answer);
	}
}
