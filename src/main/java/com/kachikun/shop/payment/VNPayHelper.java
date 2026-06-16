package com.kachikun.shop.payment;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

public class VNPayHelper {

    public static String hmacSHA512(String key, String data) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA512");
        mac.init(new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512"));
        byte[] bytes = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        for (byte b : bytes) sb.append(String.format("%02x", b));
        return sb.toString();
    }

    public static String buildPaymentUrl(int orderId, long amountVnd, String ipAddr) throws Exception {
        String txnRef    = orderId + "_" + System.currentTimeMillis();
        String createDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String orderInfo = "Thanh toan don hang #" + orderId;

        Map<String, String> params = new TreeMap<>();
        params.put("vnp_Version",    VNPayConfig.VERSION);
        params.put("vnp_Command",    VNPayConfig.COMMAND);
        params.put("vnp_TmnCode",    VNPayConfig.TMN_CODE);
        params.put("vnp_Amount",     String.valueOf(amountVnd * 100));
        params.put("vnp_CurrCode",   VNPayConfig.CURR_CODE);
        params.put("vnp_TxnRef",     txnRef);
        params.put("vnp_OrderInfo",  orderInfo);
        params.put("vnp_OrderType",  VNPayConfig.ORDER_TYPE);
        params.put("vnp_Locale",     VNPayConfig.LOCALE);
        params.put("vnp_ReturnUrl",  VNPayConfig.RETURN_URL);
        params.put("vnp_IpAddr",     ipAddr);
        params.put("vnp_CreateDate", createDate);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query    = new StringBuilder();
        Iterator<Map.Entry<String, String>> itr = params.entrySet().iterator();
        while (itr.hasNext()) {
            Map.Entry<String, String> e = itr.next();
            String encoded = URLEncoder.encode(e.getValue(), StandardCharsets.US_ASCII.name());
            hashData.append(e.getKey()).append('=').append(encoded);
            query.append(URLEncoder.encode(e.getKey(), StandardCharsets.US_ASCII.name()))
                 .append('=').append(encoded);
            if (itr.hasNext()) { hashData.append('&'); query.append('&'); }
        }

        String secureHash = hmacSHA512(VNPayConfig.HASH_SECRET, hashData.toString());
        return VNPayConfig.PAY_URL + "?" + query + "&vnp_SecureHash=" + secureHash;
    }

    public static boolean verifySignature(Map<String, String[]> requestParams,
                                          String receivedHash) throws Exception {
        Map<String, String> sorted = new TreeMap<>();
        for (Map.Entry<String, String[]> e : requestParams.entrySet()) {
            String key = e.getKey();
            if (!"vnp_SecureHash".equals(key) && !"vnp_SecureHashType".equals(key)) {
                sorted.put(key, e.getValue()[0]);
            }
        }
        StringBuilder hashData = new StringBuilder();
        Iterator<Map.Entry<String, String>> itr = sorted.entrySet().iterator();
        while (itr.hasNext()) {
            Map.Entry<String, String> e = itr.next();
            hashData.append(e.getKey()).append('=')
                    .append(URLEncoder.encode(e.getValue(), StandardCharsets.US_ASCII.name()));
            if (itr.hasNext()) hashData.append('&');
        }
        return hmacSHA512(VNPayConfig.HASH_SECRET, hashData.toString()).equalsIgnoreCase(receivedHash);
    }

    public static int parseOrderId(String txnRef) {
        try {
            return Integer.parseInt(txnRef.split("_")[0]);
        } catch (Exception e) {
            return -1;
        }
    }
}
