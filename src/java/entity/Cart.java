package entity;

import java.util.Date;

public class Cart {

    private int id;
    private User user;
    private Product product;
    private Category category;
    private int amount;
    private int total;
    private Date create_at;

    public Cart() {
    }

    public Cart(int id, User user, Product product, Category category, int amount, int total, Date create_at) {
        this.id = id;
        this.user = user;
        this.product = product;
        this.category = category;
        this.amount = amount;
        this.total = total;
        this.create_at = create_at;
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

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public Date getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Date create_at) {
        this.create_at = create_at;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", user=" + user + ", product=" + product + ", category=" + category + ", amount=" + amount + ", total=" + total + ", create_at=" + create_at + '}';
    }

}
