package dao;

import dal.DBContext;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import java.sql.*;
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
    private List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.pid, p.name, c.cname, p.amount, p.price, p.image "
                + "FROM Product p INNER JOIN Category c ON p.cateID = c.cid ";

        if (category != null) {
            query += "WHERE c.cname = ?";
        }

        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);

            if (category != null) {
                ps.setString(1, category);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("pid"),
                        rs.getString("name"),
                        rs.getString("cname"),
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
        String checkOrderSql = "SELECT orderID, totalPrice FROM [dbo].[Order] WHERE userID = ? AND statusID = 1";
        try (PreparedStatement checkOrderStmt = connection.prepareStatement(checkOrderSql)) {
            checkOrderStmt.setInt(1, order.getUser().getuID());
            ResultSet rsOrder = checkOrderStmt.executeQuery();
            int orderId = 0;
            double currentTotal = 0;
            if (rsOrder.next()) {
                orderId = rsOrder.getInt("orderID");
                currentTotal = rsOrder.getDouble("totalPrice");
            }
            rsOrder.close();

            if (orderId != 0) {
                // Đã tồn tại đơn hàng Pending cho user, kiểm tra OrderDetail
                String checkDetailSql = "SELECT detailID, quantity FROM [dbo].[OrderDetail] WHERE orderID = ? AND productID = ?";
                try (PreparedStatement checkDetailStmt = connection.prepareStatement(checkDetailSql)) {
                    checkDetailStmt.setInt(1, orderId);
                    checkDetailStmt.setInt(2, detail.getProduct().getFlowerId());
                    ResultSet rsDetail = checkDetailStmt.executeQuery();
                    if (rsDetail.next()) {
                        // Sản phẩm đã có trong OrderDetail => cập nhật số lượng
                        int detailId = rsDetail.getInt("detailID");
                        int existingQty = rsDetail.getInt("quantity");
                        int newQty = existingQty + detail.getQuantity();
                        rsDetail.close();

                        String updateDetailSql = "UPDATE [dbo].[OrderDetail] SET quantity = ? WHERE detailID = ?";
                        try (PreparedStatement updateDetailStmt = connection.prepareStatement(updateDetailSql)) {
                            updateDetailStmt.setInt(1, newQty);
                            updateDetailStmt.setInt(2, detailId);
                            int affectedRows = updateDetailStmt.executeUpdate();
                            if (affectedRows > 0) {
                                // Cập nhật lại tổng tiền đơn hàng
                                double newTotal = currentTotal + (detail.getPrice() * detail.getQuantity());
                                String updateOrderSql = "UPDATE [dbo].[Order] SET totalPrice = ? WHERE orderID = ?";
                                try (PreparedStatement updateOrderStmt = connection.prepareStatement(updateOrderSql)) {
                                    updateOrderStmt.setDouble(1, newTotal);
                                    updateOrderStmt.setInt(2, orderId);
                                    updateOrderStmt.executeUpdate();
                                }
                                return true;
                            }
                        }
                    } else {
                        rsDetail.close();
                        // Sản phẩm chưa có trong OrderDetail => insert mới
                        String insertDetailSql = "INSERT INTO [dbo].[OrderDetail] (orderID, reviewID, productID, quantity, price, priceChange) "
                                + "VALUES (?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement insertDetailStmt = connection.prepareStatement(insertDetailSql)) {
                            insertDetailStmt.setInt(1, orderId);
                            // reviewID chưa có nên set null
                            insertDetailStmt.setObject(2, null, Types.INTEGER);
                            insertDetailStmt.setInt(3, detail.getProduct().getFlowerId());
                            insertDetailStmt.setInt(4, detail.getQuantity());
                            insertDetailStmt.setDouble(5, detail.getPrice());
                            // Giá thay đổi (priceChange) đặt là bằng giá ban đầu
                            insertDetailStmt.setDouble(6, detail.getPrice());
                            int affectedRows = insertDetailStmt.executeUpdate();
                            if (affectedRows > 0) {
                                double newTotal = currentTotal + (detail.getPrice() * detail.getQuantity());
                                String updateOrderSql = "UPDATE [dbo].[Order] SET totalPrice = ? WHERE orderID = ?";
                                try (PreparedStatement updateOrderStmt = connection.prepareStatement(updateOrderSql)) {
                                    updateOrderStmt.setDouble(1, newTotal);
                                    updateOrderStmt.setInt(2, orderId);
                                    updateOrderStmt.executeUpdate();
                                }
                                return true;
                            }
                        }
                    }
                }
            } else {
                // Không có đơn hàng Pending, tạo đơn hàng mới
                String insertOrderSql = "INSERT INTO [dbo].[Order] (userID, statusID, totalPrice, orderDate, paymentMethodID) "
                        + "VALUES (?, ?, ?, GETDATE(), ?)";
                try (PreparedStatement insertOrderStmt = connection.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                    insertOrderStmt.setInt(1, order.getUser().getuID());
                    insertOrderStmt.setInt(2, 1); // Pending, statusID = 1
                    double initialTotal = detail.getPrice() * detail.getQuantity();
                    insertOrderStmt.setDouble(3, initialTotal);
                    insertOrderStmt.setInt(4, order.getMethod().getId());
                    insertOrderStmt.executeUpdate();
                    ResultSet rsNewOrder = insertOrderStmt.getGeneratedKeys();
                    int newOrderId = 0;
                    if (rsNewOrder.next()) {
                        newOrderId = rsNewOrder.getInt(1);
                    }
                    rsNewOrder.close();

                    // Insert OrderDetail cho đơn hàng mới
                    String insertDetailSql = "INSERT INTO [dbo].[OrderDetail] (orderID, reviewID, productID, quantity, price, priceChange) "
                            + "VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement insertDetailStmt = connection.prepareStatement(insertDetailSql)) {
                        insertDetailStmt.setInt(1, newOrderId);
                        insertDetailStmt.setNull(2, Types.INTEGER);
                        insertDetailStmt.setInt(3, detail.getProduct().getFlowerId());
                        insertDetailStmt.setInt(4, detail.getQuantity());
                        insertDetailStmt.setDouble(5, detail.getPrice());
                        insertDetailStmt.setDouble(6, detail.getPrice());
                        int affectedRows = insertDetailStmt.executeUpdate();
                        return affectedRows > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
