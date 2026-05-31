package com.kachikun.shop.controller.facebook;

import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.FacebookUser;
import com.kachikun.shop.model.User;
import com.kachikun.shop.utils.FacebookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/facebook-callback")
public class FacebookCallbackServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=facebook_auth_failed");
            return;
        }

        try {
            String redirectUri = request.getScheme() + "://"
                    + request.getServerName() + ":"
                    + request.getServerPort()
                    + request.getContextPath()
                    + "/facebook-callback";

            String accessToken = FacebookService.getAccessToken(code, redirectUri);
            FacebookUser fbUser = FacebookService.getUserInfo(accessToken);

            UserDAO userDAO = new UserDAO();

            User dbUser = userDAO.getUserByEmail(fbUser.getEmail());

            if (dbUser == null) {
                dbUser = new User();
                dbUser.setUsername(fbUser.getEmail());
                dbUser.setPassword("");
                dbUser.setEmail(fbUser.getEmail());
                dbUser.setFullName(fbUser.getName());
                dbUser.setRole(2);
                userDAO.register(dbUser);
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", dbUser);

            response.sendRedirect(request.getContextPath() + "/home");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=facebook_auth_failed");
        }
    }
}