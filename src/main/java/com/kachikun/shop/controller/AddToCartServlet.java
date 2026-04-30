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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String redirect = request.getParameter("redirect");
        boolean stayOnPage = "stay".equals(redirect);
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (idStr != null) {
            int productId;
            try {
                productId = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
                if (isAjax) {
                    sendJson(response, false, "ID sản phẩm không hợp lệ!", 0);
                } else {
                    response.sendRedirect("products");
                }
                return;
            }

            ProductDAO dao = new ProductDAO();
            Product dbProduct = dao.getProductById(productId);

            if (dbProduct == null) {
                if (isAjax) {
                    sendJson(response, false, "Sản phẩm không tồn tại!", 0);
                } else {
                    response.sendRedirect("products");
                }
                return;
            }

            HttpSession session = request.getSession();

            // Kiểm tra đăng nhập
            if (session.getAttribute("user") == null) {
                if (isAjax) {
                    sendJson(response, false, "Vui lòng đăng nhập để thêm vào giỏ hàng!", 0);
                } else {
                    response.sendRedirect("login");
                }
                return;
            }

            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            String message = "";
            boolean success = true;
            boolean found = false;

            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    if (item.getQuantity() < dbProduct.getStock()) {
                        item.setQuantity(item.getQuantity() + 1);
                        message = "Đã thêm " + dbProduct.getName() + " vào giỏ hàng!";
                    } else {
                        success = false;
                        message = "Sản phẩm " + dbProduct.getName() + " đã đạt giới hạn tồn kho!";
                    }
                    found = true;
                    break;
                }
            }

            if (!found) {
                if (dbProduct.getStock() > 0) {
                    cart.add(new CartItem(dbProduct, 1));
                    message = "Đã thêm " + dbProduct.getName() + " vào giỏ hàng!";
                } else {
                    success = false;
                    message = "Sản phẩm " + dbProduct.getName() + " đã hết hàng!";
                }
            }

            session.setAttribute("cart", cart);

            int cartSize = 0;
            for (CartItem item : cart) cartSize += item.getQuantity();

            if (isAjax) {
                sendJson(response, success, message, cartSize);
                return;
            }

            if (!success) {
                session.setAttribute("stockError", message);
            }
        }

        if (stayOnPage) {
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : "products");
        } else {
            response.sendRedirect("cart");
        }
    }

    private void sendJson(HttpServletResponse response, boolean success,
                          String message, int cartSize) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = String.format(
                "{\"success\":%b, \"message\":\"%s\", \"cartSize\":%d}",
                success,
                message.replace("\"", "\\\""),
                cartSize
        );
        response.getWriter().write(json);
    }
}