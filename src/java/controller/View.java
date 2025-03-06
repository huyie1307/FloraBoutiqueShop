package controller;

import dao.OrderDAO;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class View extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO dao = new OrderDAO();
        String category = request.getParameter("category");

        if (category == null || category.isEmpty()) {
            category = "all"; // Đảm bảo không null
        }

        List<Product> products;
        switch (category) {
            case "custom":
                products = dao.getCustomFlowers();
                break;
            case "funeral":
                products = dao.getFuneralFlowers();
                break;
            case "service":
                products = dao.getServiceFlowers();
                break;
            default:
                products = dao.getAllProducts();
                break;
        }

        // Lưu vào session để JSP sử dụng
        request.getSession().setAttribute("products", products);
        request.getSession().setAttribute("category", category);

        // Chuyển hướng về trang danh sách sản phẩm
        response.sendRedirect("myProduct.jsp");
    }

}
