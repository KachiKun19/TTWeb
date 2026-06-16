package com.kachikun.shop.controller;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.payment.VNPayHelper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/vnpay/return")
public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String receivedHash = request.getParameter("vnp_SecureHash");
        String responseCode = request.getParameter("vnp_ResponseCode");
        String txnRef       = request.getParameter("vnp_TxnRef");

        boolean signatureOk = false;
        try {
            signatureOk = VNPayHelper.verifySignature(request.getParameterMap(), receivedHash);
        } catch (Exception e) {
            e.printStackTrace();
        }

        int orderId = VNPayHelper.parseOrderId(txnRef);
        HttpSession session = request.getSession();

        OrderDAO orderDAO = new OrderDAO();
        if (signatureOk && "00".equals(responseCode) && orderId > 0) {
            orderDAO.confirmVNPayPayment(orderId);
            session.setAttribute("vnpayMsg", "Thanh toán VNPay thành công! Đơn hàng #" + orderId + " đang được xử lý.");
            session.setAttribute("vnpaySuccess", true);
        } else {
            if (orderId > 0) orderDAO.cancelVNPayOrder(orderId);
            session.setAttribute("vnpayMsg", "Thanh toán VNPay thất bại hoặc bị hủy. Đơn hàng đã được hủy tự động.");
            session.setAttribute("vnpaySuccess", false);
        }
        response.sendRedirect(request.getContextPath() + "/order-history");
    }
}
