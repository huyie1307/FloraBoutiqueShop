<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Customer Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .customer-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .customer-card:hover {
            transform: translateY(-5px);
        }
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        }
        .table thead th {
            background-color: #4e73df;
            color: white;
            font-weight: 600;
            border: none;
        }
        .table tbody tr {
            transition: all 0.2s ease;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .badge-status {
            padding: 8px 12px;
            font-weight: 500;
            border-radius: 20px;
            font-size: 0.85rem;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .total-amount {
            font-weight: 600;
            color: #2e59d9;
        }
        .back-link {
            transition: all 0.3s ease;
        }
        .back-link:hover {
            transform: translateX(-3px);
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <!-- Thêm nút quay lại ở đầu trang -->
        <div class="row mb-3">
            <div class="col-12">
                <a href="${pageContext.request.contextPath}/listCustomer" class="text-decoration-none back-link">
                    <i class="bi bi-arrow-left-circle-fill me-2"></i>Back to Customer Management
                </a>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-12">
                <div class="customer-card p-4 mb-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="mb-1"><i class="bi bi-person-circle me-2"></i>Customer Orders</h2>
                            <p class="mb-0 text-muted">View all orders for this customer</p>
                        </div>
                        <div class="text-end">
                            <h4 class="mb-0 text-primary">${customerName}</h4>
                            <small class="text-muted">Customer ID: #${customerId}</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${empty orders}">
            <div class="alert alert-warning d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div>
                    No orders found for this customer. 
                    <a href="${pageContext.request.contextPath}/admin/customers" class="alert-link">View all customers</a>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty orders}">
            <div class="row">
                <div class="col-12">
                    <div class="card mb-4">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Order History</h5>
                            <div class="d-flex">
                                <input type="text" class="form-control me-2" placeholder="Search orders..." id="searchInput">
                                <button class="btn btn-outline-secondary" type="button">
                                    <i class="bi bi-filter"></i> Filter
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="sortable">Order ID <i class="bi bi-arrow-down-up"></i></th>
                                            <th class="sortable">Date <i class="bi bi-arrow-down-up"></i></th>
                                            <th class="sortable">Total <i class="bi bi-arrow-down-up"></i></th>
                                            <th class="sortable">Status <i class="bi bi-arrow-down-up"></i></th>
                                            <th>Payment Method</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orders}">
                                            <tr>
                                                <td><strong>#${order.id}</strong></td>
                                                <td>
                                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                                </td>
                                                <td class="total-amount">$${order.total}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.orderStatus.statusName eq 'Pending'}">
                                                            <span class="badge-status status-pending">
                                                                <i class="bi bi-clock me-1"></i> ${order.orderStatus.statusName}
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.orderStatus.statusName eq 'Completed'}">
                                                            <span class="badge-status status-completed">
                                                                <i class="bi bi-check-circle me-1"></i> ${order.orderStatus.statusName}
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge-status status-cancelled">
                                                                <i class="bi bi-x-circle me-1"></i> ${order.orderStatus.statusName}
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.method.name eq 'Credit Card'}">
                                                            <i class="bi bi-credit-card me-1"></i>
                                                        </c:when>
                                                        <c:when test="${order.method.name eq 'PayPal'}">
                                                            <i class="bi bi-paypal me-1"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="bi bi-cash me-1"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    ${order.method.name}
                                                </td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary" title="View Details">
                                                        <i class="bi bi-eye"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-secondary ms-1" title="Print">
                                                        <i class="bi bi-printer"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                            <div class="text-muted">
                                Showing ${orders.size()} of ${orders.size()} orders
                            </div>
                            <!-- Thêm nút quay lại ở footer -->
                            <a href="${pageContext.request.contextPath}/listCustomer" class="btn btn-outline-primary">
                                <i class="bi bi-arrow-left me-1"></i>Back to Customers
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple sorting functionality
        document.querySelectorAll('.sortable').forEach(header => {
            header.style.cursor = 'pointer';
            header.addEventListener('click', () => {
                // Implement sorting logic here
                console.log('Sorting by ' + header.textContent.trim());
            });
        });

        // Search functionality
        document.getElementById('searchInput').addEventListener('input', (e) => {
            const searchTerm = e.target.value.toLowerCase();
            document.querySelectorAll('tbody tr').forEach(row => {
                const rowText = row.textContent.toLowerCase();
                row.style.display = rowText.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>