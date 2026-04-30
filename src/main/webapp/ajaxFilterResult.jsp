<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<input type="hidden" id="ajax-total-res" value="${total}"/>

<c:choose>
    <c:when test="${empty products}">
        <div class="col-span-3 text-center py-12 text-gray-500">
            <i class="fas fa-search text-4xl mb-4 opacity-30"></i>
            <p>Không tìm thấy sản phẩm nào phù hợp.</p>
        </div>
    </c:when>
    <c:otherwise>
        <c:forEach var="p" items="${products}">
            <div class="product-card border rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-shadow duration-300 group product-item bg-white">

                <div class="relative block">
                    <a href="product-detail?id=${p.id}">
                        <img src="images/${p.image}" class="w-full h-56 object-contain p-4" alt="${p.name}"/>
                    </a>
                    <div class="absolute inset-x-4 bottom-4 flex gap-2
            opacity-0 group-hover:opacity-100 transition-opacity duration-300">

                            <%-- Thêm vào giỏ--%>
                        <a href="add-to-cart?id=${p.id}&redirect=stay"
                           class="flex-1 bg-white border border-blue-600 text-blue-600 font-semibold
              py-2 rounded-lg text-center text-sm hover:bg-blue-50 transition-colors">
                            <i class="fas fa-cart-plus mr-1"></i> Thêm vào giỏ
                        </a>

                            <%-- Mua ngay  --%>
                        <c:choose>
                            <c:when test="${p.stock > 0}">
                                <a href="add-to-cart?id=${p.id}"
                                   class="flex-1 bg-blue-600 text-white font-semibold
                      py-2 rounded-lg text-center text-sm hover:bg-blue-700 transition-colors">
                                    <i class="fas fa-bolt mr-1"></i> Mua ngay
                                </a>
                            </c:when>
                            <c:otherwise>
            <span class="flex-1 bg-gray-300 text-gray-500 font-semibold
                         py-2 rounded-lg text-center text-sm cursor-not-allowed">
                Hết hàng
            </span>
                            </c:otherwise>
                        </c:choose>

                    </div>
                        <%-- Badge hết hàng --%>
                    <c:if test="${p.stock <= 0}">
                        <div class="absolute top-2 left-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded">
                            Hết hàng
                        </div>
                    </c:if>
                        <%-- Badge bán chạy--%>
                    <c:if test="${p.soldCount >= 10}">
                        <div class="absolute top-2 right-2 bg-orange-500 text-white text-xs font-bold px-2 py-1 rounded flex items-center gap-1">
                            <i class="fas fa-fire"></i> Bán chạy
                        </div>
                    </c:if>
                </div>

                    <%-- Thông tin sản phẩm --%>
                <div class="p-4">
                    <h3 class="font-semibold text-base h-12 overflow-hidden line-clamp-2 text-gray-800">
                        <a href="product-detail?id=${p.id}" class="hover:text-blue-600">${p.name}</a>
                    </h3>

                        <%--Rating--%>
                    <div class="flex items-center gap-2 mt-2 mb-1">
                        <div class="flex">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= p.averageRating}">
                                        <i class="fas fa-star text-yellow-400 text-xs"></i>
                                    </c:when>
                                    <c:when test="${i - 0.5 <= p.averageRating}">
                                        <i class="fas fa-star-half-alt text-yellow-400 text-xs"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="far fa-star text-gray-300 text-xs"></i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <c:choose>
                            <c:when test="${p.reviewCount > 0}">
                                <span class="text-xs text-gray-500">
                                    <fmt:formatNumber value="${p.averageRating}" maxFractionDigits="1"/>
                                    (${p.reviewCount})
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-xs text-gray-400">Chưa có đánh giá</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                        <%-- Giá + Đã bán --%>
                    <div class="flex items-center justify-between mt-2">
                        <p class="text-lg font-bold text-gray-800">
                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                        </p>
                        <c:if test="${p.soldCount > 0}">
                            <span class="text-xs text-gray-400">
                                <i class="fas fa-shopping-bag mr-1 text-pink-400"></i>${p.soldCount} đã bán
                            </span>
                        </c:if>
                    </div>
                </div>

            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>

<%-- Phân trang --%>
<c:if test="${endPage > 1}">
    <div class="col-span-1 sm:col-span-2 lg:col-span-3 flex justify-center mt-8 space-x-2 py-4">
        <c:forEach begin="1" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${i == index}">
                    <button onclick="filterProducts(${i})"
                            class="px-4 py-2 border rounded-lg transition-colors duration-300 bg-pink-600 text-white font-bold">
                            ${i}
                    </button>
                </c:when>
                <c:otherwise>
                    <button onclick="filterProducts(${i})"
                            class="px-4 py-2 border rounded-lg transition-colors duration-300 bg-white text-gray-700 hover:bg-pink-500 hover:text-white">
                            ${i}
                    </button>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</c:if>
