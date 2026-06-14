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
import com.kachikun.shop.service.OtpService;
import com.kachikun.shop.service.UserService;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String PREFIX = "fp";

    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("request".equals(action)) {

            String email = request.getParameter("email");
            User user = userService.getUserByEmail(email);

            if (user == null) {
                request.setAttribute("error", "Email không tồn tại!");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            String otp = OtpService.generateAndSave(session, PREFIX);
            session.setAttribute("email", email);

            boolean sent = OtpService.send(email, "Mã OTP đặt lại mật khẩu", otp);
            if (sent) {
                request.setAttribute("info", "Mã OTP đã gửi đến email của bạn!");
                request.setAttribute("step", "verify");
                request.setAttribute("email", email);
                request.setAttribute("otpSentAt", OtpService.getSentAt(session, PREFIX));
            } else {
                request.setAttribute("error", "Lỗi gửi email! Vui lòng thử lại.");
            }
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

        } else if ("verify".equals(action)) {

            String inputOtp = request.getParameter("otp1") + request.getParameter("otp2")
                    + request.getParameter("otp3") + request.getParameter("otp4")
                    + request.getParameter("otp5") + request.getParameter("otp6");
            String email = (String) session.getAttribute("email");
            Long otpSentAt = OtpService.getSentAt(session, PREFIX);

            if (OtpService.isExpired(session, PREFIX)) {
                request.setAttribute("error", "Mã OTP đã hết hạn! Vui lòng nhấn Gửi lại OTP để nhận mã mới.");
                request.setAttribute("step", "verify");
                request.setAttribute("email", email);
                request.setAttribute("otpSentAt", otpSentAt != null ? otpSentAt : System.currentTimeMillis() - 300001L);
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            if (OtpService.verify(session, PREFIX, inputOtp)) {
                OtpService.clear(session, PREFIX);
                session.setAttribute("otpVerified", true);
                request.setAttribute("step", "reset");
                request.setAttribute("email", email);
            } else {
                request.setAttribute("error", "Mã OTP không đúng!");
                request.setAttribute("step", "verify");
                request.setAttribute("email", email);
                request.setAttribute("otpSentAt", otpSentAt);
            }
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

        } else if ("reset".equals(action)) {

            String email = (String) session.getAttribute("email");
            Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");

            if (otpVerified == null || !otpVerified || email == null) {
                request.setAttribute("error", "Phiên xác thực không hợp lệ. Vui lòng thực hiện lại từ đầu.");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            String passwordPattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}$";
            if (!newPassword.matches(passwordPattern)) {
                request.setAttribute("error", "Mật khẩu quá yếu! Cần ít nhất 6 ký tự, bao gồm chữ hoa và số.");
                request.setAttribute("step", "reset");
                request.setAttribute("email", email);
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.setAttribute("step", "reset");
                request.setAttribute("email", email);
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            boolean updated = userService.recoverPassword(email, newPassword);
            if (updated) {
                session.removeAttribute("email");
                session.removeAttribute("otpVerified");
                request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Lỗi cập nhật mật khẩu! Vui lòng thử lại.");
                request.setAttribute("step", "reset");
                request.setAttribute("email", email);
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            }

        } else if ("resend".equals(action)) {

            String email = (String) session.getAttribute("email");
            if (email == null) email = request.getParameter("email");

            String otp = OtpService.generateAndSave(session, PREFIX);
            boolean sent = OtpService.send(email, "Mã OTP mới - Đặt lại mật khẩu", otp);
            if (sent) {
                request.setAttribute("info", "Mã OTP mới đã được gửi đến email của bạn!");
            } else {
                request.setAttribute("error", "Lỗi gửi email! Vui lòng thử lại.");
            }
            request.setAttribute("step", "verify");
            request.setAttribute("email", email);
            request.setAttribute("otpSentAt", OtpService.getSentAt(session, PREFIX));
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }
}