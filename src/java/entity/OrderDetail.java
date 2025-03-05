/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author admin
 */
public class OrderDetail {
    private int id;
    private Order order;
    private Review review;
    private Product product;
    private int quantity;
    private double price;
    private double priceChange;
    
    public OrderDetail(){
        
    }
    
    public OrderDetail(int id){
        this.id = id;
    }

    public OrderDetail(Order order, Review review, Product product, int quantity, double price, double priceChange) {
        this.order = order;
        this.review = review;
        this.product = product;
        this.quantity = quantity;
        this.price = price;
        this.priceChange = priceChange;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Review getReview() {
        return review;
    }

    public void setReview(Review review) {
        this.review = review;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getPriceChange() {
        return priceChange;
    }

    public void setPriceChange(double priceChange) {
        this.priceChange = priceChange;
    }
    
    
}
