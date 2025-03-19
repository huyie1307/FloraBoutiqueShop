<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="img/icons/icon-48x48.png" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

    <link href="css/light.css" rel="stylesheet">
    <link href="css/dark.css" rel="stylesheet">

    <title>EDIT INFORMATION</title>
</head>

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
    <div class="sidebar">
        <jsp:include page="Admin.jsp"/>
    </div>

    <main class="content">
        <div class="container-fluid p-0">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title">Customer List</h3>

                            <!-- Bảng dữ liệu khách hàng -->
                            <c:if test="${not empty user}">
                                <form action="updateCustomer" method="post">
                                    <input type="hidden" name="id" value="${user.uID}"> <!-- Lấy ID khách hàng -->
                                    
                                    <!-- Sử dụng lớp row và col của Bootstrap để chia các trường -->
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="name">Name:</label>
                                            <input type="text" id="name" name="name" value="${user.name}" class="form-control" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="dob">Date of Birth:</label>
                                            <input type="date" id="dob" name="dob" value="${user.dob}" class="form-control" required>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="phone">Phone:</label>
                                            <input type="text" id="phone" name="phone" value="${user.phone}" class="form-control" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="address">Address:</label>
                                            <input type="text" id="address" name="address" value="${user.address}" class="form-control" required>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-success">Update Customer</button>
                                </form>
                            </c:if>

                            <c:if test="${empty user}">
                                <p>Customer not found!</p>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

</body>

</html>
