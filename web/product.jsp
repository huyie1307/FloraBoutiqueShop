<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Panel - Manage Products</title>

        <!-- Bootstrap and DataTables -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/searchpanes/1.4.0/css/searchPanes.dataTables.min.css" rel="stylesheet">
        <style>
            /* Main styles */
            .product-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 4px;
                border: 1px solid #dee2e6;
                transition: transform 0.2s;
            }

            .product-image:hover {
                transform: scale(1.5);
                z-index: 100;
                box-shadow: 0 0 10px rgba(0,0,0,0.3);
            }

            /* Container for image to prevent layout shift on hover */
            .image-container {
                width: 60px;
                height: 60px;
                margin: 0 auto;
                overflow: hidden;
            }
            body {
                background-color: #f5f7fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .content {
                padding: 20px;
                margin-left: 250px; /* Adjust based on sidebar width */
            }

            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .card-header {
                background-color: #fff;
                border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                padding: 15px 20px;
            }

            .card-body {
                padding: 25px;
            }

            /* Table styles */
            .table {
                margin-top: 15px;
            }

            .table thead th {
                border-bottom: 2px solid #dee2e6;
                font-weight: 600;
                color: #495057;
                background-color: #f8f9fa;
            }

            .table tbody tr:hover {
                background-color: rgba(0, 0, 0, 0.02);
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: rgba(0, 0, 0, 0.01);
            }

            /* Button styles */
            .btn-primary {
                background-color: #4e73df;
                border-color: #4e73df;
            }

            .btn-primary:hover {
                background-color: #3d5ec0;
                border-color: #3d5ec0;
            }

            .btn-success {
                background-color: #1cc88a;
                border-color: #1cc88a;
            }

            .btn-warning {
                background-color: #f6c23e;
                border-color: #f6c23e;
            }

            .btn-secondary {
                background-color: #858796;
                border-color: #858796;
            }

            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }

            /* Filter section */
            .filter-section {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 25px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }

            .filter-group label {
                font-weight: 500;
                margin-bottom: 5px;
                color: #5a5c69;
            }

            /* Modal styles */
            .modal-content {
                border: none;
                border-radius: 10px;
            }

            .modal-header {
                border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                padding: 15px 20px;
            }

            .modal-body {
                padding: 20px;
            }

            /* Image styles */
            .img-thumbnail {
                max-width: 100px;
                height: auto;
                border-radius: 4px;
                border: 1px solid #ddd;
                padding: 2px;
            }

            /* Status badges */
            .status-badge {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-hidden {
                background-color: #f8d7da;
                color: #721c24;
            }

            .status-visible {
                background-color: #d4edda;
                color: #155724;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .content {
                    margin-left: 0;
                    padding: 15px;
                }

                .filter-section .row > div {
                    margin-bottom: 15px;
                }

                .card-body {
                    padding: 15px;
                }
            }
            .filter-section {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .filter-group {
                margin-bottom: 10px;
            }
            .dataTables_wrapper .dataTables_filter {
                display: none; /* Ẩn ô tìm kiếm mặc định của DataTables */
            }
        </style>
    </head>

    <body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
        <!-- Sidebar -->
        <div class="sidebar">
            <jsp:include page="Admin.jsp"/>
        </div>

        <!-- Main Content -->
        <main class="content">
            <div class="container-fluid p-0">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="m-0 font-weight-bold text-primary">Manage Product</h5>
                            </div>
                            <div class="card-body">
                                <!-- Filter Section -->
                                <div class="filter-section">
                                    <div class="row">
                                        <div class="col-md-3 filter-group">
                                            <label for="searchName">Find By Name:</label>
                                            <input type="text" id="searchName" class="form-control" placeholder="Nhập tên sản phẩm">
                                        </div>
                                        <div class="col-md-2 filter-group">
                                            <label for="searchCategory">Category:</label>
                                            <select id="searchCategory" class="form-control">
                                                <option value="">All</option>
                                                <c:forEach var="category" items="${category}">
                                                    <option value="${category.name}">${category.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-2 filter-group">
                                            <label for="searchStatus">Status:</label>
                                            <select id="searchStatus" class="form-control">
                                                <option value="">All</option>
                                                <option value="true">Hide</option>
                                                <option value="false">View</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3 filter-group">
                                            <label for="priceRange">Price Range:</label>
                                            <select id="priceRange" class="form-control">
                                                <option value="">All</option>
                                                <option value="0-100000">Under 100,000đ</option>
                                                <option value="100000-300000">100,000đ - 300,000đ</option>
                                                <option value="300000-500000">300,000đ - 500,000đ</option>
                                                <option value="500000-700000">500,000đ - 700,000đ</option>
                                                <option value="700000-1000000">700,000đ - 1,000,000đ</option>
                                                <option value="1000000-">Over 1,000,000đ</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 filter-group d-flex align-items-end">
                                            <button id="resetFilters" class="btn btn-secondary">Remove Filter</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Button to add product -->
                                <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addProductModal">
                                    <i class="fas fa-plus-circle"></i> Add Product
                                </button>

                                <!-- Product Table -->
                                <table id="productTable" class="table table-striped" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Image</th>
                                            <th>Price</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Category</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${product}" var="p" varStatus="status">
                                            <tr class="${p.isDelete ? 'table-secondary' : ''}">
                                                <td>${status.index + 1}</td>
                                                <td><a href="updateProduct?id=${p.flowerId}" class="text-decoration-none">${p.name}</a></td>
                                                <td>
                                                    <div class="image-container">
                                                        <img src="${p.imageUrl}" alt="${p.name}" class="product-image">
                                                    </div>
                                                </td>
                                                <td data-price="${p.price}">${p.price}</td>
                                                <td>${p.title}</td>
                                                <td>${p.description}</td>
                                                <td>${p.category.name}</td>
                                                <td>
                                                    <span class="status-badge ${p.isDelete ? 'status-hidden' : 'status-visible'}">
                                                        ${p.isDelete ? 'Ẩn' : 'Hiển thị'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <!-- Toggle Visibility Button -->
                                                    <c:choose>
                                                        <c:when test="${p.isDelete}">
                                                            <!-- Product is hidden → show Restore -->
                                                            <form action="updateProductStatus" method="post" style="display:inline;">
                                                                <input type="hidden" name="pid" value="${p.flowerId}" />
                                                                <input type="hidden" name="status" value="false" />
                                                                <button type="submit" class="btn btn-success btn-sm">Restore</button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Product is active → show Hide -->
                                                            <form action="updateProductStatus" method="post" style="display:inline;">
                                                                <input type="hidden" name="pid" value="${p.flowerId}" />
                                                                <input type="hidden" name="status" value="true" />
                                                                <button type="submit" class="btn btn-warning btn-sm">Hide</button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
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

        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="addProductModalLabel">
                            <i class="fas fa-cube"></i> Add New Product
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="addProduct" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" name="name" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Title</label>
                                        <input type="text" name="title" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">Category</label>
                                        <select name="categoryId" class="form-select" required>
                                            <c:forEach var="category" items="${category}">
                                                <option value="${category.id}">${category.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Price</label>
                                        <div class="input-group">
                                            <input type="number" name="price" step="0.01" class="form-control" required>
                                            <span class="input-group-text">đ</span>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="image" class="form-label">Image</label>
                                        <input type="file" name="image" class="form-control" accept="image/*" required>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="3" required></textarea>
                            </div>
                            <div class="d-flex justify-content-end">
                                <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">CANCEL</button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ADD
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

        <!-- Đặt các thư viện JS lên đầu trước khi sử dụng -->
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
        <script src="https://cdn.datatables.net/searchpanes/1.4.0/js/dataTables.searchPanes.min.js"></script>

        <script>
            $(document).ready(function () {
                // Kiểm tra nếu DataTable đã được khởi tạo thì destroy trước
                if ($.fn.DataTable.isDataTable('#productTable')) {
                    $('#productTable').DataTable().destroy(true);
                }

                // Khởi tạo DataTable
                var table = $('#productTable').DataTable({
                    responsive: true,
                    lengthChange: false,
                    dom: 'Bfrtip',
                    buttons: ['copy', 'print'],
                    language: {
                        search: "Tìm kiếm:",
                        zeroRecords: "Không tìm thấy kết quả phù hợp",
                        info: "Hiển thị _START_ đến _END_ của _TOTAL_ sản phẩm",
                        infoEmpty: "Không có dữ liệu",
                        infoFiltered: "(lọc từ _MAX_ sản phẩm)"
                    },
                    columnDefs: [
                        {targets: [2, 7], searchable: false, orderable: false}
                    ],
                    initComplete: function () {
                        // Áp dụng các filter tùy chỉnh sau khi DataTable khởi tạo xong
                        applyCustomFilters(this.api());
                    }
                });

                // Sự kiện click cho ảnh sản phẩm
                $(document).on('click', '.product-image', function () {
                    var imgSrc = $(this).attr('src');
                    $('#imagePreview').attr('src', imgSrc);
                    $('#imageModal').modal('show');
                });
            });

        // Hàm áp dụng các filter tùy chỉnh
            function applyCustomFilters(table) {
                // Filter theo tên
                $('#searchName').on('keyup', function () {
                    table.column(1).search(this.value).draw();
                });

                // Filter theo danh mục
                $('#searchCategory').on('change', function () {
                    table.column(6).search(this.value).draw();
                });

                // Filter theo trạng thái
                $('#searchStatus').on('change', function () {
                    var searchValue = this.value === 'true' ? 'Ẩn' : this.value === 'false' ? 'Hiển thị' : '';
                    table.column(7).search(searchValue).draw();
                });

                // Filter theo khoảng giá (0đ - 1,000,000đ)
                $('#priceRange').on('change', function () {
                    var range = this.value;

                    $.fn.dataTable.ext.search.pop(); // Xóa filter cũ

                    if (range) {
                        var ranges = range.split('-');
                        $.fn.dataTable.ext.search.push(
                                function (settings, data, dataIndex) {
                                    var price = parseFloat(data[3]) || 0;

                                    if (ranges[1] === '') {
                                        return price >= parseFloat(ranges[0]);
                                    } else if (ranges[0] === '') {
                                        return price <= parseFloat(ranges[1]);
                                    } else {
                                        return price >= parseFloat(ranges[0]) && price <= parseFloat(ranges[1]);
                                    }
                                }
                        );
                    }

                    table.draw();
                });

                // Nút reset filter
                $('#resetFilters').click(function () {
                    $('#searchName').val('');
                    $('#searchCategory').val('');
                    $('#searchStatus').val('');
                    $('#priceRange').val('');

                    // Reset tất cả filter
                    table.search('').columns().search('').draw();
                    $.fn.dataTable.ext.search = []; // Xóa tất cả filter tùy chỉnh
                });
            }
        </script>
        <div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <img id="imagePreview" src="" class="img-fluid" style="max-height: 80vh;">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>
