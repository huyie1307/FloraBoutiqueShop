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

        <title>Customer List</title>
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
                                <p class="card-text">Below is the list of all customers who are not admins.</p>

                                <!-- Bảng dữ liệu khách hàng -->
                                <table id="datatables-buttons" class="table table-striped" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Name</th>
                                            <th>Date of Birth</th>
                                            <th>Phone</th>
                                            <th>Address</th>
                                    
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${customer}" var="customer" varStatus="status">
                                            <tr>
                                                <td>${status.index+1}</td>
                                                <td>
                                                    <!-- Tên khách hàng giờ trở thành một liên kết, người dùng chỉ cần click vào tên -->
                                                    <a href="updateCustomer?id=${customer.uID}" class="text-decoration-none">
                                                        ${customer.name}
                                                    </a>
                                                </td>
                                                <td>${customer.dob}</td>
                                                <td>${customer.phone}</td>
                                                <td>${customer.address}</td>
                                                
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Modal View Orders -->
        <c:forEach items="${customer}" var="customer">
            <div class="modal fade" id="viewOrdersModal${customer.uID}" tabindex="-1" aria-labelledby="viewOrdersModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="viewOrdersModalLabel">Order History for ${customer.name}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" id="orderHistoryContent${customer.uID}">
                            <!-- Lịch sử đơn hàng sẽ được tải qua Ajax -->
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- JavaScript -->
        <script src="js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/datatables.js"></script>

        <script>
                                                        function loadOrderHistory(customerId) {
                                                            // Gửi Ajax request để lấy lịch sử đơn hàng của khách hàng
                                                            fetch('getOrderHistory?customerId=' + customerId)
                                                                    .then(response => response.json())
                                                                    .then(data => {
                                                                        let orderHistoryContent = document.getElementById('orderHistoryContent' + customerId);
                                                                        let orderHistoryHtml = '<table class="table table-striped"><thead><tr><th>Order ID</th><th>Product</th><th>Quantity</th><th>Total Price</th><th>Status</th></tr></thead><tbody>';

                                                                        // Duyệt qua lịch sử đơn hàng và tạo bảng hiển thị
                                                                        data.forEach(order => {
                                                                            orderHistoryHtml += '<tr>' +
                                                                                    '<td>' + order.orderId + '</td>' +
                                                                                    '<td>' + order.productName + '</td>' +
                                                                                    '<td>' + order.quantity + '</td>' +
                                                                                    '<td>' + order.totalPrice + '</td>' +
                                                                                    '<td>' + order.status + '</td>' +
                                                                                    '</tr>';
                                                                        });

                                                                        orderHistoryHtml += '</tbody></table>';
                                                                        orderHistoryContent.innerHTML = orderHistoryHtml;  // Gán HTML vào modal
                                                                    })
                                                                    .catch(error => console.error('Error loading order history:', error));
                                                        }

                                                        document.addEventListener("DOMContentLoaded", function () {
                                                            var datatablesButtons = $("#datatables-buttons").DataTable({
                                                                responsive: true,
                                                                lengthChange: false,
                                                                buttons: ["copy", "print"]
                                                            });
                                                            datatablesButtons.buttons().container().appendTo("#datatables-buttons_wrapper .col-md-6:eq(0)");
                                                        });
        </script>
        <script>
            
        </script>
    </body>

</html>
