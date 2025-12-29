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

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lấy thông tin từ đường link: ID sản phẩm và Chế độ (tăng hay giảm)
        String idStr = request.getParameter("id");
        String modStr = request.getParameter("mod"); // mod = 1 (tăng), mod = -1 (giảm)

        if (idStr != null && modStr != null) {
            int id = Integer.parseInt(idStr);
            int mod = Integer.parseInt(modStr);

            //Lấy giỏ hàng ra
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart != null) {
                for (int i = 0; i < cart.size(); i++) {
                    CartItem item = cart.get(i);
                    // Tìm sản phẩm cần sửa
                    if (item.getProduct().getId() == id) {
                        // bấm nút thêm số lương or bấm nút giảm số lượng
                        int newQuantity = item.getQuantity() + mod;

                        if (newQuantity > 0) {
                            item.setQuantity(newQuantity);
                        } else {
                            // về 0 là xóa lun
                            cart.remove(i);
                        }
                        break;
                    }
                }
            }
            // Cập nhật lại session
            session.setAttribute("cart", cart);
        }

        //Quay lại trang giỏ hàng
        response.sendRedirect("cart");
    }
}