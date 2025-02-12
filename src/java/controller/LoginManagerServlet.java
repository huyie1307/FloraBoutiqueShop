package controller;



import dao.LoginDAO;
import dao.*;
import entity.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

public class LoginManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("user");
        String password = request.getParameter("pass");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            request.setAttribute("message", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        LoginDAO loginDAO = new LoginDAO();
        Account account = loginDAO.login(username, password);

        if (account == null) {
            request.setAttribute("message", "Thông tin đăng nhập không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            User user = loginDAO.getUserLogin(username);
            session.setAttribute("user", user);
            session.setAttribute("account", account);
            session.setMaxInactiveInterval(1800); // Session 30 phút

            response.sendRedirect("index.html"); // Redirect thay vì forward
        }
    }
}
