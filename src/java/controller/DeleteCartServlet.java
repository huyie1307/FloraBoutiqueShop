package controller;

import dao.CartDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("id"));
        CartDAO cartDAO = new CartDAO();
        boolean deleted = cartDAO.deleteCartById(cartId);

        response.setContentType("text/plain");
        response.getWriter().write(deleted ? "success" : "failure");
    }
}
