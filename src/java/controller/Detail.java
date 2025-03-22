package controller;

import dao.ProductDAO;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "Detail", urlPatterns = {"/productDetail"})
public class Detail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String flowerIdStr = request.getParameter("flowerId");

        if (flowerIdStr != null) {
            try {
                int flowerId = Integer.parseInt(flowerIdStr);
                ProductDAO dao = new ProductDAO();
                Product productDetail = dao.getProductById(flowerId);

                if (productDetail != null) {
                    request.setAttribute("productDetail", productDetail);
                    request.getRequestDispatcher("productDetail.jsp").forward(request, response);
                } else {
                    response.sendRedirect("myProduct.jsp?error=Product not found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("myProduct.jsp?error=Invalid product ID");
            }
        } else {
            response.sendRedirect("myProduct.jsp?error=No product ID provided");
        }
    }
}
