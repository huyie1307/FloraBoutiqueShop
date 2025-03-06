<%-- 
    Document   : myOrder
    Created on : Feb 16, 2025, 12:07:03 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Order</title>
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
            .cart-header, .cart-item, .total-section {
                background-color: white;
                padding: 15px;
                border-radius: 5px;
            }
            .cart-header {
                display: flex;
                align-items: center;
                border-bottom: 2px solid #eee;
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
                margin-top: 15px;
            }
            .total-text {
                font-size: 16px;
                margin: 0 30px;
                color: black;
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
            .delete-btn {
                color: red;
                font-weight: bold;
                cursor: pointer;
            }
            .delete-btn:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row mb-3">
                <div class="col-6">
                    <a class="custom-btn" href="home">Quay trở lại trang chủ</a>
                </div>
            </div>
            <div class="cart-header">
                <a href="home" class="logo">
                    <img src="image/logo.png" alt="Logo">
                </a>
                <h4 class="mb-0 ms-3">Giỏ Hàng</h4>
            </div>
            <div class="cart-table mt-3">
                <table class="table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="selectAll"></th>
                            <th>Sản Phẩm</th>
                            <th>Đơn Giá</th>
                            <th>Số Lượng</th>
                            <th>Số Tiền</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty carts}">
                                <c:forEach items="${carts}" var="cart">
                                    <tr data-cart-id="${cart.id}" data-unit-price="${cart.product.price}">
                                        <td>
                                            <input type="checkbox" class="product-checkbox" name="cartCheckbox" value="${cart.id}">
                                        </td>
                                        <td class="d-flex align-items-center">
                                            <img src="${cart.product.imageUrl}" alt="${cart.product.name}" style="width: 87px; height: 67px;">
                                            <div class="ms-3">
                                                <h6>${cart.product.name}</h6>
                                                <span class="text-muted">Type: ${cart.category.name}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="price">
                                                <fmt:formatNumber value="${cart.product.price}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                            </div>
                                        </td>
                                        <td>
                                            <button class="btn btn-outline-secondary btn-sm decrement">−</button>
                                            <input type="text" value="${cart.amount}" class="quantity-box mx-2" readonly>
                                            <button class="btn btn-outline-secondary btn-sm increment">+</button>
                                        </td>
                                        <td class="price">
                                            <span class="row-total">
                                                <fmt:formatNumber value="${cart.product.price * cart.amount}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                            </span>
                                        </td>
                                        <td>
                                            <span class="delete-btn" data-cart-id="${cart.id}">Xóa</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center">Không có sản phẩm trong giỏ hàng</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                <div class="total-section">
                    <span id="totalProducts" class="total-text">Tổng số sản phẩm: 0</span>
                    <span id="totalPrice" class="total-text">Số tiền: ₫</span>
                    <button class="checkout-btn">Thanh toán</button>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(function () {
                const updateTotal = () => {
                    let totalProducts = 0;
                    let totalPrice = 0;

                    // Chỉ tính tổng cho các sản phẩm được chọn (checkbox được tích)
                    $('.product-checkbox:checked').each(function () {
                        let $row = $(this).closest('tr');
                        let qty = parseInt($row.find('.quantity-box').val());
                        // Lưu ý: sử dụng camelCase, tức data-unit-price -> unitPrice
                        let unitPrice = parseFloat($row.data('unitPrice'));
                        if (!isNaN(qty) && !isNaN(unitPrice)) {
                            totalProducts += qty;
                            totalPrice += qty * unitPrice;
                        }
                    });

                    $('#totalProducts').text("Tổng số sản phẩm: " + totalProducts);
                    $('#totalPrice').text("Số tiền: ₫" + totalPrice.toLocaleString('vi-VN'));

                };

                $('.delete-btn').on('click', function () {
                    const cartId = $(this).data('cart-id');
                    if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này không?")) {
                        $.ajax({
                            url: 'deletecart',
                            type: 'POST',
                            data: {id: cartId},
                            success: () => location.reload(),
                            error: () => alert('Xóa sản phẩm thất bại. Vui lòng thử lại.')
                        });
                    }
                });

                $('#selectAll').on('change', function () {
                    $('.product-checkbox').prop('checked', $(this).is(':checked'));
                    updateTotal();
                });

                $('.product-checkbox').on('change', updateTotal);

                $('.increment').on('click', function () {
                    const $row = $(this).closest('tr');
                    const $input = $row.find('.quantity-box');
                    let currentQty = parseInt($input.val());
                    const newQty = currentQty + 1;
                    $input.val(newQty);
                    $.ajax({
                        url: 'updateCartQuantity',
                        type: 'POST',
                        data: {cartId: $row.data('cart-id'), quantity: newQty},
                        success: (response) => {
                            if (response.trim() === "success") {
                                const unitPrice = parseFloat($row.data('unit-price'));
                                $row.find('.row-total').text("₫" + (unitPrice * newQty).toLocaleString('vi-VN'));
                                if ($row.find('.product-checkbox').is(':checked'))
                                    updateTotal();
                            } else
                                alert("Cập nhật số lượng thất bại.");
                        },
                        error: () => alert("Có lỗi xảy ra. Vui lòng thử lại.")
                    });
                });

                $('.decrement').on('click', function () {
                    const $row = $(this).closest('tr');
                    const $input = $row.find('.quantity-box');
                    let currentQty = parseInt($input.val());
                    if (currentQty > 1) {
                        const newQty = currentQty - 1;
                        $input.val(newQty);
                        $.ajax({
                            url: 'updateCartQuantity',
                            type: 'POST',
                            data: {cartId: $row.data('cart-id'), quantity: newQty},
                            success: (response) => {
                                if (response.trim() === "success") {
                                    const unitPrice = parseFloat($row.data('unit-price'));
                                    $row.find('.row-total').text("₫" + (unitPrice * newQty).toLocaleString('vi-VN'));
                                    if ($row.find('.product-checkbox').is(':checked'))
                                        updateTotal();
                                } else
                                    alert("Cập nhật số lượng thất bại.");
                            },
                            error: () => alert("Có lỗi xảy ra. Vui lòng thử lại.")
                        });
                    }
                });

                $('.checkout-btn').on('click', function () {
                    const selectedCartIds = $('.product-checkbox:checked').map(function () {
                        return $(this).val();
                    }).get();
                    if (!selectedCartIds.length) {
                        alert("Vui lòng chọn ít nhất 1 sản phẩm để thanh toán.");
                        return;
                    }
                    window.location.href = 'checkout?cartIds=' + selectedCartIds.join(',');
                });

                updateTotal();
            });
        </script>
    </body>
</html>