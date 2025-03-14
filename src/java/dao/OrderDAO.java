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

public class OrderDAO extends DBContext {
    
    private Connection conn;
    
    public OrderDAO() {
        this.conn = super.connection;
    }
    
    public List<Order> getOrdersByAccountId(int accountId, int page, int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.orderID, o.totalPrice, o.orderDate, o.completedDate, o.note, "
                + "os.statusID, os.statusName, "
                + "pm.paymentMethodID, pm.methodName "
                + "FROM [Order] o "
                + "JOIN OrderStatus os ON o.statusID = os.statusID "
                + "JOIN PaymentMethod pm ON o.paymentMethodID = pm.paymentMethodID "
                + "WHERE o.accountID = ? "
                + "ORDER BY o.orderID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, accountId);
            stmt.setInt(2, (page - 1) * limit); // OFFSET
            stmt.setInt(3, limit); // FETCH NEXT

            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setTotalPrice(rs.getBigDecimal("totalPrice"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setCompletedDate(rs.getTimestamp("completedDate") != null ? rs.getTimestamp("completedDate") : null);
                order.setNote(rs.getString("note"));
                
                OrderStatus status = new OrderStatus();
                status.setId(rs.getInt("statusID"));
                status.setStatusName(rs.getString("statusName"));
                
                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setId(rs.getInt("paymentMethodID"));
                paymentMethod.setMethodName(rs.getString("methodName"));
                
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public int getOrderCountByAccountId(int accountId) {
        String sql = "SELECT COUNT(*) AS total FROM [Order] WHERE accountID = ?";
        int count = 0;
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, accountId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
