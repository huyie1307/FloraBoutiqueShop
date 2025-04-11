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

}
