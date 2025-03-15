<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm</title>
    <%= request.getAttribute("flowerList") %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center text-primary">Danh sách sản phẩm</h2>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên hoa</th>
                    <th>Danh mục</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Hình ảnh</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="products" items="${products}">
                    <tr>
                        <td>${products.flowerId}</td>
                        <td>${products.name}</td>
                        <td>${products.category}</td>
                        <td>₫${products.price}</td>
                        <td>${products.quantity}</td>
                        <td><img src="${products.imageUrl}" alt="Hình ảnh hoa" width="80"></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
