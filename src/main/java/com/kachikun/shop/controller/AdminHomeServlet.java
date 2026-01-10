package com.kachikun.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.dao.UserDAO;
import com.kachikun.shop.model.User;

@WebServlet("/adminHome")
public class AdminHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();
	private ProductDAO productDAO = new ProductDAO();
	private OrderDAO orderDAO = new OrderDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Kiểm tra đăng nhập
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login");
			return;
		}

		// Kiểm tra quyền admin
		User user = (User) session.getAttribute("user");
		if (user.getRole() != 1) {
			// Nếu không phải admin, chuyển về trang user
			response.sendRedirect("home");
			return;
		}

		// Lấy thống kê từ DAO
		int totalUsers = userDAO.getTotalUsers();
		int totalProducts = productDAO.getTotalProducts();
		int todayOrders = orderDAO.getTodayOrdersCount();
		double todayRevenue = orderDAO.getTodayRevenue();

		// Lấy doanh thu theo tháng (12 tháng gần nhất)
		Map<String, Double> monthlyRevenue = orderDAO.getMonthlyRevenue(12);

		// Tính toán thống kê tổng quan
		double totalYearRevenue = 0;
		double maxRevenue = 0;
		double avgRevenue = 0;
		double lastMonthRevenue = 0;

		if (monthlyRevenue != null && !monthlyRevenue.isEmpty()) {
			// Tính tổng doanh thu 12 tháng
			for (Double revenue : monthlyRevenue.values()) {
				totalYearRevenue += revenue;
				if (revenue > maxRevenue) {
					maxRevenue = revenue;
				}
			}

			// Tính trung bình
			avgRevenue = totalYearRevenue / monthlyRevenue.size();

			// Lấy doanh thu tháng trước (nếu có)
			Double[] revenues = monthlyRevenue.values().toArray(new Double[0]);
			if (revenues.length >= 2) {
				lastMonthRevenue = revenues[1]; // Tháng trước
			}
		}

		// Tính phần trăm thay đổi
		double revenueChangePercent = 0;
		if (lastMonthRevenue > 0) {
			revenueChangePercent = ((todayRevenue - lastMonthRevenue) / lastMonthRevenue) * 100;
		}

		// Truyền attribute sang JSP
		request.setAttribute("totalUsers", totalUsers);
		request.setAttribute("totalProducts", totalProducts);
		request.setAttribute("todayOrders", todayOrders);
		request.setAttribute("todayRevenue", todayRevenue);
		request.setAttribute("monthlyRevenue", monthlyRevenue);
		request.setAttribute("totalYearRevenue", totalYearRevenue);
		request.setAttribute("maxRevenue", maxRevenue);
		request.setAttribute("avgRevenue", avgRevenue);
		request.setAttribute("revenueChangePercent", revenueChangePercent);
		request.setAttribute("lastMonthRevenue", lastMonthRevenue);

		// Nếu là admin, chuyển đến trang admin
		request.getRequestDispatcher("adminHome.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}