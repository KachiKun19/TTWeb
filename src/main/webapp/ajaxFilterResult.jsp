<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<input type="hidden" id="ajax-total-res" value="${total}"/>

<c:choose>
    <c:when test="${empty products}">
        <div class="col-span-3 text-center py-12 text-gray-400">
            <i class="fas fa-search text-4xl mb-3 block"></i>
            Không tìm thấy sản phẩm nào phù hợp.
        </div>
    </c:when>
    <c:otherwise>
        <c:forEach var="p" items="${products}">

            <div class="product-card border rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-shadow duration-300 group product-item relative">

                    <%-- Hết hàng: badge đỏ góc trên trái --%>
                <c:if test="${p.stock <= 0}">
                    <div class="absolute top-2 left-2 z-10 bg-red-500 text-white text-xs font-bold px-2 py-0.5 rounded">
                        Hết hàng
                    </div>
                </c:if>
                    <%-- Còn ít (1-5 cái): cam cảnh báo --%>
                <c:if test="${p.stock > 0 && p.stock <= 5}">
                    <div class="absolute top-2 left-2 z-10 bg-orange-400 text-white text-xs font-bold px-2 py-0.5 rounded">
                        Còn ${p.stock} cái
                    </div>
                </c:if>

                <div class="relative block">
                    <a href="product-detail?id=${p.id}">
                        <img src="images/${p.image}"
                             class="w-full h-56 object-contain p-4 ${p.stock <= 0 ? 'opacity-50 grayscale' : ''}"
                             alt="${p.name}"/>
                    </a>

                        <%-- chỉ hiện khi còn hàng --%>
                    <c:if test="${p.stock > 0}">
                        <div class="absolute inset-x-4 bottom-4">
                            <a href="add-to-cart?id=${p.id}"
                               class="block w-full bg-blue-600 text-white font-semibold py-2 rounded-lg text-center
                                      opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                                + Chọn nhanh
                            </a>
                        </div>
                    </c:if>
                </div>

                <div class="p-4">
                    <h3 class="font-semibold text-base h-16 overflow-hidden line-clamp-2">
                        <a href="product-detail?id=${p.id}" class="hover:text-blue-600">${p.name}</a>
                    </h3>

                    <div class="flex items-center justify-between mt-2">
                        <p class="text-lg font-bold text-gray-800">
                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                        </p>
                        <c:choose>
                            <c:when test="${p.stock <= 0}">
                                <span class="text-xs text-red-500 font-medium">Hết hàng</span>
                            </c:when>
                            <c:when test="${p.stock <= 5}">
                                <span class="text-xs text-orange-500 font-medium">Còn ít</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-xs text-green-600 font-medium">Còn hàng</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>

<c:if test="${endPage > 1}">
    <div class="col-span-1 sm:col-span-2 lg:col-span-3 flex justify-center mt-8 space-x-2 py-4">
        <c:forEach begin="1" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${i == index}">
                    <button onclick="filterProducts(${i})"
                            class="px-4 py-2 border rounded-lg transition-colors duration-300
                                   bg-pink-600 text-white font-bold">
                            ${i}
                    </button>
                </c:when>
                <c:otherwise>
                    <button onclick="filterProducts(${i})"
                            class="px-4 py-2 border rounded-lg transition-colors duration-300
                                   bg-white text-gray-700 hover:bg-pink-500 hover:text-white">
                            ${i}
                    </button>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</c:if>
