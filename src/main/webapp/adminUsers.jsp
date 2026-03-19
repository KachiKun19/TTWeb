<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Người Dùng - Kachi-Kun Shop</title>
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
	font-family: 'Montserrat', 'Arial', sans-serif;
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
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.page-header h2 {
	font-size: 24px;
	color: #2d7e7e;
}

.add-user-btn {
	background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
	color: white;
	border: none;
	padding: 12px 24px;
	border-radius: 6px;
	font-family: 'Montserrat', sans-serif;
	font-weight: 600;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 8px;
	transition: transform 0.3s, box-shadow 0.3s;
}

.add-user-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(45, 126, 126, 0.3);
}

.alert {
	padding: 15px;
	border-radius: 6px;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.alert-success {
	background-color: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
}

.alert-error {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

.users-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 30px;
	margin-bottom: 30px;
}

.user-section {
	background-color: white;
	border-radius: 10px;
	padding: 25px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 2px solid #f0f0f0;
}

.section-header h3 {
	font-size: 18px;
	color: #2d7e7e;
	display: flex;
	align-items: center;
	gap: 10px;
}

.admin-count, .user-count {
	background-color: #f0f7f7;
	color: #2d7e7e;
	padding: 4px 12px;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 600;
}

.user-list {
	list-style: none;
}

.user-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 15px 0;
	border-bottom: 1px solid #f5f5f5;
}

.user-item:last-child {
	border-bottom: none;
}

.user-info-small {
	display: flex;
	align-items: center;
	gap: 15px;
}

.user-avatar-small {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-weight: 600;
	font-size: 18px;
}

.user-details {
	flex: 1;
}

.user-name {
	font-weight: 600;
	color: #333;
	margin-bottom: 3px;
}

.user-username {
	font-size: 14px;
	color: #666;
	margin-bottom: 3px;
}

.user-email {
	font-size: 13px;
	color: #888;
}

.user-actions {
	display: flex;
	gap: 8px;
}

.action-btn {
	padding: 8px 12px;
	border-radius: 4px;
	border: none;
	font-family: 'Montserrat', sans-serif;
	font-weight: 500;
	font-size: 13px;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 5px;
	transition: all 0.3s;
	min-width: 80px;
	justify-content: center;
}

.promote-btn {
	background-color: #4facfe;
	color: white;
}

.promote-btn:hover {
	background-color: #3a9aed;
}

.demote-btn {
	background-color: #ffc107;
	color: #333;
}

.demote-btn:hover {
	background-color: #e0a800;
}

.delete-btn {
	background-color: #f5576c;
	color: white;
}

.delete-btn:hover {
	background-color: #e4465a;
}

.add-user-form {
	background-color: white;
	border-radius: 10px;
	padding: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

.form-title {
	font-size: 20px;
	color: #2d7e7e;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.form-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
	margin-bottom: 25px;
}

.form-group {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.form-group label {
	font-weight: 600;
	color: #555;
	font-size: 14px;
}

.form-group .required {
	color: #dc3545;
}

.form-control {
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-family: 'Montserrat', sans-serif;
	font-size: 14px;
	transition: border-color 0.3s;
}

.form-control:focus {
	outline: none;
	border-color: #2d7e7e;
	box-shadow: 0 0 0 3px rgba(45, 126, 126, 0.1);
}

.form-actions {
	display: flex;
	justify-content: flex-end;
	gap: 15px;
}

.submit-btn, .reset-btn {
	padding: 12px 24px;
	border-radius: 6px;
	font-family: 'Montserrat', sans-serif;
	font-weight: 600;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 8px;
	transition: all 0.3s;
	border: none;
}

.submit-btn {
	background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
	color: white;
}

.submit-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(45, 126, 126, 0.3);
}

.reset-btn {
	background-color: #f8f9fa;
	color: #6c757d;
	border: 1px solid #ddd;
}

.reset-btn:hover {
	background-color: #e9ecef;
}

.no-users {
	text-align: center;
	padding: 40px;
	color: #777;
	font-size: 16px;
}

.no-users i {
	font-size: 48px;
	margin-bottom: 15px;
	color: #ccc;
}

@media ( max-width : 992px) {
	.admin-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		margin-bottom: 20px;
	}
	.users-container {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 768px) {
	.page-header {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
	.form-grid {
		grid-template-columns: 1fr;
	}
	.user-item {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
	.user-actions {
		width: 100%;
		justify-content: flex-end;
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
				<li><a href="adminHome"><i class="fas fa-tachometer-alt"></i>
						Tổng quan</a></li>
				<li><a href="adminUsers" class="active"><i class="fas fa-users"></i> Quản lý người
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
			<div class="page-header">
				<h2>
					<i class="fas fa-users"></i> Quản Lý Người Dùng
				</h2>
				<button class="add-user-btn" onclick="toggleAddForm()">
					<i class="fas fa-user-plus"></i> Thêm Người Dùng Mới
				</button>
			</div>

			
			<c:if test="${param.success eq 'add_success'}">
				<div class="alert alert-success">
					<i class="fas fa-check-circle"></i> Người dùng đã được thêm thành công!
				</div>
			</c:if>
			
			<c:if test="${param.success eq 'delete_success'}">
				<div class="alert alert-success">
					<i class="fas fa-check-circle"></i> Người dùng đã được xóa thành công!
				</div>
			</c:if>
			
			<c:if test="${param.success eq 'role_updated'}">
				<div class="alert alert-success">
					<i class="fas fa-check-circle"></i> Vai trò người dùng đã được cập nhật!
				</div>
			</c:if>

			
			<c:if test="${param.error eq 'add_failed'}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-circle"></i> Không thể thêm người dùng. Tên đăng nhập có thể đã tồn tại!
				</div>
			</c:if>
			
			<c:if test="${param.error eq 'delete_failed'}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-circle"></i> Không thể xóa người dùng. Vui lòng thử lại!
				</div>
			</c:if>
			
			<c:if test="${param.error eq 'cannot_delete_self'}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-circle"></i> Không thể xóa tài khoản của chính bạn!
				</div>
			</c:if>
			
			<c:if test="${param.error eq 'cannot_change_self_role'}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-circle"></i> Không thể thay đổi vai trò của chính bạn!
				</div>
			</c:if>
			
			<c:if test="${param.error eq 'user_not_found'}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-circle"></i> Không tìm thấy người dùng!
				</div>
			</c:if>

			
			<div id="addUserForm" class="add-user-form" style="display: none;">
				<h3 class="form-title">
					<i class="fas fa-user-plus"></i> Thêm Người Dùng Mới
				</h3>
				<form action="adminUsers" method="POST">
					<input type="hidden" name="action" value="add">
					
					<div class="form-grid">
						<div class="form-group">
							<label for="username">Tên đăng nhập <span class="required">*</span></label>
							<input type="text" id="username" name="username" class="form-control"
								placeholder="Nhập tên đăng nhập" required>
						</div>
						
						<div class="form-group">
							<label for="password">Mật khẩu <span class="required">*</span></label>
							<input type="password" id="password" name="password" class="form-control"
								placeholder="Nhập mật khẩu" required>
						</div>
						
						<div class="form-group">
							<label for="fullName">Họ và tên</label>
							<input type="text" id="fullName" name="fullName" class="form-control"
								placeholder="Nhập họ và tên">
						</div>
						
						<div class="form-group">
							<label for="email">Email</label>
							<input type="email" id="email" name="email" class="form-control"
								placeholder="Nhập địa chỉ email">
						</div>
						
						<div class="form-group">
							<label for="role">Vai trò</label>
							<select id="role" name="role" class="form-control">
								<option value="0">Người dùng</option>
								<option value="1">Quản trị viên</option>
							</select>
						</div>
					</div>
					
					<div class="form-actions">
						<button type="button" class="reset-btn" onclick="toggleAddForm()">
							<i class="fas fa-times"></i> Hủy
						</button>
						<button type="submit" class="submit-btn">
							<i class="fas fa-save"></i> Lưu Người Dùng
						</button>
					</div>
				</form>
			</div>

			
			<div class="users-container">
				
				<div class="user-section">
					<div class="section-header">
						<h3>
							<i class="fas fa-user-shield"></i> Quản Trị Viên
						</h3>
						<span class="admin-count">${adminList.size()} người</span>
					</div>
					
					<ul class="user-list">
						<c:choose>
							<c:when test="${empty adminList}">
								<div class="no-users">
									<i class="fas fa-user-slash"></i>
									<p>Chưa có quản trị viên nào</p>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="admin" items="${adminList}">
									<li class="user-item">
										<div class="user-info-small">
											<div class="user-avatar-small">
												${admin.fullName.charAt(0)}
											</div>
											<div class="user-details">
												<div class="user-name">${admin.fullName}</div>
												<div class="user-username">@${admin.username}</div>
												<div class="user-email">${admin.email}</div>
											</div>
										</div>
										<div class="user-actions">
											<c:if test="${admin.id ne user.id}">
												<button class="action-btn demote-btn" 
													onclick="changeRole(${admin.id}, 0)">
													<i class="fas fa-arrow-down"></i> Hạ cấp
												</button>
												<button class="action-btn delete-btn" 
													onclick="confirmDelete(${admin.id})">
													<i class="fas fa-trash"></i> Xóa
												</button>
											</c:if>
											<c:if test="${admin.id eq user.id}">
												<span style="color: #777; font-size: 13px; font-style: italic;">
													(Tài khoản của bạn)
												</span>
											</c:if>
										</div>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				
				
				<div class="user-section">
					<div class="section-header">
						<h3>
							<i class="fas fa-user"></i> Người Dùng
						</h3>
						<span class="user-count">${userList.size()} người</span>
					</div>
					
					<ul class="user-list">
						<c:choose>
							<c:when test="${empty userList}">
								<div class="no-users">
									<i class="fas fa-user-slash"></i>
									<p>Chưa có người dùng nào</p>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="userItem" items="${userList}">
									<li class="user-item">
										<div class="user-info-small">
											<div class="user-avatar-small">
												${userItem.fullName.charAt(0)}
											</div>
											<div class="user-details">
												<div class="user-name">${userItem.fullName}</div>
												<div class="user-username">@${userItem.username}</div>
												<div class="user-email">${userItem.email}</div>
											</div>
										</div>
										<div class="user-actions">
											<button class="action-btn promote-btn" 
												onclick="changeRole(${userItem.id}, 1)">
												<i class="fas fa-arrow-up"></i> Thăng cấp
											</button>
											<button class="action-btn delete-btn" 
												onclick="confirmDelete(${userItem.id})">
												<i class="fas fa-trash"></i> Xóa
											</button>
										</div>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<script>
		
		function toggleAddForm() {
			var form = document.getElementById('addUserForm');
			if (form.style.display === 'none' || form.style.display === '') {
				form.style.display = 'block';
			} else {
				form.style.display = 'none';
			}
		}
		
		
		function confirmDelete(userId) {
			if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
				
				var form = document.createElement('form');
				form.method = 'POST';
				form.action = 'adminUsers';
				
				var actionInput = document.createElement('input');
				actionInput.type = 'hidden';
				actionInput.name = 'action';
				actionInput.value = 'delete';
				
				var idInput = document.createElement('input');
				idInput.type = 'hidden';
				idInput.name = 'id';
				idInput.value = userId;
				
				form.appendChild(actionInput);
				form.appendChild(idInput);
				document.body.appendChild(form);
				form.submit();
			}
		}
		
		
		function changeRole(userId, newRole) {
			var message = newRole === 1 ? 
				"Bạn có chắc chắn muốn thăng cấp người dùng này thành Quản trị viên?" :
				"Bạn có chắc chắn muốn hạ cấp Quản trị viên này thành người dùng thường?";
			
			if (confirm(message)) {
				
				var form = document.createElement('form');
				form.method = 'POST';
				form.action = 'adminUsers';
				
				var actionInput = document.createElement('input');
				actionInput.type = 'hidden';
				actionInput.name = 'action';
				actionInput.value = 'updateRole';
				
				var idInput = document.createElement('input');
				idInput.type = 'hidden';
				idInput.name = 'id';
				idInput.value = userId;
				
				var roleInput = document.createElement('input');
				roleInput.type = 'hidden';
				roleInput.name = 'newRole';
				roleInput.value = newRole;
				
				form.appendChild(actionInput);
				form.appendChild(idInput);
				form.appendChild(roleInput);
				document.body.appendChild(form);
				form.submit();
			}
		}
		
		
		setTimeout(function() {
			var alerts = document.querySelectorAll('.alert');
			alerts.forEach(function(alert) {
				alert.style.display = 'none';
			});
		}, 5000);
		
		
		document.querySelector('#addUserForm form').addEventListener('submit', function(e) {
			var username = document.getElementById('username').value.trim();
			var password = document.getElementById('password').value.trim();
			
			if (!username) {
				alert('Vui lòng nhập tên đăng nhập!');
				e.preventDefault();
				return;
			}
			
			if (!password) {
				alert('Vui lòng nhập mật khẩu!');
				e.preventDefault();
				return;
			}
			
			if (password.length < 6) {
				alert('Mật khẩu phải có ít nhất 6 ký tự!');
				e.preventDefault();
				return;
			}
		});
	</script>
</body>
</html>