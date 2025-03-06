package entity;

import java.util.Date;

public class Order {

    private String id;
    private User user;
    private Status status;
    private double total;
    private Date orderDate;
    private Date completeDate;
    private PaymentMethod method;

    public Order() {
    }

    public Order(String id, User user, Status status, double total, Date orderDate, Date completeDate, PaymentMethod method) {
        this.id = id;
        this.user = user;
        this.status = status;
        this.total = total;
        this.orderDate = orderDate;
        this.completeDate = completeDate;
        this.method = method;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

    public PaymentMethod getMethod() {
        return method;
    }

    public void setMethod(PaymentMethod method) {
        this.method = method;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", user=" + user + ", status=" + status + ", total=" + total + ", orderDate=" + orderDate + ", completeDate=" + completeDate + ", method=" + method + '}';
    }

}
