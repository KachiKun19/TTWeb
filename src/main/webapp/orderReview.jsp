<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div id="bulkReviewContainer">
    <c:choose>
        <c:when test="${not empty orderDetails}">
            <div id="reviewMainContent">
                <input type="hidden" id="bulkOrderId" value="${order.id}">

                <c:forEach var="item" items="${orderDetails}">
                    <div class="review-item border border-gray-100 rounded-[1.5rem] p-6 mb-8 bg-white hover:shadow-md transition-shadow duration-300"
                         data-product-id="${item.product.id}">

                        <div class="flex gap-6">
                            <div class="relative w-24 h-24 flex-shrink-0">
                                <img src="images/${item.product.image}"
                                     class="w-full h-full object-contain bg-gray-50 rounded-2xl border border-gray-100">
                            </div>

                            <div class="flex-1">
                                <h4 class="font-bold text-gray-900 text-lg">${item.product.name}</h4>
                                <p class="text-sm text-gray-400 mb-4">Số lượng: <span class="font-medium text-gray-600">${item.quantity}</span></p>

                                <div class="mt-2">
                                    <input type="hidden" class="product-rating" value="5" id="rating-${item.product.id}">

                                    <p class="text-sm font-semibold text-gray-700 mb-2">Chọn số sao:</p>

                                    <div class="flex gap-2 text-4xl mb-1 star-container"
                                         id="stars-${item.product.id}"
                                         data-product-id="${item.product.id}">
                                        <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform" data-value="1">★</span>
                                        <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform" data-value="2">★</span>
                                        <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform" data-value="3">★</span>
                                        <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform" data-value="4">★</span>
                                        <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform" data-value="5">★</span>
                                    </div>

                                    <p class="text-xs text-gray-400 mb-4">
                                        Bạn đang chọn: <span id="rating-label-${item.product.id}" class="font-semibold text-pink-500">5 sao</span>
                                    </p>

                                    <textarea class="product-comment w-full border border-gray-200 rounded-2xl p-4 text-gray-700 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-pink-300 focus:border-pink-500 resize-none"
                                              placeholder="Sản phẩm này tuyệt vời như thế nào?"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <div class="mt-4 px-2">
                    <button type="button" onclick="submitBulkReviews()"
                            class="w-full bg-gray-900 hover:bg-pink-600 text-white py-4 rounded-2xl font-bold transition-all shadow-lg text-lg">
                        <i class="fa-solid fa-paper-plane mr-2"></i>Gửi tất cả nhận xét
                    </button>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="py-12 text-center animate-fade-in">
                <div class="mx-auto flex items-center justify-center h-20 w-20 rounded-full bg-pink-100 mb-6">
                    <i class="fas fa-check-double text-pink-600 text-3xl"></i>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-2">Đã hoàn tất đánh giá!</h3>
                <p class="text-sm text-gray-500 mb-8 px-8">Cảm ơn bạn đã đóng góp ý kiến. Đơn hàng này đã được ghi nhận đầy đủ đánh giá.</p>
                <button onclick="window.location.reload()"
                        class="bg-gray-900 text-white px-8 py-3 rounded-xl text-sm font-semibold hover:bg-pink-600 transition-colors">
                    Quay lại danh sách
                </button>
            </div>
        </c:otherwise>
    </c:choose>

    <div id="reviewSuccessMessage" class="hidden py-12 text-center animate-fade-in">
        <div class="mx-auto flex items-center justify-center h-20 w-20 rounded-full bg-green-100 mb-6 animate-bounce">
            <i class="fas fa-heart text-pink-500 text-3xl"></i>
        </div>
        <h3 class="text-xl font-bold text-gray-800 mb-2">Gửi đánh giá thành công!</h3>
        <p class="text-sm text-gray-500 mb-8">Kachi-Kun Shop chân thành cảm ơn những chia sẻ quý báu từ bạn.</p>
        <button onclick="window.location.reload()"
                class="bg-gray-900 text-white px-8 py-3 rounded-xl text-sm font-semibold hover:bg-pink-600 transition-colors">
            Xác nhận
        </button>
    </div>
</div>