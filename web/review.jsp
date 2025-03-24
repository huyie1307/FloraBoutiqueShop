<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <title>Review List</title>
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
                            <h3 class="card-title">Review List</h3>
                            <p class="card-text">Below is the list of all customer reviews.</p>

                            <!-- Filter Form for Rating -->
                            <div class="mb-3">
                                <label for="ratingFilter">Filter by Rating</label>
                                <select id="ratingFilter" class="form-select" onchange="filterReviews()">
                                    <option value="">All Ratings</option>
                                    <option value="1">1 Star</option>
                                    <option value="2">2 Stars</option>
                                    <option value="3">3 Stars</option>
                                    <option value="4">4 Stars</option>
                                    <option value="5">5 Stars</option>
                                </select>
                            </div>

                            <!-- Table to display reviews -->
                            <table id="datatables-buttons" class="table table-striped" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Customer Name</th>
                                        <th>Product Image</th>
                                        <th>Rating</th>
                                      
                                       
                                    </tr>
                                </thead>
                                <tbody id="reviewsTable">
                                    <c:forEach items="${review}" var="review" varStatus="status">
                                        <tr class="review" data-rating="${review.rating}">
                                            <td>${status.index + 1}</td>
                                            <td><a href="reviewDetail?id=${review.id}" class="text-decoration-none">${review.user.name}</a></td>
                                            <td><img src="${review.product.imageUrl}" alt="${review.product.name}" style="width: 100px; height: auto;" /></td>
                                            <td>
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
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- JavaScript -->
    <script src="js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/datatables.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var datatablesButtons = $("#datatables-buttons").DataTable({
                responsive: true,
                lengthChange: false,
                buttons: ["copy", "print"]
            });
            datatablesButtons.buttons().container().appendTo("#datatables-buttons_wrapper .col-md-6:eq(0)");
        });

        // Function to filter reviews based on selected rating
        function filterReviews() {
            var ratingFilter = document.getElementById("ratingFilter").value;
            var reviews = document.querySelectorAll(".review");

            reviews.forEach(function (review) {
                var reviewRating = review.getAttribute("data-rating");
                
                if (ratingFilter === "" || reviewRating === ratingFilter) {
                    review.style.display = "";
                } else {
                    review.style.display = "none";
                }
            });
        }
    </script>
</body>

</html>
