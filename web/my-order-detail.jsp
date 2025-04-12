
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- font awesome cdn link  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

        <!-- custum css -->
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="modal.css">
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
        /*        .button {
                    background-color: #d63384;  Màu hồng đậm 
                    color: #fff;  Chữ màu trắng 
                    border: none;
                    padding: 10px 20px;
                    font-size: 16px;
                    border-radius: 8px;
                    cursor: pointer;
                    transition: background-color 0.3s ease, transform 0.2s ease;
                }
        
                .button:hover {
                    background-color: #b02a6b;  Màu hồng tối hơn khi hover 
                    transform: scale(1.05);  Hiệu ứng phóng to nhẹ 
                }*/
    </style>
    <body>
        <header>
            <a href="index.html" class="logo"><img src="image/logo.png" alt="" width="100"></a>
            <div class="navbar">
                <a href="#home">home</a>
                <a href="#services">services</a>
                <a href="#about">about</a>
                <a href="#shop">shop</a>
                <a href="#contact">contact</a>
                <a href="#blog">blog</a>
                <a href="Login.jsp">login</a>
                <a href="signup.jsp">sign up</a>
            </div>
            <div class="icon">
                <i class="fab fa-facebook"></i>
                <i class="fab fa-whatsapp"></i>
                <i class="fab fa-twitter"></i>
                <i class="fab fa-instagram"></i>
                <i class="fab fa-gitlab"></i>
                <div id="menu-bar" class="fa  fa-bars"></div>
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
                    <h2>Order Detail</h2>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                    <th>Review</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orderDetails}" var="od" varStatus="loop" >
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${od.product.name}</td>
                                        <td>${od.quantity}</td>
                                        <td>${od.price}đ</td>
                                        <td>${od.quantity * od.price}</td>
                                        <td>
                                            <c:if test="${od.order.status.statusName == 'Đã giao hàng'}">
                                                <c:if test="${od.review == null}">
                                                    <button class="btn-submit" onclick="openModal(${od.product.id}, ${od.id})">Review now</button>
                                                </c:if>
                                                <c:if test="${od.review != null}">
                                                    <button class="btn-cancel" onclick="showReview(${od.review.rating}, '${od.review.content}')">Detail</button>
                                                </c:if>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </section>
            </div>
        </div>
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Rate this Product</span>
                    <button class="btn-close" id="closeModal">&times;</button>
                </div>

                <div class="modal-body">
                    <form action="create-review" method="post" id="form">
                        <input type="text" id="productId" hidden="" name="productId"/>
                        <input type="text" id="orderDetailId" hidden="" name="orderDetailId"/>
                        <label for="rating">Select Rating:</label>
                        <select id="rating" class="modal-select" name="rating">
                            <option value="5">⭐⭐⭐⭐⭐ - Excellent</option>
                            <option value="4">⭐⭐⭐⭐ - Very Good</option>
                            <option value="3">⭐⭐⭐ - Good</option>
                            <option value="2">⭐⭐ - Fair</option>
                            <option value="1">⭐ - Poor</option>
                        </select>

                        <label for="reviewText">Your Review:</label>
                        <textarea name="content" id="content" class="modal-textarea" placeholder="Write your thoughts here..."></textarea>
                    </form>

                </div>

                <div class="modal-footer">
                    <button class="btn-cancel" id="closeModalBtn">Cancel</button>
                    <button class="btn-submit" id="submitReview">Submit</button>
                </div>
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
        <script src="modal.js"></script>
        <script>
            document.getElementById("submitReview").onclick = () => {
                document.getElementById("form").submit();
            }
        </script>
    </body>
</html>
