<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="sidebar">

    <div class="sidebar-brand">
        <div class="sidebar-brand-icon">
            <i class="fas fa-store"></i>
        </div>
        <div>
            <div class="sidebar-brand-text">Kachi-Kun</div>
            <div class="sidebar-brand-sub">Admin Dashboard</div>
        </div>
    </div>

    <div class="sidebar-section-label">Tổng quan</div>
    <ul class="sidebar-menu">
        <li>
            <a href="adminHome" class="${activePage == 'home' ? 'active' : ''}">
                <i class="fas fa-chart-pie"></i>
                <span>Tổng quan</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-section-label">Quản lý</div>
    <ul class="sidebar-menu">
        <li>
            <a href="adminUsers" class="${activePage == 'users' ? 'active' : ''}">
                <i class="fas fa-users"></i>
                <span>Người dùng</span>
            </a>
        </li>
        <li>
            <a href="adminProducts" class="${activePage == 'products' ? 'active' : ''}">
                <i class="fas fa-box-open"></i>
                <span>Sản phẩm</span>
            </a>
        </li>
        <li>
            <a href="adminOrders" class="${activePage == 'orders' ? 'active' : ''}">
                <i class="fas fa-shopping-bag"></i>
                <span>Đơn hàng</span>
            </a>
        </li>
        <li>
            <a href="adminContacts" class="${activePage == 'contacts' ? 'active' : ''}">
                <i class="fas fa-envelope-open-text"></i>
                <span>Liên hệ</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-section-label">Tiếp thị</div>
    <ul class="sidebar-menu">
        <li>
            <a href="adminDiscounts" class="${activePage == 'discounts' ? 'active' : ''}">
                <i class="fas fa-percent"></i>
                <span>Mã giảm giá</span>
            </a>
        </li>
        <li>
            <a href="adminFeaturedProducts" class="${activePage == 'featured' ? 'active' : ''}">
                <i class="fas fa-fire"></i>
                <span>Sản phẩm nổi bật</span>
            </a>
        </li>
        <li>
            <a href="adminInventory" class="${activePage == 'inventory' ? 'active' : ''}">
                <i class="fas fa-warehouse"></i>
                <span>Tồn kho</span>
            </a>
        </li
    </ul>

    <div class="sidebar-divider"></div>
    <ul class="sidebar-menu">
        <li>
            <a href="home" class="store-link">
                <i class="fas fa-external-link-alt"></i>
                <span>Về trang cửa hàng</span>
            </a>
        </li>
    </ul>

</div>
