<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 25/3/2026
  Time: 2:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:choose>
    <c:when test="${empty searchResults}">
        <p class="text-center text-gray-500 py-4">Không tìm thấy sản phẩm nào!</p>
    </c:when>
    <c:otherwise>
        <c:forEach var="p" items="${searchResults}">
            <a href="add-to-cart?id=${p.id}"
               class="flex items-center gap-4 p-3 hover:bg-gray-100 rounded-lg transition border-b border-gray-100">

                <img src="images/${p.image}" alt="${p.name}"
                     class="w-16 h-16 object-cover rounded"/>

                <div>
                    <h4 class="text-sm font-semibold text-gray-800">${p.name}</h4>
                    <p class="text-red-600 font-bold text-sm">
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                    </p>
                </div>

            </a>
        </c:forEach>
    </c:otherwise>
</c:choose>