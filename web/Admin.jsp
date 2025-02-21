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
        <a href="#" onclick="loadPage('admin?action=dashboard')">📊 Dashboard</a>
        <a href="#" onclick="loadPage('admin?action=orders')">📦 Orders</a>
        <a href="#" onclick="loadPage('admin?action=revenue')">📈 Revenue</a>
        <a href="#" onclick="loadPage('admin?action=cus')">👤 Users</a>
    </div>

    <div class="content">
        <h2>Chào mừng đến với Admin Dashboard</h2>
        <div id="main-content">
            <p>Chọn một mục trong sidebar để quản lý dữ liệu.</p>
        </div>
    </div>

    <script>
       function loadPage(url) {
        fetch(url)
            .then(response => response.text())
            .then(data => {
                document.getElementById('main-content').innerHTML = data;
            })
            .catch(error => console.error('Lỗi khi tải trang:', error));
    }
    </script>

</body>
</html>
