/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.ReviewDAO;
import entity.Review;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class ReviewDetailController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         // Lấy id của review từ request
        int reviewId = Integer.parseInt(request.getParameter("id"));
        
        // Tạo đối tượng ReviewDAO để lấy review từ cơ sở dữ liệu
        ReviewDAO reviewDAO = new ReviewDAO();
        try {
            // Lấy chi tiết review
            Review review = reviewDAO.getReviewById(reviewId);
            
            // Nếu không tìm thấy review, trả về thông báo lỗi
            if (review == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Review not found.");
                return;
            }
            
            // Lưu đối tượng review vào request để truyền dữ liệu đến JSP
            request.setAttribute("review", review);
            
            // Chuyển hướng đến trang reviewDetail.jsp
            request.getRequestDispatcher("reviewDetail.jsp").forward(request, response);
        }  catch (SQLException e){
            
        }
    
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
