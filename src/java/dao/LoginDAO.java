package dao;

import dal.DBContext;
import entity.*;
import java.sql.*;

public class LoginDAO extends DBContext {

    public Account getAccount(int id) {
        String query = "SELECT * FROM [Account] WHERE [uID] = 1";
        ResultSet result = null;  // Khai báo result ngoài try để có thể đóng trong finally
        PreparedStatement connect = null;
        Account account = null;

        try {
            connect = connection.prepareStatement(query);
            connect.setInt(1, id);
            result = connect.executeQuery();

            if (result.next()) {  // Nếu có kết quả trả về
                account = new Account();
                account.setId(result.getInt("uID"));
                account.setUsername(result.getString("user"));
                account.setPassword(result.getString("pass"));
                account.setIsSell(result.getBoolean("isSell"));
                account.setIsAdmin(result.getBoolean("isAdmin"));
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
        String query = "SELECT * FROM [Account] WHERE [user] = ? AND [pass] = ?";
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
                account.setId(result.getInt("uID"));
                account.setUsername(result.getString("user"));
                account.setPassword(result.getString("pass"));
                account.setIsSell(result.getBoolean("isSell"));
                account.setIsAdmin(result.getBoolean("isAdmin"));
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
        String query = "SELECT * FROM [Account] WHERE [user] = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user);
            try (ResultSet result = stmt.executeQuery()) {
                if (result.next()) {
                    Account account = new Account();
                    account.setId(result.getInt("uID"));
                    account.setUsername(result.getString("user"));
                    account.setPassword(result.getString("pass"));
                    return account;  // Trả về tài khoản nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi kiểm tra tài khoản: " + e.getMessage());
        }
        return null;  // Trả về null nếu không tìm thấy tài khoản
    }

    // Đăng ký tài khoản mới
    public boolean signup(String username, String password, String contactName, String phone) {
        String query = "INSERT INTO [Account] ([user], [pass], [isSell], [isAdmin]) VALUES (?, ?, ?, ?)";
        String query2 = "INSERT INTO [User] ([uID], [name], [dob], [phone], [address]) VALUES (?, ?, ? ,?, ?)";

        try {
            // Bật transaction: tắt auto-commit
            connection.setAutoCommit(false);

            // Thực hiện query 1
            try (PreparedStatement stmt1 = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
                stmt1.setString(1, username);
                // Mã hóa mật khẩu nếu cần, sau đó set vào query
                stmt1.setString(2, password);
                stmt1.setBoolean(3, false);  // Ví dụ: isSell = false
                stmt1.setBoolean(4, false);  // Ví dụ: isAdmin = false
                // Mặc định sẽ là Customer

                int affectedRows1 = stmt1.executeUpdate();
                if (affectedRows1 == 0) {
                    throw new SQLException("Insert into Account thất bại, không có dòng nào được ảnh hưởng.");
                }

                // Lấy uID được tạo tự động từ bảng Account
                int uID;
                try (ResultSet rs = stmt1.getGeneratedKeys()) {
                    if (rs.next()) {
                        uID = rs.getInt(1);
                    } else {
                        throw new SQLException("Insert into Account thất bại, không lấy được ID.");
                    }
                }

                // Thực hiện query 2 với uID vừa lấy được
                try (PreparedStatement stmt2 = connection.prepareStatement(query2)) {
                    stmt2.setInt(1, uID);
                    stmt2.setString(2, contactName);
                    stmt2.setNull(3, java.sql.Types.DATE);
                    stmt2.setString(4, phone);
                    stmt2.setString(5, null);

                    int affectedRows2 = stmt2.executeUpdate();
                    if (affectedRows2 == 0) {
                        throw new SQLException("Insert into User thất bại, không có dòng nào được ảnh hưởng.");
                    }
                }
            }

            // Commit transaction nếu cả hai query đều thành công
            connection.commit();
            return true;
        } catch (SQLException e) {
            System.out.println("Lỗi khi đăng ký: " + e.getMessage());
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Lỗi rollback: " + ex.getMessage());
            }
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Lỗi khi đặt lại autoCommit: " + e.getMessage());
            }
        }
    }

    // Lấy thông tin người dùng khi đăng nhập
    public User getUserLogin(String username) {
        String query = "SELECT * FROM [User] WHERE [name] = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("uID"));
                    user.setName(rs.getString("name"));
                    user.setDob(rs.getDate("dob"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    return user;  // Trả về thông tin người dùng nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy thông tin người dùng: " + e.getMessage());
        }
        return null;  // Trả về null nếu không tìm thấy người dùng
    }
}
