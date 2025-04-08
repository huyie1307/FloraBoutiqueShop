<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Deleted Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Deleted Products</h2>
    <table id="deletedProductTable" class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Image</th>
            <th>Price</th>
            <th>Title</th>
            <th>Description</th>
            <th>Category</th>
            <th>Restore</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${deletedProducts}">
            <tr>
                <td>${p.flowerId}</td>
                <td>${p.name}</td>
                <td><img src="${p.imageUrl}" alt="${p.name}" width="100" height="100" /></td>
                <td>${p.price}</td>
                <td>${p.title}</td>
                <td>${p.description}</td>
                <td>${p.category.name}</td>
                <td>
                    <form action="restoreProduct" method="post">
                        <input type="hidden" name="id" value="${p.flowerId}" />
                        <button type="submit" class="btn btn-success btn-sm">Restore</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <a href="adminListProduct" class="btn btn-secondary mt-3">Back to Product Management</a>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#deletedProductTable').DataTable();
    });
</script>
</body>
</html>
