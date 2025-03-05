/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author admin
 */
import dal.DBContext;
import java.sql.*;
import entity.*;

public class ReviewDAO extends DBContext {

    private Connection conn;

    public ReviewDAO() {
        this.conn = super.connection;
    }

    public int insertReview(Review review) {
        String sql = "INSERT INTO Review (rating, content, accountID, productID) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getContent());
            stmt.setInt(3, review.getAccount().getId());
            stmt.setInt(4, review.getProduct().getId());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

}