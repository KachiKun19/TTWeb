package com.kachikun.shop.controller;

import com.google.gson.Gson;
import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.Discount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/apply-discount")
public class ApplyDiscountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> result = new HashMap<>();

        String code = request.getParameter("code");
        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (code == null || code.trim().isEmpty()) {
            result.put("status", "error");
            result.put("message", "Vui lòng nhập mã giảm giá!");
            response.getWriter().write(gson.toJson(result));
            return;
        }

        if (cart == null || cart.isEmpty()) {
            result.put("status", "error");
            result.put("message", "Giỏ hàng trống!");
            response.getWriter().write(gson.toJson(result));
            return;
        }

        String subtotalParam = request.getParameter("subtotal");
        double subtotal = 0;
        try {
            subtotal = Double.parseDouble(subtotalParam);
        } catch (Exception e) {
            subtotal = cart.stream().mapToDouble(CartItem::getTotalPrice).sum();
        }

        DiscountDAO dao = new DiscountDAO();
        Discount discount = dao.findByCode(code.trim());

        if (discount == null) {
            result.put("status", "error");
            result.put("message", "Mã giảm giá không tồn tại!");
            response.getWriter().write(gson.toJson(result));
            return;
        }

        if (!discount.isValid()) {
            result.put("status", "error");
            result.put("message", "Mã giảm giá đã hết hạn hoặc không còn hiệu lực!");
            response.getWriter().write(gson.toJson(result));
            return;
        }

        if (subtotal < discount.getMinOrderValue()) {
            result.put("status", "error");
            result.put("message", String.format("Đơn hàng tối thiểu %,.0f₫ để dùng mã này!", discount.getMinOrderValue()));
            response.getWriter().write(gson.toJson(result));
            return;
        }

        double discountAmount = discount.calculateDiscount(subtotal);
        double finalTotal = subtotal - discountAmount;

        result.put("status", "ok");
        result.put("discountAmount", discountAmount);
        result.put("finalTotal", finalTotal);
        result.put("subtotal", subtotal);
        result.put("code", discount.getCode());
        response.getWriter().write(gson.toJson(result));
    }
}
