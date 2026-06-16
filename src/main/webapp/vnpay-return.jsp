<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Kết quả thanh toán - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen items-center justify-center p-4">
<jsp:include page="components/header2.jsp"/>

<main class="flex-grow flex items-center justify-center w-full py-12">
    <c:choose>
        <c:when test="${paymentSuccess}">
            <div class="w-full max-w-sm bg-white rounded-3xl shadow-2xl overflow-hidden">
                <div class="bg-gradient-to-br from-blue-500 to-indigo-700 px-6 pt-10 pb-16 text-center text-white">
                    <div class="mx-auto w-20 h-20 rounded-full bg-white bg-opacity-20 flex items-center justify-center mb-4">
                        <i class="fas fa-check-circle text-white text-4xl"></i>
                    </div>
                    <h3 class="text-2xl font-extrabold">Thanh toán thành công!</h3>
                    <p class="text-blue-100 text-sm mt-1">VNPay đã xác nhận giao dịch của bạn</p>
                </div>

                <div class="-mt-8 mx-4 bg-white rounded-2xl shadow-lg p-5 space-y-3">
                    <div class="flex justify-between text-sm py-2 border-b border-dashed border-gray-100">
                        <span class="text-gray-500">Mã đơn hàng</span>
                        <span class="font-bold text-gray-900">#${orderId}</span>
                    </div>
                    <div class="flex justify-between text-sm py-2 border-b border-dashed border-gray-100">
                        <span class="text-gray-500">Số tiền</span>
                        <span class="font-bold text-red-600 text-base">
                            <fmt:formatNumber value="${amount}" type="number" groupingUsed="true"/>₫
                        </span>
                    </div>
                    <div class="flex justify-between text-sm py-2">
                        <span class="text-gray-500">Phương thức</span>
                        <span class="font-bold text-blue-600">VNPay</span>
                    </div>
                </div>

                <div class="px-4 pb-6 pt-4 space-y-2">
                    <a href="orderHistory" class="block w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-xl font-bold text-center transition text-sm shadow">
                        <i class="fas fa-list-alt mr-2"></i>Xem đơn hàng của tôi
                    </a>
                    <a href="home" class="block w-full text-center text-gray-500 hover:text-gray-800 py-2 text-sm font-medium underline underline-offset-2 transition">
                        Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="w-full max-w-sm bg-white rounded-3xl shadow-2xl overflow-hidden">
                <div class="bg-gradient-to-br from-red-500 to-rose-700 px-6 pt-10 pb-16 text-center text-white">
                    <div class="mx-auto w-20 h-20 rounded-full bg-white bg-opacity-20 flex items-center justify-center mb-4">
                        <i class="fas fa-times-circle text-white text-4xl"></i>
                    </div>
                    <h3 class="text-2xl font-extrabold">Thanh toán thất bại</h3>
                    <p class="text-red-100 text-sm mt-1">Giao dịch không thành công (mã: ${responseCode})</p>
                </div>

                <div class="-mt-8 mx-4 bg-white rounded-2xl shadow-lg p-5">
                    <p class="text-sm text-gray-600 text-center leading-relaxed">
                        Đơn hàng <span class="font-bold">#${orderId}</span> của bạn vẫn được giữ với trạng thái
                        <span class="text-orange-600 font-semibold">Chờ thanh toán</span>.
                        Bạn có thể thử thanh toán lại hoặc hủy đơn trong mục lịch sử đơn hàng.
                    </p>
                </div>

                <div class="px-4 pb-6 pt-4 space-y-2">
                    <a href="orderHistory" class="block w-full bg-red-600 hover:bg-red-700 text-white py-3 rounded-xl font-bold text-center transition text-sm shadow">
                        <i class="fas fa-list-alt mr-2"></i>Xem đơn hàng của tôi
                    </a>
                    <a href="cart" class="block w-full text-center text-gray-500 hover:text-gray-800 py-2 text-sm font-medium underline underline-offset-2 transition">
                        Quay lại giỏ hàng
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="components/footer.jsp"/>
</body>
</html>
