<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 25/3/2026
  Time: 1:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<input type="hidden" id="ajax-total-res" value="${total}"/>

<c:choose>
    <c:when test="${empty products}">
        <div class="col-span-3 text-center py-12">
            Không tìm thấy sản phẩm nào phù hợp.
        </div>
    </c:when>
    <c:otherwise>
        <c:forEach var="p" items="${products}">
            <div class="product-card border rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-shadow duration-300 group product-item">

                <div class="relative block">
                    <a href="product-detail?id=${p.id}">
                        <img src="images/${p.image}" class="w-full h-56 object-contain p-4" alt="${p.name}"/>
                    </a>
                    <div class="absolute inset-x-4 bottom-4">
                        <a href="add-to-cart?id=${p.id}"
                           class="block w-full bg-blue-600 text-white font-semibold py-2 rounded-lg text-center
                                  opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                            + Chọn nhanh
                        </a>
                    </div>
                </div>

                <div class="p-4">
                    <h3 class="font-semibold text-base h-16 overflow-hidden line-clamp-2">
                        <a href="product-detail?id=${p.id}" class="hover:text-blue-600">${p.name}</a>
                    </h3>
                    <p class="text-lg font-bold text-gray-800 mt-2">
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </p>
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

