package com.kachikun.shop.controller;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.payment.VNPayHelper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/vnpay/ipn")
public class VNPayIPNServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json;charset=UTF-8");

        String receivedHash = request.getParameter("vnp_SecureHash");
        String responseCode = request.getParameter("vnp_ResponseCode");
        String txnRef       = request.getParameter("vnp_TxnRef");

        boolean signatureOk;
        try {
            signatureOk = VNPayHelper.verifySignature(request.getParameterMap(), receivedHash);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"RspCode\":\"99\",\"Message\":\"Unknown error\"}");
            return;
        }

        if (!signatureOk) {
            response.getWriter().write("{\"RspCode\":\"97\",\"Message\":\"Invalid Checksum\"}");
            return;
        }

        int orderId = VNPayHelper.parseOrderId(txnRef);
        if (orderId <= 0) {
            response.getWriter().write("{\"RspCode\":\"01\",\"Message\":\"Order not found\"}");
            return;
        }

        if (!"00".equals(responseCode)) {
            new OrderDAO().cancelVNPayOrder(orderId);
        }
        response.getWriter().write("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");
    }
}
