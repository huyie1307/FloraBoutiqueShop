
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            /* Tổng thể trang */
            body {
                background-color: #f9f9f9;
                font-family: Arial, sans-serif;
            }

            /* Header */
            .header-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 20px;
                position: relative;
            }

            /* Logo */
            .cart-header {
                display: flex;
                align-items: center;
                padding: 15px 0;
                border-bottom: 2px solid #ddd;
                width: 80%;
                justify-content: center;
            }

            .logo img {
                height: 50px;
            }

            /* Nút quay lại */
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

            /* Container sản phẩm */
            .product-container {
                width: 80%;
                margin: 20px auto;
                padding: 20px;
                border-radius: 10px;
                background: white;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }

            /* Bố cục sản phẩm */
            .product-card {
                display: flex;
                justify-content: space-between;
                align-items: stretch;
                border: 2px solid #ddd;
                padding: 20px;
                border-radius: 10px;
            }

            /* Phần bên trái (Ảnh) */
            .product-left {
                width: 40%;
            }

            .product-image img {
                width: 100%;
                max-width: 350px;
                border-radius: 10px;
            }

            /* Phần bên phải (Tên, Giá, Nút) */
            .product-right {
                width: 55%;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            /* Tên sản phẩm (Nằm cạnh trên cùng của ảnh) */
            .product-top {
                width: 100%;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .product-name {
                font-size: 24px;
                font-weight: bold;
                color: #333;
                margin-right: auto;
            }

            .product-price {
                font-size: 24px;
                font-weight: bold;
                color: red;
                text-align: right;
            }

            /* Nút giỏ hàng (Dưới cùng bên phải) */
            .product-bottom {
                display: flex;
                justify-content: flex-end;
            }

            .btn-cart {
                background-color: #ff5722;
                color: white;
                border: none;
                padding: 10px 15px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-cart:hover {
                background-color: #e64a19;
            }

            /* Chi tiết sản phẩm */
            .product-details {
                width: 100%;
                margin-top: 20px;
                text-align: left;
            }

            .product-details h3 {
                font-size: 22px;
                border-bottom: 2px solid #ddd;
                padding-bottom: 10px;
            }

            .product-details p {
                font-size: 16px;
                margin: 5px 0;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="header-container">
            <a class="btn-back" href="home.jsp">Quay lại trang chủ</a>
            <div class="cart-header">
                <a href="index.html" class="logo">
                    <img src="image/logo.png" alt="Logo">
                </a>
                <h4 class="mb-0 ms-3">Chi tiết sản phẩm</h4>
            </div>
        </div>

        <!-- Nội dung sản phẩm -->
        <div class="container product-container">
            <c:if test="${not empty productDetail}">
                <div class="product-card">
                    <!-- Ảnh sản phẩm (Bên trái) -->
                    <div class="product-left">
                        <div class="product-image">
                            <img src="${productDetail.getImageUrl()}" class="product-img" alt="${productDetail.getName()}">
                        </div>
                    </div>

                    <!-- Tên sản phẩm, Giá và Nút giỏ hàng (Bên phải) -->
                    <div class="product-right">
                        <div class="product-top">
                            <h2 class="product-name">${productDetail.getName()}</h2>
                            <p class="product-price">${productDetail.getPrice()} VNĐ</p>
                        </div>
                        <div class="product-bottom">
                            <button class="btn btn-cart" data-product-id="${productDetail.flowerId}">ADD TO CART</button>
                        </div>
                    </div>
                </div>

                <!-- Chi tiết sản phẩm -->
                <div class="product-details">
                    <h3>Chi tiết sản phẩm</h3>
                    <p><strong>Danh mục:</strong> ${productDetail.getCategory().getName()}</p>
                    <p><strong>Loại:</strong> ${productDetail.getName()}</p>
                    <p><strong>Mô tả:</strong> ${productDetail.getDescription()}</p>
                    <p><strong>Gửi từ:</strong> Hà Nội</p>
                </div>
                <!-- Đánh giá sản phẩm -->
                <div class="product-details">
                    <h3>Đánh giá sản phẩm</h3>
                    <p><strong>Danh mục:</strong> ${productDetail.getCategory().getName()}</p>
                    <p><strong>Loại:</strong> ${productDetail.getName()}</p>
                    <p><strong>Mô tả:</strong> ${productDetail.getDescription()}</p>
                    <p><strong>Gửi từ:</strong> Hà Nội</p>
                </div>
            </c:if>
            <c:if test="${empty productDetail}">
                <p class="text-danger text-center w-100">Sản phẩm không tồn tại.</p>
            </c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $(".btn-cart").on("click", function () {
                    let productId = $(this).data("product-id");
                    $.ajax({
                        url: "addToCart",
                        type: "POST",
                        data: {pid: productId},
                        success: function (response) {
                            response = response.trim();
                            if (response === "success") {
                                showNotification("Sản phẩm đã được thêm vào giỏ hàng!", "success");
                            } else if (response === "not_logged_in") {
                                window.location.href = "login"; // Chuyển hướng khi chưa đăng nhập
                            } else {
                                showNotification("Thêm sản phẩm thất bại!", "error");
                            }
                        },
                        error: function () {
                            showNotification("Có lỗi xảy ra, vui lòng thử lại.", "error");
                        }
                    });
                });

                // Hàm hiển thị thông báo
                function showNotification(message, type) {
                    let bgColor = type === "success" ? "#28a745" : "#dc3545";
                    let progressColor = type === "success" ? "#ffffff" : "#ff9999";

                    // Tạo thông báo
                    let notification = $("<div></div>", {
                        class: "cart-notification",
                        text: message,
                        css: {
                            "position": "fixed",
                            "top": "-60px",
                            "left": "50%",
                            "transform": "translateX(-50%)",
                            "padding": "12px 25px",
                            "background": bgColor,
                            "color": "white",
                            "border-radius": "10px",
                            "z-index": "1000",
                            "font-weight": "bold",
                            "box-shadow": "0px 4px 10px rgba(0, 0, 0, 0.2)",
                            "min-width": "280px",
                            "text-align": "center",
                            "opacity": "0",
                            "transition": "opacity 0.3s ease-in-out, top 0.3s ease-in-out"
                        }
                    });

                    // Thanh trượt
                    let progressBar = $("<div></div>", {
                        class: "progress-bar",
                        css: {
                            "position": "absolute",
                            "bottom": "0",
                            "left": "0",
                            "height": "4px",
                            "background": progressColor,
                            "width": "0%",
                            "border-radius": "0 0 10px 10px",
                            "transition": "width 2s linear"
                        }
                    });

                    notification.append(progressBar);
                    $("body").append(notification);

                    // Hiển thị thông báo
                    setTimeout(() => {
                        notification.css({"top": "20px", "opacity": "1"});
                        progressBar.css("width", "100%");
                    }, 100);

                    // Sau 3 giây, làm mờ dần rồi biến mất
                    setTimeout(() => {
                        notification.css({"opacity": "0", "top": "-60px"});
                        setTimeout(() => notification.remove(), 200);
                    }, 2000);
                }
            });
        </script>
    </body>

</html>
