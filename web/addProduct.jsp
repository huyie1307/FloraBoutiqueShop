<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Sản Phẩm</title>
    </head>
    <body>
        <h2>Thêm Sản Phẩm</h2>

        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>

        <form action="addProduct" method="post" enctype="multipart/form-data">
            <label for="name">Tên sản phẩm:</label>
            <input type="text" name="name" required><br>

            <label for="title">Tiêu đề:</label>
            <input type="text" name="title" required><br>

            <label for="description">Mô tả:</label>
            <textarea name="description" required></textarea><br>

            <label for="categoryId">Danh mục:</label>
            <select name="categoryId" required>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.id}">${category.name}</option>
                </c:forEach>
            </select><br>

            <label for="price">Giá:</label>
            <input type="number" name="price" step="0.01" required><br>

            <label for="amount">Số lượng:</label>
            <input type="number" name="amount" required><br>

            <label for="image">Ảnh sản phẩm:</label>
            <input type="file" name="image" accept="image/*"><br>

            <button type="submit">Thêm Sản Phẩm</button>
        </form>
    </body>
</html>
