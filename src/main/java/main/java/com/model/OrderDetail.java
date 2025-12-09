package main.java.com.model;
public class OrderDetail {
    private int id;
    
    private Order order;     
    private Product product;

    private double price;    
    private int quantity;   

    public OrderDetail() {
    }

    public OrderDetail(int id, Order order, Product product, double price, int quantity) {
        this.id = id;
        this.order = order;
        this.product = product;
        this.price = price;
        this.quantity = quantity;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    //tinh tien
    public double getTotalMoney() {
        return this.price * this.quantity;
    }
}