<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>

<%
    Map<String, Integer> revenueData = (Map<String, Integer>) request.getAttribute("revenueData");
    Integer totalRevenueObj = (Integer) request.getAttribute("totalRevenue");
    int totalRevenue = (totalRevenueObj != null) ? totalRevenueObj : 0;

    String labels = "";
    String data = "";

    if (revenueData != null) {
        for (Map.Entry<String, Integer> entry : revenueData.entrySet()) {
           labels += "\"" + entry.getKey() + "\",";
data += entry.getValue() + ",";

        }
    }

    if (!labels.isEmpty()) {
        labels = labels.substring(0, labels.length() - 1);
        data = data.substring(0, data.length() - 1);
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Doanh Thu</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body, html {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                width: 100%;
                height: 100%;
            }
            .main-container {
                display: flex;
                height: 100vh;
            }
            .sidebar {
                width: 250px;
                flex-shrink: 0;
                background-color: #f4f4f4;
                overflow-y: auto;
            }
            .content {
                flex: 1;
                padding: 20px;
                overflow-y: auto;
            }
            table {
                width: 100%;
                margin-top: 20px;
                border-collapse: collapse;
            }
            th, td {
                text-align: center;
                border: 1px solid #ddd;
                padding: 8px;
            }
            canvas {
                max-width: 100%;
                max-height: 300px;
            }
            select, input[type="date"] {
                margin: 10px;
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="sidebar">
                <jsp:include page="Admin.jsp"/>
            </div>
            <div class="content">
                <h1>Revenue Management</h1>
                <h2>Tổng doanh thu: <%= totalRevenue %> VND</h2>

                <div>
                    <label for="filterType">Chọn loại lọc:</label>
                    <select id="filterType" onchange="updateChart()">
                        <option value="day">Theo Ngày</option>
                        <option value="month">Theo Tháng</option>
                        <option value="year">Theo Năm</option>
                    </select>
                    <label for="filterDate">Chọn khoảng thời gian:</label>
                    <input type="date" id="filterDate" onchange="updateChart()"/>
                </div>

                <table>
                    <tr><th>Biểu đồ Doanh Thu</th></tr>
                    <tr><td><canvas id="revenueChart"></canvas></td></tr>
                </table>

                <script>
                    const revenueData = {
                    <% 
        if (revenueData != null) {
            for (Map.Entry<String, Integer> entry : revenueData.entrySet()) { 
                out.print("\"" + entry.getKey() + "\": " + entry.getValue() + ",");
            }
        } 
                    %>
                    };

                    let ctx = document.getElementById('revenueChart').getContext('2d');
                    let revenueChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: [],
                            datasets: [{
                                    label: 'Doanh thu',
                                    data: [],
                                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 1
                                }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {position: 'top'},
                                tooltip: {
                                    callbacks: {
                                        label: function (tooltipItem) {
                                            return tooltipItem.label + ': ' + tooltipItem.raw.toLocaleString() + ' VND';
                                        }
                                    }
                                }
                            },
                            scales: {
                                x: {title: {display: true, text: 'Thời gian'}},
                                y: {title: {display: true, text: 'Doanh thu (VND)'}}
                            }
                        }
                    });

                  function updateChart() {
    const filterType = document.getElementById('filterType').value;
    const filterDate = document.getElementById('filterDate').value;

    if (!filterDate) {
        alert("Vui lòng chọn ngày để lọc dữ liệu!");
        return;
    }

    const filteredData = {};

    Object.entries(revenueData).forEach(([date, revenue]) => {
        const d = new Date(date);
        const filter = new Date(filterDate);

        if (isNaN(d.getTime())) {
            console.warn("Ngày không hợp lệ:", date);
            return;
        }

        if (filterType === 'day' && d.toISOString().split('T')[0] === filterDate) {
            filteredData[date] = revenue;
        } 
        else if (filterType === 'month' && d.getMonth() === filter.getMonth() && d.getFullYear() === filter.getFullYear()) {
             const dayKey = `${d.getDate()}`;
            filteredData[dayKey] = revenue;
        } 
        else if (filterType === 'year' && d.getFullYear() === filter.getFullYear()) {
            // Nhóm doanh thu theo tháng thay vì ngày
            const monthKey = d.getFullYear() + '-' + ('0' + (d.getMonth() + 1)).slice(-2);

            
            if (!filteredData[monthKey]) {
                filteredData[monthKey] = 0;
            }
            
            filteredData[monthKey] += revenue; // Cộng dồn doanh thu vào từng tháng
        }
    });

    if (Object.keys(filteredData).length === 0) {
        alert("Không có dữ liệu để hiển thị biểu đồ!");
        return;
    }

    // Sắp xếp các tháng tăng dần
    const sortedData = Object.keys(filteredData)
        .sort((a, b) => new Date(a + '-01') - new Date(b + '-01'))
        .reduce((acc, key) => {
            acc[key] = filteredData[key];
            return acc;
        }, {});

    console.log("Sorted Data: ", sortedData);

    revenueChart.data.labels = Object.keys(sortedData);
    revenueChart.data.datasets[0].data = Object.values(sortedData);
    revenueChart.update();
}


                </script>
            </div>
        </div>
    </body>
</html>
