    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.LoginDAO;
import entity.Account;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hiepg
 */
public class Signin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        LoginDAO loginDAO = new LoginDAO();
        Account account = loginDAO.checkAccountExist(username);
        if (account != null) {
            request.setAttribute("message", "Thông tin đăng kí không hợp lệ. Vui lòng thử lại");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            loginDAO.signup(username, password, name, phone);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

}