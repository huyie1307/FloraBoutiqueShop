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

public class ChangePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp"); // Chưa đăng nhập thì quay lại trang login
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.changePassword(user.getuID(), currentPassword, newPassword);

        if (success) {
            request.setAttribute("message", "Đổi mật khẩu thành công!");
            request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Mật khẩu cũ không đúng!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        }
    }
}
