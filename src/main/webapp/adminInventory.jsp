<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 6/14/2026
  Time: 4:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tồn kho - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        .page-header {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .page-header h1 {
            font-size: 22px;
            color: #2d7e7e;
            margin-bottom: 5px;
        }
        .page-header p { color: #777; font-size: 14px; }

        /* Week navigator */
        .week-nav {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
            background: white;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .week-nav .week-label {
            flex: 1;
            text-align: center;
            font-weight: 700;
            font-size: 15px;
            color: #333;
        }
        .week-nav a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #f1f3f5;
            color: #555;
            text-decoration: none;
            transition: all 0.2s;
        }
        .week-nav a:hover { background: #2d7e7e; color: white; }
        .week-nav .today-btn {
            padding: 8px 18px;
            border-radius: 20px;
            background: #2d7e7e;
            color: white;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: background 0.2s;
            width: auto;
            height: auto;
        }
        .week-nav .today-btn:hover { background: #1a5c5c; }

        /* Tabs */
        .tab-buttons {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
        }
        .tab-btn {
            padding: 10px 22px;
            border-radius: 25px;
            border: none;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            font-family: 'Montserrat', sans-serif;
            transition: all 0.2s;
            background: #f1f3f5;
            color: #555;
        }
        .tab-btn.active-tab { background: #2d7e7e; color: white; }
        .tab-btn:hover:not(.active-tab) { background: #e9ecef; }

        .tab-content { display: none; }
        .tab-content.active { display: block; }

        /* Table */
        .inv-table-wrap {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        .inv-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }
        .inv-table thead tr { background: linear-gradient(135deg, #2d7e7e, #1a5c5c); }
        .inv-table th {
            padding: 14px 15px;
            color: white;
            font-weight: 600;
            text-align: left;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 12px;
        }
        .inv-table tbody tr { border-bottom: 1px solid #f1f1f1; transition: background 0.2s; }
        .inv-table tbody tr:hover { background: #f8f9fa; }
        .inv-table td { padding: 12px 15px; vertical-align: middle; }

        .prod-cell { display: flex; align-items: center; gap: 10px; }
        .prod-cell img { width: 42px; height: 42px; object-fit: contain; border-radius: 6px; border: 1px solid #eee; background: #fafafa; }
        .prod-name { font-weight: 600; color: #333; }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }
        .badge-success { background: #d1e7dd; color: #0f5132; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger  { background: #f8d7da; color: #842029; }
        .badge-info    { background: #cff4fc; color: #055160; }

        .stock-low { color: #dc3545; font-weight: 700; }
        .stock-ok  { color: #28a745; font-weight: 700; }

        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: #999;
        }
        .empty-state i { font-size: 48px; color: #dee2e6; margin-bottom: 15px; display: block; }
    </style>
</head>
<body>
<c:if test="${empty user or user.role ne 1}">
    <c:redirect url="login"/>
</c:if>
<c:set var="activePage" value="inventory" scope="request"/>

<jsp:include page="componentsAdmin/headerAdmin.jsp"/>
<div class="admin-container">
    <jsp:include page="componentsAdmin/sidebarAdmin.jsp"/>

    <div class="main-content">

        <div class="page-header">
            <h1><i class="fas fa-warehouse"></i> Quản lý tồn kho</h1>
            <p>Theo dõi sản phẩm bán chạy, không bán được và toàn bộ tồn kho</p>
        </div>

        <%-- Week Navigator --%>
        <div class="week-nav">
            <a href="adminInventory?weekOffset=${weekOffset - 1}">
                <i class="fas fa-chevron-left"></i>
            </a>
            <div class="week-label">
                <i class="fas fa-calendar-week" style="color:#2d7e7e; margin-right:8px;"></i>
                Tuần: ${weekStart} → ${weekEnd}
            </div>
            <a href="adminInventory?weekOffset=${weekOffset + 1}">
                <i class="fas fa-chevron-right"></i>
            </a>
            <a href="adminInventory" class="today-btn">Tuần này</a>
        </div>

        <%-- Tab Buttons --%>
        <div class="tab-buttons">
            <button class="tab-btn active-tab" onclick="switchTab('tab-hot', this)">
                <i class="fas fa-fire"></i> Bán chạy
                <span style="background:rgba(255,255,255,0.3); padding:2px 8px; border-radius:10px; margin-left:5px;">
                    ${topSelling.size()}
                </span>
            </button>
            <button class="tab-btn" onclick="switchTab('tab-cold', this)">
                <i class="fas fa-box-open"></i> Không bán được
                <span style="background:rgba(255,255,255,0.3); padding:2px 8px; border-radius:10px; margin-left:5px;">
                    ${notSelling.size()}
                </span>
            </button>
            <button class="tab-btn" onclick="switchTab('tab-all', this)">
                <i class="fas fa-list"></i> Toàn bộ tồn kho
                <span style="background:rgba(255,255,255,0.3); padding:2px 8px; border-radius:10px; margin-left:5px;">
                    ${allInventory.size()}
                </span>
            </button>
        </div>

        <%-- Tab 1: Bán chạy --%>
        <div id="tab-hot" class="tab-content active">
            <div class="inv-table-wrap">
                <c:choose>
                    <c:when test="${not empty topSelling}">
                        <table class="inv-table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Sản phẩm</th>
                                <th>Đã bán tuần này</th>
                                <th>Tồn kho</th>
                                <th>Giá</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="p" items="${topSelling}" varStatus="st">
                                <tr>
                                    <td style="color:#999;">${st.index + 1}</td>
                                    <td>
                                        <div class="prod-cell">
                                            <img src="images/${p.image}" alt="${p.name}"/>
                                            <span class="prod-name">${p.name}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span style="font-weight:700; color:#28a745; font-size:16px;">${p.week_sold}</span>
                                        <span style="color:#999; font-size:12px;"> sản phẩm</span>
                                    </td>
                                    <td>
                                        <span class="${p.stock_quantity < 10 ? 'stock-low' : 'stock-ok'}">${p.stock_quantity}</span>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.stock_quantity == 0}">
                                                <span class="badge badge-danger">🚨 Hết hàng</span>
                                            </c:when>
                                            <c:when test="${p.stock_quantity < 10}">
                                                <span class="badge badge-warning">⚠️ Cần nhập gấp</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-success">✅ Đủ hàng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-chart-line"></i>
                            <p>Chưa có sản phẩm nào bán được ≥10 trong tuần này.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- Tab 2: Không bán được --%>
        <div id="tab-cold" class="tab-content">
            <div class="inv-table-wrap">
                <c:choose>
                    <c:when test="${not empty notSelling}">
                        <table class="inv-table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Sản phẩm</th>
                                <th>Tồn kho</th>
                                <th>Tổng đã bán</th>
                                <th>Giá</th>
                                <th>Gợi ý</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="p" items="${notSelling}" varStatus="st">
                                <tr>
                                    <td style="color:#999;">${st.index + 1}</td>
                                    <td>
                                        <div class="prod-cell">
                                            <img src="images/${p.image}" alt="${p.name}"/>
                                            <span class="prod-name">${p.name}</span>
                                        </div>
                                    </td>
                                    <td>${p.stock_quantity}</td>
                                    <td style="color:#999;">${p.sold_count}</td>
                                    <td>
                                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.sold_count == 0}">
                                                <span class="badge badge-danger">🏷️ Giảm giá gấp</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning">🏷️ Nên giảm giá</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-trophy"></i>
                            <p>Tất cả sản phẩm đều có đơn trong tuần này! 🎉</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- Tab 3: Toàn bộ tồn kho --%>
        <div id="tab-all" class="tab-content">
            <div class="inv-table-wrap">
                <c:choose>
                    <c:when test="${not empty allInventory}">
                        <table class="inv-table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Sản phẩm</th>
                                <th>Danh mục</th>
                                <th>Thương hiệu</th>
                                <th>Tồn kho</th>
                                <th>Tổng đã bán</th>
                                <th>Giá</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="p" items="${allInventory}" varStatus="st">
                                <tr>
                                    <td style="color:#999;">${st.index + 1}</td>
                                    <td>
                                        <div class="prod-cell">
                                            <img src="images/${p.image}" alt="${p.name}"/>
                                            <span class="prod-name">${p.name}</span>
                                        </div>
                                    </td>
                                    <td style="color:#666;">${p.category_name}</td>
                                    <td style="color:#666;">${p.brand_name}</td>
                                    <td>
                                            <span class="${p.stock_quantity == 0 ? 'stock-low' : p.stock_quantity < 10 ? 'stock-low' : 'stock-ok'}">
                                                    ${p.stock_quantity}
                                            </span>
                                    </td>
                                    <td style="color:#666;">${p.sold_count}</td>
                                    <td>
                                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.stock_quantity == 0}">
                                                <span class="badge badge-danger">🚨 Hết hàng</span>
                                            </c:when>
                                            <c:when test="${p.stock_quantity < 10}">
                                                <span class="badge badge-warning">⚠️ Sắp hết</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-success">✅ Còn hàng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-box"></i>
                            <p>Chưa có sản phẩm nào trong hệ thống.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>

<script>
    function switchTab(tabId, btn) {
        document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active-tab'));
        document.getElementById(tabId).classList.add('active');
        btn.classList.add('active-tab');
    }
</script>
</body>
</html>

