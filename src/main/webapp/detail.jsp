<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>${detail.name}-Kachi-Kun Shop</title>
	<link rel="icon" type="image/png" href="images/LogoRemake.png" />
	<link rel="stylesheet" href="style.css" />
	<link
			href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
			rel="stylesheet" />
	<script src="https://cdn.tailwindcss.com"></script>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
</head>
<body class="bg-[#1a1a1a] text-white font-['Montserrat']">

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
				<li>
					<a href="${not empty sessionScope.user ? 'contact.jsp' : 'login'}">Liên Hệ</a>
				</li>
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
								</a> <a href="login#signup"
										class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
								<i class="fas fa-user-plus w-6 text-center mr-2 text-gray-400"></i>
								Đăng ký
							</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="relative">
				<button id="cartDropdownButton" data-dropdown-toggle="cartDropdown"
						class="text-xl transition-opacity duration-200 hover:opacity-80 relative focus:outline-none pt-2">
					<i class="fas fa-shopping-basket"></i>

					<c:if test="${not empty sessionScope.cart}">
            <span class="absolute -top-1 -right-2 bg-pink-600 text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full border-2 border-[#1a1a1a]">
					${sessionScope.cart.size()}
			</span>
					</c:if>
				</button>

				<div id="cartDropdown" class="z-50 hidden bg-white divide-y divide-gray-100 rounded-xl shadow-lg w-48 overflow-hidden transform origin-top-right transition-all duration-200">
					<div class="px-4 py-3 bg-gray-50 border-b text-gray-900 text-sm font-semibold">
						Hoạt động mua sắm
					</div>

					<ul class="py-1 text-sm text-gray-700" aria-labelledby="cartDropdownButton">
						<li>
							<a href="cart.jsp" class="block px-4 py-3 hover:bg-pink-50 hover:text-pink-600 transition flex items-center group">
                    <span class="bg-pink-100 text-pink-600 w-8 h-8 rounded-full flex items-center justify-center mr-3 group-hover:bg-pink-200 transition">
                        <i class="fas fa-shopping-cart text-xs"></i>
                    </span>
								<div>
									<span class="font-bold block">Giỏ hàng</span>
									<span class="text-xs text-gray-500">Thanh toán ngay</span>
								</div>
							</a>
						</li>

						<li>
							<a href="order-history" class="block px-4 py-3 hover:bg-blue-50 hover:text-blue-600 transition flex items-center group">
                    <span class="bg-blue-100 text-blue-600 w-8 h-8 rounded-full flex items-center justify-center mr-3 group-hover:bg-blue-200 transition">
                        <i class="fas fa-receipt text-xs"></i>
                    </span>
								<div>
									<span class="font-bold block">Đơn mua</span>
									<span class="text-xs text-gray-500">Xem lịch sử</span>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</header>

<main class="container mx-auto px-4 py-8 mt-20">
	<nav class="flex mb-5" aria-label="Breadcrumb">
		<ol class="inline-flex items-center space-x-1 md:space-x-3 text-sm">
			<li class="inline-flex items-center"><a href="home"
													class="text-gray-400 hover:text-white inline-flex items-center">
				<i class="fa-solid fa-house mr-2"></i> Trang chủ
			</a></li>
			<li>
				<div class="flex items-center">
					<i class="fa-solid fa-chevron-right text-gray-600 mx-2"></i> <a
						href="products" class="text-gray-400 hover:text-white">Sản
					phẩm</a>
				</div>
			</li>
			<li aria-current="page">
				<div class="flex items-center">
					<i class="fa-solid fa-chevron-right text-gray-600 mx-2"></i> <span
						class="text-pink-500 font-semibold">${detail.name}</span>
				</div>
			</li>
		</ol>
	</nav>

	<div
			class="grid grid-cols-1 md:grid-cols-2 gap-12 bg-[#252525] p-8 rounded-2xl shadow-2xl">
		<div class="flex flex-col items-center">
			<div class="overflow-hidden rounded-xl bg-white p-4 w-full">
				<img src="images/${detail.image}" alt="${detail.name}"
					 class="w-full h-auto object-contain hover:scale-105 transition-transform duration-500">
			</div>
		</div>

		<div class="flex flex-col space-y-6">
			<div>
					<span
							class="bg-pink-600 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">
						${detail.category.name} </span>
				<h1 class="text-3xl md:text-4xl font-bold mt-4 leading-tight">${detail.name}</h1>
				<p class="text-gray-400 mt-2 italic">
					Thương hiệu: <span class="text-white font-medium">${detail.brand.name}</span>
				</p>
			</div>

			<div class="flex items-center space-x-4">
					<span class="text-4xl font-extrabold text-pink-500"> <fmt:formatNumber
							value="${detail.price}" type="number" />₫
					</span>
				<c:if test="${detail.stock > 0}">
						<span
								class="text-green-400 text-sm font-semibold bg-green-400/10 px-3 py-1 rounded-lg border border-green-400/20">
							<i class="fa-solid fa-check mr-1"></i> Còn hàng (${detail.stock})
						</span>
				</c:if>
				<c:if test="${detail.stock <= 0}">
						<span
								class="text-red-400 text-sm font-semibold bg-red-400/10 px-3 py-1 rounded-lg border border-red-400/20">
							<i class="fa-solid fa-xmark mr-1"></i> Hết hàng
						</span>
				</c:if>
			</div>

			<div class="grid grid-cols-2 gap-4 py-6 border-y border-gray-700">
				<div class="flex items-center space-x-3">
					<div
							class="w-10 h-10 rounded-lg bg-gray-800 flex items-center justify-center text-pink-500">
						<i class="fa-solid fa-plug"></i>
					</div>
					<div>
						<p class="text-xs text-gray-500 uppercase">Kết nối</p>
						<p class="text-sm font-semibold">${detail.connectionTypeVi}</p>
					</div>
				</div>

				<div class="flex items-center space-x-3">
					<div
							class="w-10 h-10 rounded-lg bg-gray-800 flex items-center justify-center text-pink-500">
						<i class="fa-solid fa-layer-group"></i>
					</div>
					<div>
						<p class="text-xs text-gray-500 uppercase">Chất liệu</p>
						<p class="text-sm font-semibold">${detail.materialVi}</p>
					</div>
				</div>

				<div class="flex items-center space-x-3">
					<div
							class="w-10 h-10 rounded-lg bg-gray-800 flex items-center justify-center text-pink-500">
						<i class="fa-solid fa-maximize"></i>
					</div>
					<div>
						<p class="text-xs text-gray-500 uppercase">Kích thước</p>
						<p class="text-sm font-semibold">${detail.sizeVi}</p>
					</div>
				</div>
			</div>

			<div class="text-gray-300 leading-relaxed">
				<h3 class="text-white font-bold mb-2">Mô tả sản phẩm:</h3>
				<p>${detail.description}</p>
			</div>

			<div class="pt-6 flex flex-col sm:flex-row gap-4">
				<c:if test="${detail.stock > 0}">
					<a href="add-to-cart?id=${detail.id}"
					   class="flex-1 bg-pink-600 hover:bg-pink-700 text-white font-bold py-4 px-8 rounded-xl text-center transition-all transform hover:-translate-y-1 shadow-lg shadow-pink-600/20">
						<i class="fa-solid fa-cart-plus mr-2"></i> THÊM VÀO GIỎ HÀNG
					</a>
				</c:if>
				<c:if test="${detail.stock <= 0}">
					<button disabled
							class="flex-1 bg-gray-600 text-gray-400 font-bold py-4 px-8 rounded-xl cursor-not-allowed">
						TẠM HẾT HÀNG</button>
				</c:if>
			</div>
		</div>
	</div>
</main>

<footer class="footer">
	<div class="container">
		<div>
			<h3>Kachi-Kun Shop</h3>
			<p>
				Linh Trung Ward<br /> Thu Duc - Ho Chi Minh City - Viet Nam<br />
				<strong>Phone:</strong> +0862210723<br /> <strong>Email:</strong>
				Kachi-Kun-Shop@gmail.com
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
		© Copyright <strong>Kachi-Kun-Shop</strong>
	</p>
	<p>Designed by Kachi-Kun-Shop</p>
</div>

<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
<script src="script.js"></script>

</body>
</html>