package controller;

import dao.LikeDAO;
import dao.CommentDAO;
import entity.Comment;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class React extends HttpServlet {

    private LikeDAO likeDAO;
    private CommentDAO commentDAO;

    @Override
    public void init() {
        likeDAO = new LikeDAO();
        commentDAO = new CommentDAO();
    }

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
}
