package com.kachikun.shop.controller.google;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.GoogleUser;
import com.kachikun.shop.model.User;
import com.kachikun.shop.utils.GoogleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/google-callback")
public class GoogleCallbackServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String redirectUri = GoogleLoginServlet.buildRedirectUri(request, "/google-callback");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp?error=google_auth_failed");
            return;
        }

        try {
            String accessToken = GoogleService.getAccessToken(code, redirectUri);
            GoogleUser googleUser = GoogleService.getUserInfo(accessToken);
            UserDAO userDAO = new UserDAO();

            User dbUser = userDAO.getUserByEmail(googleUser.getEmail());

            if (dbUser == null) {
                dbUser = new User();
                dbUser.setUsername(googleUser.getEmail());
                dbUser.setPassword("");
                dbUser.setEmail(googleUser.getEmail());
                dbUser.setFullName(googleUser.getName());
                dbUser.setRole(2);
                userDAO.register(dbUser);
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", dbUser);

            response.sendRedirect(request.getContextPath() + "/home");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=google_auth_failed");
        }
    }
}