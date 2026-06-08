package com.kachikun.shop.controller.facebook;

import com.kachikun.shop.utils.FacebookConstants;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/facebook-login")
public class FacebookLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String scheme = request.getScheme();
        int port = request.getServerPort();
        String portPart = "";

        if (!((scheme.equals("https") && port == 443)
                || (scheme.equals("http")  && port == 80))) {
            portPart = ":" + port;
        }

        String redirectUri = scheme + "://"
                + request.getServerName()
                + portPart
                + request.getContextPath()
                + "/facebook-callback";

        String url = "https://www.facebook.com/v19.0/dialog/oauth"
                + "?client_id=" + FacebookConstants.FACEBOOK_APP_ID
                + "&redirect_uri=" + redirectUri
                + "&scope=email,public_profile"
                + "&response_type=code";

        response.sendRedirect(url);
    }
}