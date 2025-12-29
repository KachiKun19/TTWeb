<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Sản Phẩm - Kachi-Kun Shop</title>
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

.add-product-btn {
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

.add-product-btn:hover {
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

.products-table {
	width: 100%;
	background-color: white;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

.products-table table {
	width: 100%;
	border-collapse: collapse;
}

.products-table th {
	background-color: #f0f7f7;
	color: #2d7e7e;
	font-weight: 600;
	padding: 15px;
	text-align: left;
	border-bottom: 2px solid #e0f0f0;
}

.products-table td {
	padding: 12px 15px;
	border-bottom: 1px solid #eee;
	vertical-align: top;
}

.products-table tr:hover {
	background-color: #f9fcfc;
}

/* Điều chỉnh độ rộng các cột */
.products-table th:nth-child(1), 
.products-table td:nth-child(1) {
	width: 60px;
	text-align: center;
}

.products-table th:nth-child(2), 
.products-table td:nth-child(2) {
	width: 35%;
	min-width: 250px;
}

.products-table th:nth-child(3), 
.products-table td:nth-child(3) {
	width: 120px;
	text-align: right;
	white-space: nowrap;
}

.products-table th:nth-child(4), 
.products-table td:nth-child(4) {
	width: 100px;
	text-align: center;
}

.products-table th:nth-child(5), 
.products-table td:nth-child(5) {
	width: 15%;
}

.products-table th:nth-child(6), 
.products-table td:nth-child(6) {
	width: 15%;
}

.products-table th:nth-child(7), 
.products-table td:nth-child(7) {
	width: 160px;
	text-align: center;
}

.product-name {
	font-weight: 600;
	color: #333;
	display: block;
	margin-bottom: 5px;
	word-break: break-word;
}

.product-desc {
	font-size: 13px;
	color: #777;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	line-height: 1.4;
	max-height: 2.8em;
}

.product-price {
	font-weight: 700;
	color: #e74c3c;
	font-size: 15px;
	white-space: nowrap;
}

.product-stock {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 4px;
	font-weight: 600;
	font-size: 13px;
}

.stock-low {
	background-color: #f8d7da;
	color: #721c24;
}

.stock-ok {
	background-color: #d4edda;
	color: #155724;
}

.action-buttons {
	display: flex;
	gap: 8px;
	justify-content: center;
}

.edit-btn, .delete-btn {
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
	min-width: 70px;
	justify-content: center;
}

.edit-btn {
	background-color: #4facfe;
	color: white;
}

.edit-btn:hover {
	background-color: #3a9aed;
}

.delete-btn {
	background-color: #f5576c;
	color: white;
}

.delete-btn:hover {
	background-color: #e4465a;
}

.no-products {
	text-align: center;
	padding: 40px;
	color: #777;
	font-size: 16px;
}

.no-products i {
	font-size: 48px;
	margin-bottom: 15px;
	color: #ccc;
}

/* Phân trang - CẢI THIỆN */
.pagination-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
	padding: 15px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.pagination-info {
	color: #666;
	font-size: 14px;
	font-weight: 500;
}

.pagination {
	display: flex;
	align-items: center;
	gap: 8px;
}

.page-btn, .page-number, .current-page {
	display: flex;
	align-items: center;
	justify-content: center;
	min-width: 40px;
	height: 40px;
	padding: 0 12px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 500;
	font-size: 14px;
	transition: all 0.3s;
	cursor: pointer;
	border: 1px solid #ddd;
}

.page-btn {
	background-color: white;
	color: #2d7e7e;
}

.page-btn:hover {
	background-color: #f0f7f7;
	border-color: #2d7e7e;
	transform: translateY(-1px);
}

.page-number {
	background-color: white;
	color: #555;
}

.page-number:hover {
	background-color: #f0f7f7;
	color: #2d7e7e;
	border-color: #2d7e7e;
}

.current-page {
	background-color: #2d7e7e;
	color: white;
	border-color: #2d7e7e;
	font-weight: 600;
}

.page-btn.disabled, .page-number.disabled {
	background-color: #f5f5f5;
	color: #999;
	border-color: #ddd;
	cursor: not-allowed;
	pointer-events: none;
}

.page-btn.disabled:hover, .page-number.disabled:hover {
	background-color: #f5f5f5;
	transform: none;
}

.ellipsis {
	color: #999;
	padding: 0 10px;
	display: flex;
	align-items: center;
	height: 40px;
}

.page-numbers {
	display: flex;
	gap: 5px;
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

@media ( max-width : 768px) {
	.page-header {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
	.products-table {
		overflow-x: auto;
	}
	.products-table table {
		min-width: 800px;
	}
	.pagination-container {
		flex-direction: column;
		gap: 15px;
		align-items: stretch;
	}
	.pagination-info {
		text-align: center;
	}
	.pagination {
		justify-content: center;
		flex-wrap: wrap;
	}
	.page-btn, .page-number, .current-page {
		min-width: 36px;
		height: 36px;
		font-size: 13px;
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
				<li><a href="adminUsers"><i class="fas fa-users"></i> Quản lý người
						dùng</a></li>
				<li><a href="adminProducts" class="active"><i
						class="fas fa-box"></i> Quản lý sản phẩm</a></li>
				<li><a href="#"><i class="fas fa-shopping-cart"></i> Quản
						lý đơn hàng</a></li>
				<li><a href="#"><i class="fas fa-chart-bar"></i> Thống kê &
						Báo cáo</a></li>
				<li><a href="#"><i class="fas fa-cog"></i> Cài đặt hệ thống</a></li>
				<li><a href="home"><i class="fas fa-store"></i> Về trang
						cửa hàng</a></li>
			</ul>
		</div>

		<div class="main-content">
			<div class="page-header">
				<h2>
					<i class="fas fa-box"></i> Quản Lý Sản Phẩm
				</h2>
				<a href="addProduct">
					<button class="add-product-btn">
						<i class="fas fa-plus-circle"></i> Thêm Sản Phẩm Mới
					</button>
				</a>
			</div>

			<!-- Thông báo thành công -->
			<c:if test="${param.success eq 'true'}">
				<div class="alert alert-success">
					<i class="fas fa-check-circle"></i> Sản phẩm đã được thêm thành công!
				</div>
			</c:if>

			<c:if test="${param.success eq 'delete_success'}">
				<div class="alert alert-success">
					<i class="fas fa-check-circle"></i> Sản phẩm đã được xóa thành công!
				</div>
			</c:if>

			<!-- Thông báo lỗi -->
			<c:if test="${param.error eq 'delete_failed'}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-circle"></i> Không thể xóa sản phẩm. Vui lòng thử lại!
				</div>
			</c:if>

			<div class="products-table">
				<c:choose>
					<c:when test="${empty productList}">
						<div class="no-products">
							<i class="fas fa-box-open"></i>
							<p>Chưa có sản phẩm nào. Hãy thêm sản phẩm mới!</p>
						</div>
					</c:when>
					<c:otherwise>
						<table>
							<thead>
								<tr>
									<th>ID</th>
									<th>Tên sản phẩm</th>
									<th>Giá</th>
									<th>Tồn kho</th>
									<th>Danh mục</th>
									<th>Thương hiệu</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="product" items="${productList}">
									<tr>
										<td>${product.id}</td>
										<td>
											<span class="product-name">${product.name}</span>
											<c:if test="${not empty product.description}">
												<span class="product-desc">${product.description}</span>
											</c:if>
										</td>
										<td>
											<span class="product-price">
												<fmt:formatNumber value="${product.price}" 
													type="number" maxFractionDigits="0" groupingUsed="true" /> ₫
											</span>
										</td>
										<td>
											<span class="product-stock ${product.stock lt 10 ? 'stock-low' : 'stock-ok'}">
												${product.stock}
											</span>
										</td>
										<td>
											<c:if test="${not empty product.category}">
												${product.category.name}
											</c:if>
											<c:if test="${empty product.category}">
												<span style="color: #999; font-style: italic;">Không có</span>
											</c:if>
										</td>
										<td>
											<c:if test="${not empty product.brand}">
												${product.brand.name}
											</c:if>
											<c:if test="${empty product.brand}">
												<span style="color: #999; font-style: italic;">Không có</span>
											</c:if>
										</td>
										<td>
											<div class="action-buttons">
												<button class="edit-btn" onclick="editProduct(${product.id})">
													<i class="fas fa-edit"></i> Sửa
												</button>
												<button class="delete-btn"
													onclick="confirmDelete(${product.id})">
													<i class="fas fa-trash"></i> Xóa
												</button>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- Phân trang - FIXED -->
			<c:if test="${not empty productList}">
				<div class="pagination-container">
					<div class="pagination-info">
						Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> 
						- Hiển thị <strong>${productList.size()}</strong> sản phẩm
						<c:if test="${totalProducts > 0}">
							/ Tổng <strong>${totalProducts}</strong> sản phẩm
						</c:if>
					</div>
					
					<c:if test="${totalPages > 1}">
						<div class="pagination">
							<!-- Nút Trang đầu -->
							<c:choose>
								<c:when test="${currentPage > 1}">
									<a href="adminProducts?page=1" class="page-btn" title="Trang đầu">
										<i class="fas fa-angle-double-left"></i>
									</a>
								</c:when>
								<c:otherwise>
									<span class="page-btn disabled">
										<i class="fas fa-angle-double-left"></i>
									</span>
								</c:otherwise>
							</c:choose>
							
							<!-- Nút Trang trước -->
							<c:choose>
								<c:when test="${currentPage > 1}">
									<a href="adminProducts?page=${currentPage - 1}" class="page-btn" title="Trang trước">
										<i class="fas fa-chevron-left"></i>
									</a>
								</c:when>
								<c:otherwise>
									<span class="page-btn disabled">
										<i class="fas fa-chevron-left"></i>
									</span>
								</c:otherwise>
							</c:choose>
							
							<!-- Các số trang -->
							<div class="page-numbers">
								<c:set var="startPage" value="1" />
								<c:set var="endPage" value="${totalPages}" />
								
								<!-- Giới hạn hiển thị tối đa 5 số trang -->
								<c:if test="${totalPages > 5}">
									<c:choose>
										<c:when test="${currentPage <= 3}">
											<c:set var="startPage" value="1" />
											<c:set var="endPage" value="5" />
										</c:when>
										<c:when test="${currentPage > totalPages - 2}">
											<c:set var="startPage" value="${totalPages - 4}" />
											<c:set var="endPage" value="${totalPages}" />
										</c:when>
										<c:otherwise>
											<c:set var="startPage" value="${currentPage - 2}" />
											<c:set var="endPage" value="${currentPage + 2}" />
										</c:otherwise>
									</c:choose>
								</c:if>
								
								<!-- Hiển thị ... nếu có trang trước startPage -->
								<c:if test="${startPage > 1}">
									<a href="adminProducts?page=1" class="page-number">1</a>
									<c:if test="${startPage > 2}">
										<span class="ellipsis">...</span>
									</c:if>
								</c:if>
								
								<!-- Hiển thị các số trang -->
								<c:forEach var="i" begin="${startPage}" end="${endPage}">
									<c:choose>
										<c:when test="${i == currentPage}">
											<span class="current-page">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="adminProducts?page=${i}" class="page-number">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
								<!-- Hiển thị ... nếu có trang sau endPage -->
								<c:if test="${endPage < totalPages}">
									<c:if test="${endPage < totalPages - 1}">
										<span class="ellipsis">...</span>
									</c:if>
									<a href="adminProducts?page=${totalPages}" class="page-number">${totalPages}</a>
								</c:if>
							</div>
							
							<!-- Nút Trang sau -->
							<c:choose>
								<c:when test="${currentPage < totalPages}">
									<a href="adminProducts?page=${currentPage + 1}" class="page-btn" title="Trang sau">
										<i class="fas fa-chevron-right"></i>
									</a>
								</c:when>
								<c:otherwise>
									<span class="page-btn disabled">
										<i class="fas fa-chevron-right"></i>
									</span>
								</c:otherwise>
							</c:choose>
							
							<!-- Nút Trang cuối -->
							<c:choose>
								<c:when test="${currentPage < totalPages}">
									<a href="adminProducts?page=${totalPages}" class="page-btn" title="Trang cuối">
										<i class="fas fa-angle-double-right"></i>
									</a>
								</c:when>
								<c:otherwise>
									<span class="page-btn disabled">
										<i class="fas fa-angle-double-right"></i>
									</span>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
				</div>
			</c:if>
		</div>
	</div>

	<script>
		// Hàm xác nhận xóa sản phẩm
		function confirmDelete(productId) {
			if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
				window.location.href = "deleteProduct?id=" + productId + "&page=${currentPage}";
			}
		}

		// Hàm chuyển đến trang sửa sản phẩm (chưa triển khai)
		function editProduct(productId) {
			alert("Chức năng sửa sản phẩm đang được phát triển!");
			// window.location.href = "editProduct?id=" + productId + "&page=${currentPage}";
		}

		// Tự động ẩn thông báo sau 5 giây
		setTimeout(function() {
			var alerts = document.querySelectorAll('.alert');
			alerts.forEach(function(alert) {
				alert.style.display = 'none';
			});
		}, 5000);
	</script>
</body>
</html>