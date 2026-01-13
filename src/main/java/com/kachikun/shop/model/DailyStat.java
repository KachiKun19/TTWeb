package com.kachikun.shop.model;

public class DailyStat {
    private int day;
    private int orderCount;
    private double revenue;

    public DailyStat(int day, int orderCount, double revenue) {
        this.day = day;
        this.orderCount = orderCount;
        this.revenue = revenue;
    }

    public int getDay() { return day; }
    public void setDay(int day) { this.day = day; }
    public int getOrderCount() { return orderCount; }
    public void setOrderCount(int orderCount) { this.orderCount = orderCount; }
    public double getRevenue() { return revenue; }
    public void setRevenue(double revenue) { this.revenue = revenue; }
}