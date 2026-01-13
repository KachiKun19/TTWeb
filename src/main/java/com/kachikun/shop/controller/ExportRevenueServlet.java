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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy tham số tháng/năm
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));

        // 2. Lấy dữ liệu từ DAO
        // a. Lấy danh sách chi tiết từng đơn (để làm Sheet 3)
        List<Order> listOrders = orderDAO.getOrdersByMonthYear(month, year);
        
        // b. Lấy thống kê theo ngày (để làm Sheet 2) - Hàm bạn vừa viết
        List<DailyStat> dailyStats = orderDAO.getDailyStatistics(month, year);

        // 3. Tạo Workbook
        Workbook workbook = new XSSFWorkbook();

        // ==========================================
        // SHEET 1: TỔNG QUAN (Summary)
        // ==========================================
        Sheet sheetSummary = workbook.createSheet("Tổng quan");
        Row rowSum1 = sheetSummary.createRow(0);
        rowSum1.createCell(0).setCellValue("BÁO CÁO THÁNG " + month + "/" + year);
        
        // Tính tổng nhanh
        double totalRev = 0;
        for(DailyStat d : dailyStats) totalRev += d.getRevenue();
        
        Row rowSum2 = sheetSummary.createRow(2);
        rowSum2.createCell(0).setCellValue("Tổng doanh thu:");
        rowSum2.createCell(1).setCellValue(totalRev);
        // (Bạn có thể format cell style tiền tệ ở đây)

        // ==========================================
        // SHEET 2: CHI TIẾT NGÀY (Daily Breakdown)
        // ==========================================
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

        // ==========================================
        // SHEET 3: CHI TIẾT ĐƠN HÀNG (All Orders)
        // ==========================================
        Sheet sheetOrders = workbook.createSheet("Danh sách đơn hàng");
        Row headerOrder = sheetOrders.createRow(0);
        headerOrder.createCell(0).setCellValue("Mã đơn");
        headerOrder.createCell(1).setCellValue("Người nhận"); // Lấy người nhận hàng thì chuẩn hơn User
        headerOrder.createCell(2).setCellValue("Ngày đặt");
        headerOrder.createCell(3).setCellValue("Tổng tiền");
        headerOrder.createCell(4).setCellValue("Trạng thái");

        int rowNumOrder = 1;
        for (Order o : listOrders) {
            Row r = sheetOrders.createRow(rowNumOrder++);
            
            r.createCell(0).setCellValue(o.getId());
            
            // Lấy tên người nhận hàng (RecipientName) thay vì User để chính xác thực tế
            r.createCell(1).setCellValue(o.getRecipientName()); 
            
            r.createCell(2).setCellValue(o.getOrderDate().toString());
            r.createCell(3).setCellValue(o.getTotalPrice());
            r.createCell(4).setCellValue(o.getStatus());
        }
        
        // Auto resize cột cho đẹp
        sheetOrders.autoSizeColumn(0); 
        sheetOrders.autoSizeColumn(1); 
        sheetOrders.autoSizeColumn(2); 
        sheetOrders.autoSizeColumn(3);
        sheetOrders.autoSizeColumn(4);

        // Xuất file
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=BaoCao_Thang" + month + "_" + year + ".xlsx");
        
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        workbook.close();
        out.close();
    }
}