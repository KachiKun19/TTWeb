package com.kachikun.shop.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Timestamp;

import jakarta.servlet.http.Cookie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.RememberTokenDAO;
import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.RememberToken;
import com.kachikun.shop.model.User;
import com.kachikun.shop.service.UserService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int MAX_FAIL = 5;
    private static final int REMEMBER_DAYS = 5;
    private static final String COOKIE_NAME = "remember_token";

    private final UserService userService = new UserService();
    private final UserDAO userDAO = new UserDAO();
    private final RememberTokenDAO tokenDAO = new RememberTokenDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nếu đã đăng nhập thì k tạo session mới rồi chuyển hướng
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            response.sendRedirect(user.getRole() == 1 ? "adminHome" : "home");
            return;
        }

        // Kiểm tra cookie nhớ đăng nhập
        Cookie rememberCookie = findRememberCookie(request);
        if (rememberCookie != null) {
            Integer userId = tokenDAO.getUserIdByToken(rememberCookie.getValue());
            if (userId != null) {
                User user = userDAO.getUserById(userId);
                if (user != null) {
                    HttpSession newSession = request.getSession(true);
                    newSession.setAttribute("user", user);
                    response.sendRedirect(user.getRole() == 1 ? "adminHome" : "home");
                    return;
                }
            }
            // Token không hợp lệ → xóa cookie
            clearRememberCookie(response);
        }

        // Hiện lại CAPTCHA nếu session vẫn còn trạng thái fail >= 5
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

        // Login bth
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        HttpSession session = request.getSession();
        int failCount = session.getAttribute("loginFailCount") == null
                ? 0 : (int) session.getAttribute("loginFailCount");

        // Kiểm tra CAPCHA nếu đã sai >= 5 lần
        if (failCount >= MAX_FAIL) {
            String inputCaptcha = request.getParameter("captcha");
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

            session.removeAttribute("captchaAnswer");
            session.removeAttribute("captchaQuestion");
        }

        // Kiểm tra tài khoản
        User user = userService.login(u, p);

        if (user != null) {
            session.invalidate();
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("user", user);

            // Xử lý nhớ đăng nhập
            String rememberMe = request.getParameter("rememberMe");
            if ("on".equals(rememberMe)) {
                String token = generateToken();
                Timestamp expiry = new Timestamp(System.currentTimeMillis() + (long) REMEMBER_DAYS * 24 * 60 * 60 * 1000);
                tokenDAO.deleteByUserId(user.getId()); // xóa token cũ
                tokenDAO.saveToken(new RememberToken(user.getId(), token, expiry));

                Cookie cookie = new Cookie(COOKIE_NAME, token);
                cookie.setMaxAge(REMEMBER_DAYS * 24 * 60 * 60);
                cookie.setHttpOnly(true);
                cookie.setPath("/");
                response.addCookie(cookie);
            }

            response.sendRedirect(user.getRole() == 1 ? "adminHome" : "home");
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

    private Cookie findRememberCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (COOKIE_NAME.equals(c.getName())) return c;
            }
        }
        return null;
    }

    private void clearRememberCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie(COOKIE_NAME, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    private String generateToken() {
        byte[] bytes = new byte[32];
        new SecureRandom().nextBytes(bytes);
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) sb.append(String.format("%02x", b));
        return sb.toString(); // 64 ký tự hex
    }

    // Tạo CAPCHA đơn giản
    private void generateAndStoreCaptcha(HttpSession session) {
        SecureRandom random = new SecureRandom();
        int a = random.nextInt(10) + 1;
        int b = random.nextInt(10) + 1;
        String question;
        int answer;
        if (random.nextBoolean()) {
            question = a + " + " + b + " = ?";
            answer = a + b;
        } else {
            if (a < b) {
                int tmp = a;
                a = b;
                b = tmp;
            }
            question = a + " - " + b + " = ?";
            answer = a - b;
        }
        session.setAttribute("captchaQuestion", question);
        session.setAttribute("captchaAnswer", answer);
    }
}
