package controller;

import dao.CartDAO;
import entity.Cart;
import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.getWriter().write("not_logged_in");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            int productId = Integer.parseInt(request.getParameter("pid"));
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
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        } catch (Exception e) {
            response.getWriter().write("error");
        }
    }
}
