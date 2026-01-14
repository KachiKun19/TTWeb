package com.kachikun.shop.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.kachikun.shop.dao.OrderDAO;
import com.kachikun.shop.model.DailyStat;
import com.kachikun.shop.model.Order;
import java.util.List;

@WebServlet("/exportRevenueStats")
public class ExportRevenueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO = new OrderDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int month = Integer.parseInt(request.getParameter("month"));
		int year = Integer.parseInt(request.getParameter("year"));

		List<Order> listOrders = orderDAO.getOrdersByMonthYear(month, year);

		List<DailyStat> dailyStats = orderDAO.getDailyStatistics(month, year);

		Workbook workbook = new XSSFWorkbook();

		Sheet sheetSummary = workbook.createSheet("Tổng quan");
		Row rowSum1 = sheetSummary.createRow(0);
		rowSum1.createCell(0).setCellValue("BÁO CÁO THÁNG " + month + "/" + year);

		double totalRev = 0;
		for (DailyStat d : dailyStats)
			totalRev += d.getRevenue();

		Row rowSum2 = sheetSummary.createRow(2);
		rowSum2.createCell(0).setCellValue("Tổng doanh thu:");
		rowSum2.createCell(1).setCellValue(totalRev);

		Sheet sheetDaily = workbook.createSheet("Theo Ngày");
		Row headerDaily = sheetDaily.createRow(0);
		headerDaily.createCell(0).setCellValue("Ngày");
		headerDaily.createCell(1).setCellValue("Số đơn");
		headerDaily.createCell(2).setCellValue("Doanh thu");

		int rowNumDaily = 1;
		for (DailyStat d : dailyStats) {
			Row r = sheetDaily.createRow(rowNumDaily++);
			r.createCell(0).setCellValue(d.getDay() + "/" + month + "/" + year);
			r.createCell(1).setCellValue(d.getOrderCount());
			r.createCell(2).setCellValue(d.getRevenue());
		}

		Sheet sheetOrders = workbook.createSheet("Danh sách đơn hàng");
		Row headerOrder = sheetOrders.createRow(0);
		headerOrder.createCell(0).setCellValue("Mã đơn");
		headerOrder.createCell(1).setCellValue("Người nhận");
		headerOrder.createCell(2).setCellValue("Ngày đặt");
		headerOrder.createCell(3).setCellValue("Tổng tiền");
		headerOrder.createCell(4).setCellValue("Trạng thái");

		int rowNumOrder = 1;
		for (Order o : listOrders) {
			Row r = sheetOrders.createRow(rowNumOrder++);

			r.createCell(0).setCellValue(o.getId());

			r.createCell(1).setCellValue(o.getRecipientName());

			r.createCell(2).setCellValue(o.getOrderDate().toString());
			r.createCell(3).setCellValue(o.getTotalPrice());
			r.createCell(4).setCellValue(o.getStatus());
		}

		sheetOrders.autoSizeColumn(0);
		sheetOrders.autoSizeColumn(1);
		sheetOrders.autoSizeColumn(2);
		sheetOrders.autoSizeColumn(3);
		sheetOrders.autoSizeColumn(4);

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=BaoCao_Thang" + month + "_" + year + ".xlsx");

		OutputStream out = response.getOutputStream();
		workbook.write(out);
		workbook.close();
		out.close();
	}
}