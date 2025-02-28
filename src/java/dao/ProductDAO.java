/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.util.ArrayList;
import entity.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class ProductDAO extends DBContext {

    public ArrayList<Product> listAllProduct() {
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "select p.pid,p.name,p.image,p.amount,p.price,p.title, p.description, c.cname from Product p\n"
                + "join Category c on c.cid = p.cateID";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("pid"));
                p.setName(rs.getString("name"));
                p.setImage(rs.getString("image"));
                p.setAmount(rs.getInt("amount"));
                p.setPrice(rs.getDouble("price"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                
                Category c = new Category();
                c.setName(rs.getString("cname"));
                p.setCategory(c);
                
                productList.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return productList;
    }
    
      public void addProduct(Product p) {
        String sql = "INSERT INTO [dbo].[Product]\n"
                + "           ([name]\n"
                + "           ,[image]\n"
                + "           ,[price]\n"
                + "           ,[title]\n"
                + "           ,[description]\n"
                + "           ,[cateID])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, p.getName());
            stm.setString(2, p.getImage());
            stm.setDouble(3, p.getPrice());
            stm.setString(4, p.getTitle());
            stm.setString(5, p.getDescription());
            stm.setInt(6, p.getCategory().getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
