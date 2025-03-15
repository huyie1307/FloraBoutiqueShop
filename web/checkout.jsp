<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Checkout - Xác thực đơn hàng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
            }
            .container {
                margin-top: 20px;
            }
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
            .customer-info {
                background-color: white;
                padding: 15px;
                border-radius: 5px;
                margin-top: 20px;
            }
            .customer-info h4 {
                margin-bottom: 20px;
                color: #FF0080;
            }
            .cart-header {
                display: flex;
                align-items: center;
                padding: 15px;
                background-color: white;
                border-bottom: 2px solid #eee;
                margin-top: 20px;
            }
            .cart-header .logo img {
                width: 100px;
                transition: transform 0.2s ease-in-out;
            }
            .cart-header .logo img:hover {
                transform: scale(1.05);
            }
            .cart-header h4 {
                margin-left: 20px;
                font-size: 24px;
                font-weight: bold;
                color: #FF0080;
            }
            .cart-table {
                margin-top: 20px;
            }
            .cart-table table {
                background-color: white;
                border-radius: 5px;
            }
            .price {
                color: red;
                font-weight: bold;
            }
            .quantity-box {
                width: 40px;
                text-align: center;
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
                margin: 0 30px;
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
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Nút quay lại giỏ hàng -->
            <div class="row">
                <div class="col-6">
                    <a class="custom-btn" href="listorder.jsp">
                        Quay trở lại giỏ hàng
                    </a>
                </div>
            </div>

            <!-- Thông tin khách hàng -->
            <div class="customer-info">
                <h4>Thông tin khách hàng</h4>
                <p><strong>Họ và tên:</strong> ${user.name}</p>
                <p><strong>Ngày sinh:</strong> ${user.dob}</p>
                <p><strong>Số điện thoại:</strong> ${user.phone}</p>
                <p><strong>Địa chỉ:</strong> ${user.address}</p>
            </div>

            <!-- Header giỏ hàng -->
            <div class="cart-header d-flex align-items-center">
                <a href="home.jsp" class="logo">
                    <img src="image/logo.png" alt="Logo">
                </a>
                <h4 class="mb-0 ms-3">Xác thực đơn hàng</h4>
            </div>

            <!-- Form thanh toán -->
            <form action="checkout" method="post">
                <div class="cart-table mt-3">
                    <c:set var="totalProducts" value="0" />
                    <c:set var="totalPrice" value="0" />
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Sản Phẩm</th>
                                <th>Đơn Giá</th>
                                <th>Số Lượng</th>
                                <th>Số Tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty carts}">
                                    <c:forEach items="${sessionScope.carts}" var="cart">
                                        <tr>
                                            <td class="d-flex align-items-center">
                                                <img src="${cart.product.imageUrl}" alt="${cart.product.name}" style="width: 87px; height: 67px;">
                                                <div class="ms-3">
                                                    <h6>${cart.product.name}</h6>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="price">
                                                    <fmt:formatNumber value="${cart.product.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </div>
                                            </td>
                                            <td>
                                                <input type="text" value="${cart.amount}" class="quantity-box mx-2" readonly>
                                            </td>
                                            <td class="price">
                                                <span class="row-total">
                                                    <fmt:formatNumber value="${cart.product.price * cart.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </span>
                                            </td>
                                        </tr>
                                        <!-- Cộng dồn tổng số sản phẩm và tổng tiền -->
                                        <c:set var="totalProducts" value="${totalProducts + cart.amount}" scope="page"/>
                                        <c:set var="totalPrice" value="${totalPrice + (cart.product.price * cart.amount)}" scope="page"/>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4" class="text-center">Không có sản phẩm trong giỏ hàng</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Lựa chọn phương thức thanh toán -->
                    <div class="payment-option">
                        <h5>Lựa chọn hình thức thanh toán</h5>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="directPayment" value="direct" checked>
                            <label class="form-check-label" for="directPayment">
                                Thanh toán trực tiếp
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="onlinePayment" value="online">
                            <label class="form-check-label" for="onlinePayment">
                                Thanh toán online
                            </label>
                        </div>
                    </div>

                    <!-- Tổng tiền và nút thanh toán -->
                    <div class="total-section">
                        <span id="totalPrice" class="total-text">
                            Số tiền: ₫<fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="" groupingUsed="true"/>
                        </span>
                        <button type="submit" class="checkout-btn">Thanh toán</button>
                    </div>
                </div>
            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </body>
</html>
