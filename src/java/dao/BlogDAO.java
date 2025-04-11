package dao;

import entity.Blog;
import entity.Comment;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {

    private Connection conn;

    public BlogDAO() {
        DBContext db = new DBContext();
        this.conn = db.getConnection();
    }

    public List<Blog> getAllBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.*, (SELECT COUNT(*) FROM Likes l WHERE l.blogID = b.blogID) AS likeCount FROM Blog b";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Blog blog = new Blog(
                        rs.getInt("blogID"),
                        rs.getString("author"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("imageURL")
                );

                blog.setLikeCount(rs.getInt("likeCount")); // Lấy số like từ database

                // Lấy bình luận cho blog
                List<Comment> comments = getCommentsForBlog(blog.getBlogID());
                blog.setComments(comments);

                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    // Phương thức lấy bình luận cho blog theo blogID
    public List<Comment> getCommentsForBlog(int blogID) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.commentID, c.userID, c.blogID, c.content, u.name AS userName "
                + "FROM Comments c JOIN [User] u ON c.userID = u.uID WHERE c.blogID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Comment comment = new Comment(
                            rs.getInt("commentID"),
                            rs.getInt("userID"),
                            rs.getInt("blogID"),
                            rs.getString("content"),
                            rs.getString("userName")
                    );
                    comment.setUserName(rs.getString("userName"));  // Thiết lập tên người dùng
                    comments.add(comment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

}
