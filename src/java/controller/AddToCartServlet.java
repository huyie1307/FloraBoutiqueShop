package controller;

import dao.CartDAO;
import entity.Cart;
import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve logged-in user from session (adjust attribute name as needed)
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            // If not logged in, redirect to login page
            response.sendRedirect("login");
            return;
        }

        String pidParam = request.getParameter("pid");
        int productId = Integer.parseInt(pidParam);
        int quantity = 1;

        Cart cart = new Cart();
        cart.setAmount(quantity);
        cart.setCreate_at(new Date());

        cart.setUser(user);

        Product product = new Product();
        product.setFlowerId(productId);
        cart.setProduct(product);

        CartDAO cartDAO = new CartDAO();

        boolean added = cartDAO.addCart(cart);

        if (added) {
            request.setAttribute("success", "Bạn đã thêm thành công sản phẩm vào giỏ hàng");
            request.getRequestDispatcher("listProduct").forward(request, response);
        } else {
            response.sendRedirect("404.jsp");
        }
    }
}
