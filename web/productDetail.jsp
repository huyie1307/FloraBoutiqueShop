
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                position: relative;
            }
            .product-container {
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
            }
            .product-card {
                display: flex;
                flex-wrap: wrap;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                max-width: 900px;
                position: relative;
                padding-bottom: 60px; /* Để tránh che nút */
            }
            .product-img {
                width: 50%;
                height: auto;
                object-fit: cover;
            }
            .product-details {
                width: 50%;
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .product-price {
                font-size: 24px;
                font-weight: bold;
                color: #d0021b;
            }
            .btn-cart {
                background-color: #ff5722;
                color: white;
                position: absolute;
                bottom: 10px;
                right: 10px;
                width: auto;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 8px;
            }
            .btn-cart:hover {
                background-color: #e64a19;
            }
            .btn-back {
                position: absolute;
                top: 10px;
                left: 10px;
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
            .btn-back:hover {
                background-color: #cc0066;
                box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>
    <body>

        <a class="btn-back" href="home.jsp">Quay lại trang chủ</a>
        <div class="container product-container">
            <c:if test="${not empty productDetail}">
                <div class="product-card">
                    <img src="${productDetail.getImageUrl()}" class="product-img" alt="${productDetail.getName()}">
                    <div class="product-details">
                        <h2>${productDetail.getName()}</h2>
                        <p><strong>Loại:</strong> ${productDetail.getCategory()}</p>
                        <p><strong>Mô tả:</strong> ${productDetail.getDescription()}</p>
                        <p class="product-price">${productDetail.getPrice()} VNĐ</p>
                        <a href="myOrder.jsp?productId=${productDetail.getFlowerId()}" class="btn btn-cart">Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty productDetail}">
                <p class="text-danger text-center w-100">Sản phẩm không tồn tại.</p>
            </c:if>
        </div>
    </body>
</html>
