<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 5/24/2026
  Time: 2:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="sidebar">
    <ul class="sidebar-menu">
        <li>
            <a href="adminHome" class="${activePage == 'home' ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i> Tổng quan
            </a>
        </li>
        <li>
            <a href="adminUsers" class="${activePage == 'users' ? 'active' : ''}">
                <i class="fas fa-users"></i> Quản lý người dùng
            </a>
        </li>
        <li>
            <a href="adminProducts" class="${activePage == 'products' ? 'active' : ''}">
                <i class="fas fa-box"></i> Quản lý sản phẩm
            </a>
        </li>
        <li>
            <a href="adminOrders" class="${activePage == 'orders' ? 'active' : ''}">
                <i class="fas fa-shopping-cart"></i> Quản lý đơn hàng
            </a>
        </li>
        <li>
            <a href="adminContacts" class="${activePage == 'contacts' ? 'active' : ''}">
                <i class="fas fa-envelope"></i> Quản lý liên hệ
            </a>
        </li>
        <li>
            <a href="adminDiscounts" class="${activePage == 'discounts' ? 'active' : ''}">
                <i class="fas fa-tag"></i> Mã giảm giá
            </a>
        </li>
        <li>
            <a href="adminFeaturedProducts" class="${activePage == 'featured' ? 'active' : ''}">
                <i class="fas fa-star"></i> Sản phẩm nổi bật
            </a>
        </li>
        <li>
            <a href="home">
                <i class="fas fa-store"></i> Về trang cửa hàng
            </a>
        </li>
    </ul>
</div>
