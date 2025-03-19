package controller;

import dao.CustomerDAO;
import entity.User;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateCustomerController extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();  // Khởi tạo customerDAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID khách hàng từ tham số URL
            int customerId = Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin khách hàng từ DAO
            User user = customerDAO.getCustomerById(customerId);

            if (user != null) {
                // Đặt thông tin khách hàng vào request và chuyển đến trang sửa thông tin
                request.setAttribute("user", user);
                request.getRequestDispatcher("updateCustomer.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy khách hàng, chuyển đến trang lỗi
                request.setAttribute("errorMessage", "Khách hàng không tồn tại!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi lấy thông tin khách hàng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // Phương thức xử lý yêu cầu POST (cập nhật thông tin khách hàng)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin khách hàng từ biểu mẫu (form) gửi lên
            int customerId = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");

            // Chuyển đổi ngày sinh từ String sang java.sql.Date
            String dobString = request.getParameter("dob");  // Nhận giá trị ngày sinh dưới dạng String
            java.sql.Date dob = null;

            if (dobString != null && !dobString.isEmpty()) {
                // Chuyển đổi định dạng ngày tháng từ String sang Date
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    java.util.Date parsedDate = dateFormat.parse(dobString);
                    dob = new java.sql.Date(parsedDate.getTime());  // Chuyển thành java.sql.Date
                } catch (ParseException e) {
                    request.setAttribute("errorMessage", "Ngày sinh không hợp lệ.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }
            }

            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Tạo đối tượng User mới và thiết lập các thuộc tính
            User user = new User();
            user.setuID(customerId);  // Gán ID khách hàng
            user.setName(name);
            user.setDob(dob);  // Gán dob kiểu java.sql.Date
            user.setPhone(phone);
            user.setAddress(address);

            // Gọi DAO để cập nhật thông tin khách hàng
            customerDAO.updateCustomer(user);

            // Sau khi cập nhật thành công, chuyển về trang danh sách khách hàng
            response.sendRedirect("listCustomer");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi cập nhật thông tin khách hàng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
