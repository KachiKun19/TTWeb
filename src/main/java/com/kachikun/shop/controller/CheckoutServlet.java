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
import com.kachikun.shop.dao.ProductDAO; // Nhớ import cái này
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.Product; // Nhớ import cái này
import com.kachikun.shop.model.User;

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

        ProductDAO pDao = new ProductDAO();
        for (CartItem item : cart) {

            Product dbProduct = pDao.getProductById(item.getProduct().getId());

            if (item.getQuantity() > dbProduct.getStock()) {
                request.setAttribute("stockError", "Sản phẩm '" + dbProduct.getName() + "' chỉ còn lại " + dbProduct.getStock() + " cái. Vui lòng giảm số lượng!");
                
                request.setAttribute("totalMoney", calculateTotal(cart)); 
                
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return; 
            }
        }
        double totalMoney = calculateTotal(cart);

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

            request.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại!");
            request.setAttribute("totalMoney", totalMoney); 
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    private double calculateTotal(List<CartItem> cart) {
        double total = 0;
        if (cart != null) {
            for (CartItem item : cart) {
                total += item.getTotalPrice();
            }
        }
        return total;
    }
}