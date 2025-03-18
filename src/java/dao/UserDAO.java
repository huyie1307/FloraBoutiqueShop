package dao;

import dal.DBContext;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDAO extends DBContext {

    public boolean updateUser(User user) {
        String sql = "UPDATE [User] SET name = ?, dob = ?, phone = ?, address = ? WHERE uID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setDate(2, user.getDob() != null ? new java.sql.Date(user.getDob().getTime()) : null);
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setInt(5, user.getuID());

            return ps.executeUpdate() > 0; // Nếu update thành công, trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(int uID) {
        User user = null;
        String sql = "SELECT * FROM [User] WHERE uID = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, uID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setuID(rs.getInt("uID"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setIsSeller(rs.getBoolean("isSeller"));
                user.setIsAdmin(rs.getBoolean("isAdmin"));
                user.setName(rs.getString("name"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

}
