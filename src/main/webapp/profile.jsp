<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Tài khoản của tôi - Kachi-Kun Shop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="style.css"/>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

<%@ include file="components/header2.jsp" %>

<main class="flex-1 container mx-auto px-4 py-10 max-w-4xl">

    <h1 class="text-2xl font-bold text-gray-800 mb-8 flex items-center gap-3">
        <i class="fas fa-user-circle text-pink-500"></i> Tài khoản của tôi
    </h1>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

        <!-- Sidebar avatar / info tóm tắt -->
        <div class="md:col-span-1">
            <div class="bg-white rounded-2xl shadow-sm p-6 text-center">
                <div class="w-24 h-24 rounded-full bg-pink-100 flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-user text-pink-500 text-4xl"></i>
                </div>
                <p class="text-lg font-bold text-gray-800">${sessionScope.user.fullName}</p>
                <p class="text-sm text-gray-400 mt-1">@${sessionScope.user.username}</p>
                <span class="inline-block mt-3 px-3 py-1 rounded-full text-xs font-semibold
                    ${sessionScope.user.role == 1 ? 'bg-yellow-100 text-yellow-700' : 'bg-pink-100 text-pink-600'}">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 1}">Admin</c:when>
                        <c:otherwise>Khách hàng</c:otherwise>
                    </c:choose>
                </span>

                <div class="mt-6 text-left space-y-2 text-sm text-gray-500">
                    <div class="flex items-center gap-2">
                        <i class="fas fa-envelope text-pink-400 w-4"></i>
                        <span class="truncate">${sessionScope.user.email}</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <i class="fas fa-id-badge text-pink-400 w-4"></i>
                        <span>ID: #${sessionScope.user.id}</span>
                    </div>
                </div>

                <div class="mt-6 space-y-2">
                    <a href="order-history"
                       class="block w-full py-2 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-pink-50 hover:text-pink-600 transition">
                        <i class="fas fa-receipt mr-2"></i>Đơn mua của tôi
                    </a>
                    <a href="logout"
                       class="block w-full py-2 rounded-xl bg-red-50 text-red-500 text-sm font-medium hover:bg-red-100 transition">
                        <i class="fas fa-sign-out-alt mr-2"></i>Đăng xuất
                    </a>
                </div>
            </div>
        </div>

        <!-- Phần chính: form cập nhật -->
        <div class="md:col-span-2 space-y-6">

            <!-- Cập nhật thông tin -->
            <div class="bg-white rounded-2xl shadow-sm p-6">
                <h2 class="text-base font-bold text-gray-700 mb-5 flex items-center gap-2">
                    <i class="fas fa-pen text-pink-500 text-sm"></i> Thông tin cá nhân
                </h2>

                <c:if test="${not empty infoError}">
                    <div class="mb-4 px-4 py-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-sm flex items-center gap-2">
                        <i class="fas fa-exclamation-circle"></i> ${infoError}
                    </div>
                </c:if>
                <c:if test="${not empty infoSuccess}">
                    <div class="mb-4 px-4 py-3 bg-green-50 border border-green-200 text-green-600 rounded-xl text-sm flex items-center gap-2">
                        <i class="fas fa-check-circle"></i> ${infoSuccess}
                    </div>
                </c:if>

                <form action="profile" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="updateInfo"/>

                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Tên đăng nhập</label>
                        <input type="text" value="${sessionScope.user.username}" disabled
                               class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-gray-50 text-gray-400 text-sm cursor-not-allowed"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Họ và tên <span
                                class="text-red-400">*</span></label>
                        <input type="text" name="fullName" value="${sessionScope.user.fullName}" required
                               class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Email <span
                                class="text-red-400">*</span></label>
                        <input type="email" name="email" value="${sessionScope.user.email}" required
                               class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                    </div>

                    <div class="pt-2">
                        <button type="submit"
                                class="px-6 py-2.5 bg-pink-500 hover:bg-pink-600 text-white text-sm font-semibold rounded-xl transition">
                            <i class="fas fa-save mr-2"></i>Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</main>

<%@ include file="components/footer.jsp" %>

<script src="script.js"></script>
</body>
</html>