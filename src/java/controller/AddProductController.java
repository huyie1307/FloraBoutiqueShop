package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import entity.Category;
import entity.Product;
import java.io.IOException;
import java.io.File;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet để thêm sản phẩm vào hệ thống.
 */

public class AddProductController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    /**
     * Xử lý yêu cầu POST - Thêm sản phẩm mới.
     */
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Nhận dữ liệu từ request
            String name = request.getParameter("name");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String categoryName = request.getParameter("categoryName"); // Lấy tên danh mục từ request
            String priceStr = request.getParameter("price");

            // Kiểm tra tham số hợp lệ
            if (name == null || title == null || description == null || categoryName == null || priceStr == null) {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Missing required parameters.\"}");
                return;
            }

            // Chuyển đổi giá thành số
            double price = Double.parseDouble(priceStr);

            // Lấy đối tượng Category từ categoryName
              Category category = categoryDAO.getCategoryByName(categoryName);
            if (category == null) {
                // Phản hồi JSON khi danh mục không tồn tại
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Category not found.\"}");
                return;
            }

            // Xử lý hình ảnh
            String imageOption = request.getParameter("imageOption");
            String image = "";

            if ("upload".equals(imageOption)) {
                Part imagePart = request.getPart("image");
                String imageFileName = extractFileName(imagePart);

                // Đảm bảo thư mục uploads tồn tại
                String uploadPath = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                // Đường dẫn lưu ảnh
                String filePath = uploadPath + File.separator + imageFileName;
                imagePart.write(filePath);
                image = "uploads/" + imageFileName; // Lưu đường dẫn tương đối
            } else if ("url".equals(imageOption)) {
                image = request.getParameter("imageUrl");
            }

            // Tạo đối tượng Product với Category
            Product product = new Product();
            product.setName(name);
            product.setImage(image);
            product.setPrice(price);
            product.setTitle(title);
            product.setDescription(description);
            product.setCategory(category);

            // Thêm sản phẩm vào database
            productDAO.addProduct(product);

            // Phản hồi JSON thành công
            response.getWriter().write("{\"status\":\"success\", \"message\":\"Product added successfully!\"}");
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Invalid number format.\"}");
        } catch (Exception e) {
            Logger.getLogger(AddProductController.class.getName()).log(Level.SEVERE, "Lỗi khi thêm sản phẩm", e);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"An error occurred.\"}");
        }
    }

    /**
     * Trích xuất tên file từ đối tượng Part (file upload).
     */
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("Content-Disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding products";
    }
}
