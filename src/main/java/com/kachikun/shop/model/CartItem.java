// class mới 10/12
package com.kachikun.shop.model;

public class CartItem {
    private Product product; // Thông tin sản phẩm (Tên, giá, ảnh...)
    private int quantity;    // Số lượng khách mua

    public CartItem() {
    }

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    // Tính tổng tiền của món này (Giá * Số lượng)
    public double getTotalPrice() {
        return product.getPrice() * quantity;
    }
}