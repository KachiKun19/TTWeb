package com.kachikun.shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/ajaxUpdateCart")
public class AjaxUpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String qtyStr = request.getParameter("qty");
            String modStr = request.getParameter("mod");

            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart != null) {
                for (int i = 0; i < cart.size(); i++) {
                    CartItem item = cart.get(i);
                    if (item.getProduct().getId() == id) {
                        ProductDAO pDao = new ProductDAO();
                        Product dbProduct = pDao.getProductById(id);

                        int newQty = 0;
                        if (qtyStr != null) {
                            newQty = Integer.parseInt(qtyStr);
                        } else if (modStr != null) {
                            newQty = item.getQuantity() + Integer.parseInt(modStr);
                        }

                        if (newQty > dbProduct.getStock()) {
                            // Trả raw number
                            out.print("{\"status\":\"error\","
                                    + "\"message\":\"Kho chi con " + dbProduct.getStock() + " cai!\","
                                    + "\"currentQty\":" + item.getQuantity() + "}");
                            return;
                        }

                        if (newQty > 0) {
                            item.setQuantity(newQty);
                        } else {
                            cart.remove(i);
                            session.setAttribute("cart", cart);
                            double newTotal = calculateTotal(cart);
                            // Trả raw number
                            out.print("{\"status\":\"removed\","
                                    + "\"cartTotalRaw\":" + newTotal + ","
                                    + "\"cartSize\":" + cart.size() + "}");
                            return;
                        }
                        break;
                    }
                }
            }

            double newTotal = calculateTotal(cart);
            double itemTotal = 0;
            int currentQty = 0;

            if (cart != null) {
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == id) {
                        itemTotal  = item.getTotalPrice();
                        currentQty = item.getQuantity();
                        break;
                    }
                }
            }

            // Trả raw numbers
            out.print("{\"status\":\"ok\","
                    + "\"newQty\":" + currentQty + ","
                    + "\"itemTotalRaw\":" + itemTotal + ","
                    + "\"cartTotalRaw\":" + newTotal + ","
                    + "\"cartSize\":" + (cart != null ? cart.size() : 0) + "}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"message\":\"Loi du lieu!\"}");
        }
    }

    private double calculateTotal(List<CartItem> cart) {
        double total = 0;
        if (cart != null) {
            for (CartItem item : cart) total += item.getTotalPrice();
        }
        return total;
    }
}