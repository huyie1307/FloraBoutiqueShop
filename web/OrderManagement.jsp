<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Order Management</title>
    <style>
        .container {
            margin-left: 220px;
            padding: 20px;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .tabs {
            display: flex;
            margin-bottom: 20px;
        }
        .tab-button {
            flex: 1;
            padding: 10px;
            text-align: center;
            background-color: #ddd;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .tab-button.active {
            background-color: #343a40;
            color: white;
            font-weight: bold;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .confirm-btn {
            padding: 5px 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <%@ include file="Admin.jsp" %>

    <div class="container">
        <!-- Tab navigation -->
        <div class="tabs">
            <button class="tab-button active" onclick="openTab('processedOrders')">Processed Orders</button>
            <button class="tab-button" onclick="openTab('deliveredOrders')">Delivered Orders</button>
        </div>

        <!-- Processed Orders -->
        <div id="processedOrders" class="tab-content active">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Total Price</th>
                        <th>Order Date</th>
                        <th>Discount Code</th>
                        <th>Note</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <c:if test="${order.statusID == 2}">
                            <tr>
                                <td>${order.orderID}</td>
                                <td>${order.userID}</td>
                                <td>${order.totalPrice}</td>
                                <td>${order.orderDate}</td>
                                <td>${order.discountCodeID}</td>
                                <td>${order.note}</td>
                                <td>
                                    <form method="POST" action="order">
                                        <input type="hidden" name="action" value="updateStatus"/>
                                        <input type="hidden" name="id" value="${order.orderID}"/>
                                        <input type="hidden" name="statusID" value="3"/>
                                        <button type="submit" class="confirm-btn">Xác nhận giao hàng</button>
                                    </form>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Delivered Orders -->
        <div id="deliveredOrders" class="tab-content">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Total Price</th>
                        <th>Order Date</th>
                        <th>Discount Code</th>
                        <th>Note</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <c:if test="${order.statusID == 3}">
                            <tr>
                                <td>${order.orderID}</td>
                                <td>${order.userID}</td>
                                <td>${order.totalPrice}</td>
                                <td>${order.orderDate}</td>
                                <td>${order.discountCodeID}</td>
                                <td>${order.note}</td>
                                <td>Delivered</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        function openTab(tabId) {
            // Ẩn tất cả nội dung tab
            document.querySelectorAll(".tab-content").forEach(tab => tab.classList.remove("active"));
            // Bỏ active ở tất cả nút tab
            document.querySelectorAll(".tab-button").forEach(button => button.classList.remove("active"));
            // Hiển thị tab được chọn
            document.getElementById(tabId).classList.add("active");
            // Đánh dấu nút được chọn
            event.currentTarget.classList.add("active");
        }
    </script>
</body>
</html>
