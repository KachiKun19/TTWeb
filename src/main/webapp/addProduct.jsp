<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thêm Sản Phẩm - Kachi-Kun Shop</title>
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
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.page-header h2 {
	font-size: 24px;
	color: #2d7e7e;
}

.back-btn {
	background-color: #6c757d;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 6px;
	font-family: 'Montserrat', sans-serif;
	font-weight: 500;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 8px;
	transition: background-color 0.3s;
}

.back-btn:hover {
	background-color: #5a6268;
}

.product-form-container {
	background-color: white;
	border-radius: 10px;
	padding: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	max-width: 800px;
	margin: 0 auto;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: #555;
}

.form-group label .required {
	color: #dc3545;
}

.form-control {
	width: 100%;
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

.form-row {
	display: flex;
	gap: 20px;
	margin-bottom: 20px;
}

.form-col {
	flex: 1;
}

.form-actions {
	display: flex;
	justify-content: flex-end;
	gap: 15px;
	margin-top: 30px;
	padding-top: 20px;
	border-top: 1px solid #eee;
}

.submit-btn, .cancel-btn {
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

.cancel-btn {
	background-color: #f8f9fa;
	color: #6c757d;
	border: 1px solid #ddd;
}

.cancel-btn:hover {
	background-color: #e9ecef;
}

.alert {
	padding: 15px;
	border-radius: 6px;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.alert-error {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

@media ( max-width : 992px) {
	.admin-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		margin-bottom: 20px;
	}
	.form-row {
		flex-direction: column;
		gap: 0;
	}
}

@media ( max-width : 768px) {
	.page-header {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
	.form-actions {
		flex-direction: column;
	}
	.submit-btn, .cancel-btn {
		width: 100%;
		justify-content: center;
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
				<li><a href="adminHome"><i class="fas fa-tachometer-alt"></i>
						Tổng quan</a></li>
				<li><a href="#"><i class="fas fa-users"></i> Quản lý người
						dùng</a></li>
				<li><a href="adminProducts" class="active"><i
						class="fas fa-box"></i> Quản lý sản phẩm</a></li>
				<li><a href="#"><i class="fas fa-shopping-cart"></i> Quản
						lý đơn hàng</a></li>
				<li><a href="home"><i class="fas fa-store"></i> Về trang
						cửa hàng</a></li>
			</ul>
		</div>

		<div class="main-content">
			<div class="page-header">
				<h2>
					<i class="fas fa-plus-circle"></i> Thêm Sản Phẩm Mới
				</h2>
				<a href="adminProducts">
					<button class="back-btn">
						<i class="fas fa-arrow-left"></i> Quay lại
					</button>
				</a>
			</div>

			<!-- Hiển thị thông báo lỗi nếu có -->
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-circle"></i> ${errorMessage}
				</div>
			</c:if>

			<div class="product-form-container">
				<form action="addProduct" method="POST">
					<div class="form-row">
						<div class="form-col">
							<div class="form-group">
								<label for="name">Tên sản phẩm <span class="required">*</span></label>
								<input type="text" id="name" name="name" class="form-control"
									placeholder="Nhập tên sản phẩm" required>
							</div>

							<div class="form-group">
								<label for="price">Giá <span class="required">*</span></label>
								<input type="number" id="price" name="price"
									class="form-control" placeholder="Nhập giá sản phẩm" step="0.01"
									min="0" required>
							</div>

							<div class="form-group">
								<label for="stock">Số lượng tồn kho</label>
								<input type="number" id="stock" name="stock"
									class="form-control" placeholder="Nhập số lượng" min="0"
									value="0">
							</div>

							<div class="form-group">
								<label for="categoryId">Danh mục</label>
								<select id="categoryId" name="categoryId" class="form-control">
									<option value="">-- Chọn danh mục --</option>
									<c:forEach var="category" items="${categories}">
										<option value="${category.id}">${category.name}</option>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label for="brandId">Thương hiệu</label>
								<select id="brandId" name="brandId" class="form-control">
									<option value="">-- Chọn thương hiệu --</option>
									<c:forEach var="brand" items="${brands}">
										<option value="${brand.id}">${brand.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-col">
							<div class="form-group">
								<label for="description">Mô tả sản phẩm</label>
								<textarea id="description" name="description"
									class="form-control" rows="4"
									placeholder="Nhập mô tả chi tiết sản phẩm"></textarea>
							</div>

							<div class="form-group">
								<label for="image">URL hình ảnh</label>
								<input type="text" id="image" name="image" class="form-control"
									placeholder="https://example.com/image.jpg">
								<small style="color: #777;">Nhập đường dẫn ảnh hoặc để
									trống để sử dụng ảnh mặc định</small>
							</div>

							<div class="form-group">
								<label for="connectionType">Loại kết nối</label>
								<input type="text" id="connectionType" name="connectionType"
									class="form-control" placeholder="Ví dụ: USB, Bluetooth, Wireless">
							</div>

							<div class="form-group">
								<label for="material">Chất liệu</label>
								<input type="text" id="material" name="material"
									class="form-control" placeholder="Ví dụ: Nhựa ABS, Kim loại">
							</div>

							<div class="form-group">
								<label for="size">Kích thước</label>
								<input type="text" id="size" name="size" class="form-control"
									placeholder="Ví dụ: 120x60x40mm">
							</div>
						</div>
					</div>

					<div class="form-actions">
						<a href="adminProducts">
							<button type="button" class="cancel-btn">
								<i class="fas fa-times"></i> Hủy
							</button>
						</a>
						<button type="submit" class="submit-btn">
							<i class="fas fa-save"></i> Lưu Sản Phẩm
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		setTimeout(function() {
			var alerts = document.querySelectorAll('.alert');
			alerts.forEach(function(alert) {
				alert.style.display = 'none';
			});
		}, 5000);

		document.querySelector('form').addEventListener('submit',
				function(e) {
					var name = document.getElementById('name').value.trim();
					var price = document.getElementById('price').value.trim();

					if (!name) {
						alert('Vui lòng nhập tên sản phẩm!');
						e.preventDefault();
						return;
					}

					if (!price || parseFloat(price) <= 0) {
						alert('Vui lòng nhập giá hợp lệ!');
						e.preventDefault();
						return;
					}
				});
	</script>
</body>
</html>