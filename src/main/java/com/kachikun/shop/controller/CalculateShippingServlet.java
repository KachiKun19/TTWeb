package com.kachikun.shop.controller;

import com.kachikun.shop.utils.GHNConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/calculate-shipping")
public class CalculateShippingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BufferedReader reader = req.getReader();
        StringBuilder body = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            body.append(line);
        }
        String jsonBody = body.toString();
        URL url = new URL("https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Token", GHNConfig.TOKEN);
        conn.setRequestProperty("ShopId", GHNConfig.SHOP_ID);
        conn.setDoOutput(true);
        String requestJson = """
                {
                    "service_type_id":2,
                    "from_district_id":3695,
                    "to_district_id":"%s",
                    "to_ward_code":"%s",
                    "height":10,
                    "length":20,
                    "weight":500,
                    "width":20
                }
                """;

        OutputStream os = conn.getOutputStream();
        os.write(requestJson.getBytes());
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder result = new StringBuilder();
        while ((line = br.readLine()) != null) {
            result.append(line);
        }
        resp.setContentType("application/json");
        resp.getWriter().write(result.toString());
    }
}
