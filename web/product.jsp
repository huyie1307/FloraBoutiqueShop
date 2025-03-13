
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

        <link rel="canonical" href="tables-datatables-buttons.html" />

        <title>ADMIN PAGE</title>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">

        <!-- Choose your prefered color scheme -->
        <link href="css/light.css" rel="stylesheet"> 
        <link href="css/dark.css" rel="stylesheet"> 
        <!-- BEGIN SETTINGS -->
        <!-- Remove this after purchasing -->
        <link class="js-stylesheet" href="css/light.css" rel="stylesheet">
        <script src="js/settings.js"></script>
        <style>body {
                opacity: 0;
            }
        </style>
        <!-- END SETTINGS -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-120946860-10"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());

            gtag('config', 'UA-120946860-10', {'anonymize_ip': true});
        </script></head>
    <!--
      HOW TO USE: 
      data-theme: default (default), dark, light, colored
      data-layout: fluid (default), boxed
      data-sidebar-position: left (default), right
      data-sidebar-layout: default (default), compact
    -->

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
                                        <!-- Nút mở modal để thêm sản phẩm -->
                                        <div class="mb-3">
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                                                Add Product
                                            </button>
                                        </div>

                                        <!-- Bảng dữ liệu sản phẩm -->

                                        <!-- Bảng dữ liệu sản phẩm -->
                                        <table id="datatables-buttons" class="table table-striped" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Image</th>
                                                    <th>Price</th>
                                                    <th>Title</th>
                                                    <th>Description</th>
                                                    <th>Category</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${product}" var="p">
                                                    <tr>
                                                        <td>${p.id}</td>
                                                        <td>${p.name}</td>
                                                        <td>
                                                            <img src="${p.image}" alt="${p.name}" width="100" height="100" />
                                                        </td>
                                                        <td>${p.price}</td>
                                                        <td>${p.title}</td>
                                                        <td>${p.description}</td>
                                                        <td>${p.category.name}</td>
                                                        <td>
                                                            <a href="updateProduct?id=${p.id}" class="btn btn-warning">Edit</a>
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

                <!-- Modal Thêm Sản Phẩm -->
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

                                    <button type="submit" class="btn btn-primary">Thêm Sản Phẩm</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>



        
            
            
        

        <script src="js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/datatables.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Datatables with Buttons
                var datatablesButtons = $("#datatables-buttons").DataTable({
                    responsive: true,
                    lengthChange: !1,
                    buttons: ["copy", "print"]
                });
                datatablesButtons.buttons().container().appendTo("#datatables-buttons_wrapper .col-md-6:eq(0)");
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function (event) {
                setTimeout(function () {
                    if (localStorage.getItem('popState') !== 'shown') {
                        window.notyf.open({
                            type: "success",
                            message: "Get access to all 500+ components and 45+ pages with AdminKit PRO. <u><a class=\"text-white\" href=\"https://adminkit.io/pricing\" target=\"_blank\">More info</a></u> 🚀",
                            duration: 10000,
                            ripple: true,
                            dismissible: false,
                            position: {
                                x: "left",
                                y: "bottom"
                            }
                        });

                        localStorage.setItem('popState', 'shown');
                    }
                }, 15000);
            });
        </script>
        <script>
            $(document).ready(function () {
                $("#addProductForm").on("submit", function (event) {
                    event.preventDefault();
                    var formData = new FormData(this);

                    $.ajax({
                        url: "addProduct",
                        type: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            alert(response.message);
                            if (response.status === "success") {
                                $("#addProductModal").modal("hide");
                                location.reload();
                            }
                        },
                        error: function () {
                            alert("Error adding product.");
                        }
                    });
                });
            });
        </script>

        <script>
            document.querySelectorAll('button[data-bs-toggle="modal"]').forEach(button => {
                button.addEventListener('click', function () {
                    document.getElementById('productId').value = this.getAttribute('data-id');
                    document.getElementById('productName').value = this.getAttribute('data-name');
                    document.getElementById('productTitle').value = this.getAttribute('data-title');
                    document.getElementById('productDescription').value = this.getAttribute('data-description');
                    document.getElementById('productPrice').value = this.getAttribute('data-price');
                    document.getElementById('productCategory').value = this.getAttribute('data-category');

                    let imagePath = this.getAttribute('data-image');
                    if (imagePath && imagePath.trim() !== '') {
                        document.getElementById('existingImage').value = imagePath;
                        document.getElementById('productImagePreview').src = imagePath;
                        document.getElementById('productImagePreview').style.display = 'block';
                    } else {
                        document.getElementById('productImagePreview').style.display = 'none';
                    }
                });
            });
        </script>

    </body>

</html>