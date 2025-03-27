/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class DeleteProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID sản phẩm cần xóa từ tham số URL
            int productId = Integer.parseInt(request.getParameter("id"));

            // Xóa sản phẩm từ cơ sở dữ liệu
            boolean isDeleted = productDAO.deleteProduct(productId);

            // Kiểm tra nếu xóa thành công
            if (isDeleted) {
                // Nếu xóa thành công, chuyển hướng về trang listProduct.jsp
                response.sendRedirect("adminListProduct");
            } else {
                // Nếu xóa thất bại, hiển thị thông báo lỗi
                request.setAttribute("errorMessage", "Không thể xóa sản phẩm!");
                request.getRequestDispatcher("listProduct.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi xóa sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("product.jsp").forward(request, response);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
