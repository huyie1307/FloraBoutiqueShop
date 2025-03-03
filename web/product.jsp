
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
        <div class="wrapper">
            <nav id="sidebar" class="sidebar js-sidebar">
                <div class="sidebar-content js-simplebar">
                    <a class="sidebar-brand" href="index.html">
                        <span class="sidebar-brand-text align-middle">
                            SWP391
                            <sup><small class="badge bg-primary text-uppercase">SE1873-JS</small></sup>
                        </span>
                        <svg class="sidebar-brand-icon align-middle" width="32px" height="32px" viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="1.5"
                             stroke-linecap="square" stroke-linejoin="miter" color="#FFFFFF" style="margin-left: -3px">
                        <path d="M12 4L20 8.00004L12 12L4 8.00004L12 4Z"></path>
                        <path d="M20 12L12 16L4 12"></path>
                        <path d="M20 16L12 20L4 16"></path>
                        </svg>
                    </a>

                    <div class="sidebar-user">
                        <div class="d-flex justify-content-center">
                            <div class="flex-shrink-0">
                                <img src="img/avatars/avatar.jpg" class="avatar img-fluid rounded me-1" alt="Charles Hall" />
                            </div>
                            <div class="flex-grow-1 ps-2">
                                <a class="sidebar-user-title dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                    FLORA <BR><!-- comment -->BOUTIQUE SHOP
                                </a>
                            </div>
                        </div>
                    </div>

                    <ul class="sidebar-nav">






                        <li class="sidebar-item">
                            <a href="product.jsp" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="users"></i> <span>Product</span>
                            </a>

                        </li>

                        <li class="sidebar-header">
                            Components
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#ui" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="briefcase"></i> <span class="align-middle">UI Elements</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#icons" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="coffee"></i> <span class="align-middle">Icons</span>
                                <span class="sidebar-badge badge bg-light">1.500+</span>
                            </a>
                            <ul id="icons" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="icons-feather.html">Feather</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="icons-font-awesome.html">Font Awesome <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#forms" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="check-circle"></i> <span class="align-middle">Forms</span>
                            </a>
                            <ul id="forms" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="forms-basic-inputs.html">Basic Inputs</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="forms-layouts.html">Form Layouts <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="forms-input-groups.html">Input Groups <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="tables-bootstrap.html">
                                <i class="align-middle" data-feather="list"></i> <span class="align-middle">Tables</span>
                            </a>
                        </li>

                        <li class="sidebar-header">
                            Plugins & Addons
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#form-plugins" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="check-square"></i> <span class="align-middle">Form Plugins</span>
                            </a>
                            <ul id="form-plugins" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="forms-advanced-inputs.html">Advanced Inputs <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="forms-editors.html">Editors <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="forms-validation.html">Validation <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item active">
                            <a data-bs-target="#datatables" data-bs-toggle="collapse" class="sidebar-link">
                                <i class="align-middle" data-feather="list"></i> <span class="align-middle">DataTables</span>
                            </a>
                            <ul id="datatables" class="sidebar-dropdown list-unstyled collapse show" data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="tables-datatables-responsive.html">Responsive Table <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item active"><a class="sidebar-link" href="tables-datatables-buttons.html">Table with Buttons <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="tables-datatables-column-search.html">Column Search <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="tables-datatables-fixed-header.html">Fixed Header <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="tables-datatables-multi.html">Multi Selection <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="tables-datatables-ajax.html">Ajax Sourced Data <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#charts" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="bar-chart-2"></i> <span class="align-middle">Charts</span>
                            </a>
                            <ul id="charts" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="charts-chartjs.html">Chart.js</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="charts-apexcharts.html">ApexCharts <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="notifications.html">
                                <i class="align-middle" data-feather="bell"></i> <span class="align-middle">Notifications</span>
                                <span class="sidebar-badge badge bg-primary">Pro</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a data-bs-target="#maps" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="map"></i> <span class="align-middle">Maps</span>
                            </a>
                            <ul id="maps" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                                <li class="sidebar-item"><a class="sidebar-link" href="maps-google.html">Google Maps</a></li>
                                <li class="sidebar-item"><a class="sidebar-link" href="maps-vector.html">Vector Maps <span
                                            class="sidebar-badge badge bg-primary">Pro</span></a></li>
                            </ul>
                        </li>

                        <li class="sidebar-item">
                            <a data-bs-target="#multi" data-bs-toggle="collapse" class="sidebar-link collapsed">
                                <i class="align-middle" data-feather="corner-right-down"></i> <span class="align-middle">Multi Level</span>
                            </a>
                            <ul id="multi" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                                <li class="sidebar-item">
                                    <a data-bs-target="#multi-2" data-bs-toggle="collapse" class="sidebar-link collapsed">Two Levels</a>
                                    <ul id="multi-2" class="sidebar-dropdown list-unstyled collapse">
                                        <li class="sidebar-item">
                                            <a class="sidebar-link" href="#">Item 1</a>
                                            <a class="sidebar-link" href="#">Item 2</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="sidebar-item">
                                    <a data-bs-target="#multi-3" data-bs-toggle="collapse" class="sidebar-link collapsed">Three Levels</a>
                                    <ul id="multi-3" class="sidebar-dropdown list-unstyled collapse">
                                        <li class="sidebar-item">
                                            <a data-bs-target="#multi-3-1" data-bs-toggle="collapse" class="sidebar-link collapsed">Item 1</a>
                                            <ul id="multi-3-1" class="sidebar-dropdown list-unstyled collapse">
                                                <li class="sidebar-item">
                                                    <a class="sidebar-link" href="#">Item 1</a>
                                                    <a class="sidebar-link" href="#">Item 2</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="sidebar-item">
                                            <a class="sidebar-link" href="#">Item 2</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>

                    <div class="sidebar-cta">
                        <div class="sidebar-cta-content">
                            <strong class="d-inline-block mb-2">Weekly Sales Report</strong>
                            <div class="mb-3 text-sm">
                                Your weekly sales report is ready for download!
                            </div>

                            <div class="d-grid">
                                <a href="https://adminkit.io/" class="btn btn-outline-primary" target="_blank">Download</a>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="main">
                <nav class="navbar navbar-expand navbar-light navbar-bg">
                    <a class="sidebar-toggle js-sidebar-toggle">
                        <i class="hamburger align-self-center"></i>
                    </a>

                    <form class="d-none d-sm-inline-block">
                        <div class="input-group input-group-navbar">
                            <input type="text" class="form-control" placeholder="Search…" aria-label="Search">
                            <button class="btn" type="button">
                                <i class="align-middle" data-feather="search"></i>
                            </button>
                        </div>
                    </form>


                    <div class="navbar-collapse collapse">
                        <ul class="navbar-nav navbar-align">
                            <li class="nav-item dropdown">
                                <a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
                                    <div class="position-relative">
                                        <i class="align-middle" data-feather="bell"></i>
                                        <span class="indicator">4</span>
                                    </div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
                                    <div class="dropdown-menu-header">
                                        4 New Notifications
                                    </div>
                                    <div class="list-group">
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-danger" data-feather="alert-circle"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Update completed</div>
                                                    <div class="text-muted small mt-1">Restart server 12 to complete the update.</div>
                                                    <div class="text-muted small mt-1">30m ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-warning" data-feather="bell"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Lorem ipsum</div>
                                                    <div class="text-muted small mt-1">Aliquam ex eros, imperdiet vulputate hendrerit et.</div>
                                                    <div class="text-muted small mt-1">2h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-primary" data-feather="home"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">Login from 192.186.1.8</div>
                                                    <div class="text-muted small mt-1">5h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <i class="text-success" data-feather="user-plus"></i>
                                                </div>
                                                <div class="col-10">
                                                    <div class="text-dark">New connection</div>
                                                    <div class="text-muted small mt-1">Christina accepted your request.</div>
                                                    <div class="text-muted small mt-1">14h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="dropdown-menu-footer">
                                        <a href="#" class="text-muted">Show all notifications</a>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-icon dropdown-toggle" href="#" id="messagesDropdown" data-bs-toggle="dropdown">
                                    <div class="position-relative">
                                        <i class="align-middle" data-feather="message-square"></i>
                                    </div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="messagesDropdown">
                                    <div class="dropdown-menu-header">
                                        <div class="position-relative">
                                            4 New Messages
                                        </div>
                                    </div>
                                    <div class="list-group">
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <img src="img/avatars/avatar-5.jpg" class="avatar img-fluid rounded-circle" alt="Vanessa Tucker">
                                                </div>
                                                <div class="col-10 ps-2">
                                                    <div class="text-dark">Vanessa Tucker</div>
                                                    <div class="text-muted small mt-1">Nam pretium turpis et arcu. Duis arcu tortor.</div>
                                                    <div class="text-muted small mt-1">15m ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <img src="img/avatars/avatar-2.jpg" class="avatar img-fluid rounded-circle" alt="William Harris">
                                                </div>
                                                <div class="col-10 ps-2">
                                                    <div class="text-dark">William Harris</div>
                                                    <div class="text-muted small mt-1">Curabitur ligula sapien euismod vitae.</div>
                                                    <div class="text-muted small mt-1">2h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <img src="img/avatars/avatar-4.jpg" class="avatar img-fluid rounded-circle" alt="Christina Mason">
                                                </div>
                                                <div class="col-10 ps-2">
                                                    <div class="text-dark">Christina Mason</div>
                                                    <div class="text-muted small mt-1">Pellentesque auctor neque nec urna.</div>
                                                    <div class="text-muted small mt-1">4h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                        <a href="#" class="list-group-item">
                                            <div class="row g-0 align-items-center">
                                                <div class="col-2">
                                                    <img src="img/avatars/avatar-3.jpg" class="avatar img-fluid rounded-circle" alt="Sharon Lessman">
                                                </div>
                                                <div class="col-10 ps-2">
                                                    <div class="text-dark">Sharon Lessman</div>
                                                    <div class="text-muted small mt-1">Aenean tellus metus, bibendum sed, posuere ac, mattis non.</div>
                                                    <div class="text-muted small mt-1">5h ago</div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="dropdown-menu-footer">
                                        <a href="#" class="text-muted">Show all messages</a>
                                    </div>
                                </div>
                            </li>

                            <li class="nav-item">
                                <a class="nav-icon js-fullscreen d-none d-lg-block" href="#">
                                    <div class="position-relative">
                                        <i class="align-middle" data-feather="maximize"></i>
                                    </div>
                                </a>
                            </li>

                        </ul>
                    </div>
                </nav>

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
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Hiển thị danh sách sản phẩm -->
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
                                <h5 class="modal-title" id="addProductModalLabel">Thêm Sản Phẩm</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="addProduct" method="post" enctype="multipart/form-data">
                                    <label for="name">Tên sản phẩm:</label>
                                    <input type="text" name="name" class="form-control" required><br>

                                    <label for="title">Tiêu đề:</label>
                                    <input type="text" name="title" class="form-control" required><br>

                                    <label for="description">Mô tả:</label>
                                    <textarea name="description" class="form-control" required></textarea><br>

                                    <label for="categoryId">Danh mục:</label>
                                    <select name="categoryId" class="form-control" required>
                                        <c:forEach var="category" items="${category}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select><br>

                                    <label for="price">Giá:</label>
                                    <input type="number" name="price" step="0.01" class="form-control" required><br>

                                    <label for="amount">Số lượng:</label>
                                    <input type="number" name="amount" class="form-control" required><br>

                                    <label for="image">Ảnh sản phẩm:</label>
                                    <input type="file" name="image" class="form-control" accept="image/*"><br>

                                    <button type="submit" class="btn btn-primary">Thêm Sản Phẩm</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>



                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row text-muted">
                            <div class="col-6 text-start">
                                <p class="mb-0">
                                    <a href="https://adminkit.io/" target="_blank" class="text-muted"><strong>AdminKit</strong></a> &copy;
                                </p>
                            </div>
                            <div class="col-6 text-end">
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Support</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Help Center</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Privacy</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="#">Terms</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
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
                        url: "AddProductController",
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
        </script></body>

</html>
