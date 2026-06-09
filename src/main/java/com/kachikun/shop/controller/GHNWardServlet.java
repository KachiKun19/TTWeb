package com.kachikun.shop.controller;

import com.kachikun.shop.utils.GHNConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/ghn/wards")
public class GHNWardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String districtId = request.getParameter("district_id");

        if (districtId == null || districtId.trim().isEmpty()) {
            response.setStatus(400);
            response.getWriter().write("{\"code\":400,\"message\":\"Thiếu district_id\"}");
            return;
        }

        try {
            URL url = new URL("https://online-gateway.ghn.vn/shiip/public-api/master-data/ward");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Token", GHNConfig.TOKEN);
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);

            String json = """
                    {
                        "district_id": %s
                    }
                    """.formatted(districtId);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(json.getBytes("UTF-8"));
                os.flush();
            }

            int statusCode = conn.getResponseCode();

            InputStream is = (statusCode >= 200 && statusCode < 300)
                    ? conn.getInputStream()
                    : conn.getErrorStream();

            StringBuilder sb = new StringBuilder();

            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
            }

            response.setStatus(statusCode);
            response.getWriter().write(sb.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("{\"code\":500,\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}