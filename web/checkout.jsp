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
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 30px;
            }
            .custom-btn {
                background-color: #FF0080;
                color: white;
                padding: 12px 20px;
                font-size: 18px;
                border-radius: 8px;
                font-weight: bold;
                text-decoration: none;
                transition: 0.3s;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            }
            .custom-btn:hover {
                background-color: #cc0066;
                box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
            }
            .customer-info, .payment-option, .cart-table {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            .customer-info h4 {
                color: #FF0080;
                font-weight: bold;
            }
            .input-custom {
                border-radius: 8px;
                padding: 12px;
                font-size: 16px;
                border: 1px solid #ddd;
                transition: all 0.3s ease-in-out;
            }
            .input-custom:focus {
                border-color: #007bff;
                box-shadow: 0px 0px 6px rgba(0, 123, 255, 0.5);
                outline: none;
            }
            .payment-method {
                display: flex;
                gap: 15px;
                margin-top: 15px;
            }
            .payment-card {
                flex: 1;
                padding: 15px;
                background: #f8f9fa;
                border-radius: 8px;
                display: flex;
                align-items: center;
                gap: 10px;
                cursor: pointer;
                transition: 0.3s;
                border: 2px solid transparent;
            }
            .payment-card input {
                display: none;
            }
            .payment-card .icon {
                font-size: 22px;
                color: #FF0080;
            }
            .payment-card .text {
                font-size: 16px;
                font-weight: bold;
                color: #333;
            }
            .payment-card:hover {
                background: #e9ecef;
            }
            .payment-card input:checked + .icon {
                color: #28a745;
            }
            .payment-card input:checked + .text {
                color: #28a745;
            }
            .checkout-btn {
                background-color: #FF0080;
                color: white;
                padding: 12px 20px;
                border-radius: 8px;
                font-size: 18px;
                font-weight: bold;
                transition: 0.3s;
                border: none;
            }
            .checkout-btn:hover {
                background-color: #cc0066;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-6">
                    <a class="custom-btn" href="listorder">Quay lại giỏ hàng</a>
                </div>
            </div>

            <form action="checkout" method="post">
                <div class="customer-info">
                    <h4>Thông tin khách hàng</h4>
                    <div class="mb-3">
                        <label class="form-label"><i class="fa fa-user"></i> Họ và tên</label>
                        <input type="text" name="name" class="form-control input-custom" value="${user.name}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fa fa-phone"></i> Số điện thoại</label>
                        <input type="text" name="phone" class="form-control input-custom" value="${user.phone}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fa fa-map-marker-alt"></i> Địa chỉ</label>
                        <input type="text" name="address" class="form-control input-custom" value="${user.address}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fa fa-calendar"></i> Ngày nhận hàng</label>
                        <input type="datetime-local" name="receiveDate" class="form-control input-custom">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fa fa-comment"></i> Ghi chú (nếu có)</label>
                        <textarea id="orderNote" name="orderNote" class="form-control input-custom" rows="3" placeholder="Nhập ghi chú cho đơn hàng..." maxlength="255"></textarea>
                        <small id="charCount" class="text-muted">0/255 ký tự</small>
                    </div>
                </div>

                <div class="cart-table">
                    <h4 class="text-primary">Giỏ hàng của bạn</h4>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Số tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sessionScope.carts}" var="cart">
                                <tr>
                                    <td>
                                        <img src="${cart.product.imageUrl}" alt="${cart.product.name}" width="80">
                                        ${cart.product.name}
                                        <input type="hidden" name="productId" value="${cart.product.flowerId}">
                                    </td>
                                    <td class="price">
                                        <fmt:formatNumber value="${cart.product.price}" type="currency" currencySymbol="₫"/>
                                    </td>
                                    <td>
                                        <input type="text" name="quantity" value="${cart.amount}" class="form-control quantity-box" readonly>
                                    </td>
                                    <td class="price">
                                        <fmt:formatNumber value="${cart.product.price * cart.amount}" type="currency" currencySymbol="₫"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="payment-option">
                    <h5 class="text-primary">Lựa chọn hình thức thanh toán</h5>
                    <div class="payment-method">
                        <label class="payment-card">
                            <input type="radio" name="paymentMethod" value="direct" checked>
                            <div class="icon"><i class="fa fa-money-bill-wave"></i></div>
                            <div class="text">Thanh toán trực tiếp</div>
                        </label>
                        <label class="payment-card">
                            <input type="radio" name="paymentMethod" value="online">
                            <div class="icon"><i class="fa fa-credit-card"></i></div>
                            <div class="text">Thanh toán online</div>
                        </label>
                    </div>
                </div>

                <div class="text-end">
                    <button type="submit" class="checkout-btn">Thanh toán</button>
                </div>
            </form>
        </div>
    </body>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        
        //Cập nhật kí tự trong ghi chú
        document.addEventListener("DOMContentLoaded", function () {
            let noteField = document.getElementById("orderNote");
            let charCount = document.getElementById("charCount");

            noteField.addEventListener("input", function () {
                let length = this.value.length;
                $('#charCount').text(length + "/255 ký tự");
            });
        });


        // Hàm hiển thị thông báo
        function showNotification(message, type) {
            console.log("Thông báo:", message, "Loại:", type);
            let bgColor = type === "success" ? "#28a745" : "#dc3545";
            let progressColor = type === "success" ? "#ffffff" : "#ff9999";

            let notification = $("<div></div>", {
                class: "cart-notification",
                html: Array.isArray(message) ? message.map(msg => '- ' + msg).join('<br>') : message,
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
                    "text-align": "left",
                    "opacity": "0",
                    "transition": "opacity 0.3s ease-in-out, top 0.3s ease-in-out"
                }
            });

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
                    "transition": "width 3s linear"
                }
            });

            notification.append(progressBar);
            $("body").append(notification);

            setTimeout(() => {
                notification.css({"top": "20px", "opacity": "1"});
                progressBar.css("width", "100%");
            }, 100);

            setTimeout(() => {
                notification.css({"opacity": "0", "top": "-60px"});
                setTimeout(() => notification.remove(), 200);
            }, 3000);
        }


        $(document).ready(function () {
            $(".checkout-btn").click(function (event) {
                event.preventDefault(); // Ngăn form submit mặc định

                let isValid = true;
                let missingFields = [];

                // Xóa thông báo lỗi trước đó
                $(".error-msg").remove();

                // Lấy dữ liệu từ form
                let name = $("input[name='name']").val().trim();
                let phone = $("input[name='phone']").val().trim();
                let address = $("input[name='address']").val().trim();
                let receiveDate = $("input[name='receiveDate']").val().trim();
                let hasCartItems = $(".cart-table tbody tr").length > 0;

                if (!name) {
                    missingFields.push("Vui lòng nhập tên");
                    isValid = false;
                }
                if (!phone) {
                    missingFields.push("Vui lòng nhập số điện thoại");
                    isValid = false;
                } else if (!/^\d{9,11}$/.test(phone)) {
                    missingFields.push("Số điện thoại phải có 9-11 chữ số");
                    isValid = false;
                }
                if (!address) {
                    missingFields.push("Vui lòng nhập địa chỉ");
                    isValid = false;
                }
                if (!receiveDate) {
                    missingFields.push("Vui lòng chọn ngày và giờ nhận hàng");
                    isValid = false;
                } else if (receiveDate) {
                    let selectedDate = new Date(receiveDate);
                    let now = new Date();
                    if (selectedDate < now) {
                        missingFields.push("Thời gian lấy hàng không hợp lệ. Vui lòng chọn một thời gian sau thời điểm hiện tại.");
                        isValid = false;
                    }
                }
                if (!hasCartItems) {
                    showNotification("Giỏ hàng rỗng", "error");
                    return;
                }

                if (!isValid) {
                    console.log("missingFields ban đầu:", missingFields);
                    showNotification(missingFields, "error");
                    return;

                } else {
                    $("form").off("submit").submit();
                }
            });
        });

    </script>
</html>
