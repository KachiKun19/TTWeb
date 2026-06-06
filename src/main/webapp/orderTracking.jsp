<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Theo dõi đơn hàng #${order.id} - KachiKun Shop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-50 min-h-screen">

<div class="bg-white shadow-sm px-6 py-4 flex items-center gap-4">
    <a href="order-history" class="text-gray-500 hover:text-pink-600">
        <i class="fa-solid fa-arrow-left mr-2"></i>Lịch sử đơn hàng
    </a>
    <span class="text-gray-300">|</span>
    <span class="text-gray-700 font-semibold">Theo dõi đơn #${order.id}</span>
</div>

<%-- Thông báo success/error --%>
<c:if test="${param.success == 'cancelled'}">
    <div class="max-w-3xl mx-auto mt-4 px-6">
        <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-xl flex items-center gap-2">
            <i class="fa-solid fa-circle-check"></i>
            <span>Đơn hàng đã được hủy thành công.</span>
        </div>
    </div>
</c:if>
<c:if test="${param.error == 'cannot_cancel'}">
    <div class="max-w-3xl mx-auto mt-4 px-6">
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl flex items-center gap-2">
            <i class="fa-solid fa-circle-exclamation"></i>
            <span>Không thể hủy đơn hàng này. Đơn hàng có thể đã được giao hoặc đã hủy trước đó.</span>
        </div>
    </div>
</c:if>

<div class="max-w-3xl mx-auto p-6 space-y-6">

    <%-- ── TIMELINE TRẠNG THÁI --%>
    <div class="bg-white rounded-2xl shadow-sm p-6">
        <h2 class="text-lg font-bold text-gray-800 mb-6">Trạng thái đơn hàng</h2>

        <c:choose>
            <%-- Đơn đã hủy --%>
            <c:when test="${order.status == 'Đã hủy'}">
                <div class="flex items-center gap-4 p-4 bg-red-50 rounded-xl border border-red-200">
                    <div class="w-12 h-12 rounded-full bg-red-100 flex items-center justify-center">
                        <i class="fa-solid fa-xmark text-red-600 text-xl"></i>
                    </div>
                    <div>
                        <p class="font-bold text-red-700 text-base">Đơn hàng đã bị hủy</p>
                        <c:if test="${not empty order.cancelReason}">
                            <p class="text-sm text-red-500 mt-1">Lý do: ${order.cancelReason}</p>
                        </c:if>
                    </div>
                </div>
            </c:when>

            <%-- Đơn đang xử lý / giao hàng / đã giao --%>
            <c:otherwise>
                <c:set var="step" value="${order.timelineStep}" />
                <div class="relative">
                    <!-- Đường kẻ dọc -->
                    <div class="absolute left-5 top-6 bottom-6 w-0.5 bg-gray-200 z-0"></div>

                        <%-- Đặt hàng thành công --%>
                    <div class="relative flex items-start gap-4 mb-8 z-10">
                        <div class="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0
                        ${step >= 1 ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-400'}">
                            <i class="fa-solid fa-check text-sm"></i>
                        </div>
                        <div class="pt-1">
                            <p class="font-semibold ${step >= 1 ? 'text-gray-800' : 'text-gray-400'}">
                                Đặt hàng thành công
                            </p>
                            <c:if test="${not empty order.orderDate}">
                                <p class="text-xs text-gray-400 mt-0.5">
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                            </c:if>
                        </div>
                    </div>

                        <%-- Đang giao hàng --%>
                    <div class="relative flex items-start gap-4 mb-8 z-10">
                        <div class="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0
                        ${step >= 2 ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-400'}">
                            <i class="fa-solid fa-truck text-sm"></i>
                        </div>
                        <div class="pt-1">
                            <p class="font-semibold ${step >= 2 ? 'text-gray-800' : 'text-gray-400'}">
                                Đang giao hàng
                            </p>
                            <c:if test="${not empty order.shippedAt && step >= 2}">
                                <p class="text-xs text-gray-400 mt-0.5">
                                    <fmt:formatDate value="${order.shippedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                            </c:if>
                            <c:if test="${step == 2}">
                <span class="inline-block mt-1 text-xs bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full animate-pulse">
                  Đang trên đường giao
                </span>
                            </c:if>
                        </div>
                    </div>

                        <%-- Đã giao hàng --%>
                    <div class="relative flex items-start gap-4 mb-8 z-10">
                        <div class="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0
                        ${step >= 3 ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-400'}">
                            <i class="fa-solid fa-box text-sm"></i>
                        </div>
                        <div class="pt-1">
                            <p class="font-semibold ${step >= 3 ? 'text-gray-800' : 'text-gray-400'}">
                                Đã giao hàng
                            </p>
                            <c:if test="${not empty order.deliveredAt && step >= 3}">
                                <p class="text-xs text-gray-400 mt-0.5">
                                    <fmt:formatDate value="${order.deliveredAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                            </c:if>
                        </div>
                    </div>

                        <%-- Hoàn thành --%>
                    <div class="relative flex items-start gap-4 z-10">
                        <div class="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0
                        ${step >= 4 ? 'bg-green-600 text-white' : 'bg-gray-200 text-gray-400'}">
                            <i class="fa-solid fa-star text-sm"></i>
                        </div>
                        <div class="pt-1">
                            <p class="font-semibold ${step >= 4 ? 'text-gray-800' : 'text-gray-400'}">
                                Hoàn thành
                            </p>
                            <c:if test="${step < 4}">
                                <p class="text-xs text-gray-400 mt-0.5">Chờ xác nhận hoàn thành</p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <%-- Nút hủy đơn — chỉ hiện khi "Đang xử lý" --%>
                <c:if test="${order.status == 'Đang xử lý'}">
                    <div class="mt-6 pt-5 border-t border-gray-100">
                        <button onclick="openCancelModal('${order.id}')"
                                class="w-full sm:w-auto px-6 py-2.5 rounded-xl border-2 border-red-400 text-red-500
                           font-semibold hover:bg-red-50 transition-colors flex items-center gap-2">
                            <i class="fa-solid fa-ban"></i> Hủy đơn hàng
                        </button>
                        <p class="text-xs text-gray-400 mt-2">
                            <i class="fa-solid fa-circle-info mr-1"></i>
                            Bạn chỉ có thể hủy đơn khi đơn đang ở trạng thái "Đang xử lý".
                        </p>
                    </div>
                </c:if>

            </c:otherwise>
        </c:choose>
    </div>

    <%-- Thông tin giao hàng --%>
    <div class="bg-white rounded-2xl shadow-sm p-6">
        <h2 class="text-lg font-bold text-gray-800 mb-4">Thông tin giao hàng</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm">
            <div>
                <p class="text-gray-400">Người nhận</p>
                <p class="font-semibold text-gray-800">${order.recipientName}</p>
            </div>
            <div>
                <p class="text-gray-400">Số điện thoại</p>
                <p class="font-semibold text-gray-800">${order.recipientPhone}</p>
            </div>
            <div class="sm:col-span-2">
                <p class="text-gray-400">Địa chỉ</p>
                <p class="font-semibold text-gray-800">${order.shippingAddress}</p>
            </div>
            <div>
                <p class="text-gray-400">Phương thức thanh toán</p>
                <p class="font-semibold text-gray-800">${order.paymentMethod}</p>
            </div>
            <div>
                <p class="text-gray-400">Trạng thái đơn</p>
                <span class="inline-block px-3 py-1 rounded-full text-xs font-bold ${order.statusColor}">
                    ${order.status}
                </span>
            </div>
        </div>
    </div>

    <%-- Sản phẩm trong đơn --%>
    <div class="bg-white rounded-2xl shadow-sm p-6">
        <h2 class="text-lg font-bold text-gray-800 mb-4">Sản phẩm trong đơn</h2>
        <div class="space-y-3">
            <c:forEach var="d" items="${details}">
                <div class="flex items-center gap-4 p-3 rounded-xl bg-gray-50">
                    <img src="images/${d.product.image}" alt="${d.product.name}"
                         class="w-16 h-16 object-contain rounded-lg bg-white border border-gray-100"/>
                    <div class="flex-1">
                        <p class="font-semibold text-gray-800 text-sm">${d.product.name}</p>
                        <p class="text-xs text-gray-400 mt-0.5">x${d.quantity}</p>
                    </div>
                    <div class="text-right">
                        <p class="font-bold text-gray-800 text-sm">
                            <fmt:formatNumber value="${d.price * d.quantity}" type="number" groupingUsed="true"/>₫
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="mt-4 pt-4 border-t border-gray-100 flex justify-between items-center">
            <span class="text-gray-500">Tổng cộng</span>
            <span class="text-lg font-bold text-pink-600">
        <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/>₫
      </span>
        </div>
    </div>

</div>

<%-- ── MODAL HỦY ĐƠN --%>
<div id="cancelModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-2xl shadow-xl w-full max-w-md p-6">
        <div class="flex items-center justify-between mb-4">
            <h3 class="text-lg font-bold text-gray-800">Xác nhận hủy đơn</h3>
            <button type="button" onclick="closeCancelModal()" class="text-gray-400 hover:text-gray-600 text-xl">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        <p class="text-sm text-gray-500 mb-4">Đơn hàng sẽ bị hủy và không thể khôi phục. Hàng sẽ được hoàn lại kho.</p>
        <form method="post" action="order-tracking">
            <input type="hidden" name="orderId" id="cancelOrderId"/>
            <div class="space-y-2 mb-4">
                <label class="flex items-center gap-3 p-3 rounded-xl border border-gray-200 hover:border-pink-400 cursor-pointer transition-colors">
                    <input type="radio" name="cancelReason" value="Tôi muốn thay đổi địa chỉ giao hàng" class="accent-pink-500"/>
                    <span class="text-sm text-gray-700">Tôi muốn thay đổi địa chỉ giao hàng</span>
                </label>
                <label class="flex items-center gap-3 p-3 rounded-xl border border-gray-200 hover:border-pink-400 cursor-pointer transition-colors">
                    <input type="radio" name="cancelReason" value="Tôi muốn thay đổi sản phẩm/số lượng" class="accent-pink-500"/>
                    <span class="text-sm text-gray-700">Tôi muốn thay đổi sản phẩm/số lượng</span>
                </label>
                <label class="flex items-center gap-3 p-3 rounded-xl border border-gray-200 hover:border-pink-400 cursor-pointer transition-colors">
                    <input type="radio" name="cancelReason" value="Tôi tìm được giá rẻ hơn ở nơi khác" class="accent-pink-500"/>
                    <span class="text-sm text-gray-700">Tôi tìm được giá rẻ hơn ở nơi khác</span>
                </label>
                <label class="flex items-center gap-3 p-3 rounded-xl border border-gray-200 hover:border-pink-400 cursor-pointer transition-colors">
                    <input type="radio" name="cancelReason" value="Tôi không còn nhu cầu mua nữa" class="accent-pink-500"/>
                    <span class="text-sm text-gray-700">Tôi không còn nhu cầu mua nữa</span>
                </label>
                <label class="flex items-center gap-3 p-3 rounded-xl border border-gray-200 hover:border-pink-400 cursor-pointer transition-colors">
                    <input type="radio" name="cancelReason" value="Khác" class="accent-pink-500"
                           onchange="document.getElementById('customReasonBox').classList.remove('hidden')"/>
                    <span class="text-sm text-gray-700">Khác</span>
                </label>
            </div>
            <div id="customReasonBox" class="hidden mb-4">
        <textarea name="customReason" rows="3"
                  placeholder="Nhập lý do của bạn..."
                  class="w-full border border-gray-200 rounded-xl px-4 py-2 text-sm focus:outline-none focus:border-pink-400 resize-none"></textarea>
            </div>
            <div class="flex gap-3">
                <button type="button" onclick="closeCancelModal()"
                        class="flex-1 border border-gray-200 rounded-xl py-2 text-sm text-gray-600 hover:bg-gray-50 transition">Giữ đơn</button>
                <button type="submit"
                        class="flex-1 bg-red-500 hover:bg-red-600 text-white rounded-xl py-2 text-sm font-semibold transition">Xác nhận hủy</button>
            </div>
        </form>
    </div>
</div>

<script>
    function showCustomInput() {
        document.getElementById('customReasonBox').classList.remove('hidden');
        document.getElementById('submitBtn').disabled = false;
    }

    function hideCustomInput() {
        document.getElementById('customReasonBox').classList.add('hidden');
        document.getElementById('submitBtn').disabled = false;
    }

    // Bật nút submit khi chọn radio
    document.querySelectorAll('input[name="cancelReason"]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            document.getElementById('submitBtn').disabled = false;
        });
    });

    function validateCancel() {
        const selected = document.querySelector('input[name="cancelReason"]:checked');
        if (!selected) {
            alert('Vui lòng chọn lý do hủy đơn.');
            return false;
        }
        if (selected.value === 'Khác') {
            const custom = document.getElementById('customReason').value.trim();
            if (!custom) {
                alert('Vui lòng nhập lý do hủy đơn.');
                return false;
            }
        }
        return confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?');
    }

    // Đóng modal khi click ra ngoài
    document.getElementById('cancelModal').addEventListener('click', function(e) {
        if (e.target === this) closeCancelModal();
    });
</script>

<script src="script.js"></script>
</body>
</html>
