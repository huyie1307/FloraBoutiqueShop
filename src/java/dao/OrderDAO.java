package dao;

import dal.DBContext;
import entity.Category;
import entity.Order;
import entity.OrderDetail;
import entity.PaymentMethod;
import entity.Product;
import entity.Status;
import entity.User;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DBContext {

    //Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        return getProductsByCategory(null);
    }

    //Lấy hoa theo loại (Custom, Funeral, Service)
    public List<Product> getCustomFlowers() {
        return getProductsByCategory("HOA ĐẶT THEO YÊU CẦU");
    }

    public List<Product> getFuneralFlowers() {
        return getProductsByCategory("HOA CƯỚI");
    }

    public List<Product> getServiceFlowers() {
        return getProductsByCategory("HOA NGÀY LỄ");
    }

    //Phương thức chung để lấy sản phẩm theo loại
    private List<Product> getProductsByCategory(String categoryName) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.pid, p.name, c.cname, p.amount, p.price, p.image "
                + "FROM Product p INNER JOIN Category c ON p.cateID = c.cid ";

        if (categoryName != null) {
            query += "WHERE c.cname = ?";
        }

        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);

            if (categoryName != null) {
                ps.setString(1, categoryName);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setName(rs.getString("cname"));
                Product p = new Product(
                        rs.getInt("pid"),
                        rs.getString("name"),
                        category,
                        rs.getInt("amount"),
                        rs.getDouble("price"),
                        rs.getString("image")
                );
                products.add(p);
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean addProduct(Order order, OrderDetail detail) {
        String query1 = "INSERT INTO [Order] (userID, statusID, currentName, currentPhone, currentAddress, totalPrice, orderDate, completedDate, paymentMethodID, note) VALUES (?, ?, ?, ?, ?, ?, GETDATE(), ?, ?, ?)";
        String query2 = "INSERT INTO OrderDetail (orderID, productID, quantity, price, priceChange) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement stmtOrder = null;
        PreparedStatement stmtOrderDetail = null;
        ResultSet generatedKeys = null;

        try {
            // Bắt đầu giao dịch
            connection.setAutoCommit(false);

            // Chèn dữ liệu vào bảng Order
            stmtOrder = connection.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS);
            stmtOrder.setInt(1, order.getUser().getuID());
            stmtOrder.setInt(2, order.getStatus().getId());
            stmtOrder.setString(3, order.getCurrentName());
            stmtOrder.setString(4, order.getCurrentPhone());
            stmtOrder.setString(5, order.getCurrentAddress());
            stmtOrder.setDouble(6, order.getTotal());
            LocalDateTime completeDate = order.getCompleteDate();
            stmtOrder.setTimestamp(7, Timestamp.valueOf(completeDate));
            stmtOrder.setInt(8, order.getMethod().getId());
            stmtOrder.setString(9, order.getNote());
            stmtOrder.executeUpdate();

            // Lấy orderID vừa được tạo
            generatedKeys = stmtOrder.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderID = generatedKeys.getInt(1);

                // Chèn dữ liệu vào bảng OrderDetail
                stmtOrderDetail = connection.prepareStatement(query2);
                stmtOrderDetail.setInt(1, orderID);
                stmtOrderDetail.setInt(2, detail.getProduct().getFlowerId());
                stmtOrderDetail.setInt(3, detail.getQuantity());
                stmtOrderDetail.setDouble(4, detail.getPrice());
                stmtOrderDetail.setDouble(5, detail.getPrice());
                stmtOrderDetail.executeUpdate();
            } else {
                throw new SQLException("Không thể lấy orderID.");
            }

            // Xác nhận giao dịch
            connection.commit();
            return true;
        } catch (SQLException ex) {
            // Hủy bỏ giao dịch nếu có lỗi
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException e) {
                    System.out.println("Error when rollback: " + e.getMessage());
                }
            }
            System.out.println("Error: " + ex.getMessage());
            return false;
        } finally {
            // Đóng các tài nguyên
            try {
                if (generatedKeys != null) {
                    generatedKeys.close();
                }
                if (stmtOrder != null) {
                    stmtOrder.close();
                }
                if (stmtOrderDetail != null) {
                    stmtOrderDetail.close();
                }
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                System.out.println("Lỗi khi đóng tài nguyên: " + ex.getMessage());
            }
        }
    }

    public List<Order> getOrdersByAccountId(int accountId, int currentPage, int limit) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.orderID, o.userID, o.statusID, o.totalPrice, o.orderDate, o.paymentMethodID, "
                + "s.statusName, pm.methodName, u.username "
                + "FROM [Order] o "
                + "JOIN [Status] s ON o.statusID = s.statusID "
                + "JOIN [PaymentMethod] pm ON o.paymentMethodID = pm.methodID "
                + "JOIN [User] u ON o.userID = u.userID "
                + "WHERE o.userID = ? "
                + "ORDER BY o.orderDate DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        int offset = (currentPage - 1) * limit;

        try (Connection conn = this.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, accountId);
            ps.setInt(2, offset);
            ps.setInt(3, limit);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("orderID"));
                order.setUser(new User(rs.getInt("userID"), rs.getString("username")));
                order.setStatus(new Status(rs.getInt("statusID"), rs.getString("statusName")));
                order.setTotal(rs.getDouble("totalPrice"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setMethod(new PaymentMethod(rs.getInt("paymentMethodID"), rs.getString("methodName")));
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public long getOrderCountByAccountId(int accountId) {
        String query = "SELECT COUNT(*) AS total FROM [Order] WHERE userID = ?";
        long total = 0;

        try (Connection conn = this.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, accountId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getLong("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

}
