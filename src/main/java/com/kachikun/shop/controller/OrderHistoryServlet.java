package com.kachikun.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.dao.ProductDAO;
import com.kachikun.shop.dao.ReviewDAO;
import com.kachikun.shop.model.Order;
import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final int PAGE_SIZE = 5;

	private OrderDAO  orderDAO  = new OrderDAO();
	private ReviewDAO reviewDAO = new ReviewDAO();
	private ProductDAO productDAO = new ProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp"); return;
		}
		User user = (User) session.getAttribute("user");

		String action = request.getParameter("action");
		String idStr  = request.getParameter("id");

		// Hủy đơn
		if ("cancel".equals(action) && idStr != null) {
			int orderId = Integer.parseInt(idStr);
			String reason = request.getParameter("cancel_reason");
			if ("Khác".equals(reason)) {
				String custom = request.getParameter("custom_reason");
				reason = (custom != null && !custom.trim().isEmpty()) ? custom.trim() : "Khách hủy đơn";
			} else if (reason == null || reason.trim().isEmpty()) {
				reason = "Khách hủy đơn";
			}

			boolean cancelled = orderDAO.userCancelOrder(orderId, user.getId(), reason);
			if (cancelled) {
				request.setAttribute("msg", "Đã hủy đơn hàng #" + orderId + " thành công.");
			} else {
				request.setAttribute("error", "Không thể hủy đơn hàng #" + orderId + ". Đơn đã được xử lý hoặc đang giao!");
			}
		}

		// Lấy danh sách đơn hàng
		List<Order> myOrders = orderDAO.getOrdersByUserId(user.getId());

		// filter theo status
		String statusFilter = request.getParameter("status");
		if (statusFilter == null) statusFilter = "ALL";

		List<Order> filteredOrders;
		if ("ALL".equals(statusFilter)) {
			filteredOrders = myOrders;
		} else {
			filteredOrders = new ArrayList<>();
			for (Order o : myOrders) {
				if (statusFilter.equals(o.getStatus())) {
					filteredOrders.add(o);
				}
			}
		}

		Map<String, Integer> statusCount = new HashMap<>();
		statusCount.put("ALL", myOrders.size());
		for (Order o : myOrders) {
			statusCount.merge(o.getStatus(), 1, Integer::sum);
		}

		// phân trang
		int totalOrders = filteredOrders.size();
		int totalPages  = (int) Math.ceil((double) totalOrders / PAGE_SIZE);
		if (totalPages == 0) totalPages = 1;

		int currentPage = 1;
		String pageParam = request.getParameter("page");
		if (pageParam != null) {
			try {
				currentPage = Integer.parseInt(pageParam);
			} catch (NumberFormatException ignored) {}
		}
		if (currentPage < 1)           currentPage = 1;
		if (currentPage > totalPages)  currentPage = totalPages;

		int fromIndex = (currentPage - 1) * PAGE_SIZE;
		int toIndex   = Math.min(fromIndex + PAGE_SIZE, totalOrders);
		List<Order> pagedOrders = (totalOrders > 0)
				? filteredOrders.subList(fromIndex, toIndex)
				: new ArrayList<>();

		//

		Map<Integer, List<Product>> unreviewedMap = new HashMap<>();
		for (Order o : pagedOrders) {
			if ("Đã giao".equals(o.getStatus())) {
				List<Integer> unreviewedIds = reviewDAO.getUnreviewedProductIds(o.getId(), user.getId());
				List<Product> prods = new ArrayList<>();
				for (int pid : unreviewedIds) {
					Product p = productDAO.getProductById(pid);
					if (p != null) prods.add(p);
				}
				unreviewedMap.put(o.getId(), prods);
			}
		}
		 // xóa msg từ sesion của ReviewBulkServlet
		String sessionMsg = (String) session.getAttribute("msg");
		if (sessionMsg != null) {
			session.removeAttribute("msg");

			boolean hasUnreviewed = false;
			for (Order o : myOrders) {
				if ("Đã giao".equals(o.getStatus())) {
					List<Integer> unreviewed = reviewDAO.getUnreviewedProductIds(o.getId(), user.getId());
					if (!unreviewed.isEmpty()) {
						hasUnreviewed = true;
						break;
					}
				}
			}
			if (!hasUnreviewed) {
				request.setAttribute("msg", sessionMsg);
			}
		}

		request.setAttribute("myOrders", pagedOrders);
		request.setAttribute("unreviewedMap", unreviewedMap);
		request.setAttribute("statusFilter",  statusFilter);
		request.setAttribute("statusCount",   statusCount);
		request.setAttribute("currentPage",   currentPage);
		request.setAttribute("totalPages",    totalPages);
		request.setAttribute("totalOrders",   totalOrders);
		request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}