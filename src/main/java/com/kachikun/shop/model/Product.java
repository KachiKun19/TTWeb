package com.kachikun.shop.model;

public class Product {
	private int id;
	private String name;
	private String description;
	private double price;
	private String image; // Đường dẫn ảnh sản phẩm
	private int stock; // hết hàng

	// Quan hệ: Một sản phẩm thuộc về 1 Brand và 1 Category
	private Brand brand;
	private Category category;
	private String connectionType;
    private String material;
	public String getConnectionType() {
		return connectionType;
	}

	public void setConnectionType(String connectionType) {
		this.connectionType = connectionType;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	private String size;

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	// Constructor không tham số
	public Product() {
	}

	// Constructor đầy đủ
	public Product(int id, String name, String description, double price, String image,int stock, Brand brand,
			Category category) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.image = image;
		this.stock = stock;
		this.brand = brand;
		this.category = category;
		
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "Product: " + id + ", " + name + ", " + price ;
	}
}
