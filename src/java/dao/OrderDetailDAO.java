/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author admin
 */
import dal.DBContext;
import java.sql.*;
import java.util.List;
import entity.*;
import java.util.ArrayList;

public class OrderDetailDAO extends DBContext {

    private Connection conn;

    public OrderDetailDAO() {
        this.conn = super.connection;
    }

    public List<OrderDetail> getOrderDetailsByOrderId(String orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT od.detailID, od.quantity, od.price, od.priceChange, "
                + "o.orderID, o.accountID, o.statusID, o.totalPrice, o.orderDate, o.completedDate, o.paymentMethodID, o.discountCodeID, o.note, "
                + "os.statusName, "
                + "p.pid AS productId, p.name AS productName, p.image, p.price AS productPrice, "
                + "r.id AS reviewId, r.rating, r.content "
                + "FROM OrderDetail od "
                + "JOIN [Order] o ON od.orderID = o.orderID "
                + "JOIN OrderStatus os ON o.statusID = os.statusID "
                + "JOIN Product p ON od.productID = p.pid "
                + "LEFT JOIN Review r ON od.reviewID = r.id "
                + "WHERE od.orderID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setId(rs.getInt("detailID"));
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setPrice(rs.getDouble("price"));
                orderDetail.setPriceChange(rs.getDouble("priceChange"));

                Order order = new Order();
                order.setId(rs.getString("orderID"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setNote(rs.getString("note"));

                OrderStatus orderStatus = new OrderStatus();
                orderStatus.setId(rs.getInt("statusID"));
                orderStatus.setStatusName(rs.getString("statusName"));
                order.setStatus(orderStatus);

                orderDetail.setOrder(order);

                Product product = new Product();
                product.setId(rs.getInt("productId"));
                product.setName(rs.getString("productName"));
                product.setImage(rs.getString("image"));
                product.setPrice(rs.getDouble("productPrice"));
                orderDetail.setProduct(product);

                int reviewId = rs.getInt("reviewId");
                if (!rs.wasNull()) {
                    Review review = new Review();
                    review.setId(reviewId);
                    review.setRating(rs.getInt("rating"));
                    review.setContent(rs.getString("content"));
                    orderDetail.setReview(review);
                } else {
                    orderDetail.setReview(null);
                }

                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public boolean updateReviewIdInOrderDetail(int orderDetailId, int reviewId) {
        String sql = "UPDATE OrderDetail SET reviewID = ? WHERE detailID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            stmt.setInt(2, orderDetailId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
