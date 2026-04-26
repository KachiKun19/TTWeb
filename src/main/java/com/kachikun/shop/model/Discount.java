package com.kachikun.shop.model;

import java.sql.Date;

public class Discount {
    private int id;
    private String code;
    private String discountType;
    private double discountValue;
    private double minOrderValue;
    private Integer maxUses;
    private int usedCount;
    private boolean active;
    private Date expiresAt;

    public Discount() {
    }

    public double calculateDiscount(double orderTotal) {
        if (orderTotal < minOrderValue) return 0;
        if ("PERCENT".equals(discountType)) {
            return Math.min(orderTotal * discountValue / 100.0, orderTotal);
        }
        return Math.min(discountValue, orderTotal);
    }

    public boolean isValid() {
        if (!active) return false;
        if (maxUses != null && usedCount >= maxUses) return false;
        if (expiresAt != null && expiresAt.before(new Date(System.currentTimeMillis()))) return false;
        return true;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public double getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public Integer getMaxUses() {
        return maxUses;
    }

    public void setMaxUses(Integer maxUses) {
        this.maxUses = maxUses;
    }

    public int getUsedCount() {
        return usedCount;
    }

    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Date getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Date expiresAt) {
        this.expiresAt = expiresAt;
    }
}