package entity;

import java.util.Date;

public class User {

    private int id;
    private String contactName;
    private String username;
    private String phone;
    private String address;
    private String role;
    private Date createdAt;

    public User() {
    }

    public User(int id, String contactName, String username, String phone, String address, String role, Date createdAt) {
        this.id = id;
        this.contactName = contactName;
        this.username = username;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.createdAt = createdAt;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", contactName='" + contactName + "', username='" + username
                + "', phone='" + phone + "', address='" + address + "', role='" + role + "', createdAt=" + createdAt + "}";
    }
}