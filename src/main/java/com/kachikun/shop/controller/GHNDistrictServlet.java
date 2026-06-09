package com.kachikun.shop.controller;

import com.kachikun.shop.utils.GHNConfig;
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

@WebServlet("/ghn-districts")
public class GHNDistrictServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String provinceId = request.getParameter("provinceId");

        // Chặn lỗi input null hoặc rỗng
        if (provinceId == null || provinceId.trim().isEmpty()) {
            response.setStatus(400);
            response.getWriter().write("{\"code\":400,\"message\":\"Thiếu provinceId\"}");
            return;
        }

        try {
            URL url = new URL("https://online-gateway.ghn.vn/shiip/public-api/master-data/district");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Token", GHNConfig.TOKEN);

            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);

            String json = """
                    {
                        "province_id": %s
                    }
                    """.formatted(provinceId);

            // Dùng try-with-resources để tự động đóng luồng OutputStream
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