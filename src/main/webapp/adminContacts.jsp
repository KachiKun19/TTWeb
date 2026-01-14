<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Liên Hệ - Kachi-Kun Shop</title>
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


.page-header {
    margin-bottom: 25px;
    border-bottom: 2px solid #eee;
    padding-bottom: 15px;
}

.page-header h2 {
    color: #2d7e7e;
    font-weight: 700;
}

.table-responsive {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    overflow-x: auto;
    padding: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background-color: #f8f9fa;
    color: #555;
    font-weight: 600;
    padding: 15px;
    text-align: left;
    border-bottom: 2px solid #2d7e7e;
    text-transform: uppercase;
    font-size: 0.85rem;
}

td {
    padding: 15px;
    border-bottom: 1px solid #eee;
    vertical-align: top;
    color: #444;
}

tr:hover {
    background-color: #f0f7f7;
}


.status-badge {
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.status-unread {
    background-color: #fff5f5;
    color: #e53e3e; 
    border: 1px solid #fed7d7;
}

.status-read {
    background-color: #f0fff4;
    color: #38a169; 
    border: 1px solid #c6f6d5;
}


.btn-action {
    background-color: #2d7e7e;
    color: white;
    padding: 6px 12px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 0.85rem;
    transition: 0.3s;
    display: inline-flex;
    align-items: center;
    gap: 5px;
}

.btn-action:hover {
    background-color: #1a5c5c;
    color: white;
}

.message-preview {
    max-width: 300px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    color: #666;
}

@media ( max-width : 992px) {
	.admin-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		margin-bottom: 20px;
	}
}
</style>
</head>
<body>
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
				<li><a href="adminHome"><i class="fas fa-tachometer-alt"></i> Tổng quan</a></li>
				<li><a href="adminUsers"><i class="fas fa-users"></i> Quản lý người dùng</a></li>
				<li><a href="adminProducts"><i class="fas fa-box"></i> Quản lý sản phẩm</a></li>
				<li><a href="adminOrders"><i class="fas fa-shopping-cart"></i> Quản lý đơn hàng</a></li>
                <li><a href="adminContacts" class="active"><i class="fas fa-envelope"></i> Quản lý liên hệ</a></li>
				<li><a href="home"><i class="fas fa-store"></i> Về trang cửa hàng</a></li>
			</ul>
		</div>

		<div class="main-content">
			
            <div class="page-header">
                <h2><i class="fas fa-envelope"></i> Hộp thư góp ý & Liên hệ</h2>
                <p style="color: #666; font-size: 0.9rem; margin-top: 5px;">
                    Danh sách tin nhắn từ khách hàng gửi qua form liên hệ.
                </p>
            </div>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th width="5%">ID</th>
                            <th width="20%">Người gửi</th>
                            <th width="15%">Chủ đề</th>
                            <th width="35%">Nội dung</th>
                            <th width="15%">Thời gian</th>
                            <th width="10%">Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${messages}" var="msg">
                            <tr>
                                <td>#${msg.id}</td>
                                <td>
                                    <div style="font-weight: 700; color: #2d7e7e;">${msg.fullName}</div>
                                    <div style="font-size: 0.8rem; color: #777;">
                                        <i class="fas fa-envelope"></i> ${msg.email}
                                    </div>
                                    <c:if test="${not empty msg.phone}">
                                        <div style="font-size: 0.8rem; color: #777;">
                                            <i class="fas fa-phone"></i> ${msg.phone}
                                        </div>
                                    </c:if>
                                </td>
                                <td style="font-weight: 500;">${msg.subject}</td>
                                <td>
                                    <div class="message-preview" title="${msg.message}">
                                        ${msg.message}
                                    </div>
                                </td>
                                <td>
                                    <div style="font-size: 0.85rem;">
                                        <i class="far fa-clock"></i> 
                                        <fmt:formatDate value="${msg.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${msg.status == 'Chưa đọc'}">
                                            <span class="status-badge status-unread">Chưa đọc</span>
                                            <div style="margin-top: 5px;">
                                                <a href="adminContacts?action=markRead&id=${msg.id}" class="btn-action" title="Đánh dấu đã xem">
                                                    <i class="fas fa-check"></i> Xử lý
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-read">Đã xem</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty messages}">
                            <tr>
                                <td colspan="6" style="text-align: center; padding: 40px; color: #888;">
                                    <i class="fas fa-clipboard-check" style="font-size: 3rem; margin-bottom: 10px; color: #cbd5e0;"></i>
                                    <p>Hiện chưa có tin nhắn liên hệ nào!</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

		</div>
	</div>

</body>
</html>