<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Đơn Hàng - Kachi-Kun Shop</title>
<link rel="icon" type="image/png" href="images/LogoRemake.png" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Montserrat', 'Arial', sans-serif; background-color: #f5f7fa; color: #333; line-height: 1.6; }

/* --- HEADER & SIDEBAR GIỐNG HỆT ADMINUSERS --- */
.admin-header { background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%); color: white; padding: 20px 30px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); display: flex; justify-content: space-between; align-items: center; }
.admin-header h1 { font-size: 24px; font-weight: 600; }
.user-info { display: flex; align-items: center; gap: 15px; }
.user-avatar { width: 40px; height: 40px; border-radius: 50%; background-color: rgba(255, 255, 255, 0.2); display: flex; align-items: center; justify-content: center; font-size: 18px; }
.logout-btn { background-color: rgba(255, 255, 255, 0.2); border: none; color: white; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-family: 'Montserrat', sans-serif; font-weight: 500; transition: background-color 0.3s; }
.logout-btn:hover { background-color: rgba(255, 255, 255, 0.3); }

.admin-container { display: flex; min-height: calc(100vh - 80px); }
.sidebar { width: 250px; background-color: white; padding: 20px 0; box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05); }
.sidebar-menu { list-style: none; }
.sidebar-menu li { padding: 0; }
.sidebar-menu a { display: flex; align-items: center; padding: 15px 25px; color: #555; text-decoration: none; transition: all 0.3s; border-left: 4px solid transparent; }
.sidebar-menu a:hover { background-color: #f0f7f7; color: #2d7e7e; border-left-color: #2d7e7e; }
.sidebar-menu a.active { background-color: #e8f4f4; color: #2d7e7e; border-left-color: #2d7e7e; font-weight: 600; }
.sidebar-menu i { width: 24px; margin-right: 12px; text-align: center; }

/* --- MAIN CONTENT RIÊNG CHO ORDERS --- */
.main-content { flex: 1; padding: 30px; }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
.page-header h2 { font-size: 24px; color: #2d7e7e; }

.order-section { background-color: white; border-radius: 10px; padding: 25px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }

/* Table Style cho Đơn hàng */
.custom-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
.custom-table th { text-align: left; padding: 15px; border-bottom: 2px solid #f0f0f0; color: #2d7e7e; font-weight: 600; font-size: 14px; }
.custom-table td { padding: 15px; border-bottom: 1px solid #f5f5f5; font-size: 14px; vertical-align: middle; }
.custom-table tr:last-child td { border-bottom: none; }
.custom-table tr:hover { background-color: #f9fbfb; }

/* Status Badges */
.status-badge { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
.status-pending { background-color: #fff3cd; color: #856404; } /* Đang xử lý - Vàng */
.status-shipping { background-color: #cce5ff; color: #004085; } /* Đang giao - Xanh dương */
.status-done { background-color: #d4edda; color: #155724; } /* Đã giao - Xanh lá */
.status-cancel { background-color: #f8d7da; color: #721c24; } /* Đã hủy - Đỏ */

/* Action Buttons */
.action-btn { padding: 6px 12px; border-radius: 4px; border: none; font-size: 13px; cursor: pointer; display: inline-flex; align-items: center; gap: 5px; transition: all 0.3s; margin-right: 5px; text-decoration: none; color: white; font-family: 'Montserrat', sans-serif; }
.view-btn { background-color: #17a2b8; }
.view-btn:hover { background-color: #138496; }
.edit-btn { background-color: #ffc107; color: #333; }
.edit-btn:hover { background-color: #e0a800; }

/* Dropdown cập nhật nhanh */
.dropdown { position: relative; display: inline-block; }
.dropdown-content { display: none; position: absolute; right: 0; background-color: white; min-width: 160px; box-shadow: 0 8px 16px rgba(0,0,0,0.1); z-index: 1; border-radius: 4px; border: 1px solid #ddd; }
.dropdown-content a { color: #333; padding: 10px 15px; text-decoration: none; display: block; font-size: 13px; border-left: none; }
.dropdown-content a:hover { background-color: #f1f1f1; color: #2d7e7e; }
.dropdown:hover .dropdown-content { display: block; }

.price-text { color: #d63031; font-weight: 700; }
.customer-info div { margin-bottom: 3px; }
.customer-sub { font-size: 12px; color: #888; }

.no-orders { text-align: center; padding: 40px; color: #777; }
.no-orders i { font-size: 48px; margin-bottom: 15px; color: #ccc; }

@media (max-width: 992px) { .admin-container { flex-direction: column; } .sidebar { width: 100%; margin-bottom: 20px; } }
</style>
</head>
<body>
    <c:if test="${empty user or user.role ne 1}">
        <c:redirect url="login" />
    </c:if>

    <div class="admin-header">
        <h1><i class="fas fa-crown"></i> Trang Quản Trị - Kachi-Kun Shop</h1>
        <div class="user-info">
            <div class="user-avatar"><i class="fas fa-user-shield"></i></div>
            <div>
                <div>Xin chào, <strong>${user.fullName}</strong></div>
                <div style="font-size: 12px; opacity: 0.9;">Quản trị viên</div>
            </div>
            <a href="logout"><button class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</button></a>
        </div>
    </div>

    <div class="admin-container">
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="adminHome"><i class="fas fa-tachometer-alt"></i> Tổng quan</a></li>
                <li><a href="adminUsers"><i class="fas fa-users"></i> Quản lý người dùng</a></li>
                <li><a href="adminProducts"><i class="fas fa-box"></i> Quản lý sản phẩm</a></li>
                <li><a href="adminOrders" class="active"><i class="fas fa-shopping-cart"></i> Quản lý đơn hàng</a></li>
                <li><a href="adminContacts"><i class="fas fa-envelope"></i> Quản lý liên hệ</a></li>
                <li><a href="home"><i class="fas fa-store"></i> Về trang cửa hàng</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h2><i class="fas fa-shopping-cart"></i> Quản Lý Đơn Hàng</h2>
                </div>

            <div class="order-section">
                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="no-orders">
                            <i class="fas fa-clipboard-list"></i>
                            <p>Chưa có đơn hàng nào trong hệ thống</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="custom-table">
                            <thead>
                                <tr>
                                    <th>Mã ĐH</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${orders}">
                                    <tr>
                                        <td><strong>#${o.id}</strong></td>
                                        <td class="customer-info">
                                            <div style="font-weight: 600;">${o.recipientName}</div>
                                            <div class="customer-sub"><i class="fas fa-phone-alt" style="font-size: 10px;"></i> ${o.recipientPhone}</div>
                                        </td>
                                        <td>${o.orderDate}</td>
                                        <td class="price-text">
                                            <fmt:formatNumber value="${o.totalPrice}" type="currency" currencySymbol="₫"/>
                                        </td>
                                        <td>
                                            <span class="status-badge 
                                                ${o.status == 'Đang xử lý' ? 'status-pending' : 
                                                  (o.status == 'Đang giao hàng' ? 'status-shipping' : 
                                                  (o.status == 'Đã giao' || o.status == 'Hoàn thành' ? 'status-done' : 'status-cancel'))}">
                                                ${o.status}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="adminOrders?action=view&id=${o.id}" class="action-btn view-btn" title="Xem chi tiết">
                                                <i class="fas fa-eye"></i> Xem
                                            </a>

                                            <div class="dropdown">
                                                <button class="action-btn edit-btn">
                                                    <i class="fas fa-pen"></i> <i class="fas fa-caret-down"></i>
                                                </button>
                                                <div class="dropdown-content">
                                                    <a href="adminOrders?action=update&id=${o.id}&status=Đang xử lý"><i class="fas fa-spinner"></i> Đang xử lý</a>
                                                    <a href="adminOrders?action=update&id=${o.id}&status=Đang giao hàng"><i class="fas fa-truck"></i> Đang giao hàng</a>
                                                    <a href="adminOrders?action=update&id=${o.id}&status=Đã giao"><i class="fas fa-check"></i> Đã giao</a>
                                                    <a href="adminOrders?action=update&id=${o.id}&status=Đã hủy" style="color:red;"><i class="fas fa-times"></i> Hủy đơn</a>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>