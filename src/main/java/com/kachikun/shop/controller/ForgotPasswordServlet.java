package com.kachikun.shop.controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.util.Properties;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;
import com.kachikun.shop.service.UserService;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();
	private UserService userService = new UserService();

	private final String FROM_EMAIL = "tranhung2642005@gmail.com";
	private final String FROM_PASSWORD = "ffrq vsur riyq nblb";
	private final String SMTP_HOST = "smtp.gmail.com";
	private final String SMTP_PORT = "587";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		HttpSession session = request.getSession();

		if ("request".equals(action)) {

			String email = request.getParameter("email");
			User user = userDAO.getUserByEmail(email);
			if (user == null) {
				request.setAttribute("error", "Email không tồn tại!");
				request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
				return;
			}

			String otp = generateOTP();
			session.setAttribute("otp", otp);
			session.setAttribute("email", email);

			boolean sent = sendEmail(email, "Mã OTP đặt lại mật khẩu",
					"Mã OTP của bạn là: " + otp + ". Hiệu lực 5 phút.");
			if (sent) {
				request.setAttribute("info", "Mã OTP đã gửi đến email của bạn!");
				request.setAttribute("step", "verify");
				request.setAttribute("email", email);
			} else {
				request.setAttribute("error", "Lỗi gửi email! Vui lòng thử lại.");
			}
			request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

		} else if ("verify".equals(action)) {

			String inputOtp = request.getParameter("otp1") + request.getParameter("otp2") + request.getParameter("otp3")
					+ request.getParameter("otp4") + request.getParameter("otp5") + request.getParameter("otp6");
			String storedOtp = (String) session.getAttribute("otp");
			String email = (String) session.getAttribute("email");
			String newPassword = request.getParameter("newPassword");
			String confirmPassword = request.getParameter("confirmPassword");

			String passwordPattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}$";

			if (!newPassword.matches(passwordPattern)) {
				request.setAttribute("error", "Mật khẩu quá yếu! Cần ít nhất 6 ký tự, bao gồm chữ hoa và số.");
				request.setAttribute("step", "verify");
				request.setAttribute("email", email);
				request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
				return;
			}

			if (storedOtp != null && storedOtp.equals(inputOtp)) {

				boolean updated = userService.recoverPassword(email, newPassword);

				if (updated) {
					session.removeAttribute("otp");
					session.removeAttribute("email");
					request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				} else {
					request.setAttribute("error", "Lỗi cập nhật mật khẩu! Vui lòng thử lại.");
					request.setAttribute("step", "verify");
					request.setAttribute("email", email);
					request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
				}
			} else {
				request.setAttribute("error", "Mã OTP không đúng!");
				request.setAttribute("step", "verify");
				request.setAttribute("email", email);
				request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
			}

		} else if ("resend".equals(action)) {

			String email = request.getParameter("email");
			String otp = generateOTP();
			session.setAttribute("otp", otp);
			boolean sent = sendEmail(email, "Mã OTP mới", "Mã OTP mới của bạn là: " + otp + ". Hiệu lực 5 phút.");
			if (sent) {
				request.setAttribute("info", "Mã OTP mới đã gửi!");
			} else {
				request.setAttribute("error", "Lỗi gửi email!");
			}
			request.setAttribute("step", "verify");
			request.setAttribute("email", email);
			request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
		}
	}

	private String generateOTP() {
		Random random = new Random();
		return String.format("%06d", random.nextInt(999999));
	}

	private boolean sendEmail(String to, String subject, String content) {
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", SMTP_HOST);
		props.put("mail.smtp.port", SMTP_PORT);

		Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
			}
		});

		try {
			Message message = new MimeMessage(mailSession);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(content);
			Transport.send(message);
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
	}

	private String hashPassword(String password) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(password.getBytes());
			byte[] byteData = md.digest();

			StringBuilder sb = new StringBuilder();
			for (byte b : byteData) {
				sb.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
			}
			return sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}