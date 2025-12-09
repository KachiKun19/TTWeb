package com.kachikun.shop.model;

import java.sql.Date;

public class Order {
	private int id;
	private User user;
	private Date orderDate;
	private double totalPrice;
	private String status; 

	public Order() {
	}

	public Order(int id, User user, Date orderDate, double totalPrice, String status) {
		this.id = id;
		this.user = user;
		this.orderDate = orderDate;
		this.totalPrice = totalPrice;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
