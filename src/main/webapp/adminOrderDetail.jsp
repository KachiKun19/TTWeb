<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng #${order.id} - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        .detail-container {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
        }

        .info-box h3 {
            color: #2d7e7e;
            margin-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
            display: inline-block;
        }

        .info-row {
            margin-bottom: 10px;
            display: flex;
        }

        .info-label {
            font-weight: 600;
            width: 140px;
            color: #555;
        }

        .info-value {
            flex: 1;
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .product-table th {
            background-color: #f8f9fa;
            text-align: left;
            padding: 12px;
            border-bottom: 2px solid #ddd;
            color: #2d7e7e;
        }

        .product-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #eee;
        }

        .total-section {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .total-box {
            text-align: right;
        }

        .total-row {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 5px;
            gap: 20px;
        }

        .grand-total {
            font-size: 20px;
            font-weight: 700;
            color: #d63031;
            margin-top: 10px;
        }

        .back-btn {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.3s;
            border: none;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #5a6268;
        }

        .print-btn {
            background-color: #2d7e7e;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.3s;
            border: none;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            cursor: pointer;
            margin-left: 10px;
        }

        .print-btn:hover {
            background-color: #226666;
        }

        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<c:if test="${empty user or user.role ne 1}">
    <c:redirect url="login"/>
</c:if>
<c:set var="activePage" value="none" scope="request" />
<jsp:include page="componentsAdmin/headerAdmin.jsp"/>

<div class="admin-container">
    <jsp:include page="componentsAdmin/sidebarAdmin.jsp"/>

    <div class="main-content">
        <div class="page-header">
            <h2><i class="fas fa-file-invoice"></i> Chi Tiết Đơn Hàng #${order.id}</h2>
            <div>
                <a href="adminOrders" class="back-btn"><i class="fas fa-arrow-left"></i> Quay lại</a>
                <button onclick="window.print()" class="print-btn"><i class="fas fa-print"></i> In Hóa Đơn</button>
            </div>
        </div>

        <div class="detail-container">
            <div class="info-grid">
                <div class="info-box">
                    <h3><i class="fas fa-user"></i> Thông Tin Khách Hàng</h3>
                    <div class="info-row">
                        <span class="info-label">Người nhận:</span>
                        <span class="info-value">${order.recipientName}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Số điện thoại:</span>
                        <span class="info-value">${order.recipientPhone}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Địa chỉ:</span>
                        <span class="info-value">${order.shippingAddress}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Tài khoản đặt:</span>
                        <span class="info-value">
                                <c:if test="${not empty order.user}">@${order.user.username}</c:if>
                                <c:if test="${empty order.user}">Khách vãng lai</c:if>
                            </span>
                    </div>
                </div>

                <div class="info-box">
                    <h3><i class="fas fa-info-circle"></i> Thông Tin Đơn Hàng</h3>
                    <div class="info-row">
                        <span class="info-label">Mã đơn hàng:</span>
                        <span class="info-value"><strong>#${order.id}</strong></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Ngày đặt:</span>
                        <span class="info-value">${order.orderDate}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Thanh toán:</span>
                        <span class="info-value">${order.paymentMethod}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Trạng thái:</span>
                        <span class="info-value" style="font-weight:bold; color:#2d7e7e;">${order.status}</span>
                    </div>
                </div>
            </div>

            <h3><i class="fas fa-box-open"></i> Danh Sách Sản Phẩm</h3>
            <table class="product-table">
                <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="detail" items="${details}">
                    <tr>
                        <td>
                            <strong>${detail.product.name}</strong>
                            <br>
                            <small style="color:#777;">Mã SP: ${detail.product.id}</small>
                        </td>
                        <td>
                            <img src="images/${detail.product.image}" class="product-img" alt="Ảnh SP">
                        </td>
                        <td>
                            <fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="₫"/>
                        </td>
                        <td>x${detail.quantity}</td>
                        <td style="font-weight:600;">
                            <fmt:formatNumber value="${detail.price * detail.quantity}" type="currency"
                                              currencySymbol="₫"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="total-section">
                <div class="total-box">
                    <div class="total-row">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"/></span>
                    </div>
                    <div class="total-row">
                        <span>Phí vận chuyển:</span>
                        <span>0 ₫</span>
                    </div>
                    <div class="grand-total">
                        Tổng cộng: <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>