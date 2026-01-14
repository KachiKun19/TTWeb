<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lịch Sử Đơn Hàng - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png" />
    <link rel="stylesheet" href="style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        .status-badge { padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .st-processing { background-color: #fef3c7; color: #d97706; } 
        .st-shipping { background-color: #dbeafe; color: #2563eb; } 
        .st-completed { background-color: #d1fae5; color: #059669; } 
        .st-cancelled { background-color: #fee2e2; color: #dc2626; } 
    </style>
</head>
<body class="bg-gray-50 font-['Montserrat'] flex flex-col min-h-screen">

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
    <div class="container mx-auto px-4 py-10 flex-grow">
        <div class="max-w-6xl mx-auto">
            <h1 class="text-3xl font-bold text-gray-800 mb-2">Lịch sử đơn hàng</h1>
            <p class="text-gray-500 mb-8">Theo dõi trạng thái các đơn hàng bạn đã đặt tại Kachi-Kun Shop.</p>

            <c:if test="${not empty msg}">
                <div class="p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg" role="alert">
                    <span class="font-medium">Thành công!</span> ${msg}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="p-4 mb-4 text-sm text-red-700 bg-red-100 rounded-lg" role="alert">
                    <span class="font-medium">Lỗi!</span> ${error}
                </div>
            </c:if>

            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <c:choose>
                    <c:when test="${empty myOrders}">
                        <div class="text-center py-16">
                            <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png" class="w-24 h-24 mx-auto opacity-20 mb-4">
                            <p class="text-gray-500 text-lg">Bạn chưa có đơn hàng nào.</p>
                            <a href="products" class="mt-4 inline-block bg-pink-600 text-white px-6 py-2 rounded-full hover:bg-pink-700 transition">Mua sắm ngay</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead>
                                    <tr class="bg-gray-100 text-gray-600 uppercase text-sm leading-normal">
                                        <th class="py-4 px-6">Mã đơn</th>
                                        <th class="py-4 px-6">Ngày đặt</th>
                                        <th class="py-4 px-6">Người nhận</th>
                                        <th class="py-4 px-6">Tổng tiền</th>
                                        <th class="py-4 px-6">Thanh toán</th>
                                        <th class="py-4 px-6 text-center">Trạng thái</th>
                                        <th class="py-4 px-6 text-center">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody class="text-gray-700 text-sm">
                                    <c:forEach items="${myOrders}" var="o">
                                        <tr class="border-b border-gray-200 hover:bg-gray-50 transition">
                                            <td class="py-4 px-6 font-bold text-pink-600">#${o.id}</td>
                                            <td class="py-4 px-6"><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/></td>
                                            <td class="py-4 px-6">
                                                <div class="font-semibold">${o.recipientName}</div>
                                                <div class="text-xs text-gray-500">${o.recipientPhone}</div>
                                            </td>
                                            <td class="py-4 px-6 font-bold">
                                                <fmt:formatNumber value="${o.totalPrice}" type="currency" currencySymbol="₫"/>
                                            </td>
                                            <td class="py-4 px-6">
                                                <c:choose>
                                                    <c:when test="${o.paymentMethod == 'BANKING'}">
                                                        <span class="text-blue-600 font-semibold"><i class="fas fa-university"></i> Chuyển khoản</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-green-600 font-semibold"><i class="fas fa-money-bill-wave"></i> Tiền mặt (COD)</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="py-4 px-6 text-center">
                                                <c:choose>
                                                    <c:when test="${o.status == 'Đang xử lý'}">
                                                        <span class="status-badge st-processing">Đang xử lý</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'Đang giao hàng'}">
                                                        <span class="status-badge st-shipping">Đang giao</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'Đã giao' || o.status == 'Hoàn thành'}">
                                                        <span class="status-badge st-completed">Hoàn thành</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge st-cancelled">Đã hủy</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="py-4 px-6 text-center">
                                                <c:if test="${o.status == 'Đang xử lý'}">
                                                    <a href="order-history?action=cancel&id=${o.id}" 
                                                       onclick="return confirm('Bạn chắc chắn muốn hủy đơn hàng này?');"
                                                       class="text-red-500 hover:text-red-700 font-semibold transition bg-red-50 hover:bg-red-100 px-3 py-1 rounded border border-red-200">
                                                        <i class="fas fa-times"></i> Hủy đơn
                                                    </a>
                                                </c:if>
                                                <c:if test="${o.status != 'Đang xử lý'}">
                                                    <span class="text-gray-400 italic text-xs">Không thể hủy</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

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