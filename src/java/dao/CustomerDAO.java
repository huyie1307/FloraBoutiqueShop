package dao;

import dal.DBContext;
import entity.Category;
import entity.Order;
import entity.OrderDetail;
import entity.OrderStatus;
import entity.PaymentMethod;

import entity.Product;
import entity.Review;
import entity.User;
import java.io.ObjectInputFilter.Status;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO extends DBContext {

    public ArrayList<User> getAllCustomer() {
        ArrayList<User> user = new ArrayList<>();
        String sql = "SELECT uID, name, dob, phone, address FROM [User] WHERE isAdmin = 0";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();  // Tạo đối tượng User mới cho mỗi dòng dữ liệu
                u.setuID(rs.getInt("uID"));
                u.setName(rs.getString("name"));  // Lấy giá trị từ cột "name"
                u.setDob(rs.getDate("dob"));     // Lấy giá trị từ cột "dob" (bây giờ là String)
                u.setPhone(rs.getString("phone")); // Lấy giá trị từ cột "phone"
                u.setAddress(rs.getString("address")); // Lấy giá trị từ cột "address"

                user.add(u);  // Thêm đối tượng User vào danh sách
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public void updateCustomer(User user) throws SQLException {
        String sql = "UPDATE [User] SET name = ?, dob = ?, phone = ?, address = ? WHERE uid = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setDate(2, (Date) user.getDob());  // Gán trực tiếp dob (String) vào câu lệnh SQL
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setInt(5, user.getuID());

            int rowsUpdated = stmt.executeUpdate();  // Thực thi câu lệnh cập nhật
            if (rowsUpdated == 0) {
                throw new SQLException("Không tìm thấy khách hàng với ID " + user.getuID());
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw new SQLException("Error updating customer information");
        }
    }

    public User getCustomerById(int customerId) {
        // Câu lệnh SQL để lấy thông tin khách hàng theo ID
        String sql = "SELECT uID, name, dob, phone, address FROM [User] WHERE uID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Thiết lập giá trị cho tham số ID
            stmt.setInt(1, customerId);

            // Thực thi truy vấn
            ResultSet rs = stmt.executeQuery();

            // Kiểm tra nếu có kết quả trả về
            if (rs.next()) {
                // Tạo đối tượng User và gán giá trị từ ResultSet
                User user = new User();
                user.setuID(rs.getInt("uID"));  // Lấy ID khách hàng
                user.setName(rs.getString("name"));  // Lấy tên khách hàng
                user.setDob(rs.getDate("dob"));  // Lấy ngày sinh (sử dụng String)
                user.setPhone(rs.getString("phone"));  // Lấy số điện thoại
                user.setAddress(rs.getString("address"));  // Lấy địa chỉ
                return user;
            }
        } catch (SQLException ex) {
            // Xử lý lỗi nếu có
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;  // Trả về đối tượng User hoặc null nếu không tìm thấy
    }

    public ArrayList<Product> getProductsByUserId(int userId) {
        ArrayList<Product> products = new ArrayList<>();
        String query = "SELECT p.pid, p.name, p.image, p.price, p.title, p.description, c.cid, c.cname "
                + "FROM [Order] o "
                + "JOIN OrderDetail od ON o.orderID = od.orderID "
                + "JOIN Product p ON od.productID = p.pid "
                + "JOIN Category c ON p.cateID = c.cid "
                + "WHERE o.userID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Khởi tạo đối tượng Product mới
                Product product = new Product();
                product.setFlowerId(rs.getInt("pid"));
                product.setName(rs.getString("name"));
                product.setImageUrl(rs.getString("image"));
                product.setPrice(rs.getDouble("price"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));

                // Lấy thông tin Category
                Category category = new Category();
                category.setId(rs.getInt("cid"));
                category.setName(rs.getString("cname"));
                product.setCategory(category); // Set Category cho sản phẩm

                // Thêm sản phẩm vào danh sách
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

     public ArrayList<OrderDetail> getOrderDetailsByUserId(int userID) throws SQLException {
        ArrayList<OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT " +
                       "p.name AS product_name, " +
                       "p.price AS product_price, " +
                       "p.description AS product_description, " +
                       "od.quantity AS product_quantity, " +
                       "o.totalPrice AS total_order_price, " +
                       "pm.methodName AS payment_method, " +
                       "o.orderID, " +
                       "od.id AS detailID, " +
                       "r.id AS reviewID " +
                       "FROM [Order] o " +
                       "JOIN OrderDetail od ON o.orderID = od.orderID " +
                       "JOIN Product p ON od.productID = p.pid " +
                       "JOIN PaymentMethod pm ON o.paymentMethodID = pm.paymentMethodID " +
                       "LEFT JOIN Review r ON od.reviewID = r.id " +
                       "WHERE o.userID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // Lấy thông tin từ ResultSet và tạo đối tượng Product, Review và Order
                Product product = new Product();
                product.setName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("product_price"));
                product.setDescription(rs.getString("product_description"));

                Review review = new Review();
                review.setId(rs.getInt("reviewID"));

                Order order = new Order();
                order.setId(rs.getString("orderID"));

                // Tạo đối tượng OrderDetail và gán các giá trị
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setId(rs.getInt("detailID"));
                orderDetail.setOrder(order);
                orderDetail.setProduct(product);
                orderDetail.setReview(review);
                orderDetail.setQuantity(rs.getInt("product_quantity"));
                orderDetail.setPrice(rs.getDouble("product_price"));

                orderDetails.add(orderDetail);
            }
        }
        return orderDetails;
    }

// Cập nhật phương thức lấy tên phương thức thanh toán
    private String getPaymentMethodName(int methodId) {
        String query = "SELECT name FROM PaymentMethod WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, methodId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
