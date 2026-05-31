package com.kachikun.shop.controller.google;

import com.kachikun.shop.utils.GoogleConstants;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String redirectUri = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort()
                + request.getContextPath()
                + "/google-callback";

        String url = "https://accounts.google.com/o/oauth2/auth"
                + "?client_id=" + GoogleConstants.GOOGLE_CLIENT_ID
                + "&redirect_uri=" + redirectUri
                + "&response_type=code"
                + "&scope=email%20profile";

        response.sendRedirect(url);
    }
}
