package main.java.com.model;

public class CartItem {
    private int cartItemId;
    private Cart cart;
    private Product product;
    private int quantity;

    public CartItem() {}

    public CartItem(int cartItemId, Cart cart, Product product, int quantity) {
        this.cartItemId = cartItemId;
        this.cart = cart;
        this.product = product;
        this.quantity = quantity;
    }

    // Getter/Setter
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

    public Cart getCart() { return cart; }
    public void setCart(Cart cart) { this.cart = cart; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}