package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.Product;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy ID sản phẩm từ đường dẫn (VD: add-to-cart?id=123)
        String idStr = request.getParameter("id");
        int productId = Integer.parseInt(idStr);

        // Lấy giỏ hàng từ Session
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Nếu chưa có giỏ hàng thì tạo list mới
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Kiểm tra sản phẩm đã có trong giỏ chưa
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
                // Nếu có rồi thì tăng số lượng lên 1
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                break;
            }
        }

        // Nếu chưa có thì lấy thông tin từ DB và thêm vào list
        if (!found) {
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(productId); // Hàm này bạn đã viết trong ProductDAO rồi
            if (p != null) {
                CartItem newItem = new CartItem(p, 1);
                cart.add(newItem);
            }
        }

        // Lưu lại vào session
        session.setAttribute("cart", cart);

        // Chuyển hướng về trang giỏ hàng
        // Về thẳng trang giỏ hàng (Cart)
        response.sendRedirect("cart");
    }
}