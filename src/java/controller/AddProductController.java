package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import entity.Category;
import entity.Product;
import java.io.IOException;
import java.io.File;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Giới hạn 5MB
public class AddProductController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ArrayList<Category> categories = categoryDAO.getAllCategories();
            ArrayList<Product> products = productDAO.listAllProduct();
            request.setAttribute("categories", categories);
            request.setAttribute("products", products);
        } catch (Exception e) {
            Logger.getLogger(AddProductController.class.getName()).log(Level.SEVERE, "Lỗi khi lấy dữ liệu", e);
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
        }
        request.getRequestDispatcher("listProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name").trim();
            String title = request.getParameter("title").trim();
            String description = request.getParameter("description").trim();
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            double price = Double.parseDouble(request.getParameter("price"));
            int amount = Integer.parseInt(request.getParameter("amount"));

            // Lấy tên danh mục theo ID
            String categoryName = categoryDAO.getCategoryNameById(categoryId);
            if (categoryName == null) {
                request.setAttribute("errorMessage", "Danh mục không tồn tại!");
                doGet(request, response);
                return;
            }

            // Tạo đối tượng Category từ ID và tên
            Category category = new Category();
            category.setId(categoryId);
            category.setName(categoryName);

            // Xử lý upload ảnh
            String image = uploadImage(request.getPart("image"));

            // Tạo đối tượng Product
            Product product = new Product();
            product.setName(name);
            product.setTitle(title);
            product.setDescription(description);
            product.setPrice(price);
            product.setAmount(amount);
            product.setImage(image);
            product.setCategory(category);

            // Thêm sản phẩm vào database
            if (productDAO.addProduct(product, category.getId())) {
                response.sendRedirect("listProduct");
            } else {
                request.setAttribute("errorMessage", "Thêm sản phẩm thất bại!");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ!");
            doGet(request, response);
        } catch (Exception e) {
            Logger.getLogger(AddProductController.class.getName()).log(Level.SEVERE, "Lỗi khi thêm sản phẩm", e);
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            doGet(request, response);
        }
    }

    private String uploadImage(Part imagePart) throws IOException {
        if (imagePart == null || imagePart.getSize() == 0) {
            return "";
        }
        String fileName = new File(imagePart.getSubmittedFileName()).getName();
        String uploadPath = getServletContext().getRealPath("/") + "uploads";
        new File(uploadPath).mkdirs(); // Tạo thư mục nếu chưa có
        imagePart.write(uploadPath + File.separator + fileName);
        return "uploads/" + fileName;
    }
}
