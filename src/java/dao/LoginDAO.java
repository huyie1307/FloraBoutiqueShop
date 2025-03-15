package dao;

import dal.DBContext;
import entity.*;
import java.sql.*;

public class LoginDAO extends DBContext {

    public User getUser(int uID) {
        String query = "SELECT * FROM [User] WHERE [uID] = ?";
        ResultSet result = null;  // Khai báo result ngoài try để có thể đóng trong finally
        PreparedStatement connect = null;
        User user = new User();

        try {
            connect = connection.prepareStatement(query);
            connect.setInt(1, uID);
            result = connect.executeQuery();

            if (result.next()) {  // Nếu có kết quả trả về
                user.setuID(result.getInt("uID"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setIsSeller(result.getBoolean("isSeller"));
                user.setIsAdmin(result.getBoolean("isAdmin"));
                user.setName(result.getString("name"));
                user.setDob(result.getDate("dob"));
                user.setPhone(result.getString("phone"));
                user.setAddress(result.getString("address"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy thông tin tài khoản: " + e.getMessage());
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (connect != null) {
                    connect.close();
                }
            } catch (SQLException e) {
                System.out.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }

        return user;  // Trả về user, có thể là null nếu không tìm thấy
    }

    public User getUserByUserName(String username) {
        String query = "SELECT * FROM [User] WHERE [username] = ?";
        ResultSet result = null;  // Khai báo result ngoài try để có thể đóng trong finally
        PreparedStatement connect = null;
        User user = new User();

        try {
            connect = connection.prepareStatement(query);
            connect.setString(1, username);
            result = connect.executeQuery();

            if (result.next()) {  // Nếu có kết quả trả về
                user.setuID(result.getInt("uID"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setIsSeller(result.getBoolean("isSeller"));
                user.setIsAdmin(result.getBoolean("isAdmin"));
                user.setName(result.getString("name"));
                user.setDob(result.getDate("dob"));
                user.setPhone(result.getString("phone"));
                user.setAddress(result.getString("address"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy thông tin tài khoản: " + e.getMessage());
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (connect != null) {
                    connect.close();
                }
            } catch (SQLException e) {
                System.out.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }

        return user;  // Trả về user, có thể là null nếu không tìm thấy
    }

    public User login(String username, String password) {
        String query = "SELECT * FROM [User] WHERE [username] = ? AND [password] = ?";
        User user = new User();  // Khởi tạo biến account để trả về

        try {
            PreparedStatement connect = connection.prepareStatement(query);
            connect.setString(1, username);
            connect.setString(2, password);
            ResultSet result = connect.executeQuery();

            // Kiểm tra nếu có dữ liệu trả về
            if (result.next()) {
                user.setuID(result.getInt("uID"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setIsSeller(result.getBoolean("isSeller"));
                user.setIsAdmin(result.getBoolean("isAdmin"));
                user.setName(result.getString("name"));
                user.setDob(result.getDate("dob"));
                user.setPhone(result.getString("phone"));
                user.setAddress(result.getString("address"));
                // Bạn có thể thêm các trường khác nếu cần
                return user;
            }

        } catch (SQLException e) {
            System.out.println("Lỗi khi đăng nhập: " + e.getMessage());
        }

        return null;
    }

    public User checkAccountExist(String username) {
        String query = "SELECT * FROM [User] WHERE [username] = ?";
        User user = new User();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet result = stmt.executeQuery()) {
                if (result.next()) {
                    user.setuID(result.getInt("uID"));
                    user.setUsername(result.getString("username"));
                    user.setPassword(result.getString("password"));
                    user.setIsSeller(result.getBoolean("isSeller"));
                    user.setIsAdmin(result.getBoolean("isAdmin"));
                    user.setName(result.getString("name"));
                    user.setDob(result.getDate("dob"));
                    user.setPhone(result.getString("phone"));
                    user.setAddress(result.getString("address"));
                    return user;  // Trả về tài khoản nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi kiểm tra tài khoản: " + e.getMessage());
        }
        return null;  // Trả về null nếu không tìm thấy tài khoản
    }

    // Đăng ký tài khoản mới
    public boolean signup(String username, String password, String name, String phone, String address) {
        String query = "INSERT INTO [User] ([username], [password], [isSeller], [isAdmin], [name], [phone], [address]) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {

            // Thực hiện query
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, username);
                // Mã hóa mật khẩu nếu cần, sau đó set vào query
                stmt.setString(2, password);
                stmt.setBoolean(3, false);  // Ví dụ: isSell = false
                stmt.setBoolean(4, false);  // Ví dụ: isAdmin = false
                // Mặc định sẽ là Customer
                stmt.setString(5, name);
                stmt.setString(6, phone);
                stmt.setString(7, address);

                stmt.executeUpdate();
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi đăng ký: " + e.getMessage());
            return false;
        }
    }
}
