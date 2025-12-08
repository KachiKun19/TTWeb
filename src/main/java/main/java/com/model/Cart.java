
package main.java.com.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private int cartId;
	private User user;
	private List<CartItem> items;

	public Cart() {
		this.items = new ArrayList<>();
	}

	public Cart(int cartId, User user) {
		this.cartId = cartId;
		this.user = user;
		this.items = new ArrayList<>();
	}

	// Getter/Setter
	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}

	// Phương thức hỗ trợ
	public void addItem(CartItem item) {
		// Kiểm tra nếu sản phẩm đã có trong giỏ thì tăng số lượng
		for (CartItem cartItem : items) {
			if (cartItem.getProduct().getProductId() == item.getProduct().getProductId()) {
				cartItem.setQuantity(cartItem.getQuantity() + item.getQuantity());
				return;
			}
		}
		this.items.add(item);
	}

	public void removeItem(CartItem item) {
		this.items.remove(item);
	}

	public void removeItemById(int productId) {
		items.removeIf(item -> item.getProduct().getProductId() == productId);
	}

	public void updateQuantity(int productId, int quantity) {
		for (CartItem item : items) {
			if (item.getProduct().getProductId() == productId) {
				if (quantity <= 0) {
					items.remove(item);
				} else {
					item.setQuantity(quantity);
				}
				break;
			}
		}
	}

	public double getTotalPrice() {
		return items.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
	}

	public int getTotalItems() {
		return items.stream().mapToInt(CartItem::getQuantity).sum();
	}

	public void clearCart() {
		items.clear();
	}

	public boolean isEmpty() {
		return items.isEmpty();
	}
}