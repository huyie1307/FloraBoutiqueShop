/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderMG {

    private int orderID;
    private int userID;
    private int statusID;
    private BigDecimal totalPrice;
    private Timestamp orderDate;
    private int paymentMethodID;
    private Integer discountCodeID; // Dùng Integer để cho phép null
    private String note;

    public OrderMG() {
        
    }

    public OrderMG(int orderID, int userID, int statusID, BigDecimal totalPrice,
            Timestamp orderDate,int paymentMethodID, Integer discountCodeID, String note) {
        this.orderID = orderID;
        this.userID = userID;
        this.statusID = statusID;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.paymentMethodID = paymentMethodID;
        this.discountCodeID = discountCodeID;
        this.note = note;
    }

    // Getters and Setters
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public int getPaymentMethodID() {
        return paymentMethodID;
    }

    public void setPaymentMethodID(int paymentMethodID) {
        this.paymentMethodID = paymentMethodID;
    }

    public Integer getDiscountCodeID() {
        return discountCodeID;
    }

    public void setDiscountCodeID(Integer discountCodeID) {
        this.discountCodeID = discountCodeID;
    }

    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    public String getStatus() {
        switch (statusID) {
            case 1:
                return "Processing";
            case 2:
                return "Confirmed";
            case 3:
                return "Delivered";
            default:
                return "Unknown";
        }
    }
}
