
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>My Order</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- font awesome cdn link  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <!-- custum css -->
        <link rel="stylesheet" href="style.css">
    </head>
    <style>
        .dashboard-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
        }
        .dashboard {
            display: flex;
            width: 90%;
            max-width: 1400px;
            background: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        .sidebar {
            width: 300px;
            background: #f0f0f0;
            padding: 20px;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 15px 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
            font-size: 16px;
        }
        .sidebar ul li:hover {
            background: #ffebef;
            color: #d63384;
        }
        .sidebar ul li strong {
            color: #d63384;
        }
        .content {
            flex-grow: 1;
            padding: 50px;
            text-align: center;
        }
        .content h2 {
            font-size: 28px;
            font-weight: bold;
            color: #333;
        }
        .table-container {
            margin-top: 30px;
            text-align: left;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 16px;
        }
        th {
            background-color: #f0f0f0;
        }
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        .btn-detail {
            padding: 10px 15px;
            margin: 0 5px;
            cursor: pointer;
            border-radius: 5px;
            background: #d63384;
            color: white;
            border: none;
        }
        .pagination button {
            padding: 10px 15px;
            margin: 0 5px;
            border: 1px solid #ddd;
            background: white;
            color: black;
            cursor: pointer;
            border-radius: 5px;
        }
        .pagination a {
            color: #000;
        }
        .pagination button:hover {
            background: #ffebef;
        }
        .pagination button.active {
            background: #d63384;
            color: white;
            border: none;
        }
    </style>
    <body>
        <header>
            <a href="index.html" class="logo"><img src="image/logo.png" alt="" width="100"></a>
            < <div class="navbar">
                <a href="home">home</a>
                <a href="#services">services</a>
                <a href="#about">about</a>
                <a href="#shop">shop</a>
                <a href="listProduct">All Products</a>
                <a href="#contact">contact</a>
                <a href="#blog">blog</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="listorder">My Cart</a>
                        <a href="my-order">My Order</a>
                        <a href="logout">Logout</a>
                    </c:when>

                    <c:otherwise>
                        <a href="login">login</a>
                        <a href="signin">Sign up</a>
                    </c:otherwise>
                </c:choose>          
            </div>
        </header>
        <div class="dashboard-container">
            <div class="dashboard">
                <aside class="sidebar">
                    <ul>
                        <li>Information</li>
                        <li><strong>My Orders</strong></li>
                        <li>Logout</li>
                    </ul>
                </aside>
                <section class="content">
                    <h2>My Orders</h2>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Note</th>
                                    <th>Order Date</th>
                                    <th>Total Price</th>
                                    <th>Payment Method</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="order" varStatus="loop" >
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${order.note}</td>
                                        <td>${order.orderDate}</td>
                                        <td>${order.total}đ</td>
                                        <td>${order.paymentMethod.methodName}</td>
                                        <td>${order.status.statusName}</td>
                                        <td><a href="my-order-detail?oid=${order.id}">
                                                <button class="btn-detail">
                                                    Detail
                                                </button>
                                            </a></td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="my-order?page=${currentPage - 1}"><button>&laquo; Prev</button></a>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <a href="my-order?page=${i}"><button class="active">${i}</button></a>

                                    </c:when>
                                    <c:otherwise>
                                        <a href="my-order?page=${i}"><button>${i}</button></a>

                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="my-order?page=${currentPage + 1}"><button>Next &raquo;</button></a>
                            </c:if>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <footer>
            <div class="content">
                <div class="box">
                    <img src="image/logo.png" alt="">
                    <p>We’re always in search for talented and motivated people. Don’t be shy introduce yourself! <br>We’re always in search for talented and motivated people.</p>
                </div>
                <div class="box">
                    <h3>help & information</h3>
                    <a href="">help center</a>
                    <a href="">address store</a>
                    <a href="">privacy policy</a>
                    <a href="">reveiver</a>
                    <a href="">our store</a>
                </div>
                <div class="box">
                    <h3>about us</h3>
                    <a href="">contact us</a>
                    <a href="">about us</a>
                    <a href="">terms & condition</a>
                    <a href="">event</a>
                    <a href="">our shop</a>
                </div>
                <div class="box">
                    <h3>get in touch</h3>
                    <p>Phone : +91-2233445544</p>
                    <p>E-mail : selenaAnsari@gmaill.com</p>
                    <p>Location : South America, USA</p>
                    <div class="icon">
                        <i class="fab fa-facebook"></i>
                        <i class="fab fa-whatsapp"></i>
                        <i class="fab fa-twitter"></i>
                        <i class="fab fa-instagram"></i>
                        <i class="fab fa-gitlab"></i>
                        <div id="menu-bar" class="fa  fa-bars"></div>
                    </div>
                </div>
            </div>
            <div class="bottom">
                <p>copyright @ 2023 <span>code with selena.</span>All Rights Reserved</p>
            </div>
        </footer>
        <script src="script.js"></script>
    </body>
</html>
