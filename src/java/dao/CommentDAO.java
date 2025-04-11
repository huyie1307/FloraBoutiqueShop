package dao;

import entity.Comment;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private Connection conn;

    public CommentDAO() {
        DBContext db = new DBContext();
        this.conn = db.getConnection();
    }

    public void addComment(Comment comment) {
        String sql = "INSERT INTO Comments (blogID, userID, content) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, comment.getBlogID());
            stmt.setInt(2, comment.getUserID());
            stmt.setString(3, comment.getContent());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Comment> getCommentsByBlogID(int blogID) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM Comments WHERE blogID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment(
                        rs.getInt("commentID"),
                        rs.getInt("userID"),
                        rs.getInt("blogID"),
                        rs.getString("content"),
                        rs.getString("userName")
                );
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
}
