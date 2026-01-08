package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.User; // Import User

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("payment_method");

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        double totalMoney = 0;
        for (CartItem item : cart) {
            totalMoney += item.getTotalPrice();
        }

        OrderDAO dao = new OrderDAO();
        boolean check = dao.createOrder(user, cart, totalMoney, fullname, phone, address, paymentMethod);

        if (check) {
            session.removeAttribute("cart");

            request.setAttribute("msg", "Đặt hàng thành công!");
            request.setAttribute("paymentMethod", paymentMethod); 
            request.setAttribute("finalTotal", totalMoney);
            request.setAttribute("orderId", System.currentTimeMillis());
            
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } else {
            // Thất bại
            request.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }
}