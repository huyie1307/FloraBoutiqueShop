package controller;

import entity.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Admin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Lấy session hiện tại, nếu không có thì chuyển hướng đến trang đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Lấy đối tượng Account từ session
        Account account = (Account) session.getAttribute("account");
        
        // Kiểm tra quyền admin
        if (!account.isIsAdmin()) {
            // Nếu không phải admin, chuyển hướng đến trang báo lỗi hoặc trang không có quyền
            response.sendRedirect("404.jsp");
            return;
        }
        
        // Nếu đủ quyền, chuyển tiếp đến trang Admin.jsp
        request.getRequestDispatcher("Admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
