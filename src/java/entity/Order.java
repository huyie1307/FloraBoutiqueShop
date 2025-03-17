package entity;

import java.time.LocalDateTime;
import java.util.Date;

public class Order {

    private String id;
    private User user;
    private Status status;
    private String currentName;
    private String currentPhone;
    private String currentAddress;
    private double total;
    private Date orderDate;
    private LocalDateTime completeDate;
    private PaymentMethod method;
    private String note;

    public Order() {
    }

    public Order(String id, User user, Status status, String currentName, String currentPhone, String currentAddress, double total, Date orderDate, LocalDateTime completeDate, PaymentMethod method, String note) {
        this.id = id;
        this.user = user;
        this.status = status;
        this.currentName = currentName;
        this.currentPhone = currentPhone;
        this.currentAddress = currentAddress;
        this.total = total;
        this.orderDate = orderDate;
        this.completeDate = completeDate;
        this.method = method;
        this.note = note;
    }

    public Order(User user, Status status, String currentName, String currentPhone, String currentAddress, double total, Date orderDate, LocalDateTime completeDate, PaymentMethod method, String note) {
        this.user = user;
        this.status = status;
        this.currentName = currentName;
        this.currentPhone = currentPhone;
        this.currentAddress = currentAddress;
        this.total = total;
        this.orderDate = orderDate;
        this.completeDate = completeDate;
        this.method = method;
        this.note = note;
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

    public String getCurrentName() {
        return currentName;
    }

    public void setCurrentName(String currentName) {
        this.currentName = currentName;
    }

    public String getCurrentPhone() {
        return currentPhone;
    }

    public void setCurrentPhone(String currentPhone) {
        this.currentPhone = currentPhone;
    }

    public String getCurrentAddress() {
        return currentAddress;
    }

    public void setCurrentAddress(String currentAddress) {
        this.currentAddress = currentAddress;
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

    public LocalDateTime getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(LocalDateTime completeDate) {
        this.completeDate = completeDate;
    }

    public PaymentMethod getMethod() {
        return method;
    }

    public void setMethod(PaymentMethod method) {
        this.method = method;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", user=" + user + ", status=" + status + ", currentName=" + currentName + ", currentPhone=" + currentPhone + ", currentAddress=" + currentAddress + ", total=" + total + ", orderDate=" + orderDate + ", completeDate=" + completeDate + ", method=" + method + ", note=" + note + '}';
    }

}
