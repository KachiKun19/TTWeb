<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Giỏ hàng - Kachi-Kun Shop</title>
<link rel="icon" type="image/png" href="images/LogoRemake.png" />

<link rel="stylesheet" href="style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />

<style>
.qty-input::-webkit-outer-spin-button, .qty-input::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen">

	<div class="top-bar">
		<ul class="bar-list">
			<li><a href="#">Tư vấn chuẩn, chọn đúng gear</a></li>
			<li><a href="#">Bảo hành gọn, xử lí nhanh</a></li>
			<li><a href="#">Giao nhanh 0-3 ngày</a></li>
			<li><a href="#">Miễn phí ship từ 1 triệu</a></li>
			<li><a href="#">Trả góp 0%</a></li>
		</ul>
	</div>

	<header class="main-header sticky top-0 z-50"
		style="background-color: #1a1a1a">
		<div class="container">
			<div class="logo">
				<a href="home" class="flex items-center"> <img
					src="images/LogoChuan.png" alt="Kachi-Kun Shop Logo"
					class="logo-img w-24 h-auto" /> <span
					class="text-white text-xl font-bold ml-0 whitespace-nowrap">
						Kachi-Kun Shop </span>
				</a>
			</div>

			<nav class="nav">
				<ul class="nav-list">
					<li><a href="#" class="flex items-center"
						data-dropdown-toggle="dropdownGaming"> Gaming Gear <i
							class="fas fa-chevron-down ml-1 text-xs"></i>
					</a>
						<div id="dropdownGaming"
							class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
							<ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
								<li><a href="products?category=Chuột Gaming"
									class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Chuột
										Gaming</a></li>

								<li><a href="products?category=Bàn phím cơ"
									class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Bàn
										phím cơ</a></li>

								<li><a href="products?category=Lót chuột"
									class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Lót
										chuột</a></li>
							</ul>
						</div></li>
					<li><a href="#" class="flex items-center"
						data-dropdown-toggle="dropdownOffice"> Office Gear <i
							class="fas fa-chevron-down ml-1 text-xs"></i>
					</a>
						<div id="dropdownOffice"
							class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
							<ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
								<li><a href="products?category=Ghế công thái học"
									class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Ghế
										công thái học</a></li>

								<li><a href="products?category=Tai nghe"
									class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Tai
										nghe</a></li>
								<li><a href="products?category=Phụ kiện"
									class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Phụ
										kiện</a></li>
							</ul>
						</div></li>
					<li><a href="#">Liên Hệ</a></li>
				</ul>
			</nav>

			<div class="flex items-center space-x-8 text-white">
				<a href="#" id="open-search"
					class="text-xl transition-opacity duration-200 hover:opacity-80">
					<i class="fas fa-search"></i>
				</a>

				<div class="relative inline-block text-left">

					<button type="button" id="user-menu-btn"
						class="text-xl transition-colors duration-200 hover:text-pink-500 focus:outline-none py-2">
						<i class="fas fa-user"></i>
					</button>

					<div id="user-dropdown"
						class="hidden absolute right-0 z-50 mt-3 w-64 bg-white rounded-xl shadow-[0_10px_40px_-10px_rgba(0,0,0,0.2)] border border-gray-100 overflow-hidden transform origin-top-right">

						<c:choose>
							<%-- ĐÃ ĐĂNG NHẬP --%>
							<c:when test="${not empty sessionScope.user}">
								<div class="px-6 py-4 bg-gray-50 border-b border-gray-100">
									<p
										class="text-xs text-gray-400 uppercase tracking-wider font-semibold mb-1">Tài
										khoản</p>
									<p
										class="text-base font-bold text-gray-800 truncate leading-tight">
										${sessionScope.user.fullName}</p>
									<p class="text-xs text-gray-400 truncate mt-0.5">@${sessionScope.user.email}</p>
								</div>

								<a href="logout"
									class="block px-6 py-3.5 text-sm text-red-500 hover:bg-red-50 hover:text-red-600 font-medium transition-colors duration-200 flex items-center">
									<i class="fas fa-sign-out-alt mr-3"></i> Đăng xuất
								</a>
							</c:when>

							<%-- CHƯA ĐĂNG NHẬP --%>
							<c:otherwise>
								<div class="p-2">
									<a href="login"
										class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
										<i
										class="fas fa-sign-in-alt w-6 text-center mr-2 text-gray-400"></i>
										Đăng nhập
									</a> <a href="login.jsp?action=signup"
										class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
										<i class="fas fa-user-plus w-6 text-center mr-2 text-gray-400"></i>
										Đăng ký
									</a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<a href="cart.jsp"
					class="text-xl transition-opacity duration-200 hover:opacity-80 relative">
					<i class="fas fa-shopping-basket"></i> <%-- (Tùy chọn) Hiển thị số lượng nhỏ trên icon --%>
					<c:if test="${not empty sessionScope.cart}">
						<span
							class="absolute -top-2 -right-2 bg-pink-600 text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full">
							${sessionScope.cart.size()} </span>
					</c:if>
				</a>
			</div>
		</div>
	</header>

	<%-- sửa từ main cho chuyên nghiệp --%>
	<main class="flex-grow container mx-auto px-4 py-8">

		<div class="text-sm breadcrumbs text-gray-500 mb-6">
			<a href="home" class="hover:text-black">Trang chủ</a> <span
				class="mx-2">/</span> <span class="text-black font-semibold">Giỏ
				hàng</span>
		</div>

		<h1 class="text-3xl font-bold mb-8 uppercase border-b-2 border-black inline-block pb-2 text-black">Giỏ hàng của bạn</h1>

		<c:if test="${empty sessionScope.cart}">
			<div class="text-center py-16 bg-white rounded shadow-sm">
				<div class="text-6xl text-gray-300 mb-4">
					<i class="fas fa-shopping-basket"></i>
				</div>
				<p class="text-xl text-gray-500 mb-6">Giỏ hàng của bạn đang
					trống trơn!</p>
				<a href="home"
					class="bg-black text-white px-8 py-3 rounded hover:bg-gray-800 transition uppercase font-bold">
					Tiếp tục mua sắm </a>
			</div>
		</c:if>

		<c:if test="${not empty sessionScope.cart}">
			<div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

				<div class="lg:col-span-2 space-y-4">
					<div class="bg-white rounded shadow overflow-hidden">
						<div
							class="hidden md:grid grid-cols-12 gap-4 p-4 bg-gray-100 font-bold text-gray-700 text-sm uppercase">
							<div class="col-span-6">Sản phẩm</div>
							<div class="col-span-2 text-center">Đơn giá</div>
							<div class="col-span-2 text-center">Số lượng</div>
							<div class="col-span-2 text-right">Thành tiền</div>
						</div>

						<c:forEach items="${sessionScope.cart}" var="item">
							<div
								class="grid grid-cols-1 md:grid-cols-12 gap-4 p-4 items-center border-b last:border-0 hover:bg-gray-50 transition">
								<div class="col-span-6 flex gap-4 items-center">
									<div
										class="w-20 h-20 flex-shrink-0 border rounded overflow-hidden">
										<img src="images/${item.product.image}"
											alt="${item.product.name}" class="w-full h-full object-cover">
									</div>
									<div>
										<h3
											class="font-bold text-gray-800 hover:text-blue-600 transition">
											<a href="#">${item.product.name}</a>
										</h3>
										<p class="text-xs text-gray-500 mt-1">Mã SP:
											#${item.product.id}</p>
										<a href="update-cart?id=${item.product.id}&mod=-999"
											class="text-red-500 text-xs mt-2 hover:underline flex items-center gap-1 cursor-pointer">
											<i class="fas fa-trash"></i> Xóa
										</a>
									</div>
								</div>

								<div class="col-span-2 text-center font-medium text-gray-600">
									<fmt:formatNumber value="${item.product.price}" type="currency"
										currencySymbol="₫" />
								</div>

								<div class="col-span-2 flex justify-center">
									<div class="flex items-center border rounded">
										<a href="update-cart?id=${item.product.id}&mod=-1"
											class="px-2 py-1 hover:bg-gray-100 text-gray-600 font-bold block">
											- </a> <input type="text" value="${item.quantity}"
											class="w-12 text-center border-0 text-sm font-bold text-gray-900 focus:ring-0 bg-transparent"
											readonly /> <a
											href="update-cart?id=${item.product.id}&mod=1"
											class="px-2 py-1 hover:bg-gray-100 text-gray-600 font-bold block">
											+ </a>
									</div>
								</div>

								<div class="col-span-2 text-right font-bold text-red-600">
									<fmt:formatNumber value="${item.totalPrice}" type="currency"
										currencySymbol="₫" />
								</div>
							</div>
						</c:forEach>
					</div>

					<div class="text-right">
						<a href="home" class="text-blue-600 hover:underline text-sm"><i
							class="fas fa-arrow-left"></i> Tiếp tục mua hàng</a>
					</div>
				</div>

				<div class="lg:col-span-1">
					<div class="bg-white p-6 rounded shadow sticky top-24">
						<h2 class="text-lg font-bold mb-4 uppercase border-b pb-2">Thông
							tin thanh toán</h2>

						<form action="checkout" method="post" class="space-y-4">
							<div class="flex justify-between items-center mb-6">
								<span class="text-gray-600">Tạm tính:</span> <span
									class="font-bold text-xl text-black"> <fmt:formatNumber
										value="${totalMoney}" type="currency" currencySymbol="₫" />
								</span>
							</div>

							<hr class="border-dashed">

							<div>
								<label
									class="block text-xs font-bold text-gray-700 uppercase mb-1">Họ
									tên người nhận *</label> <input type="text" name="fullname"
									placeholder="Nguyễn Văn A" required
									class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
							</div>

							<div>
								<label
									class="block text-xs font-bold text-gray-700 uppercase mb-1">Số
									điện thoại *</label> <input type="tel" name="phone"
									placeholder="09xxxxxxx" required
									class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
							</div>

							<div>
								<label
									class="block text-xs font-bold text-gray-700 uppercase mb-1">Địa
									chỉ giao hàng *</label>
								<textarea name="address" rows="3"
									placeholder="Số nhà, đường, phường/xã..." required
									class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black text-black"></textarea>
							</div>

							<button type="submit"
								class="w-full bg-red-600 text-white py-3 rounded font-bold hover:bg-red-700 transition uppercase shadow-lg transform hover:-translate-y-1">
								Tiến hành đặt hàng</button>

							<p class="text-xs text-gray-400 text-center mt-2">
								<i class="fas fa-shield-alt"></i> Bảo mật thanh toán 100%
							</p>
						</form>
					</div>
				</div>
			</div>
		</c:if>
	</main>
	<%-- làm chức năng search --%>>
	<div id="search-overlay" class="search-overlay">
    <button id="close-search" class="search-overlay-close">&times;</button>
    <div class="search-overlay-content w-full max-w-2xl mx-auto px-4">
        
        <input oninput="searchByName(this)" name="txt" type="text"
            placeholder="Gõ tên sản phẩm để tìm..."
            class="search-overlay-input w-full p-4 text-xl border-b-2 border-gray-300 focus:border-blue-500 outline-none bg-transparent" />

        <div id="search-results"
            class="mt-4 max-h-[60vh] overflow-y-auto bg-white rounded-lg shadow-xl p-2 hidden">
        </div>

    </div>
</div>
	<%-- đây là footer rồi --%>
	<footer class="footer">
		<div class="container">
			<div>
				<h3>GROUP 14</h3>
				<p>
					Linh Trung Ward<br /> Thu Duc - Ho Chi Minh City - Viet Nam<br />
					<strong>Phone:</strong> +0862210723<br /> <strong>Email:</strong>
					group14@gmail.com
				</p>
				<div class="social-icons">
					<a href="#"><i class="fab fa-twitter"></i></a> <a href="#"><i
						class="fab fa-facebook-f"></i></a> <a href="#"><i
						class="fab fa-instagram"></i></a> <a href="#"><i
						class="fab fa-skype"></i></a> <a href="#"><i
						class="fab fa-linkedin-in"></i></a>
				</div>
			</div>
			<div>
				<h3>Useful Links</h3>
				<p>
					<a href="#">Home</a>
				</p>
				<p>
					<a href="#">About us</a>
				</p>
				<p>
					<a href="#">Services</a>
				</p>
				<p>
					<a href="#">Terms of service</a>
				</p>
				<p>
					<a href="#">Privacy policy</a>
				</p>
			</div>
			<div>
				<h3>Our Services</h3>
				<p>
					<a href="#">Web Design</a>
				</p>
				<p>
					<a href="#">Web Development</a>
				</p>
				<p>
					<a href="#">Product Management</a>
				</p>
				<p>
					<a href="#">Marketing</a>
				</p>
				<p>
					<a href="#">Graphic Design</a>
				</p>
			</div>
			<div>
				<h3>Our Newsletter</h3>
				<p>Your support is our greatest motivation. Join us for the best
					experience</p>
				<form class="newsletter">
					<input type="email" placeholder="Email" /> <input type="submit"
						value="Subscribe" />
				</form>
			</div>
		</div>
	</footer>
	<div class="footer-bottom">
		<p>
			© Copyright <strong>GROUP 14</strong>. All Rights Reserved
		</p>
		<p>Designed by GROUP 14</p>
	</div>
	<script src="https://cdn.tailwindcss.com"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
	<script src="script.js"></script>
</body>
</html>