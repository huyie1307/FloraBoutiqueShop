package entity;

public class Review {

    private int id;
    private int rating;
    private String content;
    private User user;
    private Product product;

    public Review() {
    }

    public Review(int id, int rating, String content, User user, Product product) {
        this.id = id;
        this.rating = rating;
        this.content = content;
        this.user = user;
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    @Override
    public String toString() {
        return "Review{" + "id=" + id + ", rating=" + rating + ", content=" + content + ", user=" + user + ", product=" + product + '}';
    }

}
