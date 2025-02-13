<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flower Shop Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            background-color: #ffe4e1;
        }
        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            height: 100%;
            background-color: #ff69b4;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            text-decoration: none;
            display: block;
            color: white;
            padding: 15px 20px;
            font-weight: bold;
            margin: 5px 0;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .sidebar a:hover {
            background-color: #ff85c1;
        }
        .sidebar .logo {
            font-size: 24px;
            text-align: center;
            color: white;
            margin-bottom: 30px;
        }
        /* Main Content Styles */
        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
        }
        .header {
            background-color: #ff69b4;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .table-container {
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #ff69b4;
            color: white;
        }
        .footer {
            background-color: #ff69b4;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">Flower Shop Admin</div>
        <a href="index.html">Home</a>
        <a href="?section=orders">Orders</a>
        <a href="?section=customers">Customers</a>
        <a href="?section=feedbacks">Feedbacks</a>
        <a href="logout">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            Welcome, Admin
        </div>

        <!-- Conditional content based on 'section' parameter -->
        <c:choose>
            <c:when test="${param.section == 'orders'}">
                <!-- Orders Table -->
                <div class="table-container">
                    <h2>Order Management</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer Name</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Flower Name</th>
                                <th>Quantity</th>
                                <th>Order Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>${order.id}</td>
                                    <td>${order.customerName}</td>
                                    <td>${order.phone}</td>
                                    <td>${order.address}</td>
                                    <td>${order.flowerName}</td>
                                    <td>${order.quantity}</td>
                                    <td>${order.orderDate}</td>
                                    <td><a href="admin?id=${order.id}&mode=1">Edit</a> | 
                                        <a href="admin?id=${order.id}&mode=2" onclick="return confirm('Are you sure you want to delete this order?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Default Content -->
                <div class="section">
                    <h2>Welcome to the FloSun Shop Admin Dashboard</h2>
                    <p>Select an option from the sidebar to manage the system.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2024 Flower Shop. All rights reserved.
    </div>
</body>
</html>
