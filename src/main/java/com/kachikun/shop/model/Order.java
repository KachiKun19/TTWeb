package com.kachikun.shop.model;

import java.sql.Date;

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

    public Order() {
    }

    public Order(int id, User user, Date orderDate, double totalPrice, String status, 
                 String recipientName, String recipientPhone, String shippingAddress, String paymentMethod) {
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
    
    public String getStatusColor() {
        if ("Đang xử lý".equals(status)) return "text-yellow-600 bg-yellow-100";
        if ("Đang giao hàng".equals(status)) return "text-blue-600 bg-blue-100";
        if ("Đã giao".equals(status) || "Hoàn thành".equals(status)) return "text-green-600 bg-green-100";
        if ("Đã hủy".equals(status)) return "text-red-600 bg-red-100";
        return "text-gray-600 bg-gray-100";
    }
}