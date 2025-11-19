<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Phong Cách Xanh Clone</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body>

	<!--topbar-->
	<div
		class="bg-black text-white text-base py-4 flex justify-center space-x-4">
		<span> Giao hàng nhanh 0-3 ngày</span> <span>•</span> <span>
			Trả góp 0% </span> <span>•</span> <span> Hỗ trợ 24/7 </span> <span>•</span>
		<span> Miễn phí ship </span> <span>•</span> <span> Tư vấn miễn
			phí </span> <span>•</span> <span> Bảo hành gọn, xử lý nhanh </span> <span>•</span>
	</div>

	<!--menu Bar-->
	<header class="bg-white text-black shadow sticky top-0 z-50">
		<div
			class="max-w-7xl mx-auto flex justify-between items-center py-6 px-4">
			<div class="flex items-center space-x-2">
				<img src="logo.png" alt="logo" class="h-8"> <span
					class="font-semibold">Asuka</span>
			</div>
			<nav class="hidden md:flex space-x-6 font-medium">
				<a href="#" class="hover:text-gray-600">Gaming Gear</a> <a href="#"
					class="hover:text-gray-600">Office Gear</a> <a href="#"
					class="hover:text-gray-600">Góc game thủ</a> <a href="#"
					class="hover:text-gray-600">Sản phẩm 2N</a> <a href="#"
					class="hover:text-gray-600">Tích điểm</a> <a href="#"
					class="hover:text-gray-600">Liên hệ</a>
			</nav>
			<div class="flex items-center space-x-4">
				<svg xmlns="http://www.w3.org/2000/svg" fill="none"
					viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
					class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round"
						d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
                </svg>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none"
					viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
					class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round"
						d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
                </svg>
				<svg xmlns="http://www.w3.org/2000/svg" fill="none"
					viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
					class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round"
						d="M15.75 10.5V6a3.75 3.75 0 1 0-7.5 0v4.5m11.356-1.993 1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 0 1-1.12-1.243l1.264-12A1.125 1.125 0 0 1 5.513 7.5h12.974c.576 0 1.059.435 1.119 1.007ZM8.625 10.5a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm7.5 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
                </svg>
			</div>
		</div>
	</header>

	<section
		class="relative h-[500px] flex items-center justify-center text-center bg-cover bg-center"
		style="background-image: url('banner.jpg');">

		<!-- Lớp phủ tối -->
		<div class="absolute inset-0 bg-black bg-opacity-50"></div>

		<!-- Nội dung chữ -->
		<div class="relative z-10 text-white">
			<p class="mb-2 text-sm">Phiên bản mới nhất hợp tác giữa Pulsar và
				PRX / T1</p>
			<h1 class="text-4xl font-bold mb-4">Pulsar X2 Crazylight PRX /
				T1 Edition</h1>
			<button
				class="bg-white text-black px-6 py-2 rounded-full font-semibold hover:bg-gray-200">
				Xem thêm</button>
		</div>

	</section>

	<!-- Danh mục sản phẩm -->
	<section
		class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8 grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6 text-center font-sans">
		<!-- Chuột gaming -->
		<a href="products?category=0"
			class="flex flex-col items-center space-y-3 p-4 bg-white rounded-lg shadow-md hover:shadow-lg hover:scale-105 transition-all duration-300 ease-in-out">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="-5 -10 110 135"
				class="w-16 h-16 text-gray-700">
                <path
					d="m51.199 65.133h-1.5625c-22.133 0-25.176-4.6289-25.582-6.0469l-0.058594-0.42969v-6.4648c0-14.141 11.504-25.641 25.641-25.641h1.5625v13.91h-3.125v-10.734c-11.691 0.80469-20.953 10.574-20.953 22.465v6.0078c0.67969 0.71094 4.4688 3.625 20.953 3.8008v-7.4766h3.125z" />
                <path
					d="m49.637 65.133h-1.5625v-10.609h3.125v7.4766c16.488-0.17578 20.277-3.0898 20.957-3.8008v-6.0078c0-11.891-9.2656-21.66-20.957-22.465v10.734h-3.125v-13.91h1.5625c14.141 0 25.645 11.504 25.645 25.641l-0.058594 6.8945c-0.40625 1.418-3.4492 6.0469-25.582 6.0469z" />
                <path
					d="m49.641 96.293c-14.148 0-25.652-11.504-25.652-25.641v-11.996h3.125v11.996c0 12.418 10.102 22.516 22.516 22.516 12.426 0 22.527-10.102 22.527-22.516v-11.996h3.125v11.996c0 14.141-11.504 25.641-25.641 25.641z" />
                <path
					d="m49.633 56.09c-3.0898 0-5.6055-2.5156-5.6055-5.6055v-5.9766c0-3.0898 2.5156-5.6055 5.6055-5.6055 3.0898 0 5.6055 2.5156 5.6055 5.6055v5.9766c0 3.0898-2.5156 5.6055-5.6055 5.6055zm0-14.062c-1.3672 0-2.4805 1.1133-2.4805 2.4805v5.9766c0 1.3672 1.1133 2.4805 2.4805 2.4805 1.3672 0 2.4805-1.1133 2.4805-2.4805v-5.9766c0-1.3672-1.1133-2.4805-2.4805-2.4805z" />
                <path
					d="m48.152 28.602c-0.074219-0.22656-1.7891-5.582 1.1992-9.2617 2.0625-2.5391 5.6953-3.543 10.82-2.9688 6.2773 0.69922 10.707-0.30859 12.164-2.75 1.0781-1.8047 0.53125-4.5273-1.4961-7.4648l2.5742-1.7773c2.7539 3.9883 3.3398 7.9414 1.6055 10.844-1.5156 2.543-5.3789 5.3477-15.191 4.2539-3.9922-0.44141-6.6914 0.16797-8.043 1.8242-1.918 2.3438-0.67578 6.2891-0.66406 6.3281z" />
            </svg> <span class="text-base font-semibold text-gray-800">Chuột
				gaming</span>
		</a>

		<!-- Bàn phím cơ -->
		<a href="products?category=2"
			class="flex flex-col items-center space-y-3 p-4 bg-white rounded-lg shadow-md hover:shadow-lg hover:scale-105 transition-all duration-300 ease-in-out">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 60"
				class="w-16 h-16 text-gray-700">
                <g data-name="Layer 4">
                    <path
					d="M41.68457,38.2207H6.31543a4.95452,4.95452,0,0,1-4.94922-4.94922v-18.543A4.95452,4.95452,0,0,1,6.31543,9.7793H41.68457a4.95452,4.95452,0,0,1,4.94922,4.94922v18.543A4.95452,4.95452,0,0,1,41.68457,38.2207ZM6.31543,11.7793a2.95285,2.95285,0,0,0-2.94922,2.94922v18.543A2.95285,2.95285,0,0,0,6.31543,36.2207H41.68457a2.95285,2.95285,0,0,0,2.94922-2.94922v-18.543a2.95285,2.95285,0,0,0-2.94922-2.94922Z" />
                    <path
					d="M33.28613,30.2124H13.63672a1,1,0,0,1,0-2H33.28613a1,1,0,0,1,0,2Z" />
                    <path
					d="M10.0166,30.2124H8.12012a1,1,0,0,1,0-2H10.0166a1,1,0,0,1,0,2Z" />
                    <path
					d="M10.0166,18.92188H8.12012a1,1,0,0,1,0-2H10.0166a1,1,0,0,1,0,2Z" />
                    <path
					d="M16.13574,18.92188H14.23926a1,1,0,0,1,0-2h1.89648a1,1,0,0,1,0,2Z" />
                    <path
					d="M22.25488,18.92188H20.3584a1,1,0,0,1,0-2h1.89648a1,1,0,0,1,0,2Z" />
                    <path
					d="M28.374,18.92188H26.47754a1,1,0,0,1,0-2H28.374a1,1,0,0,1,0,2Z" />
                    <path
					d="M18.8291,25H16.93262a1,1,0,0,1,0-2H18.8291a1,1,0,0,1,0,2Z" />
                    <path
					d="M24.94824,25H23.05176a1,1,0,0,1,0-2h1.89648a1,1,0,0,1,0,2Z" />
                    <path
					d="M31.06738,25H29.1709a1,1,0,0,1,0-2h1.89648a1,1,0,0,1,0,2Z" />
                    <path
					d="M34.49316,18.92188H32.59668a1,1,0,0,1,0-2h1.89648a1,1,0,0,1,0,2Z" />
                    <path
					d="M39.31934,30.2124H37.42285a1,1,0,0,1,0-2h1.89649a1,1,0,0,1,0,2Z" />
                    <path
					d="M39.31934,25H33.88965a1,1,0,0,1,0-2h4.42969V16.80176a1,1,0,0,1,2,0V24A.99974.99974,0,0,1,39.31934,25Z" />
                    <path
					d="M13.11914,25h-4.999a1,1,0,0,1,0-2h4.999a1,1,0,1,1,0,2Z" />
                </g>
            </svg> <span class="text-base font-semibold text-gray-800">Bàn
				phím cơ</span>
		</a>

		<!-- Lót chuột -->
		<a href="products?category=3"
			class="flex flex-col items-center space-y-3 p-4 bg-white rounded-lg shadow-md hover:shadow-lg hover:scale-105 transition-all duration-300 ease-in-out">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="-5 -10 110 135"
				class="w-16 h-16 text-gray-700">
                <path
					d="m92.52 18.312h-85.039c-1.918 0-3.4805 1.5625-3.4805 3.4805v56.406c0 1.9219 1.5625 3.4805 3.4805 3.4805h85.035c1.918 0 3.4805-1.5625 3.4805-3.4805l0.003906-56.402c0-1.9219-1.5625-3.4805-3.4805-3.4805zm1.4805 59.891c0 0.81641-0.66406 1.4805-1.4805 1.4805h-85.039c-0.81641 0-1.4805-0.66406-1.4805-1.4805v-56.406c0-0.81641 0.66406-1.4805 1.4805-1.4805h85.035c0.81641 0 1.4805 0.66406 1.4805 1.4805v56.406z" />
                <path
					d="m66.918 28.73c-7.5586 0-13.711 6.1484-13.711 13.711v16.629c0.75 18.184 26.672 18.188 27.422 0v-16.629c0-7.5625-6.1523-13.711-13.711-13.711zm0 9.2812c1.1445 0 2.0703 0.92969 2.0703 2.0703v5.1992c-0.070312 2.7305-4.0703 2.7344-4.1445 0v-5.1992c0-1.1445 0.92969-2.0703 2.0703-2.0703zm11.711 21.059c-0.64453 15.535-22.781 15.531-23.422 0v-16.629c0-6.1211 4.7227-11.148 10.711-11.66v5.3711c-1.7617 0.44922-3.0703 2.0352-3.0703 3.9336v5.1992c0.17188 5.3789 7.9727 5.3828 8.1445 0v-5.1992c0-1.8984-1.3125-3.4844-3.0703-3.9336v-5.3711c5.9883 0.51172 10.711 5.5391 10.711 11.66v16.629z" />
                <path
					d="m13.504 22.953h-3.668c-0.55078 0-1 0.44531-1 1v3.668c0.023437 1.3125 1.9766 1.3164 2 0v-2.668h2.668c1.3125-0.023437 1.3125-1.9766 0-2z" />
                <path
					d="m13.504 75.047h-2.668v-2.668c-0.019532-1.3125-1.9766-1.3164-2 0 0.074218 5.5312-0.85547 4.5938 4.668 4.668 1.3125-0.023437 1.3164-1.9766 0-2z" />
                <path
					d="m90.164 72.27c-0.55078 0-1 0.44531-1 1v2.668h-2.668c-1.3125 0.019531-1.3164 1.9766 0 2h3.668c0.55078 0 1-0.44531 1-1v-3.668c0-0.55469-0.44922-1-1-1z" />
                <path
					d="m90.164 23.844h-3.668c-1.3125 0.023438-1.3164 1.9766 0 2h2.668v2.668c0.023438 1.3125 1.9766 1.3164 2 0v-3.668c0-0.55469-0.44922-1-1-1z" />
            </svg> <span class="text-base font-semibold text-gray-800">Lót
				chuột</span>
		</a>

		<!-- Ghế công thái học -->
		<a href="products?category=4"
			class="flex flex-col items-center space-y-3 p-4 bg-white rounded-lg shadow-md hover:shadow-lg hover:scale-105 transition-all duration-300 ease-in-out">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="-5 -10 110 135"
				class="w-16 h-16 text-gray-700">
                <path
					d="m98.438 83.594h-32.031v-3.9844c0.039062-1.3672-0.81641-2.6016-2.1094-3.0469l-14.297-5v-5.1562h18.281c0.97266-0.011719 1.8867-0.47656 2.4688-1.2578s0.76953-1.7891 0.5-2.7266l3.125-2.0312c0.89062-0.58594 1.4219-1.5898 1.4062-2.6562v-3.8281h1.5625c0.82812 0 1.625-0.32812 2.2109-0.91406 0.58594-0.58594 0.91406-1.3828 0.91406-2.2109v-1.5625c0-0.82812-0.32812-1.625-0.91406-2.2109-0.58594-0.58594-1.3828-0.91406-2.2109-0.91406h-6.25c-1.7266 0-3.125 1.3984-3.125 3.125v1.5625c0 0.82812 0.32812 1.625 0.91406 2.2109 0.58594 0.58594 1.3828 0.91406 2.2109 0.91406h1.5625v3.8281l-2.8906 1.9531-1.25-2.0312c-0.86328-1.3672-2.3672-2.1953-3.9844-2.1875h-14.531v-4.6875h9.5312c2.418 0.011719 4.4453-1.8164 4.6875-4.2188l2.6562-28.125c0.13281-1.3203-0.30078-2.6406-1.1953-3.6211-0.89453-0.98438-2.1641-1.543-3.4922-1.5352h-27.5c-1.3281-0.007812-2.5977 0.55078-3.4922 1.5352-0.89453 0.98047-1.3281 2.3008-1.1953 3.6211l2.6562 28.125c0.24219 2.4023 2.2695 4.2305 4.6875 4.2188h9.5312v4.6875h-14.531c-1.6172-0.007812-3.1211 0.82031-3.9844 2.1875l-1.25 2.0312-2.8906-1.9531v-3.8281h1.5625c0.82812 0 1.625-0.32812 2.2109-0.91406 0.58594-0.58594 0.91406-1.3828 0.91406-2.2109v-1.5625c0-0.82812-0.32812-1.625-0.91406-2.2109-0.58594-0.58594-1.3828-0.91406-2.2109-0.91406h-6.25c-1.7266 0-3.125 1.3984-3.125 3.125v1.5625c0 0.82812 0.32812 1.625 0.91406 2.2109 0.58594 0.58594 1.3828 0.91406 2.2109 0.91406h1.5625v3.8281c0.011719 1.0391 0.53906 2.0078 1.4062 2.5781l3.125 2.0312c-0.29688 0.94531-0.12891 1.9805 0.45703 2.7812 0.58594 0.80078 1.5195 1.2773 2.5117 1.2812h18.281v5.1562l-14.297 5.0781c-1.2656 0.43359-2.1133 1.6289-2.1094 2.9688v3.9844h-28.906c-0.86328 0-1.5625 0.69922-1.5625 1.5625s0.69922 1.5625 1.5625 1.5625h96.875c0.86328 0 1.5625-0.69922 1.5625-1.5625s-0.69922-1.5625-1.5625-1.5625zm-27.344-34.375h6.25v1.5625h-6.25zm-35.312-2.9688-2.6562-28.125c-0.042969-0.44141 0.10156-0.87891 0.39844-1.207 0.29687-0.32812 0.72266-0.51562 1.1641-0.51172h27.5c0.44141-0.003906 0.86719 0.18359 1.1641 0.51172 0.29688 0.32812 0.44141 0.76562 0.39844 1.207l-2.6562 28.125c-0.082031 0.80078-0.75781 1.4102-1.5625 1.4062h-22.188c-0.80469 0.003906-1.4805-0.60547-1.5625-1.4062zm-16.25 2.9688h6.25v1.5625h-6.25zm9.0625 14.062 2.4219-3.9844c0.29297-0.44531 0.79297-0.71094 1.3281-0.70312h32.188c0.53516-0.007812 1.0352 0.25781 1.3281 0.70312l2.4219 3.9844zm5 20.312v-3.9844l13.281-4.6875v8.6719zm16.406-8.75 13.281 4.6875v3.9844h-13.281z" />
            </svg> <span class="text-base font-semibold text-gray-800">Ghế
				công thái học</span>
		</a>

		<!-- Khu vực khác -->
		<a href="products?category=5"
			class="flex flex-col items-center space-y-3 p-4 bg-white rounded-lg shadow-md hover:shadow-lg hover:scale-105 transition-all duration-300 ease-in-out">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 125"
				class="w-16 h-16 text-gray-700">
                <path
					d="M81.82,18.18a45,45,0,1,0,0,63.64A45,45,0,0,0,81.82,18.18ZM78,78a39.6,39.6,0,1,1,0-56A39.7,39.7,0,0,1,78,78Z" />
                <path
					d="M30.22,44.36A5.64,5.64,0,1,0,35.86,50,5.64,5.64,0,0,0,30.22,44.36Z" />
                <circle cx="50" cy="50" r="5.64" />
                <path
					d="M69.78,44.36A5.64,5.64,0,1,0,75.43,50,5.64,5.64,0,0,0,69.78,44.36Z" />
            </svg> <span class="text-base font-semibold text-gray-800">Khác</span>
		</a>
	</section>

	<!-- Brands Section -->
	<section class="max-w-7xl mx-auto py-12 px-4">
		<h2 class="text-2xl font-bold mb-4 text-center">Phân phối chính
			hãng</h2>
		<div
			class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6">
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/filco-ban-phim-co-va-phu-kien-ban-phim"
					class="font-bold text-purple-500">FILCO</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/finalmouse" class="font-bold">finalmouse</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/artisan-jp" class="font-bold">∧rtisan</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a
					href="/collections/pulsar-chuot-khong-day-lot-chuot-va-feet-thuy-tinh-superglide"
					class="font-bold">pulsar</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/lamzu" class="font-bold">LAMZU</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/scyrox" class="font-bold italic">Scyrox</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/hitscan" class="font-bold">x HITSCAN</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/teevolution" class="font-bold">Teevolution</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/wlmouse" class="font-bold">WLmouse</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/melgeek" class="font-bold">MelGeek</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/yuki-aim" class="font-bold">Yuki Aim</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/dysphoria" class="font-bold">DSA</a>
				<!-- Adjust if needed -->
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/lethal-gaming-gear" class="font-bold">Lethal
					Gaming Gear</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/feet-chuot-grip-tape-corepad-germany"
					class="font-bold">Corepad</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/esptiger" class="font-bold">ESPTIGER</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="#" class="font-bold text-red-500">Red Logo</a>
				<!-- Placeholder for unknown -->
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/tj-exclusive" class="font-bold">TJ</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/gamesense" class="font-bold">GameSense</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/pwnage" class="font-bold">pwnage</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/arbiter" class="font-bold">Arbiter</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="/collections/can-mau-datacolor-spyder" class="font-bold">datacolor</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="#" class="font-bold text-orange-500">V funkeer</a>
			</div>
			<div
				class="bg-gray-100 p-4 flex items-center justify-center rounded-lg h-24">
				<a href="#" class="font-bold">太</a>
			</div>
		</div>
	</section>
	<!-- Featured Products Section -->
	<section class="max-w-7xl mx-auto py-12 px-4">
		<h2 class="text-2xl font-bold mb-8 text-center">Sản phẩm nổi bật</h2>
		<div
			class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
			<c:forEach var="product" items="${featuredProducts}">
				<div
					class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
					<div class="relative">
						<img src="${product.imageUrl}" alt="${product.name}"
							class="w-full h-48 object-cover">
						<c:if test="${product.stock <= 0}">
							<div
								class="absolute top-2 left-2 bg-gray-500 text-white text-xs font-bold px-2 py-1 rounded">
								Hết hàng</div>
						</c:if>
					</div>
					<div class="p-4">
						<h3 class="text-lg font-semibold text-gray-800 mb-2">${product.name}</h3>
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
										class="bg-blue-600 text-white px-3 py-1 rounded-md text-sm hover:bg-blue-700 transition-colors">
										Thêm</button>
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
	</section>

</body>

</html>