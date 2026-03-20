package com.kachikun.shop.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Properties;
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

import com.kachikun.shop.service.UserService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserService();

	private static final String FROM_EMAIL    = "tranhung2642005@gmail.com";
	private static final String FROM_PASSWORD = "ffrq vsur riyq nblb";
	private static final String SMTP_HOST     = "smtp.gmail.com";
	private static final String SMTP_PORT     = "587";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String step = request.getParameter("step");

		if ("sendOtp".equals(step)) {
			handleSendOtp(request, response);
		} else if ("verifyOtp".equals(step)) {
			handleVerifyOtp(request, response);
		} else {
			response.sendRedirect("login.jsp");
		}
	}

	// ── BƯỚC 1: validate thông tin, gửi OTP ──────────────────────────────────
	private void handleSendOtp(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String fullname = request.getParameter("fullname");
		String email    = request.getParameter("email");
		String pass     = request.getParameter("password");
		String rePass   = request.getParameter("repassword");

		// Trả về form đăng ký kèm thông báo lỗi và giữ lại giá trị đã nhập
		if (!pass.equals(rePass)) {
			forwardError(request, response, "Mật khẩu nhập lại không khớp!", username, email, fullname);
			return;
		}

		// Dùng UserService để validate: độ dài pass, trùng username, trùng email
		String preCheck = service.preCheck(username, pass, email);
		if (!"OK".equals(preCheck)) {
			String clearUsername = preCheck.contains("Tên đăng nhập") ? "" : username;
			String clearEmail    = preCheck.contains("Email")         ? "" : email;
			forwardError(request, response, preCheck, clearUsername, clearEmail, fullname);
			return;
		}

		// Tạo OTP và lưu vào session cùng thông tin đăng ký
		String otp = generateOtp();
		long   expiry = System.currentTimeMillis() + 5 * 60 * 1000; // 5 phút

		HttpSession session = request.getSession();
		session.setAttribute("reg_otp",      otp);
		session.setAttribute("reg_expiry",   expiry);
		session.setAttribute("reg_username", username);
		session.setAttribute("reg_fullname", fullname);
		session.setAttribute("reg_email",    email);
		session.setAttribute("reg_password", pass);

		boolean sent = sendEmail(email,
				"Mã xác nhận đăng ký - Kachi-Kun Shop",
				"Mã OTP xác nhận email của bạn là: " + otp + "\nHiệu lực trong 5 phút. Không chia sẻ mã này cho ai.");

		if (!sent) {
			// Xóa session nếu gửi mail thất bại
			clearRegSession(session);
			forwardError(request, response, "Không thể gửi email. Vui lòng kiểm tra lại địa chỉ email!", username, email, fullname);
			return;
		}

		// Chuyển sang bước nhập OTP
		request.setAttribute("registerStep", "otp");
		request.setAttribute("reg_email_display", email);
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	// ── BƯỚC 2: kiểm tra OTP, tạo tài khoản ─────────────────────────────────
	private void handleVerifyOtp(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// Nếu session hết hạn hoặc chưa qua bước 1
		if (session == null || session.getAttribute("reg_otp") == null) {
			forwardError(request, response, "Phiên đăng ký đã hết hạn. Vui lòng thử lại!", "", "", "");
			return;
		}

		String inputOtp  = request.getParameter("otp1") + request.getParameter("otp2")
				+ request.getParameter("otp3") + request.getParameter("otp4")
				+ request.getParameter("otp5") + request.getParameter("otp6");
		String storedOtp = (String)  session.getAttribute("reg_otp");
		long   expiry    = (long)    session.getAttribute("reg_expiry");
		String username  = (String)  session.getAttribute("reg_username");
		String fullname  = (String)  session.getAttribute("reg_fullname");
		String email     = (String)  session.getAttribute("reg_email");
		String pass      = (String)  session.getAttribute("reg_password");

		// Kiểm tra hết hạn
		if (System.currentTimeMillis() > expiry) {
			clearRegSession(session);
			forwardError(request, response, "Mã OTP đã hết hạn. Vui lòng đăng ký lại!", "", "", "");
			return;
		}

		// Kiểm tra OTP sai
		if (!storedOtp.equals(inputOtp)) {
			request.setAttribute("registerStep",        "otp");
			request.setAttribute("reg_email_display",   email);
			request.setAttribute("registerError",       "Mã OTP không đúng. Vui lòng thử lại!");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}

		// OTP đúng → tạo tài khoản
		clearRegSession(session);
		String result = service.register(username, pass, email, fullname, 0);

		if ("Success".equals(result)) {
			String msg = java.net.URLEncoder.encode("Đăng ký thành công! Mời đăng nhập.", "UTF-8");
			response.sendRedirect("login.jsp?msg=" + msg);
		} else {
			forwardError(request, response, result, username, email, fullname);
		}
	}

	// ── Helpers ───────────────────────────────────────────────────────────────
	private void forwardError(HttpServletRequest request, HttpServletResponse response,
							  String error, String username, String email, String fullname)
			throws ServletException, IOException {
		request.setAttribute("registerError",   error);
		request.setAttribute("usernameValue",   username);
		request.setAttribute("emailValue",      email);
		request.setAttribute("fullnameValue",   fullname);
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	private void clearRegSession(HttpSession session) {
		session.removeAttribute("reg_otp");
		session.removeAttribute("reg_expiry");
		session.removeAttribute("reg_username");
		session.removeAttribute("reg_fullname");
		session.removeAttribute("reg_email");
		session.removeAttribute("reg_password");
	}

	private String generateOtp() {
		SecureRandom random = new SecureRandom();
		return String.format("%06d", random.nextInt(1_000_000));
	}

	private boolean sendEmail(String to, String subject, String content) {
		Properties props = new Properties();
		props.put("mail.smtp.auth",            "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host",            SMTP_HOST);
		props.put("mail.smtp.port",            SMTP_PORT);

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
}