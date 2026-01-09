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
/* CSS riêng cho trang giỏ hàng để số lượng đẹp hơn */
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
					<li><a
						href="${not empty sessionScope.user ? 'contact.jsp' : 'login'}">Liên
							Hệ</a></li>
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
							<c:when test="${not empty sessionScope.user}">
								<div class="px-6 py-4 bg-gray-50 border-b border-gray-100">
									<p class="text-xs text-gray-400 uppercase tracking-wider font-semibold mb-1">Tài khoản</p>
									<p class="text-base font-bold text-gray-800 truncate leading-tight">${sessionScope.user.fullName}</p>
									<p class="text-xs text-gray-400 truncate mt-0.5">@${sessionScope.user.email}</p>
								</div>
								<a href="logout" class="block px-6 py-3.5 text-sm text-red-500 hover:bg-red-50 hover:text-red-600 font-medium transition-colors duration-200 flex items-center">
									<i class="fas fa-sign-out-alt mr-3"></i> Đăng xuất
								</a>
							</c:when>
							<c:otherwise>
								<div class="p-2">
									<a href="login" class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
										<i class="fas fa-sign-in-alt w-6 text-center mr-2 text-gray-400"></i> Đăng nhập
									</a> 
									<a href="login.jsp?action=signup" class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
										<i class="fas fa-user-plus w-6 text-center mr-2 text-gray-400"></i> Đăng ký
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
							<span
								class="absolute -top-1 -right-2 bg-pink-600 text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full border-2 border-[#1a1a1a] cart-badge">
								${sessionScope.cart.size()} </span>
						</c:if>
					</button>

					<div id="cartDropdown"
						class="z-50 hidden bg-white divide-y divide-gray-100 rounded-xl shadow-lg w-48 overflow-hidden transform origin-top-right transition-all duration-200">
						<div class="px-4 py-3 bg-gray-50 border-b text-gray-900 text-sm font-semibold">
							Hoạt động mua sắm</div>
						<ul class="py-1 text-sm text-gray-700"
							aria-labelledby="cartDropdownButton">
							<li><a href="cart.jsp"
								class="block px-4 py-3 hover:bg-pink-50 hover:text-pink-600 transition flex items-center group">
									<span class="bg-pink-100 text-pink-600 w-8 h-8 rounded-full flex items-center justify-center mr-3 group-hover:bg-pink-200 transition">
										<i class="fas fa-shopping-cart text-xs"></i>
									</span>
									<div>
										<span class="font-bold block">Giỏ hàng</span> <span
											class="text-xs text-gray-500">Thanh toán ngay</span>
									</div>
							</a></li>
							<li><a href="order-history"
								class="block px-4 py-3 hover:bg-blue-50 hover:text-blue-600 transition flex items-center group">
									<span class="bg-blue-100 text-blue-600 w-8 h-8 rounded-full flex items-center justify-center mr-3 group-hover:bg-blue-200 transition">
										<i class="fas fa-receipt text-xs"></i>
									</span>
									<div>
										<span class="font-bold block">Đơn mua</span> <span
											class="text-xs text-gray-500">Xem lịch sử</span>
									</div>
							</a></li>
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
						<i class="fa-solid fa-chevron-right text-gray-600 mx-2"></i> <span
							class="text-pink-500 font-semibold ml-2">Giỏ hàng</span>
					</div>
				</li>
			</ol>
		</nav>

		<h1 class="text-3xl font-bold mb-8 uppercase border-b-2 border-black inline-block pb-2 text-black">
			Giỏ hàng của bạn
		</h1>

		<c:if test="${empty sessionScope.cart}">
			<div class="text-center py-16 bg-white rounded shadow-sm">
				<div class="text-6xl text-gray-300 mb-4">
					<i class="fas fa-shopping-basket"></i>
				</div>
				<p class="text-xl text-gray-500 mb-6">Giỏ hàng của bạn đang trống trơn!</p>
				<a href="home"
					class="bg-black text-white px-8 py-3 rounded hover:bg-gray-800 transition uppercase font-bold">
					Tiếp tục mua sắm </a>
			</div>
		</c:if>

		<c:if test="${not empty sessionScope.cart}">
			<div class="grid grid-cols-1 md:grid-cols-3 gap-8">

				<c:set var="serverError" value="${requestScope.stockError != null ? requestScope.stockError : sessionScope.stockError}" />
				
				<div id="error-alert" class="col-span-1 md:col-span-3 ${not empty serverError ? '' : 'hidden'}">
					<div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative shadow-md flex items-center animate-pulse" role="alert">
						<i class="fas fa-exclamation-triangle text-2xl mr-3"></i>
						<div>
							<strong class="font-bold">Thông báo:</strong>
							<span id="error-msg" class="block sm:inline">${serverError}</span>
						</div>
						<span onclick="document.getElementById('error-alert').classList.add('hidden')" class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer hover:text-red-900">
							<i class="fas fa-times"></i>
						</span>
					</div>
					<c:remove var="stockError" scope="session"/>
				</div>
				<div class="md:col-span-2 space-y-4">
					<div class="bg-white rounded shadow overflow-hidden">
						<div class="hidden md:grid grid-cols-12 gap-4 p-4 bg-gray-100 font-bold text-gray-700 text-sm uppercase">
							<div class="col-span-6">Sản phẩm</div>
							<div class="col-span-2 text-center">Đơn giá</div>
							<div class="col-span-2 text-center">Số lượng</div>
							<div class="col-span-2 text-right">Thành tiền</div>
						</div>

						<c:forEach items="${sessionScope.cart}" var="item">
							<div id="row-${item.product.id}"
								class="grid grid-cols-1 md:grid-cols-12 gap-4 p-4 items-center border-b last:border-0 hover:bg-gray-50 transition">
								
								<div class="col-span-6 flex gap-4 items-center">
									<a href="product-detail?id=${item.product.id}"
										class="w-20 h-20 flex-shrink-0 border rounded overflow-hidden hover:opacity-80 transition">
										<img src="images/${item.product.image}"
										alt="${item.product.name}" class="w-full h-full object-cover">
									</a>
									<div>
										<h3 class="font-bold text-gray-800 hover:text-blue-600 transition">
											<a href="product-detail?id=${item.product.id}">${item.product.name}</a>
										</h3>
										<div class="text-xs text-gray-500 mt-1 flex items-center flex-wrap gap-2">
    <span>Mã SP: #${item.product.id}</span>
    
    <span class="text-gray-300">|</span>
    
    <span class="font-semibold ${item.product.stock < 10 ? 'text-red-500' : 'text-blue-600'}">
        <i class="fas fa-box-open mr-1"></i>
        Kho còn: ${item.product.stock}
    </span>
</div>
										<a href="update-cart?id=${item.product.id}&mod=-999"
											class="text-red-500 text-xs mt-2 hover:underline flex items-center gap-1 cursor-pointer">
											<i class="fas fa-trash"></i> Xóa
										</a>
									</div>
								</div>

								<div class="col-span-2 text-center font-medium text-gray-600">
									<fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" />
								</div>

								<div class="col-span-2 flex justify-center">
									<div class="flex items-center border rounded border-gray-300">
										<button type="button"
											onclick="updateQuantityAjax(${item.product.id}, -1)"
											class="px-3 py-1 text-gray-600 hover:bg-gray-100 font-bold border-r border-gray-200 focus:outline-none transition h-full">-</button>
										
										<input type="number" id="qty-${item.product.id}"
											value="${item.quantity}"
											onchange="updateQuantityDirectly(${item.product.id}, this)"
											class="w-16 text-center border-0 text-sm font-bold text-gray-900 focus:ring-0 bg-transparent p-0 qty-input" />
										
										<button type="button"
											onclick="updateQuantityAjax(${item.product.id}, 1)"
											class="px-3 py-1 text-gray-600 hover:bg-gray-100 font-bold border-l border-gray-200 focus:outline-none transition h-full">+</button>
									</div>
								</div>

								<div class="col-span-2 text-right font-bold text-red-600">
									<span id="item-total-${item.product.id}">
										<fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫" />
									</span>
								</div>
							</div>
						</c:forEach>
					</div>

					<div class="text-right">
						<a href="home" class="text-blue-600 hover:underline text-sm"><i
							class="fas fa-arrow-left"></i> Tiếp tục mua hàng</a>
					</div>
				</div>

				<div class="md:col-span-1">
					<div class="bg-white p-6 rounded shadow sticky top-24">
						<h2 class="text-lg font-bold mb-4 uppercase border-b pb-2 text-black">Thông tin thanh toán</h2>

						<form action="checkout" method="post" class="space-y-4">
							<div class="flex justify-between items-center mb-6">
								<span class="text-gray-600">Tạm tính:</span> 
								<span class="font-bold text-xl text-black"> 
									<span id="cart-total-display">
										<fmt:formatNumber value="${totalMoney}" type="currency" currencySymbol="₫" />
									</span>
								</span>
							</div>

							<hr class="border-dashed">

							<div>
								<label class="block text-xs font-bold text-gray-700 uppercase mb-1">Họ tên người nhận *</label> 
								<input type="text" name="fullname" placeholder="Nguyễn Văn A" required class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
							</div>

							<div>
								<label class="block text-xs font-bold text-gray-700 uppercase mb-1">Số điện thoại *</label> 
								<input type="tel" name="phone" placeholder="09xxxxxxx" required class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
							</div>

							<div>
								<label class="block text-xs font-bold text-gray-700 uppercase mb-1">Địa chỉ giao hàng *</label>
								<textarea name="address" rows="3" placeholder="Số nhà, đường, phường/xã..." required class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black text-black"></textarea>
							</div>

							<div class="mt-4">
								<label class="block text-xs font-bold text-gray-700 uppercase mb-2">Phương thức thanh toán</label>
								<div class="flex items-center mb-2">
									<input id="payment-cod" type="radio" value="COD" name="payment_method" checked class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500">
									<label for="payment-cod" class="ml-2 text-sm font-medium text-gray-900">Thanh toán khi nhận hàng (COD)</label>
								</div>
								<div class="flex items-center">
									<input id="payment-bank" type="radio" value="BANKING" name="payment_method" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500">
									<label for="payment-bank" class="ml-2 text-sm font-medium text-gray-900">Chuyển khoản ngân hàng</label>
								</div>
							</div>

							<button type="submit" class="w-full bg-red-600 text-white py-3 rounded font-bold hover:bg-red-700 transition uppercase shadow-lg transform hover:-translate-y-1">
								Tiến hành đặt hàng
							</button>

							<p class="text-xs text-gray-400 text-center mt-2">
								<i class="fas fa-shield-alt"></i> Bảo mật thanh toán 100%
							</p>
						</form>
					</div>
				</div>
			</div>
		</c:if>
	</main>

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
				<h3>GROUP 14</h3>
				<p>
					Linh Trung Ward<br /> Thu Duc - Ho Chi Minh City - Viet Nam<br />
					<strong>Phone:</strong> +0862210723<br /> <strong>Email:</strong>
					group14@gmail.com
				</p>
				<div class="social-icons">
					<a href="#"><i class="fab fa-twitter"></i></a> 
					<a href="#"><i class="fab fa-facebook-f"></i></a> 
					<a href="#"><i class="fab fa-instagram"></i></a> 
					<a href="#"><i class="fab fa-skype"></i></a> 
					<a href="#"><i class="fab fa-linkedin-in"></i></a>
				</div>
			</div>
			<div>
				<h3>Useful Links</h3>
				<p><a href="home">Home</a></p>
				<p><a href="#">About us</a></p>
				<p><a href="#">Services</a></p>
				<p><a href="#">Terms of service</a></p>
				<p><a href="#">Privacy policy</a></p>
			</div>
			<div>
				<h3>Our Services</h3>
				<p><a href="#">Web Design</a></p>
				<p><a href="#">Web Development</a></p>
				<p><a href="#">Product Management</a></p>
				<p><a href="#">Marketing</a></p>
				<p><a href="#">Graphic Design</a></p>
			</div>
			<div>
				<h3>Our Newsletter</h3>
				<p>Your support is our greatest motivation. Join us for the best experience</p>
				<form class="newsletter">
					<input type="email" placeholder="Email" /> <input type="submit" value="Subscribe" />
				</form>
			</div>
		</div>
	</footer>

	<div class="footer-bottom">
		<p>© Copyright <strong>GROUP 14</strong>. All Rights Reserved</p>
		<p>Designed by GROUP 14</p>
	</div>

	<c:if test="${not empty msg}">
		<div id="paymentModal" class="fixed inset-0 bg-gray-800 bg-opacity-75 overflow-y-auto h-full w-full z-[9999] flex items-center justify-center backdrop-blur-sm">
			<div class="relative p-6 border w-[450px] shadow-2xl rounded-2xl bg-white text-center transform transition-all scale-100">
				
				<c:if test="${paymentMethod == 'COD'}">
					<div class="mt-2">
						<div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-green-100 mb-4 animate-bounce">
							<i class="fas fa-check text-green-600 text-3xl"></i>
						</div>
						<h3 class="text-2xl font-bold text-gray-900 mb-2">Đặt hàng thành công!</h3>
						<div class="mt-2 px-2 py-3">
							<p class="text-gray-500">Cảm ơn bạn đã mua sắm tại Kachi-Kun Shop.<br>Đơn hàng của bạn đã được ghi nhận.</p>
						</div>
						<div class="mt-4">
							<button onclick="window.location.href='home'" class="px-6 py-3 bg-green-600 text-white text-base font-bold rounded-lg w-full shadow hover:bg-green-700 transition duration-300">
								Về trang chủ
							</button>
						</div>
					</div>
				</c:if>

				<c:if test="${paymentMethod == 'BANKING'}">
					<div class="mt-2">
						<img src="https://upload.wikimedia.org/wikipedia/commons/6/69/Logo_BIDV.svg" alt="BIDV Logo" class="h-10 mx-auto mb-4">
						<h3 class="text-xl font-bold text-gray-800 mb-4 uppercase border-b pb-2">Thông tin chuyển khoản</h3>
						<div class="text-left bg-blue-50 p-5 rounded-xl border border-blue-200 shadow-inner mx-1">
							<div class="mb-4 text-center">
								<p class="text-gray-500 text-xs uppercase font-semibold tracking-wider mb-1">Số tài khoản</p>
								<div class="flex items-center justify-center gap-2">
									<p id="bank-acc-num" class="text-blue-700 font-extrabold text-3xl tracking-widest font-mono">1234 567 890</p>
									<button onclick="copyToClipboard()" class="text-gray-400 hover:text-blue-600" title="Sao chép"><i class="far fa-copy"></i></button>
								</div>
							</div>
							<div class="border-t border-blue-200 my-3 border-dashed"></div>
							<div class="space-y-3 text-sm">
								<div class="flex justify-between"><span class="text-gray-600">Ngân hàng:</span><span class="font-bold text-gray-900">BIDV</span></div>
								<div class="flex justify-between"><span class="text-gray-600">Chủ tài khoản:</span><span class="font-bold text-gray-900 uppercase">KACHI KUN SHOP</span></div>
								<div class="flex justify-between items-center bg-white p-2 rounded border border-blue-100"><span class="text-gray-600">Số tiền:</span><span class="text-red-600 font-bold text-lg"><fmt:formatNumber value="${finalTotal}" type="currency" currencySymbol="₫"/></span></div>
								<div class="flex justify-between"><span class="text-gray-600">Nội dung:</span><span class="font-bold text-gray-900 italic">Thanh toan don hang</span></div>
							</div>
						</div>
						<p class="text-[11px] text-gray-500 mt-4 italic">*Vui lòng chuyển khoản đúng số tiền.</p>
						<div class="mt-5 space-y-2">
							<button onclick="alert('Đơn hàng của bạn đang được xử lý. Cảm ơn bạn!'); window.location.href='home'" class="px-4 py-3 bg-blue-700 text-white text-base font-bold rounded-lg w-full shadow-lg hover:bg-blue-800 transition transform hover:-translate-y-0.5">Đã chuyển khoản xong</button>
							<button onclick="window.location.href='home'" class="px-4 py-2 text-gray-500 text-sm hover:text-gray-800 underline">Để sau, về trang chủ</button>
						</div>
					</div>
				</c:if>
			</div>
		</div>
		<script>
			function copyToClipboard() {
				var copyText = document.getElementById("bank-acc-num").innerText;
				var rawText = copyText.replace(/\s/g, ''); 
				navigator.clipboard.writeText(rawText).then(function() {
					alert("Đã sao chép số tài khoản: " + rawText);
				}, function(err) { console.error('Lỗi sao chép: ', err); });
			}
		</script>
	</c:if>

	<script src="https://cdn.tailwindcss.com"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
	<script src="script.js"></script>
	
	<script>
		// 1. Hàm cho nút bấm (+/-)
		function updateQuantityAjax(productId, mod) {
			callAjax('ajaxUpdateCart?id=' + productId + '&mod=' + mod, productId);
		}

		// 2. Hàm cho ô nhập liệu (Direct Input)
		function updateQuantityDirectly(productId, inputElement) {
			let newQty = inputElement.value;
			if (newQty === "" || isNaN(newQty) || parseInt(newQty) < 1) {
				alert("Vui lòng nhập số lượng hợp lệ!");
				location.reload(); 
				return;
			}
			callAjax('ajaxUpdateCart?id=' + productId + '&qty=' + newQty, productId);
		}

		// 3. Hàm gọi AJAX & Hiển thị lỗi
		function callAjax(url, productId) {
			const qtyInput = document.getElementById("qty-" + productId);
			const itemTotalSpan = document.getElementById("item-total-" + productId);
			const rowDiv = document.getElementById("row-" + productId);
			const cartTotalSpan = document.getElementById("cart-total-display");
			
			// Lấy khung lỗi (Luôn tồn tại trong DOM)
			const errorAlert = document.getElementById("error-alert");
			const errorMsg = document.getElementById("error-msg");

			fetch(url)
				.then(response => response.json())
				.then(data => {
					if (data.status === 'error') {
						// --- CÓ LỖI ---
						if(errorMsg) errorMsg.innerText = data.message;
						if(errorAlert) {
							errorAlert.classList.remove("hidden"); // Hiện khung đỏ
							errorAlert.scrollIntoView({behavior: "smooth", block: "center"}); // Cuộn tới lỗi
						}
						if (data.currentQty && qtyInput) {
							qtyInput.value = data.currentQty; // Reset số lượng
						}
						
					} else if (data.status === 'removed') {
						// --- XÓA SP ---
						if(errorAlert) errorAlert.classList.add("hidden");
						if(rowDiv) rowDiv.remove();
						if(cartTotalSpan) cartTotalSpan.innerText = data.cartTotal;
						updateCartCount(data.cartSize);
						
					} else {
						// --- UPDATE OK ---
						if(errorAlert) errorAlert.classList.add("hidden"); // Ẩn lỗi
						if(qtyInput) qtyInput.value = data.newQty;
						if(itemTotalSpan) itemTotalSpan.innerText = data.itemTotal;
						if(cartTotalSpan) cartTotalSpan.innerText = data.cartTotal;
						updateCartCount(data.cartSize);
					}
				})
				.catch(error => console.error('Lỗi:', error));
		}

		function updateCartCount(count) {
			const badges = document.querySelectorAll(".absolute.-top-1.-right-2"); 
			badges.forEach(b => b.innerText = count);
			if(count === 0) location.reload(); 
		}
	</script>
</body>
</html>