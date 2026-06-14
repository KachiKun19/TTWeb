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
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) {
            response.sendRedirect("home");
            return;
        }

        // Week offset
        int weekOffset = 0;
        String offsetParam = request.getParameter("weekOffset");
        if (offsetParam != null) {
            try {
                weekOffset = Integer.parseInt(offsetParam);
            } catch (NumberFormatException ignored) {
            }
        }

        // Threshold
        int threshold = 10;
        String thresholdParam = request.getParameter("threshold");
        if (thresholdParam != null) {
            try {
                threshold = Math.max(1, Integer.parseInt(thresholdParam));
            } catch (NumberFormatException ignored) {
            }
        }

        // Tính ngày đầu/cuối tuần
        LocalDate baseDate = LocalDate.now().plusWeeks(weekOffset);
        LocalDate weekStart = baseDate.with(WeekFields.of(Locale.FRANCE).dayOfWeek(), 1);
        LocalDate weekEnd = baseDate.with(WeekFields.of(Locale.FRANCE).dayOfWeek(), 7);

        // Lấy dữ liệu
        List<Map<String, Object>> topSellingAll = orderDAO.getTopSellingProductsByWeek(weekStart, weekEnd, threshold);
        List<Map<String, Object>> notSellingAll = orderDAO.getNotSellingProductsByWeek(weekStart, weekEnd, threshold);
        List<Map<String, Object>> allInventoryAll = orderDAO.getAllInventory();

        // Phân trang
        int pageSize = 10;

        int pageHot = 1, pageCold = 1, pageAll = 1;
        try {
            pageHot = Math.max(1, Integer.parseInt(request.getParameter("pageHot") != null ? request.getParameter("pageHot") : "1"));
        } catch (Exception ignored) {
        }
        try {
            pageCold = Math.max(1, Integer.parseInt(request.getParameter("pageCold") != null ? request.getParameter("pageCold") : "1"));
        } catch (Exception ignored) {
        }
        try {
            pageAll = Math.max(1, Integer.parseInt(request.getParameter("pageAll") != null ? request.getParameter("pageAll") : "1"));
        } catch (Exception ignored) {
        }

        int totalHot = topSellingAll.size();
        int totalCold = notSellingAll.size();
        int totalAll = allInventoryAll.size();

        int totalPagesHot = (int) Math.ceil((double) totalHot / pageSize);
        if (totalPagesHot == 0) totalPagesHot = 1;
        int totalPagesCold = (int) Math.ceil((double) totalCold / pageSize);
        if (totalPagesCold == 0) totalPagesCold = 1;
        int totalPagesAll = (int) Math.ceil((double) totalAll / pageSize);
        if (totalPagesAll == 0) totalPagesAll = 1;

        if (pageHot > totalPagesHot) pageHot = totalPagesHot;
        if (pageCold > totalPagesCold) pageCold = totalPagesCold;
        if (pageAll > totalPagesAll) pageAll = totalPagesAll;

        List<Map<String, Object>> topSelling = topSellingAll.subList(Math.min((pageHot - 1) * pageSize, totalHot), Math.min(pageHot * pageSize, totalHot));
        List<Map<String, Object>> notSelling = notSellingAll.subList(Math.min((pageCold - 1) * pageSize, totalCold), Math.min(pageCold * pageSize, totalCold));
        List<Map<String, Object>> allInventory = allInventoryAll.subList(Math.min((pageAll - 1) * pageSize, totalAll), Math.min(pageAll * pageSize, totalAll));

        // Active tab
        String activeTab = request.getParameter("activeTab");
        if (activeTab == null) activeTab = "tab-hot";

        // Set attributes
        request.setAttribute("weekStart", weekStart);
        request.setAttribute("weekEnd", weekEnd);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("threshold", threshold);
        request.setAttribute("topSelling", topSelling);
        request.setAttribute("notSelling", notSelling);
        request.setAttribute("allInventory", allInventory);
        request.setAttribute("totalHot", totalHot);
        request.setAttribute("totalCold", totalCold);
        request.setAttribute("totalAll", totalAll);
        request.setAttribute("totalPagesHot", totalPagesHot);
        request.setAttribute("totalPagesCold", totalPagesCold);
        request.setAttribute("totalPagesAll", totalPagesAll);
        request.setAttribute("pageHot", pageHot);
        request.setAttribute("pageCold", pageCold);
        request.setAttribute("pageAll", pageAll);
        request.setAttribute("activeTab", activeTab);
        request.setAttribute("activePage", "inventory");

        request.getRequestDispatcher("adminInventory.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}