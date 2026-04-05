package com.kachikun.shop.dao;

import com.kachikun.shop.model.CartItem;
import com.kachikun.shop.model.DailyStat;
import com.kachikun.shop.model.Order;
import com.kachikun.shop.model.OrderDetail;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.model.User;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO extends BaseDAO {

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setStatus(rs.getString("status"));
        order.setOrderDate(rs.getDate("order_date"));
        order.setRecipientName(rs.getString("recipient_name"));
        order.setRecipientPhone(rs.getString("recipient_phone"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setPaymentMethod(rs.getString("payment_method"));


        try {
            order.setShippedAt(rs.getTimestamp("shipped_at"));
        } catch (SQLException ignored) {
        }
        try {
            order.setDeliveredAt(rs.getTimestamp("delivered_at"));
        } catch (SQLException ignored) {
        }
        try {
            order.setCancelReason(rs.getString("cancel_reason"));
        } catch (SQLException ignored) {
        }

        User user = new User();
        user.setId(rs.getInt("user_id"));
        order.setUser(user);

        return order;
    }

    /**
     * Lấy trạng thái hiện tại của đơn hàng theo ID.
     */
    private String getOrderStatus(int orderId) {
        String sql = "SELECT status FROM Orders WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("status");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private boolean isValidStatusTransition(String currentStatus, String nextStatus) {
        switch (currentStatus) {
            case "Đang xử lý":
                return "Đang giao hàng".equals(nextStatus) || "Đã hủy".equals(nextStatus);
            case "Đang giao hàng":
                return "Đã giao".equals(nextStatus);
            case "Đã giao":
                return "Hoàn thành".equals(nextStatus);
            default:
                return false;
        }
    }

    /**
     * Lấy danh sách [productId, quantity] của tất cả sản phẩm trong đơn
     */
    private List<int[]> getOrderItemQuantities(Connection conn, int orderId) throws SQLException {
        String sql = "SELECT product_id, quantity FROM OrderDetails WHERE order_id = ?";
        List<int[]> items = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(new int[]{rs.getInt("product_id"), rs.getInt("quantity")});
                }
            }
        }
        return items;
    }

    /**
     * Hoàn trả tồn kho cho danh sách sản phẩm (batch update).
     */
    private void restoreStock(Connection conn, List<int[]> items) throws SQLException {
        String sql = "UPDATE Products SET stock_quantity = stock_quantity + ? WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int[] item : items) {
                ps.setInt(1, item[1]); // quantity
                ps.setInt(2, item[0]); // productId
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }


    public boolean createOrder(User user, List<CartItem> cart, double totalPrice,
                               String recipientName, String recipientPhone,
                               String shippingAddress, String paymentMethod) {

        String insertOrderSql =
                "INSERT INTO Orders (user_id, total_price, status, order_date, "
                        + "  recipient_name, recipient_phone, shipping_address, payment_method) "
                        + "VALUES (?, ?, N'Đang xử lý', GETDATE(), ?, ?, ?, ?)";

        String insertDetailSql =
                "INSERT INTO OrderDetails (order_id, product_id, price, quantity) "
                        + "VALUES (?, ?, ?, ?)";

        String deductStockSql =
                "UPDATE Products SET stock_quantity = stock_quantity - ? WHERE id = ?";

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            int orderId = -1;
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, user.getId());
                ps.setDouble(2, totalPrice);
                ps.setString(3, recipientName);
                ps.setString(4, recipientPhone);
                ps.setString(5, shippingAddress);
                ps.setString(6, paymentMethod);
                ps.executeUpdate();

                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    }
                }
            }

            if (orderId == -1) {
                conn.rollback();
                return false;
            }

            try (PreparedStatement psDetail = conn.prepareStatement(insertDetailSql);
                 PreparedStatement psStock = conn.prepareStatement(deductStockSql)) {

                for (CartItem item : cart) {
                    int productId = item.getProduct().getId();

                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, productId);
                    psDetail.setDouble(3, item.getProduct().getPrice());
                    psDetail.setInt(4, item.getQuantity());
                    psDetail.addBatch();

                    psStock.setInt(1, item.getQuantity());
                    psStock.setInt(2, productId);
                    psStock.addBatch();
                }

                psDetail.executeBatch();
                psStock.executeBatch();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            if (conn != null) try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;

        } finally {
            if (conn != null) try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public boolean adminUpdateStatus(int orderId, String newStatus) {
        String currentStatus = getOrderStatus(orderId);
        if (currentStatus == null) return false;
        if (!isValidStatusTransition(currentStatus, newStatus)) return false;

        StringBuilder sql = new StringBuilder("UPDATE Orders SET status = ?");
        if (Order.STATUS_SHIPPING.equals(newStatus)) {
            sql.append(", shipped_at = GETDATE()");
        } else if (Order.STATUS_DELIVERED.equals(newStatus) || Order.STATUS_COMPLETED.equals(newStatus)) {
            sql.append(", delivered_at = GETDATE()");
        }
        sql.append(" WHERE id = ?");

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            boolean ok = ps.executeUpdate() > 0;
            if (ok && Order.STATUS_COMPLETED.equals(newStatus)) {
                updateSoldCount(orderId);
            }
            return ok;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Alias giữ tương thích với code cũ đang gọi updateStatus()
    public boolean updateStatus(int orderId, String status) {
        return adminUpdateStatus(orderId, status);
    }


    public boolean userCancelOrder(int orderId, int userId) {
        return userCancelOrder(orderId, userId, null);
    }

    public boolean userCancelOrder(int orderId, int userId, String reason) {
        String updateSql =
                "UPDATE Orders SET status = N'Đã hủy', cancel_reason = ? "
                        + "WHERE id = ? AND user_id = ? AND status = N'Đang xử lý'";

        return cancelOrderAndRestoreStock(
                orderId, updateSql,
                ps -> {
                    ps.setString(1, reason != null ? reason : "Khách hủy đơn");
                    ps.setInt(2, orderId);
                    ps.setInt(3, userId);
                }
        );
    }


    public boolean adminCancelOrder(int orderId, String reason) {
        String updateSql =
                "UPDATE Orders SET status = N'Đã hủy', cancel_reason = ? "
                        + "WHERE id = ? AND status NOT IN (N'Đã giao', N'Hoàn thành', N'Đã hủy')";

        return cancelOrderAndRestoreStock(
                orderId, updateSql,
                ps -> {
                    ps.setString(1, reason != null ? reason : "Admin hủy đơn");
                    ps.setInt(2, orderId);
                }
        );
    }


    private boolean cancelOrderAndRestoreStock(int orderId, String updateSql, ParamSetter paramSetter) {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // Bước 1: Cập nhật trạng thái
            try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                paramSetter.set(ps);
                if (ps.executeUpdate() == 0) {
                    conn.rollback();
                    return false; // WHERE không khớp → trạng thái không cho phép hủy
                }
            }

            // Bước 2: Lấy sản phẩm cần hoàn kho
            List<int[]> items = getOrderItemQuantities(conn, orderId);

            // Bước 3: Hoàn trả tồn kho
            restoreStock(conn, items);

            conn.commit();
            return true;

        } catch (Exception e) {
            if (conn != null) try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;

        } finally {
            if (conn != null) try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @FunctionalInterface
    private interface ParamSetter {
        void set(PreparedStatement ps) throws SQLException;
    }

    /**
     * Lấy tất cả đơn hàng
     */
    public List<Order> getAllOrders() {
        String sql = "SELECT * FROM Orders ORDER BY order_date DESC";
        List<Order> orderList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) orderList.add(mapOrder(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }

    /**
     * Tìm đơn hàng theo ID.
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy tất cả đơn hàng của một người dùng, mới nhất trước.
     */
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY id DESC";
        List<Order> orderList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) orderList.add(mapOrder(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }

    /**
     * Lấy chi tiết sản phẩm bên trong một đơn hàng.
     */
    public List<OrderDetail> getOrderDetail(int orderId) {
        String sql = "SELECT d.*, p.name, p.image "
                + "FROM OrderDetails d "
                + "INNER JOIN Products p ON d.product_id = p.id "
                + "WHERE d.order_id = ?";

        List<OrderDetail> detailList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setImage(rs.getString("image"));

                    OrderDetail detail = new OrderDetail();
                    detail.setId(rs.getInt("id"));
                    detail.setPrice(rs.getDouble("price"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setProduct(product);

                    detailList.add(detail);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return detailList;
    }

    /**
     * Lấy đơn hàng theo tháng/năm — dùng cho xuất báo cáo Excel.
     */
    public List<Order> getOrdersByMonthYear(int month, int year) {
        String sql = "SELECT * FROM Orders "
                + "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ? "
                + "ORDER BY order_date DESC";

        List<Order> orderList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) orderList.add(mapOrder(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }

    /**
     * Doanh thu theo từng tháng trong 12 tháng gần nhất.
     */
    public Map<String, Double> getRevenueLast12Months() {
        String sql = "SELECT FORMAT(order_date, 'MM/yyyy') AS month_year, SUM(total_price) AS total "
                + "FROM Orders "
                + "WHERE status IN (N'Đã giao', N'Hoàn thành') "
                + "GROUP BY FORMAT(order_date, 'MM/yyyy'), YEAR(order_date), MONTH(order_date) "
                + "ORDER BY YEAR(order_date) DESC, MONTH(order_date) DESC";

        Map<String, Double> revenueMap = new LinkedHashMap<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                revenueMap.put(rs.getString("month_year"), rs.getDouble("total"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenueMap;
    }

    /**
     * Đếm số đơn hoàn thành trong ngày hôm nay.
     */
    public int getTodayOrdersCount() {
        String sql = "SELECT COUNT(*) FROM Orders "
                + "WHERE CAST(order_date AS DATE) = ? "
                + "AND status IN (N'Đã giao', N'Hoàn thành')";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(LocalDate.now()));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Tổng doanh thu từ đơn hoàn thành trong ngày hôm nay.
     */
    public double getTodayRevenue() {
        String sql = "SELECT SUM(total_price) FROM Orders "
                + "WHERE CAST(order_date AS DATE) = ? "
                + "AND status IN (N'Đã giao', N'Hoàn thành')";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(LocalDate.now()));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Thống kê doanh thu theo từng ngày trong một tháng.
     */
    public List<DailyStat> getDailyStatistics(int month, int year) {
        String sql = "SELECT DAY(order_date) AS day, COUNT(id) AS count, SUM(total_price) AS total "
                + "FROM Orders "
                + "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ? "
                + "AND status IN (N'Đã giao', N'Hoàn thành') "
                + "GROUP BY DAY(order_date) "
                + "ORDER BY day ASC";

        List<DailyStat> statList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    statList.add(new DailyStat(
                            rs.getInt("day"),
                            rs.getInt("count"),
                            rs.getDouble("total")
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return statList;
    }

    /**
     * Đếm số đơn hoàn thành của tháng trước.
     */
    public int getLastMonthOrdersCount() {
        String sql = "SELECT COUNT(*) FROM Orders "
                + "WHERE MONTH(order_date) = MONTH(DATEADD(month, -1, GETDATE())) "
                + "AND YEAR(order_date)  = YEAR(DATEADD(month, -1, GETDATE())) "
                + "AND status IN (N'Đã giao', N'Hoàn thành')";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Doanh thu theo tháng trong N tháng gần nhất.
     */
    public Map<String, Double> getMonthlyRevenue(int numberOfMonths) {
        String sql = "SELECT FORMAT(order_date, 'yyyy-MM') AS month, SUM(total_price) AS revenue "
                + "FROM Orders "
                + "WHERE status IN (N'Đã giao', N'Hoàn thành') "
                + "AND order_date >= DATEADD(month, -?, GETDATE()) "
                + "GROUP BY FORMAT(order_date, 'yyyy-MM') "
                + "ORDER BY month DESC";

        Map<String, Double> revenueMap = new LinkedHashMap<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, numberOfMonths);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    revenueMap.put(rs.getString("month"), rs.getDouble("revenue"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenueMap;
    }

    // cập nhật số lg sp bán
    private void updateSoldCount(int orderId) {
        String sql = "UPDATE Products SET sold_count = sold_count + od.quantity "
                + "FROM Products p "
                + "INNER JOIN OrderDetails od ON od.product_id = p.id "
                + "WHERE od.order_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}