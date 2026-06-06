<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="admin-header">
    <h1>
        <span class="header-crown"><i class="fas fa-crown"></i></span>
        <span class="header-title-text">Kachi-Kun Shop &nbsp;<span style="color:#94a3b8;font-weight:400;font-size:15px;">/ Quản trị</span></span>
    </h1>
    <div class="user-info">
        <div class="user-avatar">
            <i class="fas fa-user-shield"></i>
        </div>
        <div class="user-meta">
            <span class="user-name-text">
                <c:if test="${not empty user}">${user.fullName}</c:if>
                <c:if test="${empty user}">Admin</c:if>
            </span>
            <span class="user-role-text">Quản trị viên</span>
        </div>
        <a href="logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
    </div>
</div>
