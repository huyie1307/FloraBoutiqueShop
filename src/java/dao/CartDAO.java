package dao;

import dal.DBContext;
import entity.*;
import java.sql.*;
import java.util.*;

public class CartDAO extends DBContext {

    public List<Cart> getListCartByUserId(int user_id) {
        List<Cart> carts = new ArrayList<>();

        String sql = "SELECT * FROM Cart c JOIN Product p ON c.productID = p.pid JOIN [User] u ON u.uID = c.userID JOIN Category ca ON ca.cid = p.cateID WHERE c.userID = ?";

        try {
            PreparedStatement connect = connection.prepareStatement(sql);
            connect.setInt(1, user_id);
            ResultSet result = connect.executeQuery();

            while (result.next()) {
                Cart cart = new Cart();
                cart.setId(result.getInt("id"));
                cart.setAmount(result.getInt("amount"));
                cart.setCreate_at(result.getTimestamp("created_at"));

                User user = new User();
                user.setuID(result.getInt("uID"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setIsSeller(result.getBoolean("isSeller"));
                user.setIsAdmin(result.getBoolean("isAdmin"));
                user.setName(result.getString("name"));
                user.setDob(result.getDate("dob"));
                user.setPhone(result.getString("phone"));
                user.setAddress(result.getString("address"));
                cart.setUser(user);

                Product product = new Product();
                product.setFlowerId(result.getInt("pid"));
                product.setName(result.getString("name"));
                product.setImageUrl(result.getString("image"));
                product.setQuantity(result.getInt("amount"));
                product.setPrice(result.getDouble("price"));
                product.setTitle(result.getString("title"));
                product.setDescription(result.getString("description"));
                cart.setProduct(product);

                Category category = new Category();
                category.setId(result.getInt("cid"));
                category.setName(result.getString("cname"));
                cart.setCategory(category);

                carts.add(cart);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return carts;
    }

    public boolean addCart(Cart cart) {
        String checkSql = "SELECT id, amount FROM Cart WHERE userID = ? AND productID = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {

            checkStmt.setInt(1, cart.getUser().getuID());
            checkStmt.setInt(2, cart.getProduct().getFlowerId());

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                int existingAmount = rs.getInt("amount");
                int newAmount = existingAmount + cart.getAmount();
                int cartId = rs.getInt("id");

                String updateSql = "UPDATE Cart SET amount = ? WHERE id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, newAmount);
                    updateStmt.setInt(2, cartId);

                    int affectedRows = updateStmt.executeUpdate();
                    return affectedRows > 0;
                }
            } else {
                String insertSql = "INSERT INTO Cart (userID, productID, amount, created_at) VALUES (?, ?, ?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, cart.getUser().getuID());
                    insertStmt.setInt(2, cart.getProduct().getFlowerId());
                    insertStmt.setInt(3, cart.getAmount());
                    insertStmt.setTimestamp(4, new java.sql.Timestamp(cart.getCreate_at().getTime()));

                    int affectedRows = insertStmt.executeUpdate();
                    return affectedRows > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCartById(int cartId) {
        String sql = "DELETE FROM Cart WHERE id = ?";
        try {
            PreparedStatement connect = connection.prepareStatement(sql);

            connect.setInt(1, cartId);
            int affectedRows = connect.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean updateCartQuantity(int cartId, int quantity) {

        String selectSql = "SELECT amount FROM Cart WHERE id = ?";
        try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
            selectStmt.setInt(1, cartId);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                int currentQty = rs.getInt("amount");
                if (currentQty == quantity) {
                    return true;
                }
            }

            String updateSql = "UPDATE Cart SET amount = ? WHERE id = ?";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, cartId);
                int affectedRows = updateStmt.executeUpdate();
                return affectedRows > 0;
            }
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public List<Cart> getCartItemsByIds(List<Integer> idList) {
        List<Cart> carts = new ArrayList<>();
        if (idList == null || idList.isEmpty()) {
            return carts;
        }

        // Xây dựng câu lệnh SQL với IN clause có số tham số bằng số lượng id trong idList
        StringBuilder sql = new StringBuilder("SELECT * FROM Cart c "
                + "JOIN Product p ON c.productID = p.pid "
                + "JOIN [User] u ON u.uID = c.userID "
                + "JOIN Category ca ON ca.cid = p.cateID "
                + "WHERE c.id IN (");
        for (int i = 0; i < idList.size(); i++) {
            sql.append("?");
            if (i < idList.size() - 1) {
                sql.append(",");
            }
        }
        sql.append(")");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int index = 1;
            for (Integer id : idList) {
                ps.setInt(index++, id);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setAmount(rs.getInt("amount"));
                cart.setCreate_at(rs.getTimestamp("created_at"));

                User user = new User();
                user.setuID(rs.getInt("uID"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setIsSeller(rs.getBoolean("isSeller"));
                user.setIsAdmin(rs.getBoolean("isAdmin"));
                user.setName(rs.getString("name"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                cart.setUser(user);

                Product product = new Product();
                product.setFlowerId(rs.getInt("pid"));
                product.setName(rs.getString("name"));
                product.setImageUrl(rs.getString("image"));
                product.setQuantity(rs.getInt("amount")); // Lưu ý: tên cột có thể khác nếu có xung đột
                product.setPrice(rs.getDouble("price"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));
                cart.setProduct(product);

                Category category = new Category();
                category.setId(rs.getInt("cid"));
                category.setName(rs.getString("cname"));
                cart.setCategory(category);

                carts.add(cart);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return carts;
    }

}
