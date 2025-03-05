<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật Sản phẩm</title>
    <link rel="stylesheet" href="styles.css"> <!-- CSS nếu có -->
</head>
<body>
    <h2>Cập nhật Sản phẩm</h2>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty errorMessage}">
        <div style="color: red; font-weight: bold;">${errorMessage}</div>
    </c:if>

    <!-- Form cập nhật sản phẩm -->
    <form action="updateProduct" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${product.id}">

        <label for="name">Tên sản phẩm:</label>
        <input type="text" id="name" name="name" value="${product.name}" required><br>

        <label for="title">Tiêu đề:</label>
        <input type="text" id="title" name="title" value="${product.title}" required><br>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" rows="4" cols="50" required>${product.description}</textarea><br>

        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" value="${product.price}" step="0.01" required><br>

        <label for="amount">Số lượng:</label>
        <input type="number" id="amount" name="amount" value="${product.amount}" required><br>

        <label for="categoryId">Danh mục:</label>
        <select id="categoryId" name="categoryId" required>
            <c:forEach var="category" items="${categories}">
                <option value="${category.id}" ${category.id == product.category.id ? 'selected' : ''}>
                    ${category.name}
                </option>
            </c:forEach>
        </select><br>

        <label for="image">Ảnh sản phẩm:</label>
        <input type="file" id="image" name="image"><br>

        <!-- Hiển thị ảnh hiện tại nếu có -->
        <c:if test="${not empty product.image}">
            <img src="${product.image}" alt="Product Image" width="100"><br>
        </c:if>

        <!-- Lưu lại đường dẫn ảnh cũ nếu người dùng không thay đổi -->
        <input type="hidden" name="existingImage" value="${product.image}"><br>

        <input type="submit" value="Cập nhật sản phẩm">
    </form>

    <br>
    <a href="listProduct">Quay lại danh sách sản phẩm</a>
</body>
</html>
