package dao;

import dal.DBContext;
import entity.*;
import java.sql.*;
import java.util.ArrayList;

public class LoginDAO extends DBContext {

    

    public Account getAccount(int id) {
    String query = "SELECT id, username, password FROM [Customers] WHERE [id] = ?";
    ResultSet result = null;  // Khai báo result ngoài try để có thể đóng trong finally
    PreparedStatement connect = null;
    Account account = null;

    try {
        connect = connection.prepareStatement(query);
        connect.setInt(1, id);
        result = connect.executeQuery();

        if (result.next()) {  // Nếu có kết quả trả về
            account = new Account();
            account.setId(result.getInt("id"));
            account.setUsername(result.getString("username"));
            account.setPassword(result.getString("password"));
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

    return account;  // Trả về account, có thể là null nếu không tìm thấy
}


    public Account login(String user, String pass) {
    String query = "SELECT * FROM [Customers] WHERE [username] = ? AND [password] = ?";
    Account account = null;  // Khởi tạo biến account để trả về
    ResultSet result = null;
    PreparedStatement connect = null;

    try {
        // Kiểm tra kết nối cơ sở dữ liệu
        if (connection == null) {
            throw new SQLException("Kết nối cơ sở dữ liệu không hợp lệ.");
        }

        // Tạo PreparedStatement và gán các giá trị
        connect = connection.prepareStatement(query);
        connect.setString(1, user);
        connect.setString(2, pass);

        // Thực hiện truy vấn
        result = connect.executeQuery();

        // Kiểm tra nếu có dữ liệu trả về
        if (result.next()) {
            account = new Account();
            account.setId(result.getInt("id"));
            account.setUsername(result.getString("username"));
            account.setPassword(result.getString("password"));
            // Bạn có thể thêm các trường khác nếu cần
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi đăng nhập: " + e.getMessage());
    } finally {
        // Đảm bảo đóng tài nguyên
        try {
            if (result != null) {
                result.close();
            }
            if (connect != null) {
                connect.close();
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi đóng tài nguyên: " + e.getMessage());
        }
    }

    return account;  // Trả về đối tượng Account hoặc null nếu không tìm thấy
}

     public Account checkAccountExist(String user) {
        String query = "SELECT * FROM [Customers] WHERE [username] = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user);
            try (ResultSet result = stmt.executeQuery()) {
                if (result.next()) {
                    Account account = new Account();
                    account.setId(result.getInt("id"));
                    account.setUsername(result.getString("username"));
                    account.setPassword(result.getString("password"));
                    return account;  // Trả về tài khoản nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi kiểm tra tài khoản: " + e.getMessage());
        }
        return null;  // Trả về null nếu không tìm thấy tài khoản
    }

    // Đăng ký tài khoản mới
    public boolean signup(String username, String password, String contactName, String phone, String address) {
        String query = "INSERT INTO [dbo].[Customers] ([contact_name], [username], [password], [phone], [address], [role], [created_at]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, contactName);
            stmt.setString(2, username);

            // Mã hóa mật khẩu trước khi lưu
            
            stmt.setString(3, password);  // Lưu mật khẩu đã mã hóa

            stmt.setString(4, phone);
            stmt.setString(5, address);
            stmt.setString(6, "Customer");  // Vai trò mặc định là "Customer"
            stmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));  // Thời gian tạo

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu đăng ký thành công, false nếu thất bại
        } catch (SQLException e) {
            System.out.println("Lỗi khi đăng ký: " + e.getMessage());
        }
        return false;  // Nếu có lỗi xảy ra, trả về false
    }

    // Lấy thông tin người dùng khi đăng nhập
    public User getUserLogin(String username) {
        String query = "SELECT id, contact_name, username, phone, address, role, created_at FROM [Customers] WHERE username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setContactName(rs.getString("contact_name"));
                    user.setUsername(rs.getString("username"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    return user;  // Trả về thông tin người dùng nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy thông tin người dùng: " + e.getMessage());
        }
        return null;  // Trả về null nếu không tìm thấy người dùng
    }

}