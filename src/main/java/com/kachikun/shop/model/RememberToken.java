package com.kachikun.shop.model;

import java.sql.Timestamp;

public class RememberToken {
    private int userId;
    private String token;
    private Timestamp expiry;

    public RememberToken() {
    }

    public RememberToken(int userId, String token, Timestamp expiry) {
        this.userId = userId;
        this.token = token;
        this.expiry = expiry;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Timestamp getExpiry() {
        return expiry;
    }

    public void setExpiry(Timestamp expiry) {
        this.expiry = expiry;
    }
}