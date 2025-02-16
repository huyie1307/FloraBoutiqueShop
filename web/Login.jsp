<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon_1.png">
        <link rel="icon" type="image/png" href="assets/img/favicon_1.png">
        <title>
            Đăng nhập
        </title>
        <!--     Fonts and icons     -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700,900" />
        <!-- Nucleo Icons -->
        <link href="assets/css/nucleo-icons.css" rel="stylesheet" />
        <link href="assets/css/nucleo-svg.css" rel="stylesheet" />
        <!-- Font Awesome Icons -->
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <!-- Material Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
        <!-- CSS Files -->
        <link id="pagestyle" href="assets/css/material-dashboard.css?v=3.2.0" rel="stylesheet" />
    </head>

    <body class="bg-gray-200">
        <div class="container position-sticky z-index-sticky top-0">
            <div class="row">
                <div class="col-12">
                    <!-- Navbar -->
                    <nav class="navbar navbar-expand-lg blur border-radius-xl top-0 z-index-3 shadow position-absolute my-3 py-2 start-0 end-0 mx-4">
                        <div class="container-fluid ps-2 pe-0">
                            <a class="navbar-brand font-weight-bolder ms-lg-0 ms-3" href="index.html" style="color: #FF0080;">
                                Quay trở lại trang chủ
                            </a>

                        </div>
                    </nav>
                    <!-- End Navbar -->
                </div>
            </div>
        </div>
        <main class="main-content  mt-0">
            <div class="page-header align-items-start min-vh-100" style="background-image: url('https://t4.ftcdn.net/jpg/03/74/90/41/360_F_374904104_EcOjLIlgNyGhXgMD929ksRjiaZ3tpuPu.jpg');">
                <span class="mask bg-gradient-dark opacity-6"></span>
                <div class="container my-auto">
                    <div class="row">
                        <div class="col-lg-4 col-md-8 col-12 mx-auto">
                            <div class="card z-index-0 fadeIn3 fadeInBottom">
                                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                                    <div class="shadow-dark border-radius-lg py-3 pe-1" style="background: linear-gradient(#FF0080, #FF0080);">
                                        <!-- Nội dung của bạn -->
                                        <h4 class="text-white font-weight-bolder text-center mt-2 mb-0">Login</h4>

                                    </div>


                                </div>
                                <div class="text-center text-danger mt-2">
                                    <strong>${requestScope.message}</strong>
                                </div>
                                <div class="card-body">
                                    <form role="form" class="text-start" action="login" method="POST">
                                        <div class="input-group input-group-outline my-4">
                                            <input type="text" class="form-control" name="user" id="text" placeholder="">
                                            <label for="text" class="form-label">Tài khoản</label>
                                        </div>
                                        <div class="input-group input-group-outline my-4">
                                            <input type="password" class="form-control" name="pass" id="text" placeholder="">
                                            <label for="text" class="form-label">Mật khẩu</label>
                                        </div>
                                        <div class="text-center">
                                            <button type="submit" class="btn" style="background-color: #ff69b4; color: white;" class="w-100 my-4 mb-2">Log in</button>
                                        </div>

                                    </form>
                                    <div class="text-center">
                                        <p>Chưa có tài khoản?</p>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit"  class="btn" style="background-color: #ff69b4; color: white;" class="w-100 my-4 mb-2" onclick="window.location.href='signup.jsp';">Sign up</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <footer class="footer position-absolute bottom-2 py-2 w-100">
                    <div class="container">
                        <div class="row align-items-center justify-content-lg-between">
                            <div class="col-12 col-md-6 my-auto">
                                <div class="copyright text-center text-sm text-white text-lg-start">
                                    © <script>
                                        document.write(new Date().getFullYear())
                                    </script>,
                                    made with <i class="fa fa-heart" aria-hidden="true"></i> by
                                    <a href="wish" class="font-weight-bold text-white" target="_blank">Wish</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </main>
        <!--   Core JS Files   -->
        <script src="assets/js/core/popper.min.js"></script>
        <script src="assets/js/core/bootstrap.min.js"></script>
        <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
        <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
        <script>
                                        var win = navigator.platform.indexOf('Win') > -1;
                                        if (win && document.querySelector('#sidenav-scrollbar')) {
                                            var options = {
                                                damping: '0.5'
                                            }
                                            Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
                                        }
        </script>
        <script src="assets/js/material-dashboard.min.js?v=3.2.0"></script>

    </body>

</html>
