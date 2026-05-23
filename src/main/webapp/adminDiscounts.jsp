<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Mã Giảm Giá - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Montserrat', 'Arial', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .admin-header {
            background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
            color: white;
            padding: 20px 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .admin-header h1 {
            font-size: 24px;
            font-weight: 600;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .logout-btn {
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        .admin-container {
            display: flex;
            min-height: calc(100vh - 80px);
        }

        .sidebar {
            width: 250px;
            background-color: white;
            padding: 20px 0;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            padding: 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: #555;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }

        .sidebar-menu a:hover {
            background-color: #f0f7f7;
            color: #2d7e7e;
            border-left-color: #2d7e7e;
        }

        .sidebar-menu a.active {
            background-color: #e8f4f4;
            color: #2d7e7e;
            border-left-color: #2d7e7e;
            font-weight: 600;
        }

        .sidebar-menu i {
            width: 24px;
            margin-right: 12px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            padding: 30px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-header h2 {
            font-size: 24px;
            color: #2d7e7e;
        }

        .add-btn {
            background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(45, 126, 126, 0.3);
        }

        .alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .discounts-table {
            width: 100%;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .discounts-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .discounts-table th {
            background-color: #f0f7f7;
            color: #2d7e7e;
            font-weight: 600;
            padding: 15px;
            text-align: left;
            border-bottom: 2px solid #e0f0f0;
        }

        .discounts-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .discounts-table tr:hover {
            background-color: #f9fcfc;
        }

        .discounts-table th:nth-child(1), .discounts-table td:nth-child(1) {
            width: 55px;
            text-align: center;
        }

        .discounts-table th:nth-child(7), .discounts-table td:nth-child(7) {
            text-align: center;
        }

        .discounts-table th:last-child, .discounts-table td:last-child {
            width: 100px;
            text-align: center;
        }

        .code-badge {
            font-family: monospace;
            font-weight: 700;
            font-size: 14px;
            background: #f0f7f7;
            color: #1a5c5c;
            padding: 4px 10px;
            border-radius: 4px;
            letter-spacing: 1px;
        }

        .type-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .type-percent {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .type-fixed {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active {
            background-color: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }

        .expires-ok {
            color: #27ae60;
            font-weight: 500;
        }

        .expires-soon {
            color: #e67e22;
            font-weight: 500;
        }

        .expires-expired {
            color: #e74c3c;
        }

        .expires-never {
            color: #999;
            font-style: italic;
        }

        .edit-btn {
            padding: 7px 14px;
            border-radius: 4px;
            border: none;
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            font-size: 13px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
            background-color: #4facfe;
            color: white;
        }

        .edit-btn:hover {
            background-color: #3a9aed;
        }

        .no-data {
            text-align: center;
            padding: 50px;
            color: #777;
            font-size: 16px;
        }

        .no-data i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ccc;
            display: block;
        }

        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            padding: 15px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .pagination-info {
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }

        .pagination {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .page-btn, .page-number, .current-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            height: 40px;
            padding: 0 12px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s;
            cursor: pointer;
            border: 1px solid #ddd;
        }

        .page-btn {
            background-color: white;
            color: #2d7e7e;
        }

        .page-btn:hover {
            background-color: #f0f7f7;
            border-color: #2d7e7e;
            transform: translateY(-1px);
        }

        .page-number {
            background-color: white;
            color: #555;
        }

        .page-number:hover {
            background-color: #f0f7f7;
            color: #2d7e7e;
            border-color: #2d7e7e;
        }

        .current-page {
            background-color: #2d7e7e;
            color: white;
            border-color: #2d7e7e;
            font-weight: 600;
        }

        .page-btn.disabled, .page-number.disabled {
            background-color: #f5f5f5;
            color: #999;
            border-color: #ddd;
            cursor: not-allowed;
            pointer-events: none;
        }

        .ellipsis {
            color: #999;
            padding: 0 10px;
            display: flex;
            align-items: center;
            height: 40px;
        }

        .page-numbers {
            display: flex;
            gap: 5px;
        }

        /* Modal */
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .modal-overlay.open {
            display: flex;
        }

        .modal {
            background: white;
            border-radius: 12px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
            color: white;
            padding: 20px 25px;
            border-radius: 12px 12px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 18px;
            font-weight: 600;
        }

        .modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 22px;
            cursor: pointer;
            opacity: 0.8;
            transition: opacity 0.2s;
            line-height: 1;
        }

        .modal-close:hover {
            opacity: 1;
        }

        .modal-body {
            padding: 25px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            font-size: 13px;
            font-weight: 600;
            color: #555;
        }

        .form-group input, .form-group select {
            padding: 10px 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            transition: border-color 0.3s;
            outline: none;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #2d7e7e;
        }

        .form-hint {
            font-size: 11px;
            color: #999;
            margin-top: 2px;
        }

        .checkbox-group {
            flex-direction: row;
            align-items: center;
            gap: 10px;
            padding-top: 5px;
        }

        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #2d7e7e;
        }

        .checkbox-group label {
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
        }

        .modal-footer {
            padding: 15px 25px 20px;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            border-top: 1px solid #eee;
        }

        .btn-cancel {
            padding: 10px 22px;
            border-radius: 6px;
            border: 1px solid #ddd;
            background: white;
            color: #555;
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background: #f5f5f5;
        }

        .btn-save {
            padding: 10px 24px;
            border-radius: 6px;
            border: none;
            background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
            color: white;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-save:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(45, 126, 126, 0.3);
        }

        @media (max-width: 992px) {
            .admin-container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .discounts-table {
                overflow-x: auto;
            }

            .discounts-table table {
                min-width: 750px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .pagination-container {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }

            .pagination {
                justify-content: center;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>

<c:if test="${empty user or user.role ne 1}">
    <c:redirect url="login"/>
</c:if>
<c:set var="activePage" value="discounts" scope="request" />
<jsp:include page="componentsAdmin/headerAdmin.jsp"/>

<div class="admin-container">
    <jsp:include page="componentsAdmin/sidebarAdmin.jsp"/>

    <div class="main-content">
        <div class="page-header">
            <h2><i class="fas fa-tag"></i> Quản Lý Mã Giảm Giá</h2>
            <button class="add-btn" onclick="openAddModal()">
                <i class="fas fa-plus-circle"></i> Thêm Mã Mới
            </button>
        </div>

        <c:if test="${param.success eq 'added'}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> Thêm mã giảm giá thành công!</div>
        </c:if>
        <c:if test="${param.success eq 'updated'}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> Cập nhật mã giảm giá thành công!</div>
        </c:if>
        <c:if test="${param.error eq 'duplicate_code'}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Mã giảm giá này đã tồn tại!</div>
        </c:if>
        <c:if test="${param.error eq 'invalid_input'}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Dữ liệu không hợp lệ. Vui lòng kiểm
                tra lại!
            </div>
        </c:if>
        <c:if test="${param.success eq 'false'}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Thao tác thất bại. Vui lòng thử
                lại!
            </div>
        </c:if>

        <div class="discounts-table">
            <c:choose>
                <c:when test="${empty discountList}">
                    <div class="no-data">
                        <i class="fas fa-ticket-alt"></i>
                        <p>Chưa có mã giảm giá nào. Hãy thêm mã mới!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Mã</th>
                            <th>Loại</th>
                            <th>Giá trị</th>
                            <th>Đơn tối thiểu</th>
                            <th>Lượt dùng</th>
                            <th>Trạng thái</th>
                            <th>Hết hạn</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="d" items="${discountList}">
                            <tr>
                                <td style="text-align:center;">${d.id}</td>
                                <td><span class="code-badge">${d.code}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.discountType eq 'PERCENT'}">
                                            <span class="type-badge type-percent"><i class="fas fa-percent"></i> Phần trăm</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="type-badge type-fixed"><i
                                                    class="fas fa-coins"></i> Số tiền</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <strong>
                                        <c:choose>
                                            <c:when test="${d.discountType eq 'PERCENT'}">
                                                <fmt:formatNumber value="${d.discountValue}" maxFractionDigits="2"/>%
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${d.discountValue}" type="number"
                                                                  maxFractionDigits="0" groupingUsed="true"/> ₫
                                            </c:otherwise>
                                        </c:choose>
                                    </strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.minOrderValue gt 0}">
                                            <fmt:formatNumber value="${d.minOrderValue}" type="number"
                                                              maxFractionDigits="0" groupingUsed="true"/> ₫
                                        </c:when>
                                        <c:otherwise><span
                                                style="color:#999;font-style:italic;">Không giới hạn</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align:center;">
                                        ${d.usedCount}
                                    <c:choose>
                                        <c:when test="${not empty d.maxUses}"> / ${d.maxUses}</c:when>
                                        <c:otherwise> / <span title="Không giới hạn">∞</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align:center;">
                                    <c:choose>
                                        <c:when test="${d.active}">
                                            <span class="status-badge status-active"><i class="fas fa-circle"
                                                                                        style="font-size:8px;"></i> Đang bật</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive"><i class="fas fa-circle"
                                                                                          style="font-size:8px;"></i> Đã tắt</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty d.expiresAt}">
                                            <span class="expires-never">Không hết hạn</span>
                                        </c:when>
                                        <c:when test="${d.expiresAt.time lt nowMs}">
                                            <span class="expires-expired"><i
                                                    class="fas fa-times-circle"></i> ${d.expiresAt}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="expires-ok"><i
                                                    class="fas fa-calendar-check"></i> ${d.expiresAt}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align:center;">
                                    <button class="edit-btn"
                                            data-id="${d.id}"
                                            data-code="${d.code}"
                                            data-type="${d.discountType}"
                                            data-value="${d.discountValue}"
                                            data-min="${d.minOrderValue}"
                                            data-max="${d.maxUses}"
                                            data-active="${d.active}"
                                            data-expires="${d.expiresAt}"
                                            onclick="openEditModal(this)">
                                        <i class="fas fa-edit"></i> Sửa
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${not empty discountList}">
            <div class="pagination-container">
                <div class="pagination-info">
                    Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                    - Hiển thị <strong>${discountList.size()}</strong>
                    / Tổng <strong>${totalCount}</strong> mã giảm giá
                </div>
                <c:if test="${totalPages gt 1}">
                    <div class="pagination">
                        <c:choose>
                            <c:when test="${currentPage gt 1}">
                                <a href="adminDiscounts?page=1" class="page-btn" title="Trang đầu"><i
                                        class="fas fa-angle-double-left"></i></a>
                                <a href="adminDiscounts?page=${currentPage - 1}" class="page-btn" title="Trang trước"><i
                                        class="fas fa-chevron-left"></i></a>
                            </c:when>
                            <c:otherwise>
                                <span class="page-btn disabled"><i class="fas fa-angle-double-left"></i></span>
                                <span class="page-btn disabled"><i class="fas fa-chevron-left"></i></span>
                            </c:otherwise>
                        </c:choose>

                        <div class="page-numbers">
                            <c:set var="startPage" value="1"/>
                            <c:set var="endPage" value="${totalPages}"/>
                            <c:if test="${totalPages gt 5}">
                                <c:choose>
                                    <c:when test="${currentPage le 3}">
                                        <c:set var="startPage" value="1"/><c:set var="endPage" value="5"/>
                                    </c:when>
                                    <c:when test="${currentPage gt totalPages - 2}">
                                        <c:set var="startPage" value="${totalPages - 4}"/><c:set var="endPage"
                                                                                                 value="${totalPages}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="startPage" value="${currentPage - 2}"/><c:set var="endPage"
                                                                                                  value="${currentPage + 2}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${startPage gt 1}">
                                <a href="adminDiscounts?page=1" class="page-number">1</a>
                                <c:if test="${startPage gt 2}"><span class="ellipsis">...</span></c:if>
                            </c:if>
                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <c:choose>
                                    <c:when test="${i eq currentPage}"><span class="current-page">${i}</span></c:when>
                                    <c:otherwise><a href="adminDiscounts?page=${i}"
                                                    class="page-number">${i}</a></c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${endPage lt totalPages}">
                                <c:if test="${endPage lt totalPages - 1}"><span class="ellipsis">...</span></c:if>
                                <a href="adminDiscounts?page=${totalPages}" class="page-number">${totalPages}</a>
                            </c:if>
                        </div>

                        <c:choose>
                            <c:when test="${currentPage lt totalPages}">
                                <a href="adminDiscounts?page=${currentPage + 1}" class="page-btn" title="Trang sau"><i
                                        class="fas fa-chevron-right"></i></a>
                                <a href="adminDiscounts?page=${totalPages}" class="page-btn" title="Trang cuối"><i
                                        class="fas fa-angle-double-right"></i></a>
                            </c:when>
                            <c:otherwise>
                                <span class="page-btn disabled"><i class="fas fa-chevron-right"></i></span>
                                <span class="page-btn disabled"><i class="fas fa-angle-double-right"></i></span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </div>
        </c:if>
    </div>
</div>

<!-- Modal thêm / sửa -->
<div class="modal-overlay" id="modalOverlay">
    <div class="modal">
        <div class="modal-header">
            <h3 id="modalTitle"><i class="fas fa-tag"></i> Thêm Mã Giảm Giá</h3>
            <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <form method="post" action="adminDiscounts" id="discountForm" onsubmit="return validateForm()">
            <div class="modal-body">
                <input type="hidden" name="action" id="action" value="add"/>
                <input type="hidden" name="id" id="editId" value=""/>
                <div class="form-grid">
                    <div class="form-group">
                        <label for="code">Mã giảm giá <span style="color:#e74c3c;">*</span></label>
                        <input type="text" id="code" name="code" placeholder="VD: SUMMER20" required
                               style="text-transform:uppercase;" maxlength="50"/>
                        <span class="form-hint">Chỉ gồm chữ cái, số, dấu gạch dưới</span>
                    </div>
                    <div class="form-group">
                        <label for="discountType">Loại giảm giá <span style="color:#e74c3c;">*</span></label>
                        <select id="discountType" name="discountType" required onchange="updateValueHint()">
                            <option value="PERCENT">Phần trăm (%)</option>
                            <option value="FIXED_AMOUNT">Số tiền cố định (₫)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="discountValue">Giá trị giảm <span style="color:#e74c3c;">*</span></label>
                        <input type="number" id="discountValue" name="discountValue"
                               placeholder="VD: 10" min="0.01" step="any" required/>
                        <span class="form-hint" id="discountValueHint">Nhập từ 1 đến 100</span>
                    </div>
                    <div class="form-group">
                        <label for="minOrderValue">Đơn hàng tối thiểu (₫)</label>
                        <input type="number" id="minOrderValue" name="minOrderValue"
                               placeholder="0" min="0" step="1000" value="0"/>
                        <span class="form-hint">0 = không yêu cầu tối thiểu</span>
                    </div>
                    <div class="form-group">
                        <label for="maxUses">Số lần dùng tối đa</label>
                        <input type="number" id="maxUses" name="maxUses"
                               placeholder="Để trống nếu không giới hạn" min="1" step="1"/>
                        <span class="form-hint">Để trống = không giới hạn</span>
                    </div>
                    <div class="form-group">
                        <label for="expiresAt">Ngày hết hạn</label>
                        <input type="date" id="expiresAt" name="expiresAt"/>
                        <span class="form-hint">Để trống = không hết hạn</span>
                    </div>
                    <div class="form-group full-width">
                        <div class="checkbox-group">
                            <input type="checkbox" id="active" name="active" checked/>
                            <label for="active">Kích hoạt mã giảm giá này</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="closeModal()">Hủy</button>
                <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openAddModal() {
        document.getElementById('modalTitle').innerHTML = '<i class="fas fa-plus-circle"></i> Thêm Mã Giảm Giá Mới';
        document.getElementById('action').value = 'add';
        document.getElementById('editId').value = '';
        document.getElementById('discountForm').reset();
        document.getElementById('active').checked = true;
        document.getElementById('minOrderValue').value = '0';
        updateValueHint();
        document.getElementById('modalOverlay').classList.add('open');
    }

    function openEditModal(btn) {
        document.getElementById('modalTitle').innerHTML = '<i class="fas fa-edit"></i> Chỉnh Sửa Mã Giảm Giá';
        document.getElementById('action').value = 'edit';
        document.getElementById('editId').value = btn.dataset.id;
        document.getElementById('code').value = btn.dataset.code;
        document.getElementById('discountType').value = btn.dataset.type;
        document.getElementById('discountValue').value = btn.dataset.value;
        document.getElementById('minOrderValue').value = btn.dataset.min || '0';
        document.getElementById('maxUses').value = btn.dataset.max || '';
        document.getElementById('active').checked = btn.dataset.active === 'true';
        document.getElementById('expiresAt').value = btn.dataset.expires || '';
        updateValueHint();
        document.getElementById('modalOverlay').classList.add('open');
    }

    function closeModal() {
        document.getElementById('modalOverlay').classList.remove('open');
    }

    document.getElementById('modalOverlay').addEventListener('click', function (e) {
        if (e.target === this) closeModal();
    });

    function updateValueHint() {
        var type = document.getElementById('discountType').value;
        var hint = document.getElementById('discountValueHint');
        var input = document.getElementById('discountValue');
        if (type === 'PERCENT') {
            hint.textContent = 'Nhập từ 1 đến 100';
            input.max = 100;
            input.placeholder = 'VD: 10';
        } else {
            hint.textContent = 'Nhập số tiền (VD: 50000)';
            input.removeAttribute('max');
            input.placeholder = 'VD: 50000';
        }
    }

    function validateForm() {
        var code = document.getElementById('code').value.trim();
        if (!/^[A-Z0-9_\-]+$/i.test(code)) {
            alert('Mã giảm giá chỉ được chứa chữ cái, số, dấu gạch dưới hoặc gạch ngang!');
            return false;
        }
        var type = document.getElementById('discountType').value;
        var val = parseFloat(document.getElementById('discountValue').value);
        if (type === 'PERCENT' && (val <= 0 || val > 100)) {
            alert('Giá trị phần trăm phải từ 1 đến 100!');
            return false;
        }
        if (type !== 'PERCENT' && val <= 0) {
            alert('Giá trị giảm phải lớn hơn 0!');
            return false;
        }
        return true;
    }

    document.getElementById('code').addEventListener('input', function () {
        this.value = this.value.toUpperCase();
    });

    setTimeout(function () {
        document.querySelectorAll('.alert').forEach(function (el) {
            el.style.display = 'none';
        });
    }, 5000);
</script>
</body>
</html>
