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
	<style>
		/* Hiệu ứng ẩn bớt mô tả */
		.description-content {
			max-height: 120px; /* Vừa đủ đọc khoảng 4-5 dòng */
			overflow: hidden;
			position: relative;
			transition: max-height 0.4s ease;
		}
		.description-content.expanded {
			max-height: 2500px;
		}
		.description-gradient {
			position: absolute;
			bottom: 0;
			left: 0;
			width: 100%;
			height: 50px;
			background: linear-gradient(transparent, #252525);
			pointer-events: none;
		}
		.description-content.expanded .description-gradient {
			display: none;
		}
	</style>
</head>
<body class="bg-[#1a1a1a] text-white font-['Montserrat']">

<jsp:include page="components/header2.jsp" />

<!-- Tối ưu margin top cho Header dính -->
<main class="container mx-auto px-4 py-4 mt-[100px] mb-10">
	<!-- Breadcrumb kích thước cân bằng -->
	<nav class="flex mb-4" aria-label="Breadcrumb">
		<ol class="inline-flex items-center space-x-1 md:space-x-2 text-xs">
			<li class="inline-flex items-center"><a href="home"
													class="text-gray-400 hover:text-white inline-flex items-center">
				<i class="fa-solid fa-house mr-1"></i> Trang chủ
			</a></li>
			<li>
				<div class="flex items-center">
					<i class="fa-solid fa-chevron-right text-gray-600 mx-1 text-[11px]"></i> <a
						href="products" class="text-gray-400 hover:text-white">Sản phẩm</a>
				</div>
			</li>
			<li aria-current="page">
				<div class="flex items-center">
					<i class="fa-solid fa-chevron-right text-gray-600 mx-1 text-[11px]"></i> <span
						class="text-pink-500 font-semibold truncate max-w-[200px]">${detail.name}</span>
				</div>
			</li>
		</ol>
	</nav>

	<div class="grid grid-cols-1 lg:grid-cols-12 gap-6 bg-[#252525] p-6 rounded-2xl shadow-xl">
		<!-- Cột ảnh: Tối ưu Responsive, dùng Aspect-square và Max-width thay vì chiều cao cố định -->
		<div class="lg:col-span-5 flex flex-col items-center justify-start lg:justify-center">
			<div class="overflow-hidden rounded-xl bg-white p-4 lg:p-8 w-full max-w-[400px] aspect-square mx-auto flex items-center justify-center shadow-inner">
				<img src="images/${detail.image}" alt="${detail.name}"
					 class="max-w-full max-h-full object-contain hover:scale-110 transition-transform duration-500">
			</div>
		</div>

		<!-- Cột thông tin -->
		<div class="lg:col-span-7 flex flex-col space-y-4">
			<div>
                <span class="bg-pink-600 text-white text-[10px] font-bold px-2 py-1 rounded uppercase tracking-wider inline-block mb-2">
					${detail.category.name}
				</span>
				<h1 class="text-2xl md:text-3xl font-bold leading-tight">${detail.name}</h1>
				<p class="text-gray-400 text-sm mt-1">
					Thương hiệu: <span class="text-white font-medium">${detail.brand.name}</span>
				</p>
			</div>

			<div class="flex items-center space-x-4">
                <span class="text-3xl font-extrabold text-pink-500">
                    <fmt:formatNumber value="${detail.price}" type="number" />₫
                </span>
				<c:if test="${detail.stock > 0}">
                    <span class="text-green-400 text-xs font-semibold bg-green-400/10 px-2 py-1 rounded border border-green-400/20 flex items-center">
                        <i class="fa-solid fa-check mr-1"></i> Còn hàng
                    </span>
				</c:if>
			</div>

			<!-- Thông số sp -->
			<div class="grid grid-cols-3 gap-3 py-3 border-y border-gray-700">
				<div class="flex flex-col items-center text-center p-2 bg-gray-800/40 rounded-lg">
					<i class="fa-solid fa-plug text-pink-500 text-lg mb-1"></i>
					<p class="text-[10px] text-gray-500 uppercase leading-none mb-1">Kết nối</p>
					<p class="text-xs font-semibold truncate w-full">${detail.connectionTypeVi}</p>
				</div>
				<div class="flex flex-col items-center text-center p-2 bg-gray-800/40 rounded-lg">
					<i class="fa-solid fa-layer-group text-pink-500 text-lg mb-1"></i>
					<p class="text-[10px] text-gray-500 uppercase leading-none mb-1">Chất liệu</p>
					<p class="text-xs font-semibold truncate w-full">${detail.materialVi}</p>
				</div>
				<div class="flex flex-col items-center text-center p-2 bg-gray-800/40 rounded-lg">
					<i class="fa-solid fa-maximize text-pink-500 text-lg mb-1"></i>
					<p class="text-[10px] text-gray-500 uppercase leading-none mb-1">Kích thước</p>
					<p class="text-xs font-semibold truncate w-full">${detail.sizeVi}</p>
				</div>
			</div>

			<!-- Mô tả chữ dễ nhìn hơn -->
			<div class="text-gray-300 text-sm leading-relaxed relative flex-grow">
				<div class="flex justify-between items-end mb-2">
					<h3 class="text-white font-bold text-base">Mô tả sản phẩm:</h3>
					<button onclick="toggleDescription()" id="btn-toggle-desc" class="text-pink-500 font-bold text-xs hover:underline focus:outline-none bg-gray-800/50 px-2 py-1 rounded">
						XEM THÊM <i class="fa-solid fa-chevron-down ml-1"></i>
					</button>
				</div>
				<div id="description-container" class="description-content">
					<p class="mb-0">${detail.description}</p>
					<div class="description-gradient"></div>
				</div>
			</div>

			<!-- Nút mua hàng -->
			<div class="pt-2 flex flex-col sm:flex-row gap-3 mt-auto">
				<c:if test="${detail.stock > 0}">
					<a href="add-to-cart?id=${detail.id}"
					   class="flex-1 bg-pink-600 hover:bg-pink-700 text-white font-bold py-3 px-6 rounded-lg text-sm text-center transition-all transform hover:-translate-y-1 shadow-lg shadow-pink-600/20 flex items-center justify-center">
						<i class="fa-solid fa-cart-plus mr-2"></i> THÊM VÀO GIỎ HÀNG
					</a>
				</c:if>
				<c:if test="${detail.stock <= 0}">
					<button disabled
							class="flex-1 bg-gray-600 text-gray-400 font-bold py-3 px-6 rounded-lg text-sm cursor-not-allowed">
						TẠM HẾT HÀNG</button>
				</c:if>
			</div>
		</div>
	</div>

	<section class="mt-8">
		<div id="recently-viewed-container" class="bg-[#252525] p-5 rounded-2xl shadow-xl border border-gray-800/50">
		</div>
	</section>
</main>

<jsp:include page="components/footer.jsp" />

<script>
	function toggleDescription() {
		const desc = document.getElementById('description-container');
		const btn = document.getElementById('btn-toggle-desc');
		if (desc.classList.contains('expanded')) {
			desc.classList.remove('expanded');
			btn.innerHTML = 'XEM THÊM <i class="fa-solid fa-chevron-down ml-1"></i>';
		} else {
			desc.classList.add('expanded');
			btn.innerHTML = 'RÚT GỌN <i class="fa-solid fa-chevron-up ml-1"></i>';
		}
	}

	document.addEventListener("DOMContentLoaded", function() {
		const currentProduct = {
			id: "${detail.id}",
			name: "${detail.name}",
			price: ${detail.price},
			image: "${detail.image}"
		};

		saveRecentlyViewed(currentProduct);
		displayRecentlyViewed();

		const descContent = document.getElementById('description-container');
		if (descContent.scrollHeight <= 120) {
			document.getElementById('btn-toggle-desc').style.display = 'none';
			descContent.querySelector('.description-gradient').style.display = 'none';
		}
	});

	function displayRecentlyViewed() {
		const container = document.getElementById("recently-viewed-container");
		if (!container) return;

		const list = JSON.parse(localStorage.getItem("recentlyViewed")) || [];
		if (list.length <= 1) {
			container.style.display = 'none'; // Ẩn luôn box nếu không có gì
			return;
		}

		let html = '<h3 class="text-white font-bold mb-4 uppercase text-sm border-b border-pink-500 pb-2 inline-flex items-center gap-2"><i class="fa-solid fa-clock-rotate-left"></i> Sản phẩm bạn đã xem</h3>';
		html += '<div class="grid grid-cols-2 md:grid-cols-5 gap-4">';

		list.forEach(item => {
			if(item.id !== "${detail.id}") {
				const formattedPrice = new Intl.NumberFormat('vi-VN').format(item.price);
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
		list = list.filter(item => item.id !== product.id);
		list.unshift(product);
		if (list.length > 6) list.pop(); <!-- giới hạn 5 sp sẽ load lại -->
		localStorage.setItem("recentlyViewed", JSON.stringify(list));
	}
</script>
</body>
</html>