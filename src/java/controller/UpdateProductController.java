package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import entity.Category;
import entity.Product;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Giới hạn 5MB
public class UpdateProductController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateProductController.class.getName());
    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(id);

            if (product == null) {
                request.setAttribute("errorMessage", "Sản phẩm không tồn tại!");
            } else {
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.setAttribute("product", product);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID sản phẩm không hợp lệ!");
        }
        request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name").trim();
            String title = request.getParameter("title").trim();
            String description = request.getParameter("description").trim();
            double price = Double.parseDouble(request.getParameter("price"));
            int amount = Integer.parseInt(request.getParameter("amount"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            Part imagePart = request.getPart("image");
            String image = (imagePart != null && imagePart.getSize() > 0) ? uploadImage(imagePart) : request.getParameter("existingImage");

            if (name.isEmpty() || title.isEmpty() || description.isEmpty() || price < 0) {
                throw new IllegalArgumentException("Dữ liệu nhập vào không hợp lệ!");
            }

            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setTitle(title);
            product.setDescription(description);
            product.setPrice(price);
            product.setAmount(amount);
            product.setImage(image);

            Category category = new Category();
            category.setId(categoryId);
            product.setCategory(category);

            if (productDAO.updateProduct(product)) {
                response.sendRedirect("listProduct");
            } else {
                request.setAttribute("errorMessage", "Cập nhật sản phẩm thất bại!");
                request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ! Vui lòng kiểm tra lại số lượng và giá.");
            request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi hệ thống: ", e);
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
        }
    }

    private String uploadImage(Part imagePart) throws IOException {
        if (imagePart == null || imagePart.getSize() == 0) {
            return "";
        }
        String fileName = new java.io.File(imagePart.getSubmittedFileName()).getName();
        String uploadPath = getServletContext().getRealPath("/") + "uploads";
        new java.io.File(uploadPath).mkdirs();
        imagePart.write(uploadPath + java.io.File.separator + fileName);
        return "uploads/" + fileName;
    }
}
