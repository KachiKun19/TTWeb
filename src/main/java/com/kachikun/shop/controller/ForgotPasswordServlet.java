package com.kachikun.shop.controller;

import java.io.IOException;
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

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    // Cấu hình email (thay bằng email của bạn)
    private final String FROM_EMAIL = "tranhung2642005@gmail.com"; // Email gửi
    private final String FROM_PASSWORD = "ffrq vsur riyq nblb"; // App Password nếu dùng Gmail
    private final String SMTP_HOST = "smtp.gmail.com";
    private final String SMTP_PORT = "587"; // Hoặc 465 cho SSL

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("request".equals(action)) {
            // Bước 1: Yêu cầu OTP
            String email = request.getParameter("email");
            User user = userDAO.getUserByEmail(email);
            if (user == null) {
                request.setAttribute("error", "Email không tồn tại!");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            // Tạo OTP ngẫu nhiên 6 chữ số
            String otp = generateOTP();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Gửi email
            boolean sent = sendEmail(email, "Mã OTP đặt lại mật khẩu", "Mã OTP của bạn là: " + otp + ". Hiệu lực 5 phút.");
            if (sent) {
                request.setAttribute("info", "Mã OTP đã gửi đến email của bạn!");
                request.setAttribute("step", "verify");
                request.setAttribute("email", email);
            } else {
                request.setAttribute("error", "Lỗi gửi email! Vui lòng thử lại.");
            }
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

        } else if ("verify".equals(action)) {
            // Bước 2: Verify OTP và update password
            String inputOtp = request.getParameter("otp1") + request.getParameter("otp2") +
                              request.getParameter("otp3") + request.getParameter("otp4") +
                              request.getParameter("otp5") + request.getParameter("otp6");
            String storedOtp = (String) session.getAttribute("otp");
            String email = (String) session.getAttribute("email");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.setAttribute("step", "verify");
                request.setAttribute("email", email);
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            if (storedOtp != null && storedOtp.equals(inputOtp)) {
                boolean updated = userDAO.updatePassword(email, newPassword); // Hash password nếu cần (thêm BCrypt)
                if (updated) {
                    session.removeAttribute("otp");
                    session.removeAttribute("email");
                    request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Lỗi cập nhật mật khẩu!");
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
            // Resend OTP
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
}