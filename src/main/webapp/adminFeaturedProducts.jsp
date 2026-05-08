<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sản Phẩm Nổi Bật - Kachi-Kun Shop</title>
<link rel="icon" type="image/png" href="images/LogoRemake.png" />
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
<link
    href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap"
    rel="stylesheet">
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Montserrat', sans-serif; background: #f5f7fa; color: #333; line-height: 1.6; }

.admin-header {
    background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
    color: white; padding: 20px 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,.1);
    display: flex; justify-content: space-between; align-items: center;
}
.admin-header h1 { font-size: 24px; font-weight: 600; }
.user-info { display: flex; align-items: center; gap: 15px; }
.user-avatar {
    width: 40px; height: 40px; border-radius: 50%;
    background: rgba(255,255,255,.2); display: flex;
    align-items: center; justify-content: center; font-size: 18px;
}
.logout-btn {
    background: rgba(255,255,255,.2); border: none; color: white;
    padding: 8px 16px; border-radius: 4px; cursor: pointer;
    font-family: 'Montserrat', sans-serif; font-weight: 500; transition: .3s;
}
.logout-btn:hover { background: rgba(255,255,255,.3); }

.admin-container { display: flex; min-height: calc(100vh - 80px); }
.sidebar { width: 250px; background: white; padding: 20px 0; box-shadow: 2px 0 8px rgba(0,0,0,.05); }
.sidebar-menu { list-style: none; }
.sidebar-menu a {
    display: flex; align-items: center; padding: 15px 25px;
    color: #555; text-decoration: none; transition: .3s;
    border-left: 4px solid transparent;
}
.sidebar-menu a:hover { background: #f0f7f7; color: #2d7e7e; border-left-color: #2d7e7e; }
.sidebar-menu a.active { background: #e8f4f4; color: #2d7e7e; border-left-color: #2d7e7e; font-weight: 600; }
.sidebar-menu i { width: 24px; margin-right: 12px; text-align: center; }

.main-content { flex: 1; padding: 30px; }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
.page-header h2 { font-size: 24px; color: #2d7e7e; }

.alert {
    padding: 15px; border-radius: 6px; margin-bottom: 20px;
    display: flex; align-items: center; gap: 10px;
}
.alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
.alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

.card {
    background: white; border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,.05); margin-bottom: 30px;
    overflow: hidden;
}
.card-header {
    background: #f0f7f7; padding: 15px 20px;
    border-bottom: 2px solid #e0f0f0;
    font-weight: 600; color: #2d7e7e; font-size: 16px;
    display: flex; align-items: center; gap: 8px;
}

.products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 16px; padding: 20px;
}

.product-card {
    border: 2px solid #e8e8e8; border-radius: 8px; padding: 16px;
    display: flex; flex-direction: column; gap: 10px;
    transition: .3s; position: relative;
}
.product-card.is-featured { border-color: #2d7e7e; background: #f0fafa; }
.product-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,.1); }

.featured-badge {
    position: absolute; top: 10px; right: 10px;
    background: #2d7e7e; color: white;
    font-size: 11px; font-weight: 600;
    padding: 3px 8px; border-radius: 20px;
}

.product-card-img {
    width: 100%; height: 140px; object-fit: contain;
    border-radius: 6px; background: #f8f8f8;
}
.product-card-name { font-weight: 600; font-size: 14px; color: #333; line-height: 1.4; }
.product-card-meta { font-size: 12px; color: #777; }
.product-card-price { font-weight: 700; color: #e74c3c; font-size: 15px; }

.card-actions { display: flex; gap: 8px; margin-top: auto; }

.btn-add {
    flex: 1; background: linear-gradient(135deg, #2d7e7e, #1a5c5c);
    color: white; border: none; padding: 8px 12px;
    border-radius: 6px; cursor: pointer;
    font-family: 'Montserrat', sans-serif; font-weight: 500; font-size: 13px;
    display: flex; align-items: center; justify-content: center; gap: 5px;
    transition: .3s;
}
.btn-add:hover { opacity: .85; }

.btn-remove {
    flex: 1; background: #f5576c; color: white; border: none;
    padding: 8px 12px; border-radius: 6px; cursor: pointer;
    font-family: 'Montserrat', sans-serif; font-weight: 500; font-size: 13px;
    display: flex; align-items: center; justify-content: center; gap: 5px;
    transition: .3s;
}
.btn-remove:hover { background: #e4465a; }


.search-bar {
    padding: 15px 20px; border-bottom: 1px solid #eee;
}
.search-bar input {
    width: 100%; padding: 10px 14px; border: 1px solid #ddd;
    border-radius: 6px; font-size: 14px;
    font-family: 'Montserrat', sans-serif;
}
.search-bar input:focus { outline: none; border-color: #2d7e7e; }

.empty-state { text-align: center; padding: 40px; color: #999; }
.empty-state i { font-size: 40px; margin-bottom: 12px; }
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
            <div style="font-size:12px;opacity:.9;">Quản trị viên</div>
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
            <li><a href="adminOrders"><i class="fas fa-shopping-cart"></i> Quản lý đơn hàng</a></li>
            <li><a href="adminContacts"><i class="fas fa-envelope"></i> Quản lý liên hệ</a></li>
            <li><a href="adminDiscounts"><i class="fas fa-tag"></i> Mã giảm giá</a></li>
            <li><a href="adminFeaturedProducts" class="active"><i class="fas fa-star"></i> Sản phẩm nổi bật</a></li>
            <li><a href="home"><i class="fas fa-store"></i> Về trang cửa hàng</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="page-header">
            <h2><i class="fas fa-star"></i> Quản Lý Sản Phẩm Nổi Bật</h2>
        </div>

        <c:if test="${param.success eq 'added'}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> Đã thêm sản phẩm vào danh sách nổi bật!</div>
        </c:if>
        <c:if test="${param.success eq 'removed'}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> Đã xóa sản phẩm khỏi danh sách nổi bật!</div>
        </c:if>
        <c:if test="${param.error eq 'add_failed'}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Không thể thêm. Sản phẩm có thể đã có trong danh sách!</div>
        </c:if>
        <c:if test="${param.error eq 'remove_failed'}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> Không thể xóa sản phẩm!</div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <i class="fas fa-list"></i>
                Tất cả sản phẩm
                <span style="font-weight:400; font-size:13px; color:#666; margin-left:8px;">
                    — Sản phẩm có viền xanh đang được hiển thị nổi bật trên trang chủ
                </span>
            </div>
            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Tìm kiếm sản phẩm..." oninput="filterCards()" />
            </div>

            <c:choose>
                <c:when test="${empty allProducts}">
                    <div class="empty-state">
                        <i class="fas fa-box-open"></i>
                        <p>Chưa có sản phẩm nào trong hệ thống.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="products-grid" id="productsGrid">
                        <c:forEach var="p" items="${allProducts}">
                            <c:set var="isFeatured" value="false" />
                            <c:forEach var="fid" items="${featuredIds}">
                                <c:if test="${fid == p.id}"><c:set var="isFeatured" value="true" /></c:if>
                            </c:forEach>

                            <div class="product-card ${isFeatured ? 'is-featured' : ''}"
                                 data-name="${p.name}" data-brand="${p.brand.name}" data-cat="${p.category.name}">

                                <c:if test="${isFeatured}">
                                    <span class="featured-badge"><i class="fas fa-star"></i> Nổi bật</span>
                                </c:if>

                                <c:choose>
                                    <c:when test="${not empty p.image}">
                                        <img class="product-card-img" src="images/${p.image}" alt="${p.name}"
                                             onerror="this.src='images/LogoRemake.png'">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="product-card-img" src="images/LogoRemake.png" alt="No image">
                                    </c:otherwise>
                                </c:choose>

                                <div class="product-card-name">${p.name}</div>
                                <div class="product-card-meta">
                                    <i class="fas fa-tag"></i> ${p.category.name} &nbsp;|&nbsp;
                                    <i class="fas fa-industry"></i> ${p.brand.name}
                                </div>
                                <div class="product-card-price">
                                    <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0" groupingUsed="true" /> ₫
                                </div>

                                <div class="card-actions">
                                    <c:choose>
                                        <c:when test="${isFeatured}">
                                            <form method="post" action="adminFeaturedProducts" style="flex:1;">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="productId" value="${p.id}">
                                                <button type="submit" class="btn-remove" style="width:100%;">
                                                    <i class="fas fa-times"></i> Bỏ nổi bật
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form method="post" action="adminFeaturedProducts" style="flex:1;">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productId" value="${p.id}">
                                                <button type="submit" class="btn-add" style="width:100%;">
                                                    <i class="fas fa-star"></i> Thêm nổi bật
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
function filterCards() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#productsGrid .product-card').forEach(card => {
        const text = (card.dataset.name + ' ' + card.dataset.brand + ' ' + card.dataset.cat).toLowerCase();
        card.style.display = text.includes(q) ? '' : 'none';
    });
}

setTimeout(() => {
    document.querySelectorAll('.alert').forEach(a => a.style.display = 'none');
}, 4000);
</script>
</body>
</html>
