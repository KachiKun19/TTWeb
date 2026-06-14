package com.kachikun.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.model.User;

@WebServlet("/adminInventory")
public class AdminInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp"); return;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            response.sendRedirect("home"); return;
        }

        // Tính tuần hiện tại
        LocalDate today = LocalDate.now();
        LocalDate weekStart = today;
        LocalDate weekEnd = today;

        String offsetParam = request.getParameter("weekOffset");
        int weekOffset = 0;
        if (offsetParam != null) {
            try { weekOffset = Integer.parseInt(offsetParam); } catch (NumberFormatException ignored) {}
        }

        // Tính ngày đầu tuần (Thứ 2) và cuối tuần (Chủ nhật)
        LocalDate baseDate = today.plusWeeks(weekOffset);
        weekStart = baseDate.with(WeekFields.of(Locale.FRANCE).dayOfWeek(), 1); // Thứ 2
        weekEnd   = baseDate.with(WeekFields.of(Locale.FRANCE).dayOfWeek(), 7); // Chủ nhật

        List<Map<String, Object>> topSelling    = orderDAO.getTopSellingProductsByWeek(weekStart, weekEnd);
        List<Map<String, Object>> notSelling    = orderDAO.getNotSellingProductsByWeek(weekStart, weekEnd);
        List<Map<String, Object>> allInventory  = orderDAO.getAllInventory();

        request.setAttribute("topSelling",   topSelling);
        request.setAttribute("notSelling",   notSelling);
        request.setAttribute("allInventory", allInventory);
        request.setAttribute("weekStart",    weekStart);
        request.setAttribute("weekEnd",      weekEnd);
        request.setAttribute("weekOffset",   weekOffset);

        request.setAttribute("activePage", "inventory");
        request.getRequestDispatcher("adminInventory.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}