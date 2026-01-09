package com.kachikun.shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                            int mod = Integer.parseInt(modStr);
                            newQty = item.getQuantity() + mod;
                        }

                        if (newQty > dbProduct.getStock()) {
                            out.print("{\"status\":\"error\", \"message\":\"Kho chỉ còn " + dbProduct.getStock() + " cái!\", \"currentQty\":" + item.getQuantity() + "}");
                            return;
                        }

                        if (newQty > 0) {
                            item.setQuantity(newQty);
                        } else {
                            cart.remove(i);
                            session.setAttribute("cart", cart);
                            double newTotal = calculateTotal(cart);
                            out.print(String.format("{\"status\":\"removed\", \"cartTotal\":\"%s\", \"cartSize\":%d}", 
                                    formatMoney(newTotal), cart.size()));
                            return;
                        }
                        break;
                    }
                }
            }
            
            double newTotal = calculateTotal(cart);
            double itemTotal = 0;
            int currentQty = 0;
            
            for(CartItem item : cart) {
                if(item.getProduct().getId() == id) {
                    itemTotal = item.getTotalPrice();
                    currentQty = item.getQuantity();
                    break;
                }
            }

            String jsonResponse = String.format(
                "{\"status\":\"ok\", \"newQty\":%d, \"itemTotal\":\"%s\", \"cartTotal\":\"%s\", \"cartSize\":%d}",
                currentQty, 
                formatMoney(itemTotal), 
                formatMoney(newTotal),
                cart.size()
            );
            
            out.print(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Lỗi dữ liệu nhập vào!\"}");
        }
    }

    private double calculateTotal(List<CartItem> cart) {
        double total = 0;
        if (cart != null) {
            for (CartItem item : cart) total += item.getTotalPrice();
        }
        return total;
    }
    
    private String formatMoney(double amount) {
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return nf.format(amount);
    }
}