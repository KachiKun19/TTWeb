<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>Giỏ hàng - Kachi-Kun Shop</title>
		<link rel="icon" type="image/png" href="images/LogoRemake.png"/>
		<link rel="stylesheet" href="style.css"/>
		<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet"/>
		<link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet"/>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
		<style>
			.qty-input::-webkit-outer-spin-button,
			.qty-input::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0; }
			.cart-checkbox {
				width: 18px; height: 18px;
				accent-color: #e11d48;
				cursor: pointer;
				flex-shrink: 0;
			}
		</style>
</head>
<body class="bg-gray-50 min-h-screen">
<jsp:include page="components/header2.jsp"/>
<%-- hủy đơn --%>
<div id="cancelModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
	<div class="bg-white rounded-2xl shadow-xl w-full max-w-md p-6">
		<h3 class="text-lg font-bold text-gray-800 mb-1">Xác nhận hủy đơn</h3>
		<p class="text-sm text-gray-500 mb-4">Đơn hàng sẽ bị hủy và không thể khôi phục. Hàng sẽ được hoàn lại kho.</p>
		<form method="get" action="order-history" id="cancelForm">
			<input type="hidden" name="action" value="cancel"/>
			<input type="hidden" name="id" id="cancelOrderId"/>
			<input type="hidden" name="status" value="${statusFilter}"/>
			<input type="hidden" name="page"   value="${currentPage}"/>
			<div class="mb-4">
				<label class="text-sm text-gray-600 mb-1 block">Lý do hủy (không bắt buộc)</label>
				<textarea name="cancel_reason" rows="3"
						  class="w-full border border-gray-200 rounded-xl px-3 py-2 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-pink-300"
						  placeholder="VD: Đặt nhầm sản phẩm, muốn đổi địa chỉ..."></textarea>
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

<%-- đánh giá--%>
<div id="reviewModal" class="hidden fixed inset-0 bg-black/60 backdrop-blur-sm z-[9999] flex items-center justify-center p-4 transition-all duration-300">
	<div class="bg-white rounded-[2rem] w-full max-w-2xl shadow-2xl overflow-hidden transform transition-all scale-95 border border-gray-100">
		<div class="px-8 py-6 border-b flex justify-between items-center bg-gradient-to-r from-gray-50 to-white">
			<div>
				<h3 class="text-2xl font-extrabold text-gray-800 tracking-tight">
					Đánh giá đơn hàng <span class="text-pink-600">#<span id="modalOrderId"></span></span>
				</h3>
				<p class="text-sm text-gray-500 mt-1">Chia sẻ trải nghiệm của bạn để giúp chúng tôi tốt hơn</p>
			</div>
			<button onclick="closeReviewModal()"
					class="w-10 h-10 rounded-full flex items-center justify-center text-gray-400 hover:bg-gray-100 hover:text-gray-600 transition-all text-2xl">
				<i class="fa-solid fa-xmark"></i>
			</button>
		</div>
		<div id="reviewContent" class="p-8 max-h-[70vh] overflow-y-auto bg-white"></div>
	</div>
</div>

<%--main content --%>
<div class="max-w-4xl mx-auto p-6">

	<div class="flex items-center justify-between mb-6">
		<div>
			<h1 class="text-2xl font-bold text-gray-800">Lịch sử đơn hàng</h1>
			<p class="text-sm text-gray-400 mt-1">Quản lý và theo dõi các đơn hàng của bạn</p>
		</div>
		<a href="home" class="text-pink-600 hover:text-pink-700 text-sm font-medium">
			<i class="fa-solid fa-store mr-1"></i>Tiếp tục mua sắm
		</a>
	</div>

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

	<%--
		 dùng c:url + c:param để encode tiếng Việt đúng cách.
	--%>
	<c:url var="urlAll"       value="order-history"><c:param name="page" value="1"/><c:param name="status" value="ALL"/></c:url>
	<c:url var="urlPending"   value="order-history"><c:param name="page" value="1"/><c:param name="status" value="Đang xử lý"/></c:url>
	<c:url var="urlShipping"  value="order-history"><c:param name="page" value="1"/><c:param name="status" value="Đang giao hàng"/></c:url>
	<c:url var="urlDelivered" value="order-history"><c:param name="page" value="1"/><c:param name="status" value="Đã giao"/></c:url>
	<c:url var="urlCompleted" value="order-history"><c:param name="page" value="1"/><c:param name="status" value="Hoàn thành"/></c:url>
	<c:url var="urlCancelled" value="order-history"><c:param name="page" value="1"/><c:param name="status" value="Đã hủy"/></c:url>

	<div class="flex gap-2 mb-5 overflow-x-auto pb-1">

		<a href="${urlAll}" class="flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all
			${'ALL' eq statusFilter ? 'bg-pink-600 text-white shadow' : 'bg-white text-gray-600 border border-gray-200 hover:border-pink-300 hover:text-pink-600'}">
			Tất cả <span class="ml-1 text-xs opacity-70">(${statusCount['ALL']})</span>
		</a>

		<a href="${urlPending}" class="flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all
			${'Đang xử lý' eq statusFilter ? 'bg-yellow-500 text-white shadow' : 'bg-white text-gray-600 border border-gray-200 hover:border-yellow-300 hover:text-yellow-600'}">
			Đang xử lý
			<c:if test="${statusCount['Đang xử lý'] != null}">
				<span class="ml-1 text-xs opacity-70">(${statusCount['Đang xử lý']})</span>
			</c:if>
		</a>

		<a href="${urlShipping}" class="flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all
			${'Đang giao hàng' eq statusFilter ? 'bg-blue-500 text-white shadow' : 'bg-white text-gray-600 border border-gray-200 hover:border-blue-300 hover:text-blue-600'}">
			Đang giao
			<c:if test="${statusCount['Đang giao hàng'] != null}">
				<span class="ml-1 text-xs opacity-70">(${statusCount['Đang giao hàng']})</span>
			</c:if>
		</a>

		<a href="${urlDelivered}" class="flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all
			${'Đã giao' eq statusFilter ? 'bg-green-500 text-white shadow' : 'bg-white text-gray-600 border border-gray-200 hover:border-green-300 hover:text-green-600'}">
			Đã giao
			<c:if test="${statusCount['Đã giao'] != null}">
				<span class="ml-1 text-xs opacity-70">(${statusCount['Đã giao']})</span>
			</c:if>
		</a>

		<a href="${urlCompleted}" class="flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all
			${'Hoàn thành' eq statusFilter ? 'bg-emerald-600 text-white shadow' : 'bg-white text-gray-600 border border-gray-200 hover:border-emerald-300 hover:text-emerald-600'}">
			Hoàn thành
			<c:if test="${statusCount['Hoàn thành'] != null}">
				<span class="ml-1 text-xs opacity-70">(${statusCount['Hoàn thành']})</span>
			</c:if>
		</a>

		<a href="${urlCancelled}" class="flex-shrink-0 px-4 py-2 rounded-full text-sm font-semibold transition-all
			${'Đã hủy' eq statusFilter ? 'bg-red-500 text-white shadow' : 'bg-white text-gray-600 border border-gray-200 hover:border-red-300 hover:text-red-600'}">
			Đã hủy
			<c:if test="${statusCount['Đã hủy'] != null}">
				<span class="ml-1 text-xs opacity-70">(${statusCount['Đã hủy']})</span>
			</c:if>
		</a>
	</div>

	<%-- danh sách--%>
	<c:choose>
		<c:when test="${empty myOrders}">
			<div class="bg-white rounded-2xl shadow-sm p-16 text-center">
				<i class="fa-regular fa-folder-open text-5xl text-gray-300 mb-4"></i>
				<p class="text-gray-500">
					<c:choose>
						<c:when test="${'ALL' eq statusFilter}">Bạn chưa có đơn hàng nào.</c:when>
						<c:otherwise>Không có đơn hàng nào ở trạng thái này.</c:otherwise>
					</c:choose>
				</p>
				<a href="home" class="inline-block mt-4 bg-pink-600 text-white px-6 py-2 rounded-xl text-sm font-semibold hover:bg-pink-700 transition">Mua ngay</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="space-y-4">
				<c:forEach var="o" items="${myOrders}">
					<div class="bg-white rounded-2xl shadow-sm overflow-hidden">

						<div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
							<div class="flex items-center gap-3">
								<span class="font-bold text-gray-700">#${o.id}</span>
								<c:if test="${not empty o.orderDate}">
									<span class="text-xs text-gray-400"><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/></span>
								</c:if>
							</div>
							<span class="px-3 py-1 rounded-full text-xs font-bold ${o.statusColor}">${o.status}</span>
						</div>

						<div class="px-5 py-3 bg-gray-50 text-xs text-gray-500 flex flex-wrap gap-4">
							<span><i class="fa-solid fa-user mr-1"></i>${o.recipientName}</span>
							<span><i class="fa-solid fa-phone mr-1"></i>${o.recipientPhone}</span>
							<span><i class="fa-solid fa-location-dot mr-1"></i>${o.shippingAddress}</span>
						</div>

						<c:if test="${o.status != 'Đã hủy'}">
							<div class="px-5 py-3">
								<div class="flex items-center gap-1">
									<c:set var="s" value="${o.timelineStep}"/>
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center text-xs ${s >= 1 ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-check text-xs"></i>
										</div>
										<span class="text-xs ${s >= 1 ? 'text-gray-700' : 'text-gray-400'}">Đặt hàng</span>
									</div>
									<div class="flex-1 h-0.5 ${s >= 2 ? 'bg-blue-400' : 'bg-gray-200'} mx-1"></div>
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center ${s >= 2 ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-truck text-xs"></i>
										</div>
										<span class="text-xs ${s >= 2 ? 'text-gray-700' : 'text-gray-400'}">Đang giao</span>
									</div>
									<div class="flex-1 h-0.5 ${s >= 3 ? 'bg-green-400' : 'bg-gray-200'} mx-1"></div>
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center ${s >= 3 ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-box text-xs"></i>
										</div>
										<span class="text-xs ${s >= 3 ? 'text-gray-700' : 'text-gray-400'}">Đã giao</span>
									</div>
									<div class="flex-1 h-0.5 ${s >= 4 ? 'bg-green-600' : 'bg-gray-200'} mx-1"></div>
									<div class="flex items-center gap-1">
										<div class="w-6 h-6 rounded-full flex items-center justify-center ${s >= 4 ? 'bg-green-600 text-white' : 'bg-gray-200 text-gray-400'}">
											<i class="fa-solid fa-star text-xs"></i>
										</div>
										<span class="px-3 py-1 rounded-full text-xs font-bold ${o.status == 'Hoàn thành' ? 'bg-yellow-100 text-yellow-600' : o.statusColor}">
												${o.status}
										</span>
									</div>
								</div>
							</div>
						</c:if>

						<c:if test="${o.status == 'Đã hủy' && not empty o.cancelReason}">
							<div class="px-5 py-3 bg-red-50">
								<p class="text-xs text-red-500"><i class="fa-solid fa-circle-info mr-1"></i>Lý do hủy: ${o.cancelReason}</p>
							</div>
						</c:if>

						<div class="flex items-center justify-between px-5 py-4 border-t border-gray-100">
							<div>
								<span class="text-xs text-gray-400">Tổng tiền</span>
								<p class="font-bold text-pink-600 text-base">
									<fmt:formatNumber value="${o.totalPrice}" type="number" groupingUsed="true"/>₫
								</p>
							</div>
							<div class="flex gap-2">
								<c:if test="${o.status != 'Đã hủy'}">
									<a href="order-tracking?id=${o.id}"
									   class="px-4 py-2 rounded-xl text-sm bg-blue-50 text-blue-600 hover:bg-blue-100 transition font-medium">
										<i class="fa-solid fa-location-dot mr-1"></i>Theo dõi
									</a>
								</c:if>
								<c:if test="${o.status == 'Đã giao'}">
									<button onclick="openReviewModal('${o.id}', '${pageContext.request.contextPath}')"
											class="px-4 py-2 rounded-xl text-sm bg-purple-600 text-white hover:bg-purple-700 transition font-medium">
										<i class="fa-solid fa-star mr-1"></i>Đánh giá
									</button>
								</c:if>
								<c:if test="${o.cancellable}">
									<button onclick="openCancelModal('${o.id}')"
											class="px-4 py-2 rounded-xl text-sm bg-red-50 text-red-600 hover:bg-red-100 transition font-medium">
										<i class="fa-solid fa-ban mr-1"></i>Hủy đơn
									</button>
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<%-- Phân trang --%>
			<c:if test="${totalPages > 1}">
				<div class="flex items-center justify-center gap-2 mt-8">

					<c:choose>
						<c:when test="${currentPage > 1}">
							<c:url var="prevUrl" value="order-history"><c:param name="status" value="${statusFilter}"/><c:param name="page" value="${currentPage - 1}"/></c:url>
							<a href="${prevUrl}" class="w-9 h-9 flex items-center justify-center rounded-full border border-gray-200 bg-white text-gray-600 hover:border-pink-400 hover:text-pink-600 transition">
								<i class="fa-solid fa-chevron-left text-xs"></i>
							</a>
						</c:when>
						<c:otherwise>
							<span class="w-9 h-9 flex items-center justify-center rounded-full border border-gray-100 bg-gray-50 text-gray-300 cursor-not-allowed">
								<i class="fa-solid fa-chevron-left text-xs"></i>
							</span>
						</c:otherwise>
					</c:choose>

					<c:forEach begin="1" end="${totalPages}" var="p">
						<c:choose>
							<c:when test="${p == currentPage}">
								<span class="w-9 h-9 flex items-center justify-center rounded-full bg-pink-600 text-white text-sm font-bold shadow">${p}</span>
							</c:when>
							<c:otherwise>
								<c:url var="pageUrl" value="order-history"><c:param name="status" value="${statusFilter}"/><c:param name="page" value="${p}"/></c:url>
								<a href="${pageUrl}" class="w-9 h-9 flex items-center justify-center rounded-full border border-gray-200 bg-white text-gray-600 text-sm hover:border-pink-400 hover:text-pink-600 transition">${p}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${currentPage < totalPages}">
							<c:url var="nextUrl" value="order-history"><c:param name="status" value="${statusFilter}"/><c:param name="page" value="${currentPage + 1}"/></c:url>
							<a href="${nextUrl}" class="w-9 h-9 flex items-center justify-center rounded-full border border-gray-200 bg-white text-gray-600 hover:border-pink-400 hover:text-pink-600 transition">
								<i class="fa-solid fa-chevron-right text-xs"></i>
							</a>
						</c:when>
						<c:otherwise>
							<span class="w-9 h-9 flex items-center justify-center rounded-full border border-gray-100 bg-gray-50 text-gray-300 cursor-not-allowed">
								<i class="fa-solid fa-chevron-right text-xs"></i>
							</span>
						</c:otherwise>
					</c:choose>
				</div>
				<p class="text-center text-xs text-gray-400 mt-2">
					Trang ${currentPage} / ${totalPages} &nbsp;•&nbsp; ${totalOrders} đơn hàng
				</p>
			</c:if>

		</c:otherwise>
	</c:choose>
</div>
<jsp:include page="components/footer.jsp"/>

<script src="${pageContext.request.contextPath}/script.js"></script>
</body>
</html>
