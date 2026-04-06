<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:forEach var="item" items="${orderDetails}">
  <div class="border border-gray-100 rounded-[1.5rem] p-6 mb-8 bg-white hover:shadow-md transition-shadow duration-300">
    <div class="flex gap-6">
      <div class="relative w-24 h-24 flex-shrink-0">
        <img src="images/${item.product.image}"
             class="w-full h-full object-contain bg-gray-50 rounded-2xl border border-gray-100">
      </div>

      <div class="flex-1">
        <h4 class="font-bold text-gray-900 text-lg">${item.product.name}</h4>
        <p class="text-sm text-gray-400 mb-4">Số lượng: <span class="font-medium text-gray-600">${item.quantity}</span></p>

        <form action="review" method="post" class="mt-2">
          <input type="hidden" name="productId" value="${item.product.id}">
          <input type="hidden" name="orderId"   value="${order.id}">
          <input type="hidden" name="rating"    value="5" id="rating-${item.product.id}">

          <p class="text-sm font-semibold text-gray-700 mb-2">Chọn số sao:</p>

          <div class="flex gap-2 text-4xl mb-1 star-container"
               id="stars-${item.product.id}"
               data-product-id="${item.product.id}">

    <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform"
          data-value="1">★</span>
            <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform"
                  data-value="2">★</span>
            <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform"
                  data-value="3">★</span>
            <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform"
                  data-value="4">★</span>
            <span class="star-btn text-yellow-400 cursor-pointer select-none hover:scale-125 transition-transform"
                  data-value="5">★</span>
          </div>

          <p class="text-xs text-gray-400 mb-4">
            Bạn đang chọn: <span id="rating-label-${item.product.id}" class="font-semibold text-pink-500">5 sao</span>
          </p>

          <textarea name="comment" rows="3"
                    class="w-full border border-gray-200 rounded-2xl p-4 text-gray-700 placeholder-gray-400
                           focus:outline-none focus:ring-2 focus:ring-pink-300 focus:border-pink-500 resize-none"
                    placeholder="Sản phẩm này tuyệt vời như thế nào?"></textarea>

          <button type="submit"
                  class="mt-4 w-full sm:w-auto bg-gray-900 hover:bg-pink-600 text-white px-10 py-3
                         rounded-xl font-bold transition-all shadow-lg">
            Gửi nhận xét ngay
          </button>
        </form>
      </div>
    </div>
  </div>
</c:forEach>
