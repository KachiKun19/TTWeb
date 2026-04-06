<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Lịch Sử Đơn Hàng - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
          rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .st-processing {
            background-color: #fef3c7;
            color: #d97706;
        }

        .st-shipping {
            background-color: #dbeafe;
            color: #2563eb;
        }

        .st-completed {
            background-color: #d1fae5;
            color: #059669;
        }

        .st-cancelled {
            background-color: #fee2e2;
            color: #dc2626;
        }
    </style>
</head>
<body class="bg-gray-50 font-['Montserrat'] flex flex-col min-h-screen">
<jsp:include page="components/header.jsp"/>


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
                        <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png"
                             class="w-24 h-24 mx-auto opacity-20 mb-4">
                        <p class="text-gray-500 text-lg">Bạn chưa có đơn hàng nào.</p>
                        <a href="products"
                           class="mt-4 inline-block bg-pink-600 text-white px-6 py-2 rounded-full hover:bg-pink-700 transition">Mua
                            sắm ngay</a>
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
                                    <td class="py-4 px-6"><fmt:formatDate value="${o.orderDate}"
                                                                          pattern="dd/MM/yyyy"/></td>
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
                                                <span class="text-blue-600 font-semibold"><i
                                                        class="fas fa-university"></i> Chuyển khoản</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-green-600 font-semibold"><i
                                                        class="fas fa-money-bill-wave"></i> Tiền mặt (COD)</span>
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

<jsp:include page="components/footer.jsp"/>

<script src="https://cdn.tailwindcss.com"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
<script src="https://cdn.tailwindcss.com"></script>
<script src="script.js"></script>
</body>
</html>