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
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/ghn-provinces")
public class GHNProvinceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            System.out.println("====== [DEBUG GHN] TOKEN ĐANG ĐỌC LÀ: '" + GHNConfig.TOKEN + "' ======");
            System.out.println("====== [DEBUG GHN] TOKEN LENGTH: " + GHNConfig.TOKEN.length() + " ======");
            System.out.println("====== [DEBUG GHN] BASE_URL ĐANG DÙNG LÀ: '" + GHNConfig.BASE_URL + "' ======");

            URL url = new URL(GHNConfig.BASE_URL + "/master-data/province");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // Gắn Header
            conn.setRequestProperty("Token", GHNConfig.TOKEN);
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);

            int statusCode = conn.getResponseCode();

            System.out.println("====== [DEBUG GHN] HTTP STATUS TRẢ VỀ: " + statusCode + " ======");

            InputStream is = (statusCode >= 200 && statusCode < 300)
                    ? conn.getInputStream()
                    : conn.getErrorStream();

            BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            StringBuilder result = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            br.close();

            System.out.println("====== [DEBUG GHN RESPONSE] ======");
            System.out.println(result.toString());
            System.out.println("==================================");

            resp.setStatus(statusCode);
            resp.getWriter().write(result.toString());

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write("{\"code\":500,\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}