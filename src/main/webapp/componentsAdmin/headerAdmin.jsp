<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 5/24/2026
  Time: 2:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="admin-header">
    <h1>
        <i class="fas fa-crown"></i> Trang Quản Trị - Kachi-Kun Shop
    </h1>
    <div class="user-info">
        <div class="user-avatar">
            <i class="fas fa-user-shield"></i>
        </div>
        <div>
            <div>
                Xin chào, <strong>${user.fullName}</strong>
            </div>
            <div style="font-size: 12px; opacity: 0.9;">Quản trị viên</div>
        </div>
        <a href="logout">
            <button class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </button>
        </a>
    </div>
</div>