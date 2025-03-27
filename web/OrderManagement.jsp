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
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
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
            .title-row {
                background-color: #343a40;
                color: white;
                font-size: 18px;
                font-weight: bold;
                text-align: center;
            }
            .confirm-btn {
                padding: 5px 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .confirm-btn:disabled {
                background-color: #ccc;
                cursor: not-allowed;
            }
        </style>
    </head>
    <body>
        <%@ include file="Admin.jsp" %>

        <div class="content">
            <table>
                <thead>
                    <tr class="title-row">
                        <th colspan="7">Processing Orders</th>
                    </tr>
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
                        <c:if test="${order.statusID == 1}">
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
                                        <input type="hidden" name="statusID" value="2"/>
                                        <button type="submit" class="confirm-btn">Xác nhận đơn hàng</button>
                                    </form>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>

            <table>
                <thead>
                    <tr class="title-row">
                        <th colspan="7">Processed Orders</th>
                    </tr>
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
                                        <input type="hidden" name="statusID" value="4"/>
                                        <button type="submit" class="confirm-btn">Xác nhận giao hàng</button>
                                    </form>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>

            <table>
                <thead>
                    <tr class="title-row">
                        <th colspan="7">Delivered Orders</th>
                    </tr>
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
    </body>
</html>
