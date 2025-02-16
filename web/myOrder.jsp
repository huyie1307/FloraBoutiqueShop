<%-- 
    Document   : myOrder
    Created on : Feb 16, 2025, 12:07:03 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <title>My Order</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
            }
            .container {
                margin-top: 20px;
            }
            .cart-header {
                background-color: white;
                padding: 15px;
                border-radius: 5px;
            }
            .cart-item {
                background-color: white;
                padding: 15px;
                margin-top: 10px;
                border-radius: 5px;
            }
            .cart-item img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 5px;
            }
            .delete-btn {
                color: red;
                font-weight: bold;
                cursor: pointer;
            }
            .delete-btn:hover {
                text-decoration: underline;
            }

            .price {
                color: red;
                font-weight: bold;
            }

            .total-section {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                background-color: white;
                padding: 15px;
                border-radius: 5px;
                margin-top: 15px;
            }

            .total-text {
                font-size: 16px;
                margin: 0 30px; /* Tăng khoảng cách giữa các phần tử */
            }

            .checkout-btn {
                background-color: red;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }
            .checkout-btn:hover {
                background-color: darkred;
            }

            .quantity-box {
                width: 40px;
                text-align: center;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <!-- Nút Quay lại trang chủ nằm hẳn bên trái -->
                <div class="col-6">
                    <a class="custom-btn" href="index.html">
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
            </style>

            <div class="cart-header d-flex align-items-center">
                <a href="index.html" class="logo">
                    <img src="image/logo.png" alt="Logo">
                </a>
                <h4 class="mb-0 ms-3">Giỏ Hàng</h4>
            </div>

            <div class="cart-table mt-3">
                <table class="table">
                    <thead>
                        <tr>
                            <th><input type="checkbox"></th>
                            <th>Sản Phẩm</th>
                            <th>Đơn Giá</th>
                            <th>Số Lượng</th>
                            <th>Số Tiền</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="checkbox"></td>
                            <td class="d-flex align-items-center">
                                <img src="image/OIP.jpg" alt="Sản phẩm" style="width: 87px; height: 67px;">
                                <div class="ms-3">
                                    <h6>Sunflower</h6>
                                    <span class="text-muted">Type: Service</span>
                                </div>
                            </td>
                            <td>
                                <div class="price">₫500.000</div>
                            </td>
                            <td>
                                <button class="btn btn-outline-secondary btn-sm">−</button>
                                <input type="text" value="1" class="quantity-box mx-2">
                                <button class="btn btn-outline-secondary btn-sm">+</button>
                            </td>
                            <td class="price">₫500.000</td>
                            <td><span class="delete-btn">Xóa</span></td>
                        </tr>
                    </tbody>
                </table>
                <div class="total-section">
                    <span id="totalProducts" class="total-text">Tổng số sản phẩm: 1</span>
                    <span id="totalPrice" class="total-text">Số tiền: ₫500.000</span>
                    <button class="checkout-btn">Thanh toán</button>
                </div>
            </div>

            <script>
                function updateTotal() {
                    let totalProducts = 0;
                    let totalPrice = 0;

                    document.querySelectorAll('.product-checkbox:checked').forEach((checkbox) => {
                        let row = checkbox.closest("tr");
                        let quantity = parseInt(row.querySelector(".quantity").value);
                        let price = parseInt(row.querySelector(".price-new").textContent.replace(/[^\d]/g, ''));

                        totalProducts += quantity;
                        totalPrice += quantity * price;
                    });

                    document.getElementById("totalProducts").textContent = `Tổng số sản phẩm: ${totalProducts}`;
                    document.getElementById("totalPrice").textContent = `Số tiền: ₫${totalPrice.toLocaleString()}`;
                }

                document.querySelectorAll('.quantity').forEach(input => {
                    input.addEventListener('input', updateTotal);
                });

                document.querySelectorAll('.increase').forEach(btn => {
                    btn.addEventListener('click', function () {
                        let input = this.parentNode.querySelector('.quantity');
                        input.value = parseInt(input.value) + 1;
                        updateTotal();
                    });
                });

                document.querySelectorAll('.decrease').forEach(btn => {
                    btn.addEventListener('click', function () {
                        let input = this.parentNode.querySelector('.quantity');
                        if (parseInt(input.value) > 1) {
                            input.value = parseInt(input.value) - 1;
                            updateTotal();
                        }
                    });
                });

                document.querySelectorAll('.product-checkbox').forEach(checkbox => {
                    checkbox.addEventListener('change', updateTotal);
                });

                document.getElementById('selectAll').addEventListener('change', function () {
                    document.querySelectorAll('.product-checkbox').forEach(checkbox => {
                        checkbox.checked = this.checked;
                    });
                    updateTotal();
                });
            </script>

            <h1>Hello World!</h1>
    </body>
</html>
