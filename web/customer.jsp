<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Customer Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.bootstrap5.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .customer-card {
            transition: all 0.3s ease;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            background: #fff;
        }

        .customer-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .customer-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }

        .action-btn {
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 2px;
        }

        .highlight-row {
            background-color: rgba(78, 115, 223, 0.1) !important;
        }

        .dataTables_wrapper .dataTables_filter {
            display: none;
        }

        #filterInput {
            max-width: 300px;
            border-radius: 30px;
            padding-left: 15px;
        }

        .table-hover tbody tr:hover {
            background-color: #f2f4f7;
        }
    </style>
</head>
<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
    <div class="sidebar">
        <jsp:include page="Admin.jsp" />
    </div>

    <main class="content">
        <div class="container-fluid p-4">
            <div class="mb-4">
                <h1 class="h3">Customer Management</h1>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <div>
                        <input type="text" id="filterInput" class="form-control" placeholder="🔍 Search name, phone or address...">
                    </div>
                </div>
            </div>

            <div class="card customer-card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Customer List</h5>
                    <p class="card-subtitle text-muted">Below is the list of all registered customers</p>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="customerTable" class="table table-hover align-middle">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Customer</th>
                                    <th>Date of Birth</th>
                                    <th>Contact</th>
                                    <th>Address</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customer}" var="customer" varStatus="status">
                                    <tr data-customer-id="${customer.uID}">
                                        <td>${status.index + 1}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://ui-avatars.com/api/?name=${customer.name}&background=random" alt="Avatar" class="customer-avatar">
                                                <div>
                                                    <a href="orderCustomer?userId=${customer.uID}" class="fw-bold text-decoration-none">${customer.name}</a>
                                                    
                                                </div>
                                            </div>
                                        </td>
                                        <td><fmt:formatDate value="${customer.dob}" pattern="dd/MM/yyyy" /></td>
                                        <td>${customer.phone}</td>
                                        <td>${customer.address}</td>
                                        <td>
                                            <a href="orderCustomer?userId=${customer.uID}" class="btn btn-sm btn-outline-primary action-btn" title="View Orders">
                                                <i class="bi bi-cart3"></i>
                                            </a>
                                            <a href="updateCustomer?id=${customer.uID}" class="btn btn-sm btn-outline-secondary action-btn" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.colVis.min.js"></script>

    <script>
        $(document).ready(function () {
            const table = $('#customerTable').DataTable({
                dom: 'Bfrtip',
                buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                responsive: true,
                pageLength: 4,
                lengthChange: false,
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search...",
                    paginate: {
                        previous: "«",
                        next: "»"
                    },
                    info: "Showing _START_ to _END_ of _TOTAL_ customers"
                }
            });

            // Custom filter
            $('#filterInput').on('keyup', function () {
                table.search(this.value).draw();
            });
        });
    </script>
</body>
</html>
