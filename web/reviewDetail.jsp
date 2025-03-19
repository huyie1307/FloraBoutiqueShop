<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <title>Review Details</title>

    <!-- Font Awesome for Star Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <style>
        /* Căn giữa toàn bộ nội dung */
        .container-fluid {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            width: 100%;
            max-width: 800px;
            text-align: center;
            margin: auto;
        }

        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        table {
            width: 100%;
            margin-top: 20px;
        }

        td, th {
            padding: 10px;
            text-align: left;
        }

        img {
            width: 200px;
            height: auto;
            margin-bottom: 20px;
        }

        .btn {
            margin-top: 20px;
        }

        /* Ẩn sidebar cho trang reviewDetail */
        .sidebar {
            display: none;
        }
    </style>
</head>

<body>
    <main class="content">
        <!-- Ẩn Sidebar chỉ hiển thị phần chính -->
        <div class="container-fluid p-0">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title">Review Details</h3>
                            <p class="card-text">Details of the review for the product <strong>${review.product.name}</strong></p>

                            <!-- Display Product Image -->
                            <img src="${review.product.imageUrl}" alt="${review.product.name}" />

                            <!-- Table to display review details -->
                            <table class="table">
                                <tr>
                                    <th>Customer Name</th>
                                    <td>${review.user.name}</td>
                                </tr>
                                <tr>
                                    <th>Product Name</th>
                                    <td>${review.product.name}</td>
                                </tr>
                                <tr>
                                    <th>Rating</th>
                                    <td>
                                        <!-- Display rating as stars -->
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:if test="${i <= review.rating}">
                                                <i class="fas fa-star" style="color: gold;"></i>  <!-- Full star -->
                                            </c:if>
                                            <c:if test="${i > review.rating}">
                                                <i class="far fa-star" style="color: gold;"></i>  <!-- Empty star -->
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Review Content</th>
                                    <td>${review.content}</td>
                                </tr>
                            </table>

                            <!-- Back button -->
                            <a href="listReview" class="btn btn-primary">Back to Reviews List</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
