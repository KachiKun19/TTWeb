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

<jsp:include page="components/header2.jsp" />

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

	<section class="container mx-auto px-4 pb-12">
		<div id="recently-viewed-container" class="mt-6 border-t border-gray-800 pt-6"></div>
	</section>
</main>

<jsp:include page="components/footer.jsp" />
<script>
	document.addEventListener("DOMContentLoaded", function() {
		// 1. Lưu sản phẩm hiện tại vào localStorage
		const currentProduct = {
			id: "${detail.id}",
			name: "${detail.name}",
			price: ${detail.price},
			image: "${detail.image}"
		};
		saveRecentlyViewed(currentProduct);

		let recentlyViewed = JSON.parse(localStorage.getItem("recentlyViewed")) || [];
		recentlyViewed = recentlyViewed.filter(item => item.id !== currentProduct.id);
		recentlyViewed.unshift(currentProduct);

		if (recentlyViewed.length > 6) { recentlyViewed = recentlyViewed.slice(0, 6); }

		localStorage.setItem("recentlyViewed", JSON.stringify(recentlyViewed));

		// --- PHẦN 2: GỌI HÀM HIỂN THỊ (QUAN TRỌNG) ---
		displayRecentlyViewed();
	});

	function displayRecentlyViewed() {
		const container = document.getElementById("recently-viewed-container");
		if (!container) return;

		const list = JSON.parse(localStorage.getItem("recentlyViewed")) || [];

		// Chỉ hiển thị nếu có từ 2 sản phẩm trở lên (vì 1 cái là cái đang xem rồi)
		if (list.length <= 1) return;

		let html = '<h3 class="text-white font-bold mb-6 uppercase text-lg border-b border-pink-500 pb-2 inline-block">Sản phẩm bạn đã xem</h3>';
		html += '<div class="grid grid-cols-2 md:grid-cols-5 gap-6">';

		list.forEach(item => {
			// Không hiện lại chính sản phẩm đang xem
			if(item.id !== "${detail.id}") {
				const formattedPrice = new Intl.NumberFormat('vi-VN').format(item.price);

				// Sử dụng nối chuỗi truyền thống để tránh lỗi JSP parse nhầm dấu backtick
				html += '<div class="bg-[#252525] p-4 rounded-xl border border-gray-800 hover:border-pink-500 transition shadow-lg group">' +
						'<a href="product-detail?id=' + item.id + '">' +
						'<div class="bg-white rounded-lg p-2 mb-3 overflow-hidden">' +
						'<img src="images/' + item.image + '" class="w-full h-32 object-contain group-hover:scale-110 transition duration-300">' +
						'</div>' +
						'<p class="text-sm font-semibold truncate text-gray-200">' + item.name + '</p>' +
						'<p class="text-pink-500 font-bold mt-1">' + formattedPrice + '₫</p>' +
						'</a>' +
						'</div>';
			}
		});
		html += '</div>';
		container.innerHTML = html;
	}
	function saveRecentlyViewed(product) {
		let list = JSON.parse(localStorage.getItem("recentlyViewed")) || [];
		// Xóa nếu sản phẩm đã tồn tại để đưa lên đầu
		list = list.filter(item => item.id !== product.id);
		list.unshift(product);
		// Giới hạn 5 sản phẩm
		if (list.length > 6) list.pop();
		localStorage.setItem("recentlyViewed", JSON.stringify(list));
	}
</script>
</body>
</html>