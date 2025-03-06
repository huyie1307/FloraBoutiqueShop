/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dao.OrderDAO;
import entity.Product;
import java.util.List;

/**
 *
 * @author Admin
 */
public class Main {

    public static void main(String[] args) {
        DBContext db = new DBContext();
        if (db.getConnection() != null) {
            System.out.println("Database connection is active.");
        } else {
            System.out.println("Database connection failed.");
        }
        OrderDAO dao = new OrderDAO();
        List<Product> products = dao.getAllProducts();
        System.out.println("🔍 Số lượng sản phẩm lấy được: " + products.size());
    }
}
