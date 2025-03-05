/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author admin
 */
import dao.OrderDetailDAO;
import dao.ReviewDAO;
import entity.Account;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Review;
import jakarta.servlet.http.HttpSession;
/**
 *
 * @author daoducdanh
 */
@WebServlet(name = "CreateReviewController", urlPatterns = {"/create-review"})
public class CreateReviewController extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
        
        int rating = Integer.parseInt(request.getParameter("rating"));
        String content = request.getParameter("content");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int orderDetailId = Integer.parseInt(request.getParameter("orderDetailId"));
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        Review review = new Review(rating, content, account, new Product(productId));
        int reviewId = reviewDAO.insertReview(review);
        
        orderDetailDAO.updateReviewIdInOrderDetail(orderDetailId, reviewId);
        
        response.sendRedirect("/WebApplication1/my-order");
        
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