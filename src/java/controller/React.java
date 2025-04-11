package controller;

import dao.LikeDAO;
import dao.CommentDAO;
import entity.Comment;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
        String action = request.getParameter("action");

        if ("like".equals(action)) {
            int blogID = Integer.parseInt(request.getParameter("blogID"));

            // Tăng số like trong bảng Blog
            likeDAO.incrementLikeCount(blogID);

            // Lấy số like mới
            int newLikeCount = likeDAO.getLikeCount(blogID);

            // Trả về số like mới cho JavaScript
            response.getWriter().write(String.valueOf(newLikeCount));
        } else if ("comment".equals(action)) {
            int blogID = Integer.parseInt(request.getParameter("blogID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            String content = request.getParameter("content");
            String userName = request.getParameter("userName");

            // Tạo và thêm bình luận vào database
            Comment comment = new Comment(0, userID, blogID, content, userName);
            commentDAO.addComment(comment);

            // Sau khi thêm bình luận, chuyển hướng lại trang chi tiết blog để hiển thị bình luận mới
            response.sendRedirect("listBlog?blogID=" + blogID);  // Chuyển hướng lại trang blog chi tiết
        }
    }
}
