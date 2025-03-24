package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "Update", urlPatterns = {"/update"})
public class UpdateProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        int uID = Integer.parseInt(request.getParameter("uID"));
        String name = request.getParameter("name");
        String dobStr = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Chuyển đổi ngày sinh từ String sang Date
        Date dob = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dob = sdf.parse(dobStr);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        // Tạo đối tượng User với thông tin mới
        User user = new User();
        user.setuID(uID);
        user.setName(name);
        user.setDob(dob);
        user.setPhone(phone);
        user.setAddress(address);

        // Gọi UserDAO để cập nhật thông tin người dùng
        UserDAO userDAO = new UserDAO();
        boolean isUpdated = userDAO.updateUser(user);

        if (isUpdated) {
            // 🚀 Lấy lại thông tin user từ database sau khi cập nhật
            User updatedUser = userDAO.getUserById(uID);
            
            // 🛠 Cập nhật lại session với thông tin mới
            HttpSession session = request.getSession();
            session.setAttribute("user", updatedUser);

            request.setAttribute("message", "Cập nhật thành công!");
        } else {
            request.setAttribute("message", "Cập nhật thất bại!");
        }

        // Chuyển hướng về trang thông tin người dùng
        request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
    }
}