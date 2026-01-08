<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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
	color: white;
	flex-shrink: 0;
}

.activity-icon.new-user {
	background-color: #667eea;
}

.activity-icon.new-order {
	background-color: #4facfe;
}

.activity-icon.new-product {
	background-color: #f5576c;
}

.activity-details {
	flex: 1;
}

.activity-title {
	font-weight: 600;
	margin-bottom: 5px;
}

.activity-time {
	font-size: 13px;
	color: #777;
}

.welcome-message {
	background: linear-gradient(135deg, #e8f4f4 0%, #f0f7f7 100%);
	border-radius: 10px;
	padding: 30px;
	margin-bottom: 30px;
	border-left: 5px solid #2d7e7e;
}

.welcome-message h2 {
	color: #2d7e7e;
	margin-bottom: 10px;
}

.welcome-message p {
	color: #555;
	margin-bottom: 15px;
}

.alert {
	background-color: #fff3cd;
	border: 1px solid #ffeaa7;
	color: #856404;
	padding: 15px;
	border-radius: 5px;
	margin-bottom: 20px;
}

@media ( max-width : 992px) {
	.admin-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		margin-bottom: 20px;
	}
	.dashboard-cards {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 768px) {
	.dashboard-cards {
		grid-template-columns: 1fr;
	}
	.admin-header {
		flex-direction: column;
		gap: 15px;
		align-items: flex-start;
	}
	.user-info {
		align-self: flex-end;
	}
}
</style>
</head>
<body>
	<!-- Kiểm tra quyền admin -->
	<c:if test="${empty user or user.role ne 1}">
		<c:redirect url="login" />
	</c:if>

	<div class="admin-header">
		<h1>
			<i class="fas fa-crown"></i> Trang Quản Trị - Kachi-Kun Shop
		</h1>
		<div class="user-info">
			<div class="user-avatar">
				<i class="fas fa-user-shield"></i>
			</div>
			<div>
				<div>
					Xin chào, <strong>${user.fullName}</strong>
				</div>
				<div style="font-size: 12px; opacity: 0.9;">Quản trị viên</div>
			</div>
			<a href="logout">
				<button class="logout-btn">
					<i class="fas fa-sign-out-alt"></i> Đăng xuất
				</button>
			</a>
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
					<div class="card-value">1,248</div>
					<div class="card-change">+12% so với tháng trước</div>
				</div>

				<div class="card">
					<div class="card-icon products">
						<i class="fas fa-box"></i>
					</div>
					<h3>Tổng sản phẩm</h3>
					<div class="card-value">568</div>
					<div class="card-change">+8% so với tháng trước</div>
				</div>

				<div class="card">
					<div class="card-icon orders">
						<i class="fas fa-shopping-cart"></i>
					</div>
					<h3>Đơn hàng hôm nay</h3>
					<div class="card-value">42</div>
					<div class="card-change">+5% so với hôm qua</div>
				</div>

				<div class="card">
					<div class="card-icon revenue">
						<i class="fas fa-dollar-sign"></i>
					</div>
					<h3>Doanh thu hôm nay</h3>
					<div class="card-value">12.5 triệu ₫</div>
					<div class="card-change negative">-3% so với hôm qua</div>
				</div>
			</div>

			<div class="recent-activity">
				<h2>
					<i class="fas fa-history"></i> Hoạt động gần đây
				</h2>
				<ul class="activity-list">
					<li class="activity-item">
						<div class="activity-icon new-user">
							<i class="fas fa-user-plus"></i>
						</div>
						<div class="activity-details">
							<div class="activity-title">Người dùng mới đăng ký</div>
							<div class="activity-desc">"kachikun_fan" vừa đăng ký tài
								khoản</div>
							<div class="activity-time">10 phút trước</div>
						</div>
					</li>
					<li class="activity-item">
						<div class="activity-icon new-order">
							<i class="fas fa-cart-plus"></i>
						</div>
						<div class="activity-details">
							<div class="activity-title">Đơn hàng mới</div>
							<div class="activity-desc">Đơn hàng #ORD-2024-00123 với giá
								trị 850,000 ₫</div>
							<div class="activity-time">45 phút trước</div>
						</div>
					</li>
					<li class="activity-item">
						<div class="activity-icon new-product">
							<i class="fas fa-box-open"></i>
						</div>
						<div class="activity-details">
							<div class="activity-title">Sản phẩm mới được thêm</div>
							<div class="activity-desc">"Áo thun Kachi-Kun Limited
								Edition" đã được thêm vào kho</div>
							<div class="activity-time">2 giờ trước</div>
						</div>
					</li>
					<li class="activity-item">
						<div class="activity-icon new-user">
							<i class="fas fa-user-check"></i>
						</div>
						<div class="activity-details">
							<div class="activity-title">Xác minh người dùng</div>
							<div class="activity-desc">Tài khoản "shop_admin" đã được
								xác minh thành công</div>
							<div class="activity-time">5 giờ trước</div>
						</div>
					</li>
				</ul>
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