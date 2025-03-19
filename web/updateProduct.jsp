<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
    <div class="sidebar">
        <jsp:include page="Admin.jsp"/>
    </div>

    <main class="content">
        <div class="container mt-5">
            <h2 class="text-center">Update Product</h2>

            <!-- Display error message if there is any -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    ${errorMessage}
                </div>
            </c:if>

            <!-- Product update form -->
            <form action="updateProduct" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${product.flowerId}">

                <!-- Divide the fields into columns using Bootstrap grid system -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="name" class="form-label">Product Name:</label>
                        <input type="text" id="name" name="name" value="${product.name}" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label for="title" class="form-label">Title:</label>
                        <input type="text" id="title" name="title" value="${product.title}" class="form-control" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="price" class="form-label">Price:</label>
                        <input type="number" id="price" name="price" value="${product.price}" step="0.01" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label for="categoryId" class="form-label">Category:</label>
                        <select id="categoryId" name="categoryId" class="form-select" required>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${category.id == product.category.id ? 'selected' : ''}>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description:</label>
                    <textarea id="description" name="description" rows="4" class="form-control" required>${product.description}</textarea>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">Product Image:</label>
                    <input type="file" id="image" name="image" class="form-control">
                </div>

                <!-- Display current image if available -->
                <c:if test="${not empty product.imageUrl}">
                    <div class="mb-3">
                        <img src="${product.imageUrl}" alt="Product Image" width="100">
                    </div>
                </c:if>

                <!-- Keep the existing image path if the user does not change the image -->
                <input type="hidden" name="existingImage" value="${product.imageUrl}">

                <div class="mb-3">
                    <button type="submit" class="btn btn-success">Update Product</button>
                    <a href="adminListProduct" class="btn btn-secondary">Back to Product List</a>
                </div>
            </form>
        </div>
    </main>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
