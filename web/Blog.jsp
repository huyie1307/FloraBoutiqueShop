<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="checkLogin.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Blog</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 100vh;
                margin: auto;
                background-color: #f4f4f4;
            }
            .header {
                width: 100%;
                background-color: #fff;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .header-center {
                flex: 1;
                text-align: center;
            }
            .header-center img {
                height: 50px;
            }
            .header-right {
                display: flex;
                align-items: center;
            }
            .user-name {
                color: #e72463;
                font-size: 20px;
                text-align: center;
                display: block;
                text-decoration: none;
            }
            .btn-back {
                background-color: #FF0080;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none;
                border-radius: 8px;
                transition: background 0.3s ease-in-out;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }
            .blog-container {
                width: 50%;
                max-width: 800px;
                background: white;
                padding: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                margin-top: 20px;
            }
            .post {
                border: 1px solid #ccc;
                padding: 10px;
                margin: 10px 0;
                background: #fff;
                border-radius: 5px;
            }
            .post img {
                width: 100%;
                height: auto;
                object-fit: cover;
                display: block;
                margin: 10px 0;
                border-radius: 5px;
            }
            .comment-box {
                margin-top: 10px;
            }
            .comment {
                margin-left: 20px;
                color: #555;
            }
            .heart {
                cursor: pointer;
                font-size: 24px;
            }

            .heart.liked {
                color: red;
            }

        </style>
    </style>
</head>
<body>
    <div class="header">
        <a class="btn-back" href="home.jsp">Quay lại trang chủ</a>
        <div class="header-center">
            <img src="image/logo.png" alt="Logo">
        </div>
        <div class="header-right">
            <a href="UserProfile.jsp" class="user-name">👤</a>
            <a href="UserProfile.jsp" class="user-name">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        ${sessionScope.user.name}
                    </c:when>
                    <c:otherwise>
                        Khách
                    </c:otherwise>
                </c:choose>
            </a>
        </div>
    </div>

    <div class="blog-container">
        <h2 style="text-align: center;">Blog</h2>
        <c:choose>
            <c:when test="${empty blogs}">
                <p style="text-align: center;">Không có bài viết nào.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="blog" items="${blogs}">
                    <%
                        dao.LikeDAO likeDAO = new dao.LikeDAO();
                        boolean liked = false;
                        entity.User currentUser = (entity.User) session.getAttribute("user");
                        if (currentUser != null) {
                            liked = likeDAO.hasUserLiked(((entity.Blog)pageContext.findAttribute("blog")).getBlogID(), currentUser.getuID());
                        } 
                    %>
                    <div class="post">
                        <p><strong>Người đăng:</strong> ${blog.author}</p>
                        <p><strong>Tiêu đề:</strong> ${blog.title}</p>
                        <p>${blog.content}</p>
                        <c:if test="${not empty blog.imageURL}">
                            <img src="${blog.imageURL}" alt="Hình ảnh bài đăng">
                        </c:if>

                        <!-- Nút like (đã cập nhật có điều kiện liked) -->
                        <button class="heart <%= liked ? "liked" : "" %>" data-blogid="${blog.blogID}">❤️</button>
                        <span id="like-count-${blog.blogID}">${blog.likeCount}</span> lượt thích

                        <!-- Form bình luận -->
                        <form action="react" method="post">
                            <input type="text" name="content" placeholder="Viết bình luận..." required />
                            <input type="hidden" name="blogID" value="${blog.blogID}" />
                            <input type="hidden" name="userID" value="${sessionScope.user.uID}" />
                            <input type="hidden" name="action" value="comment" />
                            <button type="submit">Gửi</button>
                        </form>

                        <div class="comments">
                            <c:forEach var="comment" items="${blog.comments}">
                                <div class="comment">
                                    <strong>${comment.userName}</strong>: ${comment.content}
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>           
    </div>
    <script>
        document.querySelectorAll('.heart').forEach(button => {
            button.addEventListener('click', function () {
                const blogID = this.getAttribute('data-blogid');
                const userID = '${sessionScope.user.uID}';
                const liked = this.classList.contains('liked');
                const action = liked ? 'unlike' : 'like';

                fetch('react', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'action=' + action + '&blogID=' + blogID + '&userID=' + userID
                })
                        .then(response => response.text())
                        .then(newLikeCount => {
                            document.getElementById('like-count-' + blogID).innerText = newLikeCount;
                            this.classList.toggle('liked');
                        });
            });
        });
    </script>

</body>
</html>
