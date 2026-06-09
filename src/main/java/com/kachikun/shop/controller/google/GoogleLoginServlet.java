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
        String redirectUri = buildRedirectUri(request, "/google-callback");

        String url = "https://accounts.google.com/o/oauth2/auth"
                + "?client_id=" + GoogleConstants.GOOGLE_CLIENT_ID
                + "&redirect_uri=" + redirectUri
                + "&response_type=code"
                + "&scope=email%20profile";

        response.sendRedirect(url);
    }

    static String buildRedirectUri(HttpServletRequest request, String path) {
        String scheme = request.getScheme();
        int port = request.getServerPort();
        boolean isDefaultPort = (scheme.equals("https") && port == 443)
                || (scheme.equals("http")  && port == 80);
        String portPart = isDefaultPort ? "" : ":" + port;

        return scheme + "://"
                + request.getServerName()
                + portPart
                + request.getContextPath()
                + path;
    }
}