<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FlowSun - flower shop website</title>
        <!-- font awesome cdn link  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <!-- custum css -->
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <!-- header section start -->
        <header>
            <a href="index.html" class="logo"><img src="image/logo.png" alt="" width="100"></a>
            <div class="navbar">
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
                        <a href="#">My Order</a>
                        <a href="logout">Logout</a>
                    </c:when>

                    <c:otherwise>
                        <a href="login">login</a>
                        <a href="signin">Sign up</a>
                    </c:otherwise>
                </c:choose>          
            </div>
            <div class="icon">
                <a href="myOrder.jsp" title="Facebook"><i class="fab fa-facebook"></i></a>
                <a href="myOrder.jsp" title="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="listorder" title="My Order"><i class="fas fa-shopping-cart"></i></a>
                <a href="UserProfile.jsp" title="My Profile"><i class="fas fa-user"></i></a>
                <a href="UserProfile.jsp" style="color: #e72463; font-size: 20px; text-align: center; display: block;">
                    ${sessionScope.user.name}
                </a>
                <div id="menu-bar" class="fa  fa-bars"></div>
            </div>
        </header>
        <!-- home section start -->
        <section class="home" id="home">
            <div class="detail">
                <span>top trend</span>
                <h1>2025 top trend flowers</h1>
                <p>Dolor sit amet consectetur adipisicing elit. Placeat provident labore, fugiat nihil voluptatem consectetur? <br>Nostrum fugit nulla exercitationem officiis ad cumque, illo odio et id numquam porro recusandae laboriosam?</p>
                <a href="#shop" class="btn">shop now</a>
            </div>
        </section>
        <!-- service section start -->
        <section class="services" id="services">
            <div class="box-container">
                <div class="box">
                    <div class="icon">
                        <img src="image/fast-delivery.png" alt="">
                    </div>
                    <div class="detail">
                        <h4>delivery</h4>
                        <span>100% secure</span>
                    </div>
                </div>
                <div class="box">
                    <div class="icon">
                        <img src="image/pay.png" alt="">
                    </div>
                    <div class="detail">
                        <h4>payment</h4>
                        <span>100% secure</span>
                    </div>
                </div>
                <div class="box">
                    <div class="icon">
                        <img src="image/support.png" alt="">
                    </div>
                    <div class="detail">
                        <h4>support</h4>
                        <span>24*7 hours</span>
                    </div>
                </div>
                <div class="box">
                    <div class="icon">
                        <img src="image/gift-box.png" alt="">
                    </div>
                    <div class="detail">
                        <h4>gift service</h4>
                        <span>support gift services</span>
                    </div>
                </div>
                <div class="box">
                    <div class="icon">
                        <img src="image/easy-return.png" alt="">
                    </div>
                    <div class="detail">
                        <h4>returns</h4>
                        <span>24*7 free returns</span>
                    </div>
                </div>
                <div class="box">
                    <div class="icon">
                        <img src="image/returning.png" alt="">
                    </div>
                    <div class="detail">
                        <h4>money back</h4>
                        <span>100% secure</span>
                    </div>
                </div>
            </div>
        </section>
        <!-- about section start -->
        <div class="about" id="about">
            <div class="row">
                <div class="box">
                    <img src="image/about.jpg" alt="" class="img">
                    <img src="image/blog.avif" alt="">
                </div>
                <div class="content">
                    <span>why choose us</span>
                    <h3>take a look around our shop</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quos sint ea fuga blanditiis eum aliquid commodi ab labore exercitationem numquam, odit, obcaecati nisi voluptatem. Accusantium eius quisquam quasi in quaerat! Lorem ipsum dolor sit amet consectetur adipisicing elit. Vitae tenetur optio et eius ut? Consequuntur, praesentium nemo at, nisi odit repellendus culpa dignissimos voluptate recusandae molestias possimus voluptatum ex? Sunt! Lorem ipsum dolor, sit amet consectetur adipisicing elit. Consequatur modi magnam nulla. Tenetur animi deleniti ea atque voluptate earum in delectus, quae consequatur nostrum ad, laboriosam tempore aspernatur possimus minus?</p>
                    <div class="buttons">
                        <a href="#shop" class="btn">shop now</a>
                        <a href="#shop" class="btn">learn more</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- shop section start -->
        <div class="shop" id="shop">
            <h1 class="heading">our best products</h1>

            <div class="box-container" id="productList">
                <c:forEach var="product" items="${sessionScope.products}">
                    <div class="box" data-name="${product.name}">
                        <a href="productDetail?flowerId=${product.getFlowerId()}"><img src="${product.imageUrl}" alt="${product.getName()}" style="width: 500px; height: 500px; object-fit: cover; border-radius: 5px;"></a>
                        <p class="price">price : <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" groupingUsed="true" /></p>
                        <div class="detail">
                            <h1 class="heading" 
                                style="font-size: 20px; font-weight: bold; text-align: center; color: #333;
                                padding: 10px 0; transition: 0.3s;"
                                onmouseover="this.style.color = '#d9534f'" 
                                onmouseout="this.style.color = '#333'">
                                ${product.name}
                            </h1>
                            <div class="add-to-cart-btn" data-product-id="${product.flowerId}">
                                <i class="fa fa-cart-plus" 
                                   style="font-size: 24px; color: #d9534f; cursor: pointer; padding: 10px;
                                   border-radius: 50%; background: #ffe6e6; transition: 0.3s;"
                                   onmouseover="this.style.background = '#ffcccc'" 
                                   onmouseout="this.style.background = '#ffe6e6'"></i>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- contact section start -->
        <section class="contact" id="contact">
            <form action="">
                <div class="heading">
                    <span>any query</span>
                    <h1>contact us</h1>
                </div>
                <div class="input-field">
                    <label for="">name <sup>*</sup></label><br>
                    <input type="text">
                </div>
                <div class="input-field">
                    <label for="">email <sup>*</sup></label><br>
                    <input type="email">
                </div>
                <div class="input-field">
                    <label for="">number <sup>*</sup></label><br>
                    <input type="number">
                </div>
                <div class="input-field">
                    <label for="">message <sup>*</sup></label><br>
                    <textarea name="" id="" cols="30" rows="10"></textarea>
                </div>
                <button class="btn">send message</button>
            </form>
        </section>
        <section class="blog" id="blog">
            <h1 class="heading">our blog</h1>
            <p style="text-align: center; font-size: 1.5rem;">A collection of stories about the people and
                places we admire.</p>
            <div class="box-container">
                <div class="box">
                    <p class="date">june 20, 2023</p>
                    <div class="img-box">
                        <img src="image/blog2.avif" alt="">
                    </div>
                    <div class="detail">
                        <h1>The Standard Chunk Of Lorem Ipsum Used Since</h1>
                        <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Quisquam eveniet optio commodi sit fugiat quaerat quam, vero aut beatae porro accusantium molestiae consequatur necessitatibus amet sapiente accusamus cumque adipisci repellendus.</p>
                        <a href="" class="btn">read more</a>
                    </div>

                </div>
                <div class="box">
                    <p class="date">june 20, 2023</p>
                    <div class="img-box">
                        <img src="image/blog0.avif" alt="">
                    </div>
                    <div class="detail">
                        <h1>The Standard Chunk Of Lorem Ipsum Used Since</h1>
                        <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Quisquam eveniet optio commodi sit fugiat quaerat quam, vero aut beatae porro accusantium molestiae consequatur necessitatibus amet sapiente accusamus cumque adipisci repellendus.</p>
                        <a href="" class="btn">read more</a>
                    </div>

                </div>
                <div class="box">
                    <p class="date">june 20, 2023</p>
                    <div class="img-box">
                        <img src="image/blog.avif" alt="">
                    </div>
                    <div class="detail">
                        <h1>The Standard Chunk Of Lorem Ipsum Used Since</h1>
                        <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Quisquam eveniet optio commodi sit fugiat quaerat quam, vero aut beatae porro accusantium molestiae consequatur necessitatibus amet sapiente accusamus cumque adipisci repellendus.</p>
                        <a href="" class="btn">read more</a>
                    </div>

                </div>
            </div>
        </section>
        <div class="client">
            <img src="image/client.png" alt="">
            <img src="image/client0.avif" alt="">
            <img src="image/client1.avif" alt="">
            <img src="image/client2.png" alt="">
            <img src="image/client3.avif" alt="">
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


    </body>

    <script src="script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
                                       $(document).ready(function () {
                                           $(".add-to-cart-btn").on("click", function () {
                                               let productId = $(this).data("product-id");
                                               $.ajax({
                                                   url: "addToCart",
                                                   type: "POST",
                                                   data: {pid: productId},
                                                   success: function (response) {
                                                       response = response.trim();
                                                       if (response === "success") {
                                                           showNotification("Sản phẩm đã được thêm vào giỏ hàng!", "success");
                                                       } else if (response === "not_logged_in") {
                                                           window.location.href = "login"; // Chuyển hướng khi chưa đăng nhập
                                                       } else {
                                                           showNotification("Thêm sản phẩm thất bại!", "error");
                                                       }
                                                   },
                                                   error: function () {
                                                       showNotification("Có lỗi xảy ra, vui lòng thử lại.", "error");
                                                   }
                                               });
                                           });

                                           // Hàm hiển thị thông báo
                                           function showNotification(message, type) {
                                               let bgColor = type === "success" ? "#28a745" : "#dc3545";
                                               let progressColor = type === "success" ? "#ffffff" : "#ff9999";

                                               // Tạo thông báo
                                               let notification = $("<div></div>", {
                                                   class: "cart-notification",
                                                   text: message,
                                                   css: {
                                                       "position": "fixed",
                                                       "top": "-60px",
                                                       "left": "50%",
                                                       "transform": "translateX(-50%)",
                                                       "padding": "12px 25px",
                                                       "background": bgColor,
                                                       "color": "white",
                                                       "border-radius": "10px",
                                                       "z-index": "1000",
                                                       "font-weight": "bold",
                                                       "box-shadow": "0px 4px 10px rgba(0, 0, 0, 0.2)",
                                                       "min-width": "280px",
                                                       "text-align": "center",
                                                       "opacity": "0",
                                                       "transition": "opacity 0.3s ease-in-out, top 0.3s ease-in-out"
                                                   }
                                               });

                                               // Thanh trượt
                                               let progressBar = $("<div></div>", {
                                                   class: "progress-bar",
                                                   css: {
                                                       "position": "absolute",
                                                       "bottom": "0",
                                                       "left": "0",
                                                       "height": "4px",
                                                       "background": progressColor,
                                                       "width": "0%",
                                                       "border-radius": "0 0 10px 10px",
                                                       "transition": "width 2s linear"
                                                   }
                                               });

                                               notification.append(progressBar);
                                               $("body").append(notification);

                                               // Hiển thị thông báo
                                               setTimeout(() => {
                                                   notification.css({"top": "20px", "opacity": "1"});
                                                   progressBar.css("width", "100%");
                                               }, 100);

                                               // Sau 3 giây, làm mờ dần rồi biến mất
                                               setTimeout(() => {
                                                   notification.css({"opacity": "0", "top": "-60px"});
                                                   setTimeout(() => notification.remove(), 200);
                                               }, 2000);
                                           }
                                       });
    </script>

</html>
