package controller;
import entity.User;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class UserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

     @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");

    if (action != null) {
        if (action.equals("delete")) {
            // Xóa user
            int uID = Integer.parseInt(request.getParameter("uID"));
            userDAO.deleteUser(uID);
            response.sendRedirect("user");
            return;
        } else if (action.equals("search")) {
            // Tìm kiếm user
            String keyword = request.getParameter("keyword");
            List<User> users = userDAO.searchUsers(keyword);
            request.setAttribute("users", users);
            request.getRequestDispatcher("Customer.jsp").forward(request, response);
            return;
        }
    }

    // Nếu không có action, lấy toàn bộ danh sách user
    List<User> users = userDAO.getAllUsers();
    request.setAttribute("users", users);
    request.getRequestDispatcher("Customer.jsp").forward(request, response);
}


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");

    if (action != null && action.equals("add")) {
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String dobStr = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String isAdminStr = request.getParameter("isAdmin");
        String isSellStr = request.getParameter("isSell");

        // Kiểm tra input có bị null hoặc rỗng không
        if (username == null || username.isEmpty() ||
            password == null || password.isEmpty() ||
            name == null || name.isEmpty() ||
            dobStr == null || dobStr.isEmpty() ||
            phone == null || phone.isEmpty() ||
            address == null || address.isEmpty()) {

            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("AddUser.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi ngày sinh từ String sang java.sql.Date
        java.sql.Date dob = null;
        try {
            dob = java.sql.Date.valueOf(dobStr); // Định dạng phải là yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ!");
            request.getRequestDispatcher("AddUser.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi giá trị của isAdmin và isSell từ String sang boolean
        boolean isAdmin = Boolean.parseBoolean(isAdminStr);
        boolean isSell = Boolean.parseBoolean(isSellStr);

        // Tạo đối tượng User
        User newUser = new User(0, username, password, isSell, isAdmin, name, dob, phone, address);

        // Gọi DAO để thêm user vào database
        boolean success = userDAO.addUser(newUser);

        if (success) {
            response.sendRedirect("user"); // Chuyển hướng đến trang danh sách user
        } else {
            request.setAttribute("error", "Thêm người dùng thất bại! Kiểm tra lại thông tin.");
            request.getRequestDispatcher("AddUser.jsp").forward(request, response);
        }
    }
}


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
