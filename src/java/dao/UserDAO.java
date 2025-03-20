package dao;

import dal.DBContext;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("uID"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getBoolean("isSeller"),
                        rs.getBoolean("isAdmin"),
                        rs.getString("name"),
                        rs.getDate("dob"),
                        rs.getString("phone"),
                        rs.getString("address")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Thêm người dùng mới
    public boolean addUser(User user) {
        String sql = "INSERT INTO [User] (username, password, isSeller, isAdmin, name, dob, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setBoolean(3, user.isIsSeller());
            ps.setBoolean(4, user.isIsAdmin());
            ps.setString(5, user.getName());
            ps.setDate(6, new java.sql.Date(user.getDob().getTime()));
            ps.setString(7, user.getPhone());
            ps.setString(8, user.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa người dùng theo ID
    public boolean deleteUser(int uID) {
        String sql = "DELETE FROM User WHERE uID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, uID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy người dùng theo tên đăng nhập
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM User WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("uID"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getBoolean("isSeller"),
                            rs.getBoolean("isAdmin"),
                            rs.getString("name"),
                            rs.getDate("dob"),
                            rs.getString("phone"),
                            rs.getString("address")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> searchUsers(String keyword) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [User] WHERE username LIKE ? OR name LIKE ? OR phone LIKE ? OR address LIKE ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("uID"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getBoolean("isSeller"),
                        rs.getBoolean("isAdmin"),
                        rs.getString("name"),
                        rs.getDate("dob"),
                        rs.getString("phone"),
                        rs.getString("address")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

}
