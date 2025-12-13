package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.model.CartItem; 

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lấy giỏ hàng từ Session ra
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        // AddToCart chỉ thêm số lượng chứ chưa tính tổng cả đơn)
        double totalMoney = 0;
        if (cart != null) {
            for (CartItem item : cart) {
                // Hàm getTotalPrice() này nằm trong class CartItem
                totalMoney += item.getTotalPrice(); 
            }
        }
        
        // Đẩy biến 'totalMoney' sang JSP để hiển thị dòng "Tạm tính" và "Tổng tiền"
        request.setAttribute("totalMoney", totalMoney);
        
        // Mở trang giao diện
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}