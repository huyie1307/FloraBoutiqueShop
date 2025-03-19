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
import java.util.ArrayList;

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
            stmt.setInt(3, review.getUser().getuID());
            stmt.setInt(4, review.getProduct().getFlowerId());

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
     public ArrayList<Review> getALlReviews() throws SQLException {
        ArrayList<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.id AS ReviewID, p.name AS ProductName,p.image, u.name AS CustomerName, r.rating, r.content "
                + "FROM Review r "
                + "JOIN Product p ON r.productID = p.pid "
                + "JOIN [User] u ON r.userID = u.uID "
                + "ORDER BY r.id DESC";

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                User user = new User(); // Tạo đối tượng User
                user.setName(rs.getString("CustomerName"));

                Product product = new Product(); // Tạo đối tượng Product
                product.setName(rs.getString("ProductName"));
                product.setImageUrl(rs.getString("image"));

                Review review = new Review();
                review.setId(rs.getInt("ReviewID"));
                review.setRating(rs.getInt("rating"));
                review.setContent(rs.getString("content"));
                review.setUser(user);
                review.setProduct(product);

                reviews.add(review);
            }
        }
        return reviews;
    }

    public Review getReviewById(int reviewId) throws SQLException {
        String sql = "SELECT r.id AS ReviewID, p.name AS ProductName,p.image as ProductImage, u.name AS CustomerName, r.rating, r.content "
                + "FROM Review r "
                + "JOIN Product p ON r.productID = p.pid "
                + "JOIN [User] u ON r.userID = u.uID "
                + "WHERE r.id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, reviewId);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setName(rs.getString("CustomerName"));

                    Product product = new Product();
                    product.setName(rs.getString("ProductName"));
                    product.setImageUrl(rs.getString("ProductImage"));

                    Review review = new Review();
                    review.setId(rs.getInt("ReviewID"));
                    review.setRating(rs.getInt("rating"));
                    review.setContent(rs.getString("content"));
                    review.setUser(user);
                    review.setProduct(product);

                    return review;
                }
            }
        }
        return null; // Nếu không tìm thấy review, trả về null
    }

}