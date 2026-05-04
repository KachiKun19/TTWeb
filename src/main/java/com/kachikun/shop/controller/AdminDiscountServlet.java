package com.kachikun.shop.controller;

import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.model.Discount;
import com.kachikun.shop.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/adminDiscounts")
public class AdminDiscountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DiscountDAO discountDAO = new DiscountDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            response.sendRedirect("home");
            return;
        }

        String pageParam = request.getParameter("page");
        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int pageSize = 10;
        int totalCount = discountDAO.getTotalCount();
        int totalPages = totalCount > 0 ? (int) Math.ceil((double) totalCount / pageSize) : 0;
        if (totalPages > 0 && currentPage > totalPages) currentPage = totalPages;

        List<Discount> discountList = discountDAO.getByPage(currentPage, pageSize);

        request.setAttribute("discountList", discountList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("nowMs", System.currentTimeMillis());
        request.getRequestDispatcher("adminDiscounts.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            response.sendRedirect("home");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            Discount d = parseDiscount(request);

            if ("add".equals(action)) {
                if (discountDAO.findByCode(d.getCode()) != null) {
                    response.sendRedirect("adminDiscounts?error=duplicate_code");
                    return;
                }
                boolean ok = discountDAO.insert(d);
                response.sendRedirect("adminDiscounts?success=" + (ok ? "added" : "false"));
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                d.setId(id);
                boolean ok = discountDAO.update(d);
                response.sendRedirect("adminDiscounts?success=" + (ok ? "updated" : "false"));
            } else {
                response.sendRedirect("adminDiscounts");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDiscounts?error=invalid_input");
        }
    }

    private Discount parseDiscount(HttpServletRequest request) {
        Discount d = new Discount();
        d.setCode(request.getParameter("code").trim().toUpperCase());
        d.setDiscountType(request.getParameter("discountType"));
        d.setDiscountValue(Double.parseDouble(request.getParameter("discountValue")));

        String minOrderParam = request.getParameter("minOrderValue");
        d.setMinOrderValue(minOrderParam != null && !minOrderParam.isEmpty() ? Double.parseDouble(minOrderParam) : 0);

        String maxUsesParam = request.getParameter("maxUses");
        d.setMaxUses(maxUsesParam != null && !maxUsesParam.isEmpty() ? Integer.parseInt(maxUsesParam) : null);

        d.setActive(request.getParameter("active") != null);

        String expiresAtParam = request.getParameter("expiresAt");
        d.setExpiresAt(expiresAtParam != null && !expiresAtParam.isEmpty() ? Date.valueOf(expiresAtParam) : null);

        return d;
    }
}
