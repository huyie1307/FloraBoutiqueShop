<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 400px;
            width: 90%;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            box-sizing: border-box;
            margin: 50px auto; /* Căn giữa ngang, đẩy xuống dưới */
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        input[type="text"], input[type="password"], input[type="date"], select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        button:hover {
            background-color: #218838;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .success {
            color: green;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="Admin.jsp" %> <!-- Đảm bảo file này không bị lỗi CSS -->

    <div class="container">
        <h2>Add New User</h2>

        <!-- Hiển thị thông báo -->
        <c:if test="${not empty message}">
            <p class="${messageType}">${message}</p>
        </c:if>

        <form action="user" method="POST">
            <input type="hidden" name="action" value="add">
            
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="date" name="dob" required>
            <input type="text" name="phone" placeholder="Phone Number" required>
            <input type="text" name="address" placeholder="Address" required>

            <label>Role:</label>
            <select name="isAdmin">
                <option value="false">Customer</option>
                <option value="true">Admin</option>
            </select>

           

            <button type="submit">Add User</button>
        </form>
    </div>
</body>
</html>
