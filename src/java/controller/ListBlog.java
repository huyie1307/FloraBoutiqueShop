package controller;

import dao.BlogDAO;
import entity.Blog;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ListBlog extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();
        List<Blog> listBlog = blogDAO.getAllBlogs();

        request.setAttribute("blogs", listBlog);
        request.getRequestDispatcher("Blog.jsp").forward(request, response);
    }
}
