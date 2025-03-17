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

                Category category = new Category();
                category.setName(rs.getString("cname"));
                p.setCategory(category);

                productList.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return productList;
    }

    public boolean addProduct(String name, String image, int amount, double price,
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
                return true;
            } else {
                // Nếu không tìm thấy category, ném ngoại lệ
                throw new SQLException("Category not found: " + categoryName);
            }

        } catch (SQLException ex) {
            // Log lỗi hoặc ném ngoại lệ ra ngoài (hoặc có thể thông báo cho người dùng)
            ex.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(int productId) {
        String deleteSQL = "DELETE FROM [Product] WHERE pid = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(deleteSQL);
            stmt.setInt(1, productId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT p.pid, p.name, p.image, p.amount, p.price, p.title, p.description, c.cname "
                + "FROM Product p "
                + "JOIN Category c ON c.cid = p.cateID "
                + "WHERE p.pid = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setFlowerId(rs.getInt("pid"));
                product.setName(rs.getString("name"));
                product.setImageUrl(rs.getString("image"));
                product.setQuantity(rs.getInt("amount"));
                product.setPrice(rs.getDouble("price"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));

                Category category = new Category();
                category.setName(rs.getString("cname"));
                product.setCategory(category);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return product;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET name = ?, image = ?, amount = ?, price = ?, title = ?, description = ?, cateID = ? "
                + "WHERE pid = ?";
        try {
            // Retrieve the category ID based on the category name
            String getCategorySQL = "SELECT cid FROM Category WHERE cname = ?";
            PreparedStatement stmtCategory = connection.prepareStatement(getCategorySQL);
            ResultSet result = stmtCategory.executeQuery();

            Category category = new Category();
            category.setId(result.getInt("cid"));

            stmtCategory.setInt(1, category.getId());
            ResultSet rsCategory = stmtCategory.executeQuery();
            int cateID = 0;
            if (rsCategory.next()) {
                cateID = rsCategory.getInt("cid");
            } else {
                throw new SQLException("Category not found: " + product.getCategory());
            }

            // Update the product
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, product.getName());
            stm.setString(2, product.getImageUrl());
            stm.setInt(3, product.getQuantity());
            stm.setDouble(4, product.getPrice());
            stm.setString(5, product.getTitle());
            stm.setString(6, product.getDescription());
            stm.setInt(7, cateID);
            stm.setInt(8, product.getFlowerId());

            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

}
