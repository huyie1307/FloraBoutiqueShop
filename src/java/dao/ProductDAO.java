/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.util.ArrayList;
import entity.*;
import java.sql.*;
import java.util.List;
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
                p.setFlowerId(rs.getInt("pid"));
                p.setName(rs.getString("name"));
                p.setImageUrl(rs.getString("image"));
                p.setQuantity(rs.getInt("amount"));
                p.setPrice(rs.getDouble("price"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("cname"));

                productList.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return productList;
    }

    public void addProduct(String name, String image, int amount, double price,
            String title, String description, String categoryName) {
        String insertProductSQL = "INSERT INTO [dbo].[Product] "
                + "([name], [image], [amount], [price], [title], [description], [cateID], [sell_ID]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, 1)";

        String getCategorySQL = "SELECT cid FROM [dbo].[Category] WHERE cname = ?";

        try {
            // Lấy cateID dựa trên tên danh mục
            PreparedStatement stmtCategory = connection.prepareStatement(getCategorySQL);
            stmtCategory.setString(1, categoryName);
            ResultSet rsCategory = stmtCategory.executeQuery();

            if (rsCategory.next()) {
                int cateID = rsCategory.getInt("cid");

                // Thêm sản phẩm vào bảng Product
                PreparedStatement stmtProduct = connection.prepareStatement(insertProductSQL);
                stmtProduct.setString(1, name);
                stmtProduct.setString(2, image);
                stmtProduct.setInt(3, amount);
                stmtProduct.setDouble(4, price);
                stmtProduct.setString(5, title);
                stmtProduct.setString(6, description);
                stmtProduct.setInt(7, cateID);

                // Thực thi câu lệnh INSERT
                stmtProduct.executeUpdate();
            } else {
                // Nếu không tìm thấy category, ném ngoại lệ
                throw new SQLException("Category not found: " + categoryName);
            }

        } catch (SQLException ex) {
            // Log lỗi hoặc ném ngoại lệ ra ngoài (hoặc có thể thông báo cho người dùng)
            ex.printStackTrace();
            throw new RuntimeException("Error adding product: " + ex.getMessage());
        }
    }
}
