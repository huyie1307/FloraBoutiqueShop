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
        String sql = "SELECT p.pid, p.name, p.image, p.price, p.title, p.description, c.cname, p.isDelete "
                + "FROM Product p JOIN Category c ON c.cid = p.cateID "
                + "ORDER BY p.pid DESC"; // sản phẩm mới thêm sẽ có pid lớn hơn, nên DESC để hiện đầu

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setFlowerId(rs.getInt("pid"));
                p.setName(rs.getString("name"));
                p.setImageUrl(rs.getString("image"));
                p.setPrice(rs.getDouble("price"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setIsDelete(rs.getBoolean("isDelete"));

                Category c = new Category();
                c.setName(rs.getString("cname"));
                p.setCategory(c);

                productList.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public ArrayList<Product> getVisibleProduct() {
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT p.pid, p.name, p.image, p.price, p.title, p.description, c.cname, p.isDelete "
                + "FROM Product p JOIN Category c ON c.cid = p.cateID "
                + "WHERE p.isDelete = 0";;
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setFlowerId(rs.getInt("pid"));
                p.setName(rs.getString("name"));
                p.setImageUrl(rs.getString("image"));
                p.setPrice(rs.getDouble("price"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setIsDelete(rs.getBoolean("isDelete"));

                Category c = new Category();
                c.setName(rs.getString("cname"));
                p.setCategory(c);

                productList.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public boolean addProduct(Product product, int cateID) {
        String sql = "INSERT INTO [dbo].[Product] "
                + "([name], [image], [price], [title], [description], [cateID], [isDelete]) "
                + "VALUES (?, ?, ?, ?, ?, ?, 0)"; // isDelete mặc định là 0

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, product.getName());            // name
            stmt.setString(2, product.getImageUrl());        // image
            stmt.setDouble(3, product.getPrice());           // price
            stmt.setString(4, product.getTitle());           // title
            stmt.setString(5, product.getDescription());     // description
            stmt.setInt(6, cateID);                          // cateID

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Lỗi khi thêm sản phẩm", ex);
            return false;
        }
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET name = ?,"
                + " image = ?, price = ?, "
                + "title = ?, description = ?, cateID = ? "
                + "WHERE pid = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getImageUrl());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getTitle());
            stmt.setString(5, product.getDescription());
            stmt.setInt(6, product.getCategory().getId());
            stmt.setInt(7, product.getFlowerId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;  // Trả về true nếu có ít nhất một bản ghi được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // Trả về false nếu có lỗi xảy ra
    }

    // Lấy thông tin sản phẩm theo ID
    public Product getProductById(int id) {
        String sql = "SELECT p.pid, p.name, p.image, p.price, p.title, p.description, c.cname "
                + "FROM Product p "
                + "JOIN Category c ON c.cid = p.cateID "
                + "WHERE p.pid = ? and p.isDelete = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setFlowerId(rs.getInt("pid"));
                product.setName(rs.getString("name"));
                product.setImageUrl(rs.getString("image"));
                product.setPrice(rs.getDouble("price"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));

                Category category = new Category();
                category.setName(rs.getString("cname"));
                product.setCategory(category);

                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateProductStatus(boolean status, int pid) {
        String sql = "UPDATE Product SET isDelete = ? WHERE pid = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBoolean(1, status); // boolean → bit trong SQL Server
            st.setInt(2, pid);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
