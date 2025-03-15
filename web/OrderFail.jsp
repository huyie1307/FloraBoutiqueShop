<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt hàng thành công</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 600px;
                margin-top: 50px;
                padding: 20px;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            .custom-btn {
                display: inline-block;
                padding: 12px 24px;
                background-color: #FF0080;
                color: white;
                font-size: 18px;
                font-weight: bold;
                text-decoration: none;
                border-radius: 8px;
                transition: background 0.3s ease-in-out, transform 0.2s ease-in-out;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }
            .custom-btn:hover {
                background-color: #cc0066;
                transform: scale(1.05);
                box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="alert alert-success d-flex align-items-center" role="alert">
                <i class="fas fa-check-circle me-2" style="font-size: 24px; color: red;"></i>
                <div>
                    <strong>Đặt hàng thất bại!</strong>Vui lòng đặt lại đơn hàng này.
                </div>
            </div>
            <a href="listorder" class="custom-btn">Quay về giỏ hàng</a>
        </div>
    </body>
</html>

