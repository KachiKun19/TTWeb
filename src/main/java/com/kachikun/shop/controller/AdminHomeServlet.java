package com.kachikun.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.DailyStat; 
import com.kachikun.shop.model.User;

@WebServlet("/adminHome")
public class AdminHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO = new UserDAO();
    private ProductDAO productDAO = new ProductDAO();
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user.getRole() != 1) { // 1 là Admin
            response.sendRedirect("home");
            return;
        }

        int totalUsers = 0;
        int totalProducts = 0;
        int todayOrders = 0;
        double todayRevenue = 0;

        try {
            totalUsers = userDAO.getTotalUsers();
            totalProducts = productDAO.getTotalProducts();
            
            todayOrders = orderDAO.getTodayOrdersCount();
            todayRevenue = orderDAO.getTodayRevenue(); 
        } catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, Double> monthlyRevenue = orderDAO.getRevenueLast12Months();

        double totalYearRevenue = 0;
        double maxRevenue = 0;
        double avgRevenue = 0;

        if (monthlyRevenue != null && !monthlyRevenue.isEmpty()) {
            for (Double revenue : monthlyRevenue.values()) {
                totalYearRevenue += revenue;
                if (revenue > maxRevenue) {
                    maxRevenue = revenue;
                }
            }
            avgRevenue = totalYearRevenue / monthlyRevenue.size();
        }

        LocalDate now = LocalDate.now();
        int selectedMonth = now.getMonthValue();
        int selectedYear = now.getYear();
        
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");
        
        if (monthParam != null && yearParam != null) {
            try {
                selectedMonth = Integer.parseInt(monthParam);
                selectedYear = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
            }
        }

        List<DailyStat> dailyStats = orderDAO.getDailyStatistics(selectedMonth, selectedYear);
        
        int prevMonth = (selectedMonth == 1) ? 12 : selectedMonth - 1;
        int prevYear = (selectedMonth == 1) ? selectedYear - 1 : selectedYear;
        
        int nextMonth = (selectedMonth == 12) ? 1 : selectedMonth + 1;
        int nextYear = (selectedMonth == 12) ? selectedYear + 1 : selectedYear;

        
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("todayOrders", todayOrders);
        request.setAttribute("todayRevenue", todayRevenue);
        
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("totalYearRevenue", totalYearRevenue);
        request.setAttribute("maxRevenue", maxRevenue);
        request.setAttribute("avgRevenue", avgRevenue);
        
        request.setAttribute("dailyStats", dailyStats);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);
        request.setAttribute("prevMonth", prevMonth);
        request.setAttribute("prevYear", prevYear);
        request.setAttribute("nextMonth", nextMonth);
        request.setAttribute("nextYear", nextYear);

        request.getRequestDispatcher("adminHome.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}