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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
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
                        <div class="card-body">
                            <!-- Button to add product -->
                            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addProductModal">Add Product</button>

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
                                        <th>Actions</th> <!-- Added Actions Column -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${product}" var="p">
                                        <tr>
                                            <td>${p.flowerId}</td>
                                            <td><a href="updateProduct?id=${p.flowerId}" class="text-decoration-none">${p.name}</a></td>
                                            <td><img src="${p.imageUrl}" alt="${p.name}" width="100" height="100" /></td>
                                            <td>${p.price}</td>
                                            <td>${p.title}</td>
                                            <td>${p.description}</td>
                                            <td>${p.category.name}</td>
                                            <td>
                                                <!-- Delete Button -->
                                                <button class="btn btn-danger btn-sm" onclick="deleteProduct(${p.flowerId})">Delete</button>
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
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="addProduct" method="post" enctype="multipart/form-data">
                        <label for="name">Name:</label>
                        <input type="text" name="name" class="form-control" required><br>

                        <label for="title">Title:</label>
                        <input type="text" name="title" class="form-control" required><br>

                        <label for="description">Description:</label>
                        <textarea name="description" class="form-control" required></textarea><br>

                        <label for="categoryId">Category:</label>
                        <select name="categoryId" class="form-control" required>
                            <c:forEach var="category" items="${category}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select><br>

                        <label for="price">Price:</label>
                        <input type="number" name="price" step="0.01" class="form-control" required><br>

                        <label for="image">Image:</label>
                        <input type="file" name="image" class="form-control" accept="image/*"><br>

                        <button type="submit" class="btn btn-primary">Add Product</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

    <script>
        // Initialize DataTable for pagination, search, and sorting
        $(document).ready(function() {
            $('#productTable').DataTable({
                responsive: true,
                lengthChange: false,
                buttons: ['copy', 'print']
            });
        });

        // JavaScript function to delete a product
        function deleteProduct(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                // Call servlet or API to delete the product
                window.location.href = "deleteProduct?id=" + productId;  // Redirect to deleteProduct servlet
            }
        }
    </script>

</body>

</html>
