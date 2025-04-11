<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Management</title>
    <style>
        .container {
            margin-left: 220px;
            padding: 20px;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        h2 {
            color: #333;
        }
        .search-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        #searchInput {
            padding: 8px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .add-btn {
            padding: 8px 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .add-btn:hover {
            background-color: #218838;
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
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .delete-btn {
            background-color: #ff4d4f;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            font-weight: bold;
            padding: 5px;
        }
        .delete-btn:hover {
            background-color: #d9363e;
        }
    </style>
</head>
<body>
    <%@ include file="Admin.jsp" %>
    <div class="container">
        <h2>Use List</h2>

        <div class="search-container">
            <form action="user" method="GET">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" id="searchInput" placeholder="Tìm kiếm người dùng..."value="${param.keyword}">
                <button type="submit">🔍</button>
            </form>
            <button class="add-btn" onclick="window.location.href='AddUser.jsp'">➕ Add Account</button>
        </div>

        <table>
            <tr>
                <th>UserID</th>
                <th>Full Name</th>
                <th>Username</th>
                <th>Address</th>
                <th>Role</th>
                <th>Phone Number</th>
                <th>Action</th>
            </tr>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.uID}</td>
                    <td>${user.name}</td>
                    <td>${user.username}</td>
                    <td>${user.address}</td>
                    <td>
                        <c:choose>
                            <c:when test="${user.isAdmin}">Admin</c:when>
                            <c:otherwise>Customer</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${user.phone}</td>
                    <td>
                        <a href="user?action=delete&uID=${user.uID}" class="delete-btn" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">🗑️</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
