<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<title>Lịch sử đơn hàng - KachiKun Shop</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-50 min-h-screen">

<!-- Modal hủy đơn -->
<div id="cancelModal"
	 class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
	<div class="bg-white rounded-2xl shadow-xl w-full max-w-md p-6">
		<h3 class="text-lg font-bold text-gray-800 mb-1">Xác nhận hủy đơn</h3>
		<p class="text-sm text-gray-500 mb-4">
			Đơn hàng sẽ bị hủy và không thể khôi phục. Hàng sẽ được hoàn lại kho.
		</p>
		<form method="get" action="order-history" id="cancelForm">
			<input type="hidden" name="action" value="cancel"/>
			<input type="hidden" name="id" id="cancelOrderId"/>
			<div class="mb-4">
				<label class="text-sm text-gray-600 mb-1 block">Lý do hủy (không bắt buộc)</label>
				<textarea name="cancel_reason" rows="3"
						  class="w-full border border-gray-200 rounded-xl px-3 py-2 text-sm text-gray-800
                           focus:outline-none focus:ring-2 focus:ring-pink-300"
						  placeholder="VD: Đặt nhầm sản phẩm, muốn đổi địa chỉ..."></textarea>
			</div>
			<div class="flex gap-3">
				<button type="button" onclick="closeCancelModal()"
						class="flex-1 border border-gray-200 rounded-xl py-2 text-sm text-gray-600
                           hover:bg-gray-50 transition">
					Giữ đơn
				</button>
				<button type="submit"
						class="flex-1 bg-red-500 hover:bg-red-600 text-white rounded-xl py-2 text-sm
                           font-semibold transition">
					Xác nhận hủy
				</button>
			</div>
		</form>
	</div>
</div>

<div class="max-w-4xl mx-auto p-6">

	<!-- Header -->
	<div class="flex items-center justify-between mb-6">
		<div>
			<h1 class="text-2xl font-bold text-gray-800">Lịch sử đơn hàng</h1>
			<p class="text-sm text-gray-400 mt-1">Quản lý và theo dõi các đơn hàng của bạn</p>
		</div>
		<a href="home" class="text-pink-600 hover:text-pink-700 text-sm font-medium">
			<i class="fa-solid fa-store mr-1"></i>Tiếp tục mua sắm
		</a>
	</div>

	<!-- Thông báo -->
	<c:if test="${not empty msg}">
		<div class="mb-4 p-4 bg-green-50 border border-green-200 rounded-xl flex items-center gap-3">
			<i class="fa-solid fa-circle-check text-green-500"></i>
			<span class="text-green-700 text-sm">${msg}</span>
		</div>
	</c:if>
	<c:if test="${not empty error}">
		<div class="mb-4 p-4 bg-red-50 border border-red-200 rounded-xl flex items-center gap-3">
			<i class="fa-solid fa-circle-xmark text-red-500"></i>
			<span class="text-red-700 text-sm">${error}</span>
		</div>
	</c:if>

	<!-- Danh sách đơn hàng -->
	<c:choose>
		<c:when test="${empty myOrders}">
			<div class="bg-white rounded-2xl shadow-sm p-16 text-center">
				<i class="fa-regular fa-folder-open text-5xl text-gray-300 mb-4"></i>
				<p class="text-gray-500">Bạn chưa có đơn hàng nào.</p>
				<a href="home"
				   class="inline-block mt-4 bg-pink-600 text-white px-6 py-2 rounded-xl text-sm
                          font-semibold hover:bg-pink-700 transition">
					Mua ngay
				</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="space-y-4">
				<c:forEach var="o" items="${myOrders}">
					<div class="bg-white rounded-2xl shadow-sm overflow-hidden">

						<!-- Header đơn -->
						<div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
							<div class="flex items-center gap-3">
								<span class="font-bold text-gray-700">#${o.id}</span>
								<c:if test="${not empty o.orderDate}">
                                    <span class="text-xs text-gray-400">
                                        <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/>
                                    </span>
								</c:if>
							</div>
							<span class="px-3 py-1 rounded-full text-xs font-bold ${o.statusColor}">
									${o.status}
							</span>
						</div>

						<!-- Thông tin giao hàng nhanh -->
						<div class="px-5 py-3 bg-gray-50 text-xs text-gray-500 flex flex-wrap gap-4">
							<span><i class="fa-solid fa-user mr-1"></i>${o.recipientName}</span>
							<span><i class="fa-solid fa-phone mr-1"></i>${o.recipientPhone}</span>
							<span><i class="fa-solid fa-location-dot mr-1"></i>${o.shippingAddress}</span>
						</div>

						<!-- Timeline mini -->
						<c:if test="${o.status != 'Đã hủy'}">
							<div class="px-5 py-3">
								<div class="flex items-center gap-1">
									<c:set var="s" value="${o.timelineStep}"/>

									<!-- Bước 1 -->
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center text-xs
                                            ${s >= 1 ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-check text-xs"></i>
										</div>
										<span class="text-xs ${s >= 1 ? 'text-gray-700' : 'text-gray-400'}">Đặt hàng</span>
									</div>
									<div class="flex-1 h-0.5 ${s >= 2 ? 'bg-blue-400' : 'bg-gray-200'} mx-1"></div>

									<!-- Bước 2 -->
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center
                                            ${s >= 2 ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-truck text-xs"></i>
										</div>
										<span class="text-xs ${s >= 2 ? 'text-gray-700' : 'text-gray-400'}">Đang giao</span>
									</div>
									<div class="flex-1 h-0.5 ${s >= 3 ? 'bg-green-400' : 'bg-gray-200'} mx-1"></div>

									<!-- Bước 3 -->
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center
                                            ${s >= 3 ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-box text-xs"></i>
										</div>
										<span class="text-xs ${s >= 3 ? 'text-gray-700' : 'text-gray-400'}">Đã giao</span>
									</div>
									<div class="flex-1 h-0.5 ${s >= 4 ? 'bg-green-600' : 'bg-gray-200'} mx-1"></div>

									<!-- Bước 4 -->
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center
                                            ${s >= 4 ? 'bg-green-600 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-star text-xs"></i>
										</div>
										<span class="text-xs ${s >= 4 ? 'text-gray-700' : 'text-gray-400'}">Hoàn thành</span>
									</div>
								</div>
							</div>
						</c:if>

						<!-- Lý do hủy nếu có -->
						<c:if test="${o.status == 'Đã hủy' && not empty o.cancelReason}">
							<div class="px-5 py-3 bg-red-50">
								<p class="text-xs text-red-500">
									<i class="fa-solid fa-circle-info mr-1"></i>
									Lý do hủy: ${o.cancelReason}
								</p>
							</div>
						</c:if>

						<!-- Footer: tổng tiền + actions -->
						<div class="flex items-center justify-between px-5 py-4 border-t border-gray-100">
							<div>
								<span class="text-xs text-gray-400">Tổng tiền</span>
								<p class="font-bold text-pink-600 text-base">
									<fmt:formatNumber value="${o.totalPrice}" type="number" groupingUsed="true"/>₫
								</p>
							</div>
							<div class="flex gap-2">
								<!-- Nút theo dõi -->
								<c:if test="${o.status != 'Đã hủy'}">
									<a href="order-tracking?id=${o.id}"
									   class="px-4 py-2 rounded-xl text-sm bg-blue-50 text-blue-600
                                              hover:bg-blue-100 transition font-medium">
										<i class="fa-solid fa-location-dot mr-1"></i>Theo dõi
									</a>
								</c:if>

								<!-- Nút hủy — chỉ khi Đang xử lý -->
								<c:if test="${o.cancellable}">
									<button onclick="openCancelModal(${o.id})"
											class="px-4 py-2 rounded-xl text-sm bg-red-50 text-red-600
                                               hover:bg-red-100 transition font-medium">
										<i class="fa-solid fa-ban mr-1"></i>Hủy đơn
									</button>
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script>
	function openCancelModal(orderId) {
		document.getElementById('cancelOrderId').value = orderId;
		document.getElementById('cancelModal').classList.remove('hidden');
	}
	function closeCancelModal() {
		document.getElementById('cancelModal').classList.add('hidden');
	}
	// Đóng modal khi click vào nền
	document.getElementById('cancelModal').addEventListener('click', function(e) {
		if (e.target === this) closeCancelModal();
	});
</script>
</body>
</html>
