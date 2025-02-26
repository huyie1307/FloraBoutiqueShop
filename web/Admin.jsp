<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: Arial, sans-serif; }
        .sidebar { width: 250px; height: 100vh; position: fixed; background: #343a40; padding-top: 20px; }
        .sidebar a { color: white; text-decoration: none; display: block; padding: 10px 20px; }
        .sidebar a:hover { background: #495057; }
        .content { margin-left: 260px; padding: 20px; }
    </style>
</head>
<body>
 
    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center text-white">Admin Panel</h4>
        <a href="admin?action=dashboard">📊 Dashboard</a>
        <a href="admin?action=orders">📦 Orders</a>
        <a href="admin?action=revenue">📈 Revenue</a>
        <a href="admin?action=cus">👤 Users</a>
    </div>
    

    

</body>
</html>
