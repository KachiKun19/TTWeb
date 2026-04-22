package com.kachikun.shop.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Order {
    private int id;
    private User user;
    private Date orderDate;
    private double totalPrice;
    private String status;

    private String recipientName;
    private String recipientPhone;
    private String shippingAddress;
    private String paymentMethod;

   // theo dõi hàng
    private Timestamp shippedAt;    // thời điểm bắt đầu giao
    private Timestamp deliveredAt;  // thời điểm giao thành công
    private String cancelReason;    // lý do hủy

    public static final String STATUS_PENDING   = "Đang xử lý";
    public static final String STATUS_SHIPPING  = "Đang giao hàng";
    public static final String STATUS_DELIVERED = "Đã giao";
    public static final String STATUS_COMPLETED = "Hoàn thành";
    public static final String STATUS_CANCELLED = "Đã hủy";

    public Order() {}

    public Order(int id, User user, Date orderDate, double totalPrice, String status,
                 String recipientName, String recipientPhone,
                 String shippingAddress, String paymentMethod) {
        this.id = id;
        this.user = user;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.shippingAddress = shippingAddress;
        this.paymentMethod = paymentMethod;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getRecipientName() { return recipientName; }
    public void setRecipientName(String recipientName) { this.recipientName = recipientName; }

    public String getRecipientPhone() { return recipientPhone; }
    public void setRecipientPhone(String recipientPhone) { this.recipientPhone = recipientPhone; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public Timestamp getShippedAt() { return shippedAt; }
    public void setShippedAt(Timestamp shippedAt) { this.shippedAt = shippedAt; }

    public Timestamp getDeliveredAt() { return deliveredAt; }
    public void setDeliveredAt(Timestamp deliveredAt) { this.deliveredAt = deliveredAt; }

    public String getCancelReason() { return cancelReason; }
    public void setCancelReason(String cancelReason) { this.cancelReason = cancelReason; }


    /** Màu badge trạng thái cho Tailwind */
    public String getStatusColor() {
        if (STATUS_PENDING.equals(status))   return "text-yellow-700 bg-yellow-100";
        if (STATUS_SHIPPING.equals(status))  return "text-blue-700   bg-blue-100";
        if (STATUS_DELIVERED.equals(status))   return "text-green-700  bg-green-100";
        if (STATUS_COMPLETED.equals(status)) return "bg-yellow-100 text-yellow-600";
        if (STATUS_CANCELLED.equals(status)) return "text-red-700    bg-red-100";
        return "text-gray-600 bg-gray-100";
    }

    /** Bước hiện tại trong timeline (1–4), dùng trong JSP */
    public int getTimelineStep() {
        if (STATUS_CANCELLED.equals(status)) return -1;
        if (STATUS_PENDING.equals(status))   return 1;
        if (STATUS_SHIPPING.equals(status))  return 2;
        if (STATUS_DELIVERED.equals(status)) return 3;
        if (STATUS_COMPLETED.equals(status)) return 4;
        return 1;
    }

    /** User chỉ được hủy khi đơn đang "Đang xử lý" */
    public boolean isCancellable() {
        return STATUS_PENDING.equals(status);
    }
}