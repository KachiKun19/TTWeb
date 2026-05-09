package com.kachikun.shop.controller;

import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.Discount;
import com.kachikun.shop.model.User;
import com.kachikun.shop.service.OtpService;
import com.kachikun.shop.service.UserService;
import com.kachikun.shop.utils.BCryptUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final String PREFIX = "cp";

    private final UserDAO userDAO = new UserDAO();
    private final UserService userService = new UserService();
    private final DiscountDAO discountDAO = new DiscountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        User profileUser = (User) session.getAttribute("user");
        List<Discount> savedDiscounts = discountDAO.getSavedDiscountsByUser(profileUser.getId());
        request.setAttribute("savedDiscounts", savedDiscounts);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        switch (action == null ? "" : action) {
            case "updateInfo":
                handleUpdateInfo(request, response, session, sessionUser);
                break;
            case "requestChangePassword":
                handleRequestChangePassword(request, response, session, sessionUser);
                break;
            case "verifyCpOtp":
                handleVerifyCpOtp(request, response, session, sessionUser);
                break;
            case "resendCpOtp":
                handleResendCpOtp(request, response, session, sessionUser);
                break;
            default:
                response.sendRedirect("profile");
        }
    }

    private void handleRequestChangePassword(HttpServletRequest request, HttpServletResponse response,
                                             HttpSession session, User sessionUser)
            throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        User userWithPw = userDAO.getUserByUsername(sessionUser.getUsername());

        if (userWithPw == null || !BCryptUtils.checkPassword(oldPassword, userWithPw.getPassword())) {
            request.setAttribute("pwError", "Mật khẩu cũ không đúng!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        String passwordPattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}$";
        if (newPassword == null || !newPassword.matches(passwordPattern)) {
            request.setAttribute("pwError", "Mật khẩu mới quá yếu! Cần ít nhất 6 ký tự, có chữ hoa và số.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("pwError", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        String otp = OtpService.generateAndSave(session, PREFIX);
        session.setAttribute("cpNewPassword", newPassword);

        boolean sent = OtpService.send(sessionUser.getEmail(), "Mã OTP đổi mật khẩu - Kachi-Kun Shop", otp);
        if (sent) {
            request.setAttribute("pwInfo", "Mã OTP đã gửi đến " + sessionUser.getEmail());
            request.setAttribute("pwStep", "verify");
            request.setAttribute("cpOtpSentAt", OtpService.getSentAt(session, PREFIX));
        } else {
            OtpService.clear(session, PREFIX);
            session.removeAttribute("cpNewPassword");
            request.setAttribute("pwError", "Lỗi gửi email! Vui lòng thử lại.");
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private void handleVerifyCpOtp(HttpServletRequest request, HttpServletResponse response,
                                   HttpSession session, User sessionUser)
            throws ServletException, IOException {
        String inputOtp = request.getParameter("otp1") + request.getParameter("otp2")
                + request.getParameter("otp3") + request.getParameter("otp4")
                + request.getParameter("otp5") + request.getParameter("otp6");
        Long otpSentAt = OtpService.getSentAt(session, PREFIX);
        String newPassword = (String) session.getAttribute("cpNewPassword");

        if (OtpService.isExpired(session, PREFIX)) {
            request.setAttribute("pwError", "Mã OTP đã hết hạn! Vui lòng nhấn Gửi lại OTP.");
            request.setAttribute("pwStep", "verify");
            request.setAttribute("cpOtpSentAt", otpSentAt != null ? otpSentAt : System.currentTimeMillis() - 300001L);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        if (OtpService.verify(session, PREFIX, inputOtp)) {
            boolean ok = userService.recoverPassword(sessionUser.getEmail(), newPassword);
            OtpService.clear(session, PREFIX);
            session.removeAttribute("cpNewPassword");
            if (ok) {
                request.setAttribute("pwSuccess", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("pwError", "Lỗi cập nhật mật khẩu! Vui lòng thử lại.");
            }
        } else {
            request.setAttribute("pwError", "Mã OTP không đúng!");
            request.setAttribute("pwStep", "verify");
            request.setAttribute("cpOtpSentAt", otpSentAt);
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private void handleResendCpOtp(HttpServletRequest request, HttpServletResponse response,
                                   HttpSession session, User sessionUser)
            throws ServletException, IOException {
        if (session.getAttribute("cpNewPassword") == null) {
            request.setAttribute("pwError", "Phiên đổi mật khẩu đã hết hạn. Vui lòng bắt đầu lại.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        String otp = OtpService.generateAndSave(session, PREFIX);
        boolean sent = OtpService.send(sessionUser.getEmail(), "Mã OTP mới - Đổi mật khẩu Kachi-Kun Shop", otp);
        if (sent) {
            request.setAttribute("pwInfo", "Mã OTP mới đã được gửi đến " + sessionUser.getEmail());
        } else {
            request.setAttribute("pwError", "Lỗi gửi email! Vui lòng thử lại.");
        }
        request.setAttribute("pwStep", "verify");
        request.setAttribute("cpOtpSentAt", OtpService.getSentAt(session, PREFIX));
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private void handleUpdateInfo(HttpServletRequest request, HttpServletResponse response,
                                  HttpSession session, User sessionUser)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("infoError", "Họ tên không được để trống!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        if (email == null || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            request.setAttribute("infoError", "Email không đúng định dạng!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        if (!email.equalsIgnoreCase(sessionUser.getEmail())) {
            User existing = userDAO.getUserByEmail(email);
            if (existing != null && existing.getId() != sessionUser.getId()) {
                request.setAttribute("infoError", "Email này đã được sử dụng bởi tài khoản khác!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
        }

        sessionUser.setFullName(fullName.trim());
        sessionUser.setEmail(email.trim());
        boolean ok = userDAO.updateUser(sessionUser);
        if (ok) {
            session.setAttribute("user", sessionUser);
            request.setAttribute("infoSuccess", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("infoError", "Cập nhật thất bại, vui lòng thử lại!");
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

}