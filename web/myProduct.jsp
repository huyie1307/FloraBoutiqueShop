<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="category" value="${param.category ne null ? param.category : sessionScope.category}" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dao.OrderDAO, entity.Product, java.util.List" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách sản phẩm</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .container {
                margin-top: 30px;
            }
            .table thead {
                background-color: #FF0080;
                color: white;
            }
            .table-hover tbody tr:hover {
                background-color: #ffe6f2;
            }
            .btn-custom {
                background-color: #FF0080;
                color: white;
                border-radius: 5px;
            }
            .btn-custom:hover {
                background-color: #cc0066;
            }
            .form-select, .form-control {
                border-radius: 5px;
            }
            .update-form {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <!-- Quay lại trang chủ -->
        <div class="container">
            <div class="row">
                <!-- Nút Quay lại trang chủ nằm hẳn bên trái -->
                <div class="col-6">
                    <a class="custom-btn" href="home">
                        Quay trở lại trang chủ
                    </a>
                </div>
            </div>
            <style>
                .custom-btn {
                    display: inline-block;
                    padding: 12px 24px;
                    background-color: #FF0080;
                    color: white;
                    font-size: 18px;
                    font-weight: bold;
                    text-decoration: none;
                    border-radius: 8px;
                    transition: background 0.3s ease-in-out;
                    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                }
                .custom-btn:hover {
                    background-color: #cc0066;
                    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
                }

            </style>
        </div>

        <!-- Logo -->
        <div class="container">
            <!-- Header -->
            <style>
                .cart-header {
                    display: flex;
                    align-items: center;
                    padding: 15px;
                    background-color: white;
                    border-bottom: 2px solid #eee;
                }
                .cart-header .logo img {
                    width: 100px;
                    transition: transform 0.2s ease-in-out;
                }
                .cart-header .logo img:hover {
                    transform: scale(1.05); /* Hiệu ứng phóng to nhẹ */
                }
                .cart-header h4 {
                    margin-left: 20px; /* Tăng khoảng cách */
                    font-size: 24px;
                    font-weight: bold;
                    color: #FF0080; /* Màu nổi bật hơn */
                }

                .product-card {
                    background: #fff;
                    padding: 15px;
                    border-radius: 8px;
                    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                }
                .product-image {
                    width: 100px;
                    height: 100px;
                    object-fit: cover;
                    border-radius: 5px;
                }
                .product-info {
                    margin-left: 15px;
                }
                .product-name {
                    font-weight: bold;
                    font-size: 18px;
                }
                .product-type, .product-amount {
                    font-size: 14px;
                }
                .product-price {
                    font-size: 20px;
                    font-weight: bold;
                    color: red;
                }

                .add-to-cart-btn {
                    display: inline-block;
                    background-color: #FF0080; /* Màu hồng */
                    color: white;
                    font-size: 16px;
                    font-weight: bold;
                    padding: 10px 18px;
                    border: none;
                    border-radius: 8px;
                    cursor: pointer;
                    transition: background 0.3s ease-in-out, transform 0.2s ease-in-out;
                    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                }

                .add-to-cart-btn:hover {
                    background-color: #cc0066; /* Màu hồng đậm hơn khi hover */
                    transform: scale(1.05); /* Phóng to nhẹ */
                    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
                }


            </style>

            <div class="cart-header d-flex align-items-center">
                <a href="index.html" class="logo">
                    <img src="image/logo.png" alt="Logo">
                </a>
                <h4 class="mb-0 ms-3">Danh sách sản phẩm</h4>
            </div>
        </div>
        <div class="container">
            <!-- Dropdown chọn danh mục -->
            <div class="card p-3 mb-4">
                <h5>Chọn danh mục</h5>
                <form action="flowerz" method="get">
                    <select name="category" class="form-select" onchange="this.form.submit()">
                        <option value="all" ${category == 'all' ? 'selected' : ''}>Tất cả</option>
                        <option value="custom" ${category == 'custom' ? 'selected' : ''}>Custom Flowers</option>
                        <option value="funeral" ${category == 'funeral' ? 'selected' : ''}>Funeral Flowers</option>
                        <option value="service" ${category == 'service' ? 'selected' : ''}>Service Flowers</option>
                    </select>
                </form>
            </div>
        </div>

        <!-- Bảng danh sách sản phẩm -->
        <div class="container mt-4">
            <div class="row">
                <c:forEach var="p" items="${products}">
                    <div class="col-lg-2 col-md-3 col-sm-6 mb-3 product-item">
                        <div class="product-card text-center">
                            <img src="${p.getImageUrl()}" alt="${p.getName()}" class="product-image img-fluid">
                            <div class="product-info">
                                <h5 class="product-name">
                                    <a href="productDetail?flowerId=${p.getFlowerId()}">${p.getName()}</a>
                                </h5>
                                <p class="product-type">TYPE: ${p.getCategory().getName()}</p>
                                <p class="product-price">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                </p>
                                <button class="add-to-cart-btn" data-product-id="${p.flowerId}">ADD TO CART</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                        $(document).ready(function () {
                            $(".add-to-cart-btn").on("click", function () {
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
