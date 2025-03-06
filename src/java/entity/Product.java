package entity;

public class Product {

    private int flowerId;
    private String name;
    private String category;
    private int quantity;
    private double price;
    private String imageUrl;
    private String title;
    private String description;

    public Product() {

    }

    public Product(int flowerId, String name, String category, int quantity, double price, String imageUrl) {
        this.flowerId = flowerId;
        this.name = name;
        this.category = category;
        this.quantity = quantity;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    public Product(int flowerId, String name, String category, int quantity, double price, String imageUrl, String title, String description) {
        this.flowerId = flowerId;
        this.name = name;
        this.category = category;
        this.quantity = quantity;
        this.price = price;
        this.imageUrl = imageUrl;
        this.title = title;
        this.description = description;
    }

    public int getFlowerId() {
        return flowerId;
    }

    public void setFlowerId(int flowerId) {
        this.flowerId = flowerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Product{" + "flowerId=" + flowerId + ", name=" + name + ", category=" + category + ", quantity=" + quantity + ", price=" + price + ", imageUrl=" + imageUrl + ", title=" + title + ", description=" + description + '}';
    }

}
