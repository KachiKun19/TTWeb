package com.kachikun.shop.controller;

import com.kachikun.shop.utils.GHNConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/ghn/shipping-fee")
public class GHNFeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        try {
            String districtId = request.getParameter("district_id");
            String wardCode = request.getParameter("ward_code");
            System.out.println("DISTRICT: " + districtId);
            System.out.println("WARD: " + wardCode);
            URL url = new URL("https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee");

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Token", GHNConfig.TOKEN);
            conn.setRequestProperty("ShopId", GHNConfig.SHOP_ID);

            String json = """
                    {
                        "service_type_id": 2,
                        "from_district_id": 1454,
                        "to_district_id": %s,
                        "to_ward_code": "%s",
                        "height": 15,
                        "length": 15,
                        "width": 15,
                        "weight": 1000,
                        "insurance_value": 100000
                    }
                    """.formatted(districtId, wardCode);

            System.out.println(json);
            OutputStream os = conn.getOutputStream();
            os.write(json.getBytes());
            os.flush();
            os.close();
            int code = conn.getResponseCode();
            InputStream is;
            if (code >= 200 && code < 300) {
                is = conn.getInputStream();
            } else {
                is = conn.getErrorStream();
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            br.close();

            System.out.println("GHN RESPONSE: " + sb);

            response.getWriter().write(sb.toString());

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().write("""
                    {
                        "code":500,
                        "message":"SERVER ERROR"
                    }
                    """);
        }
    }
}