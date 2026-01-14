<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<%@ page import="com.kachikun.shop.dao.CategoryDAO"%>
<%@ page import="com.kachikun.shop.model.Category"%>
<%@ page import="java.util.List"%>

<%

CategoryDAO dao = new CategoryDAO();
List<Category> list = dao.getAllCategories();


request.setAttribute("listCategories", list);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Kachi-Kun Shop</title>
<link rel="icon" type="image/png" href="images/LogoRemake.png" />
<link rel="stylesheet" href="style.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
	rel="stylesheet" />

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<div class="top-bar">
		<ul class="bar-list">
			<li><a href="#">Tư vấn chuẩn, chọn đúng gear</a></li>
			<li><a href="#">Bảo hành gọn, xử lí nhanh</a></li>
			<li><a href="#">Giao nhanh 0-3 ngày</a></li>
			<li><a href="#">Miễn phí ship từ 1 triệu</a></li>
			<li><a href="#">Trả góp 0%</a></li>
		</ul>
	</div>

	<div class="header-banner-wrapper">
		<header class="main-header">
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
										</a> <a href="login.jsp?action=signup"
											class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
											<i
											class="fas fa-user-plus w-6 text-center mr-2 text-gray-400"></i>
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

		<section class="banner-section">
			<div id="banner-background" class="banner-bg"
				style="background-image: url('https://cdn.sforum.vn/sforum/wp-content/uploads/2022/02/9-9-960x538.jpg');"></div>

			<div class="banner-content">
				<p class="banner-subtitle">Store cho các streamer và game thủ
					lựa chọn!</p>
				<h1 class="banner-title">
					 <br />Mouse Edition
				</h1>
				<a href="products" class="banner-button">Xem thêm</a>
			</div>

			<div class="slider-nav">
				<button class="dot active" data-slide="0">1</button>
				<button class="dot" data-slide="1">2</button>
				<button class="dot" data-slide="2">3</button>
				<button class="dot" data-slide="3">4</button>
			</div>
		</section>
	</div>
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
	<main class="main-content">
		<section class="product-categories bg-white">
			<div class="container">
				<div class="category-wrapper" style="position: relative;">

					<button class="nav-btn prev-btn" id="btnPrev">
						<i class="fas fa-chevron-left"></i>
					</button>

					<div class="category-grid" id="categoryList">
						<c:forEach items="${listCategories}" var="cate">
							<a href="products?category=${cate.name}" class="category-item">
								<i class="${cate.icon}"></i> <span>${cate.name}</span>
							</a>
						</c:forEach>
					</div>

					<button class="nav-btn next-btn" id="btnNext">
						<i class="fas fa-chevron-right"></i>
					</button>

				</div>
			</div>
		</section>
	</main>

	<footer class="footer">
		<div class="container">
			<div>
				<h3>Hung Khanh</h3>
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
			© Copyright <strong>Hung Khanh</strong>
		</p>
		<p>Designed by Hung Khanh</p>
	</div>

	<script src="https://cdn.tailwindcss.com"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="script.js"></script>
</body>
</html>