package entity;

import java.util.Date;

public class User {

    private int uID;
    private String username;
    private String password;
    private boolean isSeller;
    private boolean isAdmin;
    private String name;
    private Date dob;
    private String phone;
    private String address;

    public User() {
    }

    public User(int uID, String username, String password, boolean isSeller, boolean isAdmin, String name, Date dob, String phone, String address) {
        this.uID = uID;
        this.username = username;
        this.password = password;
        this.isSeller = isSeller;
        this.isAdmin = isAdmin;
        this.name = name;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
    }

    public int getuID() {
        return uID;
    }

    public void setuID(int uID) {
        this.uID = uID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isIsSeller() {
        return isSeller;
    }

    public void setIsSeller(boolean isSeller) {
        this.isSeller = isSeller;
    }

    public boolean isIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
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

    @Override
    public String toString() {
        return "User{" + "uID=" + uID + ", username=" + username + ", password=" + password + ", isSeller=" + isSeller + ", isAdmin=" + isAdmin + ", name=" + name + ", dob=" + dob + ", phone=" + phone + ", address=" + address + '}';
    }

}
