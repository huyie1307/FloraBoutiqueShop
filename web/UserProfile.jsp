<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>User Profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            .container {
                max-width: 600px;
                margin-top: 50px;
            }
            .btn-save {
                background-color: #28a745;
                color: white;
                border: none;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .btn-save:hover {
                background-color: #218838;
                transform: scale(1.05);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Thông tin người dùng</h2>
            <c:if test="${not empty user}">
                <form action="update" method="post">
                    <input type="hidden" name="uID" value="${user.uID}">
                    <div class="mb-3">
                        <label class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" value="${user.username}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Họ và Tên</label>
                        <input type="text" name="name" class="form-control" value="${user.name}" required>

                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày sinh</label>
                        <input type="date" name="dob" class="form-control" value="${user.dob}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" name="phone" class="form-control" value="${user.phone}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" name="address" class="form-control" value="${user.address}">
                    </div>
                    <button type="submit" class="btn btn-save w-100">Lưu thay đổi</button>
                </form>
            </c:if>
            <c:if test="${empty user}">
                <p class="text-danger text-center">Không tìm thấy thông tin người dùng.</p>
            </c:if>
            <a href="home.jsp" class="btn btn-secondary w-100 mt-3">Quay lại</a>
        </div>
        <c:if test="${not empty message}">
            <div class="alert alert-info">${message}</div>
        </c:if>

    </body>
</html>
