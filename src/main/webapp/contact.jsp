<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Liên Hệ - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png" />
    <link rel="stylesheet" href="style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <script src="https://cdn.tailwindcss.com"></script>

    <style>

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in-up {
            animation: fadeInUp 0.8s ease-out forwards;
        }


        .glass-panel {
            background: rgba(17, 24, 39, 0.85);
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body class="bg-gray-100 font-['Montserrat'] flex flex-col min-h-screen">

<div class="top-bar">
    <ul class="bar-list">
        <li><a href="#">Tư vấn chuẩn, chọn đúng gear</a></li>
        <li><a href="#">Bảo hành gọn, xử lí nhanh</a></li>
        <li><a href="#">Giao nhanh 0-3 ngày</a></li>
        <li><a href="#">Miễn phí ship từ 1 triệu</a></li>
        <li><a href="#">Trả góp 0%</a></li>
    </ul>
</div>

<header class="main-header sticky top-0 z-50 shadow-md" style="background-color: #1a1a1a;">
    <div class="container">
        <div class="logo">
            <a href="home" class="flex items-center">
                <img src="images/LogoChuan.png" alt="Kachi-Kun Shop Logo" class="logo-img w-24 h-auto" />
                <span class="text-white text-xl font-bold ml-0 whitespace-nowrap"> Kachi-Kun Shop </span>
            </a>
        </div>

        <nav class="nav">
            <ul class="nav-list">
                <li>
                    <a href="#" class="flex items-center" data-dropdown-toggle="dropdownGaming">
                        Gaming Gear <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </a>
                    <div id="dropdownGaming" class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
                        <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                            <li><a href="products?category=Chuột Gaming" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Chuột Gaming</a></li>
                            <li><a href="products?category=Bàn phím cơ" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Bàn phím cơ</a></li>
                            <li><a href="products?category=Lót chuột" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Lót chuột</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a href="#" class="flex items-center" data-dropdown-toggle="dropdownOffice">
                        Office Gear <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </a>
                    <div id="dropdownOffice" class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
                        <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                            <li><a href="products?category=Ghế công thái học" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Ghế công thái học</a></li>
                            <li><a href="products?category=Tai nghe" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Tai nghe</a></li>
                            <li><a href="products?category=Phụ kiện" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Phụ kiện</a></li>
                        </ul>
                    </div>
                </li>
                <li><a href="contact" class="text-pink-500 font-bold">Liên Hệ</a></li>
            </ul>
        </nav>

        <div class="flex items-center space-x-8 text-white">
            <a href="#" id="open-search" class="text-xl transition-opacity duration-200 hover:opacity-80">
                <i class="fas fa-search"></i>
            </a>
            <div class="relative inline-block text-left">
                <button type="button" id="user-menu-btn" class="text-xl transition-colors duration-200 hover:text-pink-500 focus:outline-none py-2">
                    <i class="fas fa-user"></i>
                </button>
                <div id="user-dropdown" class="hidden absolute right-0 z-50 mt-3 w-64 bg-white rounded-xl shadow-[0_10px_40px_-10px_rgba(0,0,0,0.2)] border border-gray-100 overflow-hidden transform origin-top-right">
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
                                <a href="login#signup" class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
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
        <div id="search-results" class="mt-4 max-h-[60vh] overflow-y-auto bg-white rounded-lg shadow-xl p-2 hidden">
        </div>
    </div>
</div>

<div class="flex-grow flex items-center justify-center py-16 px-4 relative overflow-hidden">

    <div class="absolute top-0 left-0 w-full h-full opacity-10 pointer-events-none z-0">
        <img src="https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=2070&auto=format&fit=crop" class="w-full h-full object-cover">
    </div>

    <div class="max-w-6xl w-full bg-white rounded-2xl shadow-2xl overflow-hidden flex flex-col md:flex-row z-10 animate-fade-in-up">

        <div class="md:w-5/12 relative text-white p-10 flex flex-col justify-between"
             style="background-image: url('https://images.unsplash.com/photo-1593305841991-05c29736cec7?q=80&w=1000&auto=format&fit=crop'); background-size: cover; background-position: center;">

            <div class="absolute inset-0 bg-gradient-to-br from-slate-900/90 to-blue-900/80 z-0"></div>

            <div class="relative z-10">
                <h2 class="text-4xl font-extrabold mb-2 tracking-wide text-transparent bg-clip-text bg-gradient-to-r from-pink-400 to-blue-400">
                    Get in Touch
                </h2>
                <p class="text-gray-300 mb-8 font-medium">Bạn có thắc mắc về sản phẩm? Team Kachi-Kun luôn sẵn sàng hỗ trợ 24/7.</p>

                <div class="space-y-6">
                    <div class="flex items-start group">
                        <div class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-pink-500 transition duration-300 shrink-0">
                            <i class="fas fa-map-marker-alt text-xl"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-lg">Địa chỉ Store</h4>
                            <p class="text-sm text-gray-300">Khu phố 6, Linh Trung, Thủ Đức<br>TP. Hồ Chí Minh</p>
                        </div>
                    </div>

                    <div class="flex items-start group">
                        <div class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-blue-500 transition duration-300 shrink-0">
                            <i class="fas fa-phone-alt text-xl"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-lg">Hotline</h4>
                            <p class="text-sm text-gray-300">+84 862 210 723<br>Hỗ trợ kỹ thuật: Phím 1</p>
                        </div>
                    </div>

                    <div class="flex items-start group">
                        <div class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-purple-500 transition duration-300 shrink-0">
                            <i class="fas fa-envelope text-xl"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-lg">Email</h4>
                            <p class="text-sm text-gray-300">support@kachikun.com<br>jobs@kachikun.com</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="relative z-10 mt-10 rounded-xl overflow-hidden shadow-lg border-2 border-white/20 h-40">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.231171196204!2d106.8008654146215!3d10.86991836043217!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527587e9ad5bf%3A0xafa66f9c8be3c91!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBDw7RuZyBuZ2jhu4cgVGjDtG5nIHRpbiAtIMSQSFFHIFRQLkhDTQ!5e0!3m2!1svi!2s!4v1646732338875!5m2!1svi!2s" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </div>

        <div class="md:w-7/12 p-10 md:p-14 bg-white">

            <div class="mb-8">
                <h3 class="text-2xl font-bold text-gray-800">Gửi tin nhắn cho chúng tôi</h3>
                <p class="text-gray-500 text-sm mt-1">Vui lòng điền thông tin bên dưới, chúng tôi sẽ phản hồi trong vòng 24h.</p>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="bg-green-50 border-l-4 border-green-500 text-green-700 p-4 rounded mb-6 flex items-center animate-pulse">
                    <i class="fas fa-check-circle mr-3 text-xl"></i>
                    <span class="font-medium">${successMessage}</span>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded mb-6 flex items-center">
                    <i class="fas fa-exclamation-triangle mr-3 text-xl"></i>
                    <span class="font-medium">${errorMessage}</span>
                </div>
            </c:if>

            <form action="contact" method="post" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-user"></i>
                            </span>
                        <input type="text" name="fullname" required placeholder="Họ và tên"
                               class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white"
                               value="${sessionScope.user.fullName}">
                    </div>
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-envelope"></i>
                            </span>
                        <input type="email" name="email" required placeholder="Địa chỉ Email"
                               class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white"
                               value="${sessionScope.user.email}">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-phone"></i>
                            </span>
                        <input type="tel" name="phone" placeholder="Số điện thoại"
                               class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white">
                    </div>
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-tag"></i>
                            </span>
                        <input type="text" name="subject" required placeholder="Chủ đề cần hỗ trợ"
                               class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white">
                    </div>
                </div>

                <div class="relative group">
                        <span class="absolute top-3 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                            <i class="fas fa-pen"></i>
                        </span>
                    <textarea name="message" rows="4" required placeholder="Nội dung tin nhắn..."
                              class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white"></textarea>
                </div>

                <button type="submit"
                        class="w-full bg-gradient-to-r from-pink-600 to-purple-600 hover:from-pink-700 hover:to-purple-700 text-white font-bold py-4 rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition duration-300 flex justify-center items-center text-lg uppercase tracking-wide">
                    <span>Gửi Tin Nhắn</span>
                    <i class="fas fa-paper-plane ml-3"></i>
                </button>
            </form>
        </div>
    </div>
</div>

<footer class="footer mt-auto">
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
<script src="script.js"></script>
</body>
</html>