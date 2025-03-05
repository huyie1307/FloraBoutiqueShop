/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author admin
 */
import java.time.LocalDate;

/**
 *
 * @author daoducdanh
 */
public class DiscountCode {
    private int id;
    private String code;
    private int discountPercentage;
    private LocalDate expirDate;
    private int amount;
    private boolean isActive;
    
    public DiscountCode(){
        
    }
    public DiscountCode(int id){
        this.id = id;
    }

    public DiscountCode(String code, int discountPercentage, LocalDate expirDate, int amount, boolean isActive) {
        this.code = code;
        this.discountPercentage = discountPercentage;
        this.expirDate = expirDate;
        this.amount = amount;
        this.isActive = isActive;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(int discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public LocalDate getExpirDate() {
        return expirDate;
    }

    public void setExpirDate(LocalDate expirDate) {
        this.expirDate = expirDate;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
    
}
