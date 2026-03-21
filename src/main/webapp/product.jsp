<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Sản phẩm - Kachi-Kun Shop</title>
	<link rel="icon" type="image/png" href="images/LogoRemake.png" />
	<link rel="stylesheet" href="style.css" />
	<link
			href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
			rel="stylesheet" />
	<link
			href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
			rel="stylesheet" />
	<script src="https://cdn.tailwindcss.com"></script>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
		  integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
		  crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body class="bg-white text-black">
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

<main class="flex-grow container mx-auto px-4 py-8">

	<nav class="flex mb-5" aria-label="Breadcrumb">
		<ol class="inline-flex items-center space-x-1 md:space-x-3 text-sm">
			<li class="inline-flex items-center"><a href="home"
													class="text-gray-400 hover:text-black inline-flex items-center">
				<i class="fa-solid fa-house mr-2"></i> Trang chủ
			</a></li>
			<li>
				<div class="flex items-center">
					<i class="fa-solid fa-chevron-right text-gray-600 mx-2"></i> <a
						href="products" class="text-gray-400 hover:text-black">Sản
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

	<div class="page-container">
		<div class="page-content active" id="page-category">
			<div class="container py-12">
				<input type="hidden" id="current-category-slug"
					   value="${param.category}" />

				<div class="flex items-center mb-8">
					<c:set var="cat" value="${param.category}" />

					<c:if test="${cat == 'keyboard' || cat == 'headset'}">
						<a
								href="products?category=${cat == 'keyboard' ? 'mouse' : 'keyboard'}"
								class="section-scroll-link mr-3" title="Quay lại"> <i
								class="fas fa-chevron-left"></i>
						</a>
					</c:if>

					<h1 class="text-3xl font-bold">
						<c:choose>
							<c:when test="${not empty currentCategory}">
								${currentCategory}
							</c:when>
							<c:otherwise>Tất cả sản phẩm</c:otherwise>
						</c:choose>
					</h1>

					<c:if test="${cat == 'mouse' || cat == 'keyboard'}">
						<a
								href="products?category=${empty cat || cat == 'mouse' ? 'keyboard' : 'headset'}"
								class="section-scroll-link ml-3" title="Tiếp theo"> <i
								class="fas fa-chevron-right"></i>
						</a>
					</c:if>
				</div>

				<div class="flex flex-col lg:flex-row lg:space-x-8">
					<aside class="w-full lg:w-1/4 mb-8 lg:mb-0">
						<div id="filter-accordion">

							<h2 id="filter-heading-brands">
								<button type="button"
										class="flex items-center justify-between w-full py-5 font-semibold text-left text-gray-900 border-b border-gray-200">
									<span class="text-base">Thương hiệu</span>
									<svg data-accordion-icon class="w-4 h-4 rotate-180 shrink-0"
										 aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
										 fill="none" viewBox="0 0 10 6">
										<path stroke="currentColor"
											  stroke-linecap="round" stroke-linejoin="round"
											  stroke-width="2" d="M9 5 5 1 1 5" />
									</svg>
								</button>
							</h2>
							<div id="filter-body-brands" class="filter-content"
								 aria-labelledby="filter-heading-brands">
								<div class="inner-list py-5 border-b border-gray-200 space-y-4">
									<c:forEach var="brand" items="${brands}">
										<div class="flex items-center">
											<input id="filter-brand-${brand.id}" type="checkbox"
												   value="${brand.id}"
												   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
											<label for="filter-brand-${brand.id}"
												   class="ml-3 text-sm font-medium text-gray-700">${brand.name}</label>
										</div>
									</c:forEach>
									<c:if test="${empty brands}">
										<p class="text-sm text-gray-500">Đang cập nhật...</p>
									</c:if>
								</div>
							</div>

							<h2 id="filter-heading-connection">
								<button type="button"
										class="flex items-center justify-between w-full py-5 font-semibold text-left text-gray-900 border-b border-gray-200">
									<span class="text-base">Kết nối</span>
									<svg data-accordion-icon class="w-4 h-4 rotate-180 shrink-0"
										 aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
										 fill="none" viewBox="0 0 10 6">
										<path stroke="currentColor"
											  stroke-linecap="round" stroke-linejoin="round"
											  stroke-width="2" d="M9 5 5 1 1 5" />
									</svg>
								</button>
							</h2>
							<div id="filter-body-connection" class="filter-content"
								 aria-labelledby="filter-heading-connection">
								<div class="inner-list py-5 border-b border-gray-200 space-y-4">
									<div class="flex items-center">
										<input id="filter-connection-1" type="checkbox" value="wired"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-connection-1"
											   class="ml-3 text-sm font-medium text-gray-700">Có
											dây</label>
									</div>
									<div class="flex items-center">
										<input id="filter-connection-2" type="checkbox"
											   value="bluetooth"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-connection-2"
											   class="ml-3 text-sm font-medium text-gray-700">Bluetooth</label>
									</div>
									<div class="flex items-center">
										<input id="filter-connection-3" type="checkbox" value="usb"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-connection-3"
											   class="ml-3 text-sm font-medium text-gray-700">USB</label>
									</div>
								</div>
							</div>

							<h2 id="filter-heading-material">
								<button type="button"
										class="flex items-center justify-between w-full py-5 font-semibold text-left text-gray-900 border-b border-gray-200">
									<span class="text-base">Chất liệu</span>
									<svg data-accordion-icon class="w-4 h-4 rotate-180 shrink-0"
										 aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
										 fill="none" viewBox="0 0 10 6">
										<path stroke="currentColor"
											  stroke-linecap="round" stroke-linejoin="round"
											  stroke-width="2" d="M9 5 5 1 1 5" />
									</svg>
								</button>
							</h2>
							<div id="filter-body-material" class="filter-content"
								 aria-labelledby="filter-heading-material">
								<div class="inner-list py-5 border-b border-gray-200 space-y-4">
									<div class="flex items-center">
										<input id="filter-material-1" type="checkbox" value="pbt"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-material-1"
											   class="ml-3 text-sm font-medium text-gray-700">Carbon</label>
									</div>
									<div class="flex items-center">
										<input id="filter-material-2" type="checkbox" value="abs"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-material-2"
											   class="ml-3 text-sm font-medium text-gray-700">Nhựa</label>
									</div>
								</div>
							</div>
							<h2 id="filter-heading-size">
								<button type="button"
										class="flex items-center justify-between w-full py-5 font-semibold text-left text-gray-900 border-b border-gray-200">
									<span class="text-base">Kích thước</span>
									<svg data-accordion-icon class="w-4 h-4 rotate-180 shrink-0"
										 aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
										 fill="none" viewBox="0 0 10 6">
										<path stroke="currentColor" stroke-linecap="round"
											  stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5" />
									</svg>
								</button>
							</h2>
							<div id="filter-body-size" class="filter-content"
								 aria-labelledby="filter-heading-size">
								<div class="inner-list py-5 border-b border-gray-200 space-y-4">
									<div class="flex items-center">
										<input id="filter-size-s" type="checkbox" value="S"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-size-s"
											   class="ml-3 text-sm font-medium text-gray-700">Nhỏ
											(S)</label>
									</div>
									<div class="flex items-center">
										<input id="filter-size-m" type="checkbox" value="M"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-size-m"
											   class="ml-3 text-sm font-medium text-gray-700">Trung
											bình (M)</label>
									</div>
									<div class="flex items-center">
										<input id="filter-size-l" type="checkbox" value="L"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-size-l"
											   class="ml-3 text-sm font-medium text-gray-700">Lớn
											(L)</label>
									</div>
									<div class="flex items-center">
										<input id="filter-size-xl" type="checkbox" value="XL"
											   class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
										<label for="filter-size-xl"
											   class="ml-3 text-sm font-medium text-gray-700">Rất
											lớn (XL)</label>
									</div>
								</div>
							</div>

						</div>
					</aside>

					<section class="w-full lg:w-3/4">
						<div class="flex justify-between items-center mb-6">
								<span id="count-display" class="text-sm text-gray-600">
									Hiển thị <c:choose>
									<c:when test="${not empty products}">
										${products.size()}
									</c:when>
									<c:otherwise>0</c:otherwise>
								</c:choose> sản phẩm
								</span>

							<div>
								<button id="dropdownDefaultButton"
										data-dropdown-toggle="dropdownSort"
										class="text-gray-700 bg-gray-100 hover:bg-gray-200 focus:ring-2 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center"
										type="button">
									Sắp xếp: Mặc định <i class="fas fa-chevron-down ml-2"></i>
								</button>
								<div id="dropdownSort"
									 class="z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-60">
									<ul class="py-2 text-sm text-gray-700"
										aria-labelledby="dropdownDefaultButton">
										<li><a href="#"
											   class="block px-4 py-2 hover:bg-gray-100">Ngày (từ mới
											đến cũ)</a></li>
										<li><a href="#"
											   class="block px-4 py-2 hover:bg-gray-100">Giá (từ thấp
											đến cao)</a></li>
										<li><a href="#"
											   class="block px-4 py-2 hover:bg-gray-100">Giá (từ cao
											đến thấp)</a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6"
							 id="productGrid">
							<c:choose>
								<c:when test="${not empty products}">
									<c:forEach var="p" items="${products}">
										<div
												class="product-card border rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-shadow duration-300 group product-item"
												data-brand="${p.brand != null ? p.brand.id : '0'}"
												data-price="${p.price}"
												data-stock="${p.stock > 0 ? 'inStock' : 'outOfStock'}">

											<a href="product-detail?id=${p.id}" class="relative block">
												<img
														src="images/${not empty p.image ? p.image : 'https://via.placeholder.com/300x300'}"
														alt="${p.name}" class="w-full h-56 object-contain p-4" />

												<c:if test="${p.stock <= 0}">
													<div
															class="absolute top-2 left-2 bg-gray-500 text-white text-xs font-bold px-2 py-1 rounded">Hết
														hàng</div>
												</c:if>

												<div class="absolute inset-x-4 bottom-4">
													<c:choose>
														<c:when test="${p.stock > 0}">
															<button
																	class="w-full bg-blue-600 text-white font-semibold py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300 add-to-cart"
																	data-id="${p.id}">+ Chọn nhanh</button>
														</c:when>
														<c:otherwise>
															<button
																	class="w-full bg-gray-400 text-white font-semibold py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300 cursor-not-allowed"
																	disabled>Hết hàng</button>
														</c:otherwise>
													</c:choose>
												</div>
											</a>

											<div class="p-4">
												<h3
														class="font-semibold text-base h-16 overflow-hidden line-clamp-2">
													<a href="product-detail?id=${p.id}"
													   class="hover:text-blue-600"> ${p.name} </a>
												</h3>
												<p class="text-lg font-bold text-gray-800 mt-2">
													<fmt:formatNumber value="${p.price}" type="currency"
																	  currencySymbol="₫" maxFractionDigits="0" />
												</p>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="col-span-3 text-center py-12">
										<p class="text-gray-500 text-lg">Không tìm thấy sản phẩm
											nào trong danh mục này.</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						<%-- Pagging sản phẩm ra nhiều trang --%>
						<c:if test="${endP > 1}">
							<div id="default-pagination"
								 class="flex justify-center mt-8 space-x-2">
								<c:forEach begin="1" end="${endP}" var="i">

									<button onclick="filterProducts(${i})"
											class="px-4 py-2 border rounded-lg transition-colors duration-300
    ${tag == i ? 'bg-pink-600 text-white font-bold' : 'bg-white text-gray-700 hover:bg-pink-500 hover:text-white'}">
											${i}</button>
								</c:forEach>
							</div>
						</c:if>
					</section>
				</div>
			</div>
		</div>
	</div>
</main>

<div id="cart-overlay" class="cart-overlay">
	<button id="close-cart" class="cart-overlay-close">&times;</button>
	<div class="cart-overlay-content">
		<h2>Giỏ hàng của bạn</h2>
		<div class="cart-items-container">
			<p class="cart-empty-message">Chưa có sản phẩm nào trong giỏ
				hàng.</p>
		</div>
	</div>
</div>

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