
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <style>
        body { font-family: Arial, sans-serif; }
   
        .content { margin-left: 260px; padding: 20px; }
    </style>
    </head>
    <body>
        <jsp:include page="Admin.jsp"/>
       <div class="content">
        <h2>Chào mừng đến với Admin Dashboard</h2>
        <div id="main-content">
            <p>Chọn một mục trong sidebar để quản lý dữ liệu.</p>
        </div>
    </div>
    </body>
</html>
