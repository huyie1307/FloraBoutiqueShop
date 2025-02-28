/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import entity.Category;
import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class CategoryDAO extends DBContext {
    
    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        String sql = "SELECT cid, cname FROM Category"; // Câu truy vấn lấy danh sách danh mục
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()){
                Category category = new Category();
                category.setId(rs.getInt("cid")); // Lấy giá trị cid từ cột
                category.setName(rs.getString("cname")); // Lấy giá trị cname từ cột
                categories.add(category); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;
    }
      public Category getCategoryByName(String categoryName) {
        String sql = "SELECT cid, cname, url FROM Category WHERE cname = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, categoryName);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Tạo đối tượng Category với đầy đủ dữ liệu
                Category category = new Category();
                category.setId(rs.getInt("cid"));
                category.setName(rs.getString("cname"));
                category.setUrl(rs.getString("url")); // Lấy URL của danh mục
                return category;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, "Lỗi khi truy vấn danh mục theo tên", ex);
        }
        return null; // Trả về null nếu không tìm thấy danh mục
    }
}
