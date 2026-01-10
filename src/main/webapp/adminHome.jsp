<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Quản Trị - Kachi-Kun Shop</title>
<link rel="icon" type="image/png" href="images/LogoRemake.png" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap"
	rel="stylesheet">

<style>
/* CSS cho báo cáo doanh thu theo tháng */
.revenue-chart-container {
    margin-top: 20px;
}

.chart-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 25px;
    border-left: 4px solid #2d7e7e;
}

.chart-summary h3 {
    color: #2d7e7e;
    margin-bottom: 15px;
    font-size: 18px;
}

.summary-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
}

.stat-item {
    background: white;
    padding: 12px 15px;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.stat-label {
    display: block;
    font-size: 12px;
    color: #666;
    margin-bottom: 5px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.stat-value {
    font-size: 16px;
    font-weight: 600;
    color: #333;
}

.stat-value.total-revenue {
    color: #28a745;
    font-size: 18px;
}

.revenue-table-container {
    overflow-x: auto;
    border-radius: 8px;
    border: 1px solid #e9ecef;
}

.revenue-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
}

.revenue-table thead {
    background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
}

.revenue-table th {
    padding: 15px;
    text-align: left;
    color: white;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-size: 13px;
}

.revenue-table tbody tr {
    border-bottom: 1px solid #f1f1f1;
    transition: background-color 0.3s;
}

.revenue-table tbody tr:hover {
    background-color: #f8f9fa;
}

.revenue-table td {
    padding: 15px;
}

.month-column {
    font-weight: 600;
    color: #2d7e7e;
    min-width: 120px;
}

.revenue-column {
    font-weight: 600;
    color: #333;
    min-width: 150px;
}

.chart-column {
    width: 60%;
}

.chart-bar-container {
    background-color: #e9ecef;
    border-radius: 10px;
    height: 30px;
    overflow: hidden;
    position: relative;
}

.chart-bar {
    height: 100%;
    background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding-right: 10px;
    min-width: 40px;
    transition: width 1s ease-in-out;
}

.bar-label {
    color: white;
    font-size: 12px;
    font-weight: 600;
    text-shadow: 0 1px 2px rgba(0,0,0,0.2);
}

.no-data-message {
    text-align: center;
    padding: 40px 20px;
    color: #666;
}

.no-data-message i {
    font-size: 48px;
    color: #dee2e6;
    margin-bottom: 15px;
}

.no-data-message p {
    font-size: 16px;
}

/* Animation cho chart bars */
@keyframes slideIn {
    from {
        width: 0;
    }
    to {
        width: var(--bar-width);
    }
}

.revenue-table tbody tr:nth-child(1) .chart-bar {
    background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%);
}

.revenue-table tbody tr:nth-child(2) .chart-bar {
    background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
}

.revenue-table tbody tr:nth-child(3) .chart-bar {
    background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
}

@media (max-width: 768px) {
    .summary-stats {
        grid-template-columns: 1fr;
    }
    
    .revenue-table th,
    .revenue-table td {
        padding: 10px;
        font-size: 14px;
    }
    
    .chart-column {
        display: none;
    }
}
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Montserrat', sans-serif;
	background-color: #f5f7fa;
	color: #333;
	line-height: 1.6;
}

.admin-header {
	background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
	color: white;
	padding: 20px 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.admin-header h1 {
	font-size: 24px;
	font-weight: 600;
}

.user-info {
	display: flex;
	align-items: center;
	gap: 15px;
}

.user-avatar {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	background-color: rgba(255, 255, 255, 0.2);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
}

.logout-btn {
	background-color: rgba(255, 255, 255, 0.2);
	border: none;
	color: white;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
	font-family: 'Montserrat', sans-serif;
	font-weight: 500;
	transition: background-color 0.3s;
}

.logout-btn:hover {
	background-color: rgba(255, 255, 255, 0.3);
}

.admin-container {
	display: flex;
	min-height: calc(100vh - 80px);
}

.sidebar {
	width: 250px;
	background-color: white;
	padding: 20px 0;
	box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
}

.sidebar-menu {
	list-style: none;
}

.sidebar-menu li {
	padding: 0;
}

.sidebar-menu a {
	display: flex;
	align-items: center;
	padding: 15px 25px;
	color: #555;
	text-decoration: none;
	transition: all 0.3s;
	border-left: 4px solid transparent;
}

.sidebar-menu a:hover {
	background-color: #f0f7f7;
	color: #2d7e7e;
	border-left-color: #2d7e7e;
}

.sidebar-menu a.active {
	background-color: #e8f4f4;
	color: #2d7e7e;
	border-left-color: #2d7e7e;
	font-weight: 600;
}

.sidebar-menu i {
	width: 24px;
	margin-right: 12px;
	text-align: center;
}

.main-content {
	flex: 1;
	padding: 30px;
}

.dashboard-cards {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.card {
	background-color: white;
	border-radius: 10px;
	padding: 25px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.card-icon {
	width: 60px;
	height: 60px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 15px;
	font-size: 24px;
	color: white;
}

.card-icon.users {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.card-icon.products {
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.card-icon.orders {
	background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.card-icon.revenue {
	background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
}

.card h3 {
	font-size: 14px;
	color: #777;
	margin-bottom: 5px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.card-value {
	font-size: 28px;
	font-weight: 700;
	color: #333;
	margin-bottom: 10px;
}

.card-change {
	font-size: 13px;
	color: #28a745;
	font-weight: 600;
}

.card-change.negative {
	color: #dc3545;
}

.recent-activity {
	background-color: white;
	border-radius: 10px;
	padding: 25px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.recent-activity h2 {
	font-size: 20px;
	margin-bottom: 20px;
	color: #333;
	display: flex;
	align-items: center;
}

.recent-activity h2 i {
	margin-right: 10px;
	color: #2d7e7e;
}

.activity-list {
	list-style: none;
}

.activity-item {
	display: flex;
	padding: 15px 0;
	border-bottom: 1px solid #eee;
}

.activity-item:last-child {
	border-bottom: none;
}

.activity-icon {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 15px;
	font-size: 16px;
	color: white;
}

.activity-icon.new-user {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.activity-icon.new-order {
	background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.activity-icon.new-product {
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.activity-details {
	flex: 1;
}

.activity-title {
	font-weight: 600;
	margin-bottom: 3px;
}

.activity-desc {
	color: #666;
	margin-bottom: 3px;
	font-size: 14px;
}

.activity-time {
	color: #999;
	font-size: 12px;
}

.welcome-message {
	background-color: white;
	border-radius: 10px;
	padding: 25px;
	margin-bottom: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.welcome-message h2 {
	font-size: 24px;
	margin-bottom: 10px;
	color: #2d7e7e;
	display: flex;
	align-items: center;
	gap: 10px;
}

.welcome-message p {
	margin-bottom: 8px;
	color: #555;
}

#current-time {
	color: #2d7e7e;
	font-weight: 600;
}

@media (max-width: 992px) {
	.admin-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		margin-bottom: 20px;
	}
	.sidebar-menu {
		display: flex;
		flex-wrap: wrap;
		justify-content: center;
	}
	.sidebar-menu li {
		flex: 1 1 auto;
	}
}

@media (max-width: 768px) {
	.dashboard-cards {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>
	<div class="admin-header">
		<h1>Quản Trị Kachi-Kun Shop</h1>
		<div class="user-info">
			<div class="user-avatar">
				<i class="fas fa-user"></i>
			</div>
			<form action="logout" method="post">
				<button class="logout-btn" type="submit">
					<i class="fas fa-sign-out-alt"></i> Đăng xuất
				</button>
			</form>
		</div>
	</div>

	<div class="admin-container">
		<div class="sidebar">
			<ul class="sidebar-menu">
				<li><a href="adminHome" class="active"><i
						class="fas fa-tachometer-alt"></i> Tổng quan</a></li>
				<li><a href="adminUsers"><i class="fas fa-users"></i> Quản lý người
						dùng</a></li>
				<li><a href="adminProducts"><i class="fas fa-box"></i> Quản lý sản phẩm</a></li>
				<li><a href="adminOrders"><i class="fas fa-shopping-cart"></i> Quản
						lý đơn hàng</a></li>
				<li><a href="adminContacts"><i class="fas fa-envelope"></i> Quản lý liên hệ</a></li>
				<li><a href="home"><i class="fas fa-store"></i> Về trang
						cửa hàng</a></li>
			</ul>
		</div>

		<div class="main-content">
			<div class="welcome-message">
				<h2>
					<i class="fas fa-hand-wave"></i> Chào mừng trở lại, Quản trị viên!
				</h2>
				<p>Đây là bảng điều khiển quản trị của Kachi-Kun Shop. Bạn có
					thể quản lý người dùng, sản phẩm, đơn hàng và xem thống kê từ đây.</p>
				<p>
					Thời gian đăng nhập: <strong id="current-time"></strong>
				</p>
			</div>

			<div class="dashboard-cards">
				<div class="card">
					<div class="card-icon users">
						<i class="fas fa-users"></i>
					</div>
					<h3>Tổng người dùng</h3>
					<div class="card-value">${totalUsers}</div>
				</div>

				<div class="card">
					<div class="card-icon products">
						<i class="fas fa-box"></i>
					</div>
					<h3>Tổng sản phẩm</h3>
					<div class="card-value">${totalProducts}</div>
				</div>

				<div class="card">
					<div class="card-icon orders">
						<i class="fas fa-shopping-cart"></i>
					</div>
					<h3>Đơn hàng hôm nay</h3>
					<div class="card-value">${todayOrders}</div>
				</div>

				<div class="card">
					<div class="card-icon revenue">
						<i class="fas fa-dollar-sign"></i>
					</div>
					<h3>Doanh thu hôm nay</h3>
					<div class="card-value">
						<fmt:formatNumber value="${todayRevenue}" type="currency" currencySymbol="₫" />
					</div>
				</div>
			</div>

<div class="recent-activity">
    <h2>
        <i class="fas fa-chart-line"></i> Báo cáo doanh thu theo tháng
    </h2>
    
    <c:if test="${not empty monthlyRevenue}">
        <div class="revenue-chart-container">
            <div class="chart-header">
                <div class="chart-summary">
                    <h3>Tổng quan 12 tháng gần nhất</h3>
                    <div class="summary-stats">
                        <div class="stat-item">
                            <span class="stat-label">Tháng cao nhất:</span>
                            <span class="stat-value">
                                <fmt:formatNumber value="${maxRevenue}" type="currency" currencySymbol="₫" />
                            </span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-label">Trung bình/tháng:</span>
                            <span class="stat-value">
                                <fmt:formatNumber value="${avgRevenue}" type="currency" currencySymbol="₫" />
                            </span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-label">Tổng doanh thu:</span>
                            <span class="stat-value total-revenue">
                                <fmt:formatNumber value="${totalYearRevenue}" type="currency" currencySymbol="₫" />
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="revenue-table-container">
                <table class="revenue-table">
                    <thead>
                        <tr>
                            <th>Tháng/Năm</th>
                            <th>Doanh thu</th>
                            <th>Tỷ lệ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="maxValue" value="${0}" />
                        <c:forEach items="${monthlyRevenue}" var="entry">
                            <c:if test="${entry.value > maxValue}">
                                <c:set var="maxValue" value="${entry.value}" />
                            </c:if>
                        </c:forEach>
                        
                        <c:set var="total" value="${0}" />
                        <c:forEach items="${monthlyRevenue}" var="entry">
                            <c:set var="total" value="${total + entry.value}" />
                        </c:forEach>
                        
                        <c:forEach items="${monthlyRevenue}" var="entry">
                            <c:set var="percentage" value="${(entry.value/maxValue)*100}" />
                            <c:set var="monthName" value="${entry.key}" />
                            <tr>
                                <td class="month-column">
                                    <span class="month-label">${monthName}</span>
                                </td>
                                <td class="revenue-column">
                                    <span class="revenue-value">
                                        <fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="₫" />
                                    </span>
                                </td>
                                <td class="chart-column">
                                    <div class="chart-bar-container">
                                        <div class="chart-bar" style="width: ${percentage}%">
                                            <span class="bar-label">
                                                <fmt:formatNumber value="${(entry.value/total)*100}" 
                                                    maxFractionDigits="1" />%
                                            </span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
    
    <c:if test="${empty monthlyRevenue}">
        <div class="no-data-message">
            <i class="fas fa-chart-pie"></i>
            <p>Chưa có dữ liệu doanh thu theo tháng.</p>
        </div>
    </c:if>
</div>
		</div>
	</div>

	<script>
		// Hiển thị thời gian hiện tại
		function updateCurrentTime() {
			const now = new Date();
			const options = {
				weekday : 'long',
				year : 'numeric',
				month : 'long',
				day : 'numeric',
				hour : '2-digit',
				minute : '2-digit',
				second : '2-digit',
				hour12 : false
			};
			const formattedTime = now.toLocaleDateString('vi-VN', options);
			document.getElementById('current-time').textContent = formattedTime;
		}

		updateCurrentTime();
		setInterval(updateCurrentTime, 1000);
	</script>
</body>
</html>