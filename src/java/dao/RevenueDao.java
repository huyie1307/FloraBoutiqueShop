/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Huyie
 */
public class RevenueDao extends DBContext{
    public Map<String, Integer> getRevenueByProduct() {
        Map<String, Integer> revenueData = new HashMap<>();
        String query = "SELECT p.name, SUM(od.quantity * od.price) AS totalRevenue " +
                       "FROM OrderDetail od " +
                       "JOIN Product p ON od.pid = p.pid " +
                       "GROUP BY p.name";

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                revenueData.put(rs.getString("name"), rs.getInt("totalRevenue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueData;
    }
    public Map<String, Integer> getRevenueByCategory() {
    Map<String, Integer> revenueData = new HashMap<>();
    String query = "SELECT c.cname, SUM(od.quantity * od.price) AS totalRevenue " +
                   "FROM OrderDetail od " +
                   "JOIN Product p ON od.productID= p.pid " +
                   "JOIN Category c ON p.cateID = c.cid " +
                   "WHERE c.cid IN (1, 2, 3) " +
                   "GROUP BY c.cname";

    try (PreparedStatement ps = connection.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            String categoryName = rs.getString("cname");
            revenueData.put(categoryName, rs.getInt("totalRevenue"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return revenueData;
}
public Map<String, Integer> getRevenueByDate(String filter) {
    Map<String, Integer> revenueData = new HashMap<>();
    String sql = "";
    switch (filter) {
        case "day":
            sql = "SELECT CONVERT(VARCHAR(10), orderDate, 120) AS [Date], SUM(totalPrice) AS Revenue " +
                    "FROM [Order] WHERE statusID = 4 GROUP BY CONVERT(VARCHAR(10), orderDate, 120) ORDER BY [Date]";
            break;
        case "month":
            sql = "SELECT FORMAT(orderDate, 'yyyy-MM') AS [Month], SUM(totalPrice) AS Revenue " +
                    "FROM [Order] WHERE statusID = 4 GROUP BY FORMAT(orderDate, 'yyyy-MM') ORDER BY [Month]";
            break;
        case "year":
            sql = "SELECT YEAR(orderDate) AS [Year], SUM(totalPrice) AS Revenue " +
                    "FROM [Order] WHERE statusID = 4 GROUP BY YEAR(orderDate) ORDER BY [Year]";
            break;
        default:
            return revenueData;
    }

    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            revenueData.put(rs.getString(1), rs.getInt(2));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return revenueData;
}

    public int getTotalRevenue() {
        String sql = "SELECT SUM(totalPrice) FROM [Order]";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
      public void updateStatus(int orderID, int statusID) throws Exception {
        String query = "UPDATE [Order] SET statusID = ? WHERE orderID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
             
            ps.setInt(1, statusID);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        }
    }

}
