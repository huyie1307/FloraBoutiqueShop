/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.CommentDAO;
import dao.LikeDAO;
import entity.Comment;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class ReactController extends HttpServlet {
   
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
       private LikeDAO likeDAO = new LikeDAO();
    private CommentDAO commentDAO = new CommentDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Chưa đăng nhập → chuyển hướng sang login.jsp
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("like".equals(action)) {
            int blogID = Integer.parseInt(request.getParameter("blogID"));
            int userID = Integer.parseInt(request.getParameter("userID"));

            likeDAO.insertLike(blogID, userID);
            likeDAO.incrementLikeCount(blogID);

            int newLikeCount = likeDAO.getLikeCount(blogID);
            response.getWriter().write(String.valueOf(newLikeCount));

        } else if ("unlike".equals(action)) {
            int blogID = Integer.parseInt(request.getParameter("blogID"));
            int userID = Integer.parseInt(request.getParameter("userID"));

            likeDAO.removeLike(blogID, userID);
            likeDAO.decrementLikeCount(blogID);

            int newLikeCount = likeDAO.getLikeCount(blogID);
            response.getWriter().write(String.valueOf(newLikeCount));

        } else if ("comment".equals(action)) {
            int blogID = Integer.parseInt(request.getParameter("blogID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            String content = request.getParameter("content");
            String userName = request.getParameter("userName");

            Comment comment = new Comment(0, userID, blogID, content, userName);
            commentDAO.addComment(comment);

            response.sendRedirect("listBlog?blogID=" + blogID);
        }
    
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
