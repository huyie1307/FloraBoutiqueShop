package dao;

import dal.DBContext;
import java.sql.*;

public class LikeDAO {

    private Connection conn;

    public LikeDAO() {
        DBContext db = new DBContext();
        this.conn = db.getConnection();
    }

    public void incrementLikeCount(int blogID) {
        String sql = "UPDATE Blog SET likeCount = likeCount + 1 WHERE blogID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void decrementLikeCount(int blogID) {
        String sql = "UPDATE Blog SET likeCount = likeCount - 1 WHERE blogID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getLikeCount(int blogID) {
        String sql = "SELECT likeCount FROM Blog WHERE blogID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("likeCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean hasUserLiked(int blogID, int userID) {
        String sql = "SELECT 1 FROM Likes WHERE blogID = ? AND userID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            stmt.setInt(2, userID);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void insertLike(int blogID, int userID) {
        String sql = "INSERT INTO Likes (blogID, userID) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            stmt.setInt(2, userID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeLike(int blogID, int userID) {
        String sql = "DELETE FROM Likes WHERE blogID = ? AND userID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogID);
            stmt.setInt(2, userID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
