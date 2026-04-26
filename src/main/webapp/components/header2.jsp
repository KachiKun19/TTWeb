<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
                    class="logo-img w-24 h-auto"/> <span
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
                    </div>
                </li>
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
                    </div>
                </li>
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
                            <div class="p-2 border-b border-gray-100">
                                <a href="profile"
                                   class="flex items-center px-4 py-2.5 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
                                    <i class="fas fa-user-circle w-6 text-center mr-2 text-gray-400"></i> Tài khoản của
                                    tôi
                                </a>
                                <a href="order-history"
                                   class="flex items-center px-4 py-2.5 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-100 hover:text-pink-600 transition-colors">
                                    <i class="fas fa-receipt w-6 text-center mr-2 text-gray-400"></i> Đơn mua
                                </a>
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
            <c:if test="${not empty sessionScope.user}">
                <div class="relative">
                    <button id="notiBtn" onclick="toggleNoti()"
                            class="text-xl relative pt-2 focus:outline-none">
                        <i class="fas fa-bell"></i>

                        <c:if test="${unreadCount > 0}">
            <span class="absolute -top-1 -right-2 bg-red-600 text-white text-xs px-1 rounded-full">
                    ${unreadCount}
            </span>
                        </c:if>
                    </button>

                    <!-- DROPDOWN -->
                    <div id="notiDropdown"
                         class="hidden absolute right-0 mt-3 w-80 bg-white rounded-xl shadow-lg z-50 text-black">

                        <div class="p-3 border-b font-bold">
                            Thông báo
                        </div>

                        <div class="max-h-60 overflow-y-auto">
                            <c:forEach var="item" items="${list}">
                                <div class="p-3 border-b hover:bg-gray-100 text-sm">

                                    <c:choose>
                                        <c:when test="${item.replyMessage != null}">
                                            <p class="font-semibold text-green-600">
                                                    ${item.replyMessage}
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-yellow-500">
                                                Đang chờ phản hồi...
                                            </p>
                                        </c:otherwise>
                                    </c:choose>

                                    <p class="text-xs text-gray-500">
                                            ${item.replyDate}
                                    </p>
                                </div>
                            </c:forEach>
                        </div>

                        <a href="notifications"
                           class="block text-center p-2 text-blue-600 hover:bg-gray-100">
                            Xem tất cả
                        </a>
                    </div>
                </div>
            </c:if>
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

                <div id="cartDropdown"
                     class="z-50 hidden bg-white divide-y divide-gray-100 rounded-xl shadow-lg w-48 overflow-hidden transform origin-top-right transition-all duration-200">
                    <div class="px-4 py-3 bg-gray-50 border-b text-gray-900 text-sm font-semibold">
                        Hoạt động mua sắm
                    </div>

                    <ul class="py-1 text-sm text-gray-700" aria-labelledby="cartDropdownButton">
                        <li>
                            <a href="cart.jsp"
                               class="block px-4 py-3 hover:bg-pink-50 hover:text-pink-600 transition flex items-center group">
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
                            <a href="order-history"
                               class="block px-4 py-3 hover:bg-blue-50 hover:text-blue-600 transition flex items-center group">
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