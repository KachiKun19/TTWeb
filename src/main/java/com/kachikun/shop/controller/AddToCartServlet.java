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
        String idStr = request.getParameter("id");
        
        if(idStr != null) {
            int productId = Integer.parseInt(idStr);

            ProductDAO dao = new ProductDAO();
            Product dbProduct = dao.getProductById(productId);

            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;

            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {

                    if (item.getQuantity() < dbProduct.getStock()) {

                        item.setQuantity(item.getQuantity() + 1);
                    } else {
                        session.setAttribute("stockError", "Sản phẩm " + dbProduct.getName() + " đã đạt giới hạn số lượng tồn kho!");
                    }
                    
                    found = true;
                    break;
                }
            }

            if (!found) {
                if (dbProduct.getStock() > 0) {
                    CartItem newItem = new CartItem(dbProduct, 1);
                    cart.add(newItem);
                } else {
                     session.setAttribute("stockError", "Sản phẩm này đã hết hàng!");
                }
            }

            session.setAttribute("cart", cart);
        }

        response.sendRedirect("cart.jsp");
    }
}