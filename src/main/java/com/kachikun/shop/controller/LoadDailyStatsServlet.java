package com.kachikun.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.model.DailyStat;

@WebServlet("/loadDailyStats")
public class LoadDailyStatsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO = new OrderDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int month = Integer.parseInt(request.getParameter("month"));
		int year = Integer.parseInt(request.getParameter("year"));

		List<DailyStat> dailyStats = orderDAO.getDailyStatistics(month, year);

		int prevMonth = (month == 1) ? 12 : month - 1;
		int prevYear = (month == 1) ? year - 1 : year;

		int nextMonth = (month == 12) ? 1 : month + 1;
		int nextYear = (month == 12) ? year + 1 : year;

		request.setAttribute("dailyStats", dailyStats);
		request.setAttribute("selectedMonth", month);
		request.setAttribute("selectedYear", year);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("nextYear", nextYear);

		request.getRequestDispatcher("dailyStatsFragment.jsp").forward(request, response);
	}
}