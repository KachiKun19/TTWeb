<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sản phẩm - Asuka</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
	<!-- Header giống trang Home -->
	<div
		class="bg-black text-white text-base py-4 flex justify-center space-x-4">
		<span> Giao hàng nhanh 0-3 ngày</span> <span>•</span> <span>
			Trả góp 0% </span> <span>•</span> <span> Hỗ trợ 24/7 </span> <span>•</span>
		<span> Miễn phí ship </span> <span>•</span> <span> Tư vấn miễn
			phí </span> <span>•</span> <span> Bảo hành gọn, xử lý nhanh </span> <span>•</span>
	</div>

	<header class="bg-white text-black shadow sticky top-0 z-50">
		<div
			class="max-w-7xl mx-auto flex justify-between items-center py-6 px-4">
			<div class="flex items-center space-x-2">
				<img src="logo.png" alt="logo" class="h-8"> <span
					class="font-semibold">Asuka</span>
			</div>
			<nav class="hidden md:flex space-x-6 font-medium">
				<a href="home" class="hover:text-gray-600">Trang chủ</a> <a
					href="products?category=1" class="hover:text-gray-600">Gaming
					Gear</a> <a href="products?category=2" class="hover:text-gray-600">Office
					Gear</a> <a href="#" class="hover:text-gray-600">Góc game thủ</a> <a
					href="#" class="hover:text-gray-600">Sản phẩm 2N</a> <a href="#"
					class="hover:text-gray-600">Tích điểm</a> <a href="#"
					class="hover:text-gray-600">Liên hệ</a>
			</nav>
			<div class="flex items-center space-x-4">
				<a href="login.jsp"> <svg xmlns="http://www.w3.org/2000/svg"
						fill="none" viewBox="0 0 24 24" stroke-width="1.5"
						stroke="currentColor" class="size-6">
                        <path stroke-linecap="round"
							stroke-linejoin="round"
							d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
                    </svg>
				</a>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none"
					viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
					class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round"
						d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                </svg>
				<a href="cart.jsp"> <svg xmlns="http://www.w3.org/2000/svg"
						fill="none" viewBox="0 0 24 24" stroke-width="1.5"
						stroke="currentColor" class="size-6">
                        <path stroke-linecap="round"
							stroke-linejoin="round"
							d="M15.75 10.5V6a3.75 3.75 0 1 0-7.5 0v4.5m11.356-1.993 1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 0 1-1.12-1.243l1.264-12A1.125 1.125 0 0 1 5.513 7.5h12.974c.576 0 1.059.435 1.119 1.007ZM8.625 10.5a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm7.5 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
                    </svg>
				</a>
			</div>
		</div>
	</header>

	<!-- Breadcrumb -->
	<div class="max-w-7xl mx-auto py-4 px-4">
		<nav class="text-sm">
			<ol class="list-none p-0 inline-flex">
				<li class="flex items-center"><a href="home"
					class="text-gray-500 hover:text-gray-700">Trang chủ</a> <svg
						class="w-3 h-3 mx-2" fill="none" stroke="currentColor"
						viewBox="0 0 24 24">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg></li>
				<li class="flex items-center"><span
					class="text-gray-800 font-medium"> <c:choose>
							<c:when test="${not empty currentCategory}">
                                ${currentCategory.categoryName}
                            </c:when>
							<c:otherwise>
                                Tất cả sản phẩm
                            </c:otherwise>
						</c:choose>
				</span></li>
			</ol>
		</nav>
	</div>

	<!-- Tiêu đề danh mục -->
	<div class="max-w-7xl mx-auto py-6 px-4">
		<h1 class="text-3xl font-bold text-gray-800">
			<c:choose>
				<c:when test="${not empty currentCategory}">
                    ${currentCategory.categoryName}
                </c:when>
				<c:otherwise>
                    Tất cả sản phẩm
                </c:otherwise>
			</c:choose>
		</h1>
		<c:if test="${not empty products}">
			<p class="text-gray-600 mt-2">Tìm thấy ${products.size()} sản
				phẩm</p>
		</c:if>
	</div>

	<!-- Bộ lọc và sắp xếp -->
	<div
		class="max-w-7xl mx-auto py-4 px-4 flex flex-col md:flex-row justify-between items-start md:items-center space-y-4 md:space-y-0">
		<div class="flex flex-wrap gap-4">
			<!-- Bộ lọc thương hiệu -->
			<div class="relative">
				<select id="brandFilter"
					class="appearance-none bg-white border border-gray-300 rounded-md py-2 pl-3 pr-10 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
					<option value="">Tất cả thương hiệu</option>
					<c:forEach var="brand" items="${brands}">
						<option value="${brand.brandId}">${brand.brandName}</option>
					</c:forEach>
				</select>
			</div>

			<!-- Bộ lọc giá -->
			<div class="relative">
				<select id="priceFilter"
					class="appearance-none bg-white border border-gray-300 rounded-md py-2 pl-3 pr-10 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
					<option value="">Tất cả mức giá</option>
					<option value="0-500000">Dưới 500.000đ</option>
					<option value="500000-1000000">500.000đ - 1.000.000đ</option>
					<option value="1000000-2000000">1.000.000đ - 2.000.000đ</option>
					<option value="2000000-999999999">Trên 2.000.000đ</option>
				</select>
			</div>

			<!-- Bộ lọc tình trạng -->
			<div class="relative">
				<select id="stockFilter"
					class="appearance-none bg-white border border-gray-300 rounded-md py-2 pl-3 pr-10 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
					<option value="">Tất cả tình trạng</option>
					<option value="inStock">Còn hàng</option>
					<option value="outOfStock">Hết hàng</option>
				</select>
			</div>
		</div>

		<!-- Sắp xếp -->
		<div class="relative">
			<select id="sortBy"
				class="appearance-none bg-white border border-gray-300 rounded-md py-2 pl-3 pr-10 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
				<option value="default">Sắp xếp theo: Mặc định</option>
				<option value="price_asc">Giá: Thấp đến cao</option>
				<option value="price_desc">Giá: Cao đến thấp</option>
				<option value="name_asc">Tên: A-Z</option>
				<option value="name_desc">Tên: Z-A</option>
			</select>
		</div>
	</div>

	<!-- Danh sách sản phẩm -->
	<section class="max-w-7xl mx-auto py-8 px-4">
		<c:choose>
			<c:when test="${not empty products && products.size() > 0}">
				<div
					class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6"
					id="productGrid">
					<c:forEach var="product" items="${products}">
						<div
							class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300 product-item"
							data-brand="${product.brand.brandId}"
							data-price="${product.price}"
							data-stock="${product.stock > 0 ? 'inStock' : 'outOfStock'}">
							<div class="relative">
								<img
									src="${not empty product.imageUrl ? product.imageUrl : 'https://via.placeholder.com/300x300'}"
									alt="${product.name}" class="w-full h-48 object-cover">
								<c:if test="${product.stock <= 0}">
									<div
										class="absolute top-2 left-2 bg-gray-500 text-white text-xs font-bold px-2 py-1 rounded">
										Hết hàng</div>
								</c:if>
								<c:if test="${product.price > 2000000}">
									<div
										class="absolute top-2 right-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded">
										Cao cấp</div>
								</c:if>
							</div>
							<div class="p-4">
								<h3 class="text-lg font-semibold text-gray-800 mb-2 truncate">${product.name}</h3>
								<p class="text-sm text-gray-600 mb-2">${product.brand.brandName}</p>
								<div class="flex items-center justify-between">
									<div>
										<span class="text-lg font-bold text-gray-800"> <fmt:formatNumber
												value="${product.price}" type="number" maxFractionDigits="0" />đ
										</span>
									</div>
									<c:choose>
										<c:when test="${product.stock > 0}">
											<button
												class="bg-blue-600 text-white px-3 py-1 rounded-md text-sm hover:bg-blue-700 transition-colors add-to-cart"
												data-product-id="${product.productId}"
												data-product-name="${product.name}"
												data-product-price="${product.price}">Thêm</button>
										</c:when>
										<c:otherwise>
											<button
												class="bg-gray-400 text-white px-3 py-1 rounded-md text-sm cursor-not-allowed"
												disabled>Hết hàng</button>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<div class="text-center py-12">
					<svg class="mx-auto h-12 w-12 text-gray-400" fill="none"
						viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2"
							d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
					<h3 class="mt-2 text-sm font-medium text-gray-900">Không tìm
						thấy sản phẩm</h3>
					<p class="mt-1 text-sm text-gray-500">Không có sản phẩm nào phù
						hợp với tiêu chí tìm kiếm của bạn.</p>
					<div class="mt-6">
						<a href="products"
							class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
							Xem tất cả sản phẩm </a>
					</div>
				</div>
			</c:otherwise>
		</c:choose>

		<!-- Phân trang (có thể thêm sau) -->
		<!--
        <div class="flex justify-center mt-12">
            <nav class="flex items-center space-x-2">
                <a href="#" class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                    <span>Trước</span>
                </a>
                <a href="#" class="px-3 py-2 text-sm font-medium text-blue-600 bg-blue-50 border border-blue-300 rounded-md">1</a>
                <a href="#" class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50">2</a>
                <a href="#" class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50">3</a>
                <a href="#" class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                    <span>Tiếp</span>
                </a>
            </nav>
        </div>
        -->
	</section>

	<!-- Footer -->
	<footer class="bg-gray-800 text-white py-12">
		<div class="max-w-7xl mx-auto px-4">
			<div class="grid grid-cols-1 md:grid-cols-4 gap-8">
				<div>
					<h3 class="text-lg font-semibold mb-4">Về chúng tôi</h3>
					<ul class="space-y-2">
						<li><a href="#" class="text-gray-300 hover:text-white">Giới
								thiệu</a></li>
						<li><a href="#" class="text-gray-300 hover:text-white">Tin
								tức</a></li>
						<li><a href="#" class="text-gray-300 hover:text-white">Tuyển
								dụng</a></li>
					</ul>
				</div>
				<div>
					<h3 class="text-lg font-semibold mb-4">Hỗ trợ khách hàng</h3>
					<ul class="space-y-2">
						<li><a href="#" class="text-gray-300 hover:text-white">Hướng
								dẫn mua hàng</a></li>
						<li><a href="#" class="text-gray-300 hover:text-white">Chính
								sách bảo hành</a></li>
						<li><a href="#" class="text-gray-300 hover:text-white">Chính
								sách đổi trả</a></li>
					</ul>
				</div>
				<div>
					<h3 class="text-lg font-semibold mb-4">Liên hệ</h3>
					<ul class="space-y-2">
						<li class="text-gray-300">Hotline: 1900 1234</li>
						<li class="text-gray-300">Email: support@asuka.vn</li>
						<li class="text-gray-300">Địa chỉ: 123 Nguyễn Văn Linh, Q.7,
							TP.HCM</li>
					</ul>
				</div>
				<div>
					<h3 class="text-lg font-semibold mb-4">Kết nối với chúng tôi</h3>
					<div class="flex space-x-4">
						<!-- Social media icons -->
					</div>
				</div>
			</div>
			<div
				class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
				<p>© 2023 Asuka. Tất cả các quyền được bảo lưu.</p>
			</div>
		</div>
	</footer>

	<!-- JavaScript cho bộ lọc và giỏ hàng -->
	<script>
        // Bộ lọc sản phẩm
        document.addEventListener('DOMContentLoaded', function() {
            const brandFilter = document.getElementById('brandFilter');
            const priceFilter = document.getElementById('priceFilter');
            const stockFilter = document.getElementById('stockFilter');
            const sortBy = document.getElementById('sortBy');
            const productItems = document.querySelectorAll('.product-item');

            function filterProducts() {
                const selectedBrand = brandFilter.value;
                const selectedPrice = priceFilter.value;
                const selectedStock = stockFilter.value;
                const selectedSort = sortBy.value;

                productItems.forEach(item => {
                    let show = true;

                    // Lọc theo thương hiệu
                    if (selectedBrand && item.dataset.brand !== selectedBrand) {
                        show = false;
                    }

                    // Lọc theo giá
                    if (selectedPrice) {
                        const [min, max] = selectedPrice.split('-').map(Number);
                        const price = parseFloat(item.dataset.price);
                        if (price < min || price > max) {
                            show = false;
                        }
                    }

                    // Lọc theo tình trạng
                    if (selectedStock && item.dataset.stock !== selectedStock) {
                        show = false;
                    }

                    item.style.display = show ? 'block' : 'none';
                });

                // Sắp xếp sản phẩm
                sortProducts(selectedSort);
            }

            function sortProducts(sortType) {
                const productGrid = document.getElementById('productGrid');
                const items = Array.from(productGrid.querySelectorAll('.product-item'));

                items.sort((a, b) => {
                    switch(sortType) {
                        case 'price_asc':
                            return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
                        case 'price_desc':
                            return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
                        case 'name_asc':
                            return a.querySelector('h3').textContent.localeCompare(b.querySelector('h3').textContent);
                        case 'name_desc':
                            return b.querySelector('h3').textContent.localeCompare(a.querySelector('h3').textContent);
                        default:
                            return 0;
                    }
                });

                // Xóa và thêm lại các item đã sắp xếp
                items.forEach(item => productGrid.appendChild(item));
            }

            // Thêm sự kiện cho các bộ lọc
            [brandFilter, priceFilter, stockFilter, sortBy].forEach(filter => {
                filter.addEventListener('change', filterProducts);
            });

            // Thêm vào giỏ hàng
            document.querySelectorAll('.add-to-cart').forEach(button => {
                button.addEventListener('click', function() {
                    const productId = this.dataset.productId;
                    const productName = this.dataset.productName;
                    const productPrice = this.dataset.productPrice;

                    // Gọi API hoặc xử lý thêm vào giỏ hàng
                    alert(`Đã thêm ${productName} vào giỏ hàng!`);
                    
                    // Có thể gửi AJAX request đến servlet để thêm vào giỏ hàng
                    /*
                    fetch('add-to-cart', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `productId=${productId}&quantity=1`
                    })
                    .then(response => response.json())
                    .then(data => {
                        if(data.success) {
                            alert('Đã thêm vào giỏ hàng!');
                        }
                    });
                    */
                });
            });
        });
    </script>
</body>
</html>