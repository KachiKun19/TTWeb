package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.Discount;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullname      = request.getParameter("fullname");
        String phone         = request.getParameter("phone");
        String address       = request.getParameter("address");
        String paymentMethod = request.getParameter("payment_method");
        String discountCode  = request.getParameter("discountCode");

        // Lấy danh sách productId được chọn từ checkbox
        String[] selectedIdsArr = request.getParameterValues("selectedIds");

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

        List<Discount> savedDiscounts = new DiscountDAO().getSavedDiscountsByUser(user.getId());

        List<CartItem> selectedCart;
        if (selectedIdsArr != null && selectedIdsArr.length > 0) {
            Set<Integer> selectedIds = new HashSet<>();
            for (String sid : selectedIdsArr) {
                try {
                    selectedIds.add(Integer.parseInt(sid));
                } catch (NumberFormatException ignored) {
                }
            }
            selectedCart = cart.stream()
                    .filter(item -> selectedIds.contains(item.getProduct().getId()))
                    .collect(Collectors.toList());
        } else {
            request.setAttribute("stockError", "Vui lòng chọn ít nhất một sản phẩm để thanh toán!");
            request.setAttribute("totalMoney", calculateTotal(cart));
            request.setAttribute("savedDiscounts", savedDiscounts);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        if (selectedCart.isEmpty()) {
            request.setAttribute("stockError", "Không tìm thấy sản phẩm đã chọn!");
            request.setAttribute("totalMoney", calculateTotal(cart));
            request.setAttribute("savedDiscounts", savedDiscounts);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tồn kho của các item được chọn
        ProductDAO pDao = new ProductDAO();
        for (CartItem item : selectedCart) {
            Product dbProduct = pDao.getProductById(item.getProduct().getId());
            if (item.getQuantity() > dbProduct.getStock()) {
                request.setAttribute("stockError",
                        "Sản phẩm '" + dbProduct.getName() + "' chỉ còn lại "
                                + dbProduct.getStock() + " cái. Vui lòng giảm số lượng!");
                request.setAttribute("totalMoney", calculateTotal(cart));
                request.setAttribute("savedDiscounts", savedDiscounts);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }
        }

        // Tính tổng và áp dụng discount
        double totalMoney = calculateTotal(selectedCart);
        double discountAmount = 0;

        if (discountCode != null && !discountCode.trim().isEmpty()) {
            DiscountDAO discountDAO = new DiscountDAO();
            Discount discount = discountDAO.findByCode(discountCode.trim());
            if (discount != null && discount.isValid() && totalMoney >= discount.getMinOrderValue()) {
                discountAmount = discount.calculateDiscount(totalMoney);
            }
        }
        double finalTotal = totalMoney - discountAmount;

        // ── Tạo đơn hàng chỉ từ selectedCart ────────────────────────────────
        OrderDAO dao = new OrderDAO();
        boolean check = dao.createOrder(user, selectedCart, finalTotal, fullname, phone, address, paymentMethod);

        if (check) {
            if (discountCode != null && !discountCode.trim().isEmpty() && discountAmount > 0) {
                boolean usedOk = new DiscountDAO().incrementUsedSafe(discountCode.trim());
                if (!usedOk) {
                    System.out.println("[WARN] Discount quota race condition: code=" + discountCode
                            + ", userId=" + user.getId());
                }
            }

            // Xóa khỏi session chỉ những item đã mua, giữ lại item chưa chọn
            Set<Integer> boughtIds = selectedCart.stream()
                    .map(item -> item.getProduct().getId())
                    .collect(Collectors.toSet());
            List<CartItem> remainingCart = cart.stream()
                    .filter(item -> !boughtIds.contains(item.getProduct().getId()))
                    .collect(Collectors.toList());

            if (remainingCart.isEmpty()) {
                session.removeAttribute("cart");
            } else {
                session.setAttribute("cart", remainingCart);
            }

            request.setAttribute("msg", "Đặt hàng thành công!");
            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("finalTotal", finalTotal);
            request.setAttribute("orderId", System.currentTimeMillis());
            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } else {
            request.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại!");
            request.setAttribute("totalMoney", totalMoney);
            request.setAttribute("savedDiscounts", savedDiscounts);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
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