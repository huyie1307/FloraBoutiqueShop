<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đổi Mật Khẩu</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background: url('image/userbg.avif') no-repeat center center fixed;
                background-size: cover;
            }
            .container-fluid {
                margin-top: 50px;
            }
            .sidebar {
                height: 100vh;
                background: #f8f9fa;
                padding: 20px;
                border-right: 1px solid #dee2e6;
                position: fixed;
                left: -250px;
                width: 250px;
                transition: left 0.3s;
            }
            .sidebar.show {
                left: 0;
            }
            .toggle-btn {
                position: absolute;
                top: 10px;
                left: 10px;
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
            }
            .content-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                width: 100%;
            }
            .content {
                max-width: 400px;
                width: 100%;
                padding: 20px;
                background: white;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }
            .btn-success {
                background-color: #d63384;
                border-color: #d63384;
            }
            .btn-success:hover, .btn-success:active, .btn-success:focus {
                background-color: #b82b6e !important;
                border-color: #b82b6e !important;
                box-shadow: none !important;
            }
        </style>
    </head>
    <body>
        <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
        <div class="sidebar" id="sidebar">
            <h4>Quản lý tài khoản</h4>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="UserProfile.jsp">Thông tin cá nhân</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="change-password.jsp">Đổi mật khẩu</a>
                </li>
            </ul>
        </div>
        <div class="content-container">
            <main class="content">
                <h2 class="text-center">Đổi Mật Khẩu</h2>
                <c:if test="${not empty message}">
                    <div class="alert alert-info">${message}</div>
                </c:if>
                <form action="changePassword" method="post">
                    <input type="hidden" name="uID" value="${user.uID}">
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu hiện tại</label>
                        <input type="password" name="currentPassword" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới</label>
                        <input type="password" name="newPassword" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Xác nhận mật khẩu mới</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Đổi mật khẩu</button>
                </form>
                <a href="home.jsp" class="btn btn-secondary w-100 mt-3">Quay lại</a>
            </main>
        </div>
        <script>
            function toggleSidebar() {
                document.getElementById("sidebar").classList.toggle("show");
            }
        </script>
    </body>
</html>
