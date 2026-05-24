<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
        * { box-sizing: border-box; }

        /* ===== SECTION WRAPPER ===== */
        .home-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 30px;
        }
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
        }
        .section-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 20px;
            font-weight: 800;
            color: #111;
            font-family: 'Montserrat', sans-serif;
        }
        .section-title::before {
            content: '';
            width: 4px; height: 22px;
            background: linear-gradient(180deg, #f82c97, #a855f7);
            border-radius: 4px;
            display: inline-block;
            flex-shrink: 0;
        }
        .section-link {
            font-size: 13px; font-weight: 600; color: #f82c97;
            text-decoration: none; display: flex; align-items: center; gap: 4px;
            transition: opacity .2s;
        }
        .section-link:hover { opacity: .7; }

        /* ===== CATEGORY SECTION ===== */
        .cat-section {
            background: #fff;
            padding: 28px 0;
            border-bottom: 1px solid #f3f4f6;
        }

        /* ===== DISCOUNT SECTION ===== */
        .discount-section {
            padding: 52px 0;
            background: linear-gradient(180deg, #fff7fb 0%, #fff 100%);
        }
        .coupon-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 16px;
        }
        .coupon-card {
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            display: flex;
            box-shadow: 0 2px 12px rgba(248,44,151,.08);
            border: 1px solid #fce7f3;
            position: relative;
            transition: box-shadow .2s, transform .2s;
        }
        .coupon-card:hover {
            box-shadow: 0 6px 24px rgba(248,44,151,.15);
            transform: translateY(-2px);
        }
        .coupon-left {
            width: 8px;
            background: linear-gradient(180deg, #f82c97, #a855f7);
            flex-shrink: 0;
        }
        .coupon-body {
            padding: 16px 18px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .coupon-type {
            font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: .6px; color: #a855f7;
        }
        .coupon-code {
            font-size: 20px; font-weight: 800; color: #f82c97;
            letter-spacing: 2px; line-height: 1;
        }
        .coupon-info { font-size: 12px; color: #6b7280; line-height: 1.5; }
        .coupon-info span { display: inline-flex; align-items: center; gap: 4px; }
.coupon-action {
            display: flex;
            align-items: center;
            padding: 0 18px;
            border-left: 1.5px dashed #fce7f3;
            flex-shrink: 0;
        }
        .coupon-save-btn {
            background: none; border: none; cursor: pointer;
            display: flex; flex-direction: column; align-items: center; gap: 4px;
            color: #f82c97; font-size: 11px; font-weight: 700;
            padding: 8px; border-radius: 8px;
            transition: background .2s;
        }
        .coupon-save-btn:hover { background: #fff0f6; }
        .coupon-save-btn i { font-size: 18px; }
        .coupon-save-btn:disabled { color: #9ca3af; cursor: not-allowed; }
        .coupon-save-btn:disabled:hover { background: none; }

        /* ===== FEATURED PRODUCTS ===== */
        .featured-section {
            padding: 52px 0 64px;
            background: #fff;
        }
        .fp-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(210px, 1fr));
            gap: 20px;
        }
        .fp-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: box-shadow .25s, transform .25s;
            position: relative;
        }
        .fp-card:hover {
            box-shadow: 0 8px 28px rgba(0,0,0,.1);
            transform: translateY(-3px);
        }
        .fp-badge {
            position: absolute; top: 10px;
            font-size: 10px; font-weight: 700;
            padding: 3px 8px; border-radius: 50px; z-index: 2;
        }
        .fp-badge-out { left: 10px; background: #ef4444; color: #fff; }
        .fp-badge-hot { right: 10px; background: linear-gradient(135deg,#f97316,#ef4444); color: #fff; }
        .fp-img-wrap {
            position: relative; display: block;
            width: 100%; height: 210px;
            background: #f9fafb; overflow: hidden;
        }
        .fp-img-wrap img {
            width: 100%; height: 100%; object-fit: contain;
            padding: 14px; transition: transform .35s;
        }
        .fp-card:hover .fp-img-wrap img { transform: scale(1.07); }
        .fp-hover-actions {
            position: absolute; bottom: 10px; left: 10px; right: 10px;
            display: flex; gap: 8px; opacity: 0; transition: opacity .25s;
        }
        .fp-card:hover .fp-hover-actions { opacity: 1; }
        .fp-btn-cart {
            flex: 1; background: rgba(255,255,255,.95); color: #f82c97;
            border: 1.5px solid #f82c97; padding: 8px 6px; border-radius: 8px;
            font-family: 'Montserrat', sans-serif; font-size: 12px; font-weight: 600;
            cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 4px;
            text-decoration: none; transition: background .2s;
            backdrop-filter: blur(4px);
        }
        .fp-btn-cart:hover { background: #fff0f6; }
        .fp-btn-detail {
            flex: 1; background: linear-gradient(135deg,#f82c97,#a855f7); color: #fff;
            border: none; padding: 8px 6px; border-radius: 8px;
            font-family: 'Montserrat', sans-serif; font-size: 12px; font-weight: 600;
            cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 4px;
            text-decoration: none; transition: opacity .2s;
        }
        .fp-btn-detail:hover { opacity: .88; }
        .fp-btn-disabled {
            flex: 1; background: #e5e7eb; color: #9ca3af;
            border: 1.5px solid #e5e7eb; padding: 8px 6px; border-radius: 8px;
            font-family: 'Montserrat', sans-serif; font-size: 12px; font-weight: 600;
            text-align: center; cursor: not-allowed;
        }
        .fp-body {
            padding: 12px 14px 16px;
            flex: 1; display: flex; flex-direction: column; gap: 5px;
        }
        .fp-category {
            font-size: 10px; font-weight: 700; color: #a855f7;
            text-transform: uppercase; letter-spacing: .5px;
        }
        .fp-name {
            font-size: 13px; font-weight: 600; color: #111; line-height: 1.4;
            display: -webkit-box; -webkit-line-clamp: 2;
            -webkit-box-orient: vertical; overflow: hidden;
        }
        .fp-name a { color: inherit; text-decoration: none; }
        .fp-name a:hover { color: #f82c97; }
        .fp-stars { display: flex; align-items: center; gap: 2px; font-size: 11px; margin-top: 2px; }
        .star-full, .star-half { color: #f59e0b; }
        .star-empty { color: #d1d5db; }
        .fp-rc { color: #9ca3af; font-size: 10px; margin-left: 4px; }
        .fp-bottom {
            display: flex; align-items: center; justify-content: space-between; margin-top: 6px;
        }
        .fp-price { font-size: 15px; font-weight: 800; color: #f82c97; }
        .fp-sold { font-size: 10px; color: #9ca3af; display: flex; align-items: center; gap: 3px; }

        /* Toast */
        #discount-toast {
            display: none; position: fixed; bottom: 24px; right: 24px; z-index: 9999;
            background: #111; color: #fff; padding: 12px 22px;
            border-radius: 12px; font-size: 14px; font-weight: 600;
            box-shadow: 0 4px 20px rgba(0,0,0,.25); transition: opacity .3s;
        }
    </style>
</head>
<body>
<%@ include file="components/header.jsp" %>

<main class="main-content">

    <%-- ===== DANH MỤC ===== --%>
    <section class="cat-section">
        <div class="home-section">
            <div class="category-wrapper" style="position:relative;">
                <button class="nav-btn prev-btn" id="btnPrev">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <div class="category-grid" id="categoryList">
                    <c:forEach items="${listCategories}" var="cate">
                        <a href="products?category=${cate.name}" class="category-item">
                            <i class="${cate.icon}"></i> <span>${cate.name}</span>
                        </a>
                    </c:forEach>
                </div>
                <button class="nav-btn next-btn" id="btnNext">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </section>

    <%-- ===== MÃ GIẢM GIÁ ===== --%>
    <c:if test="${not empty activeDiscounts}">
    <section class="discount-section" id="discounts">
        <div id="discount-toast"></div>
        <div class="home-section">
            <div class="section-header">
                <h2 class="section-title">Ưu Đãi Hôm Nay</h2>
            </div>
            <div class="coupon-grid">
                <c:forEach var="d" items="${activeDiscounts}">
                    <c:set var="alreadySaved" value="${not empty savedDiscountIds and savedDiscountIds.contains(d.id)}"/>
                    <div class="coupon-card">
                        <div class="coupon-left"></div>
                        <div class="coupon-body">
                            <div class="coupon-type">
                                <c:choose>
                                    <c:when test="${d.discountType eq 'PERCENT'}"><i class="fas fa-percent"></i> Giảm ${d.discountValue}%</c:when>
                                    <c:otherwise><i class="fas fa-tag"></i> Giảm <fmt:formatNumber value="${d.discountValue}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="coupon-code">${d.code}</div>
                            <div class="coupon-info">
                                <span><i class="fas fa-receipt" style="color:#f9a8d4;"></i> Đơn từ <fmt:formatNumber value="${d.minOrderValue}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫</span>
                                <c:if test="${d.expiresAt != null}">
                                    &nbsp;·&nbsp; <span><i class="fas fa-calendar" style="color:#f9a8d4;"></i> HSD: <fmt:formatDate value="${d.expiresAt}" pattern="dd/MM/yy"/></span>
                                </c:if>
                            </div>
                        </div>
                        <div class="coupon-action">
                            <c:choose>
                                <c:when test="${alreadySaved}">
                                    <button class="coupon-save-btn" disabled>
                                        <i class="fas fa-check" style="color:#10b981;"></i>
                                        <span style="color:#10b981;">Đã lưu</span>
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="coupon-save-btn" onclick="saveDiscount(this, ${d.id})">
                                        <i class="fas fa-bookmark"></i>
                                        <span>Lưu mã</span>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
    <script>
    function saveDiscount(btn, discountId) {
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>Đang lưu</span>';
        fetch('save-discount', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'discountId=' + discountId
        })
        .then(r => r.json())
        .then(data => {
            if (data.status === 'ok') {
                btn.innerHTML = '<i class="fas fa-check" style="color:#10b981;"></i><span style="color:#10b981;">Đã lưu</span>';
                showDiscountToast('Đã lưu mã thành công!');
            } else if (data.status === 'already') {
                btn.innerHTML = '<i class="fas fa-check" style="color:#10b981;"></i><span style="color:#10b981;">Đã lưu</span>';
            } else {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-bookmark"></i><span>Lưu mã</span>';
                if (data.message && data.message.includes('đăng nhập')) {
                    window.location.href = 'login';
                } else {
                    showDiscountToast(data.message || 'Có lỗi xảy ra!');
                }
            }
        })
        .catch(() => { btn.disabled = false; btn.innerHTML = '<i class="fas fa-bookmark"></i><span>Lưu mã</span>'; });
    }
    function showDiscountToast(msg) {
        var t = document.getElementById('discount-toast');
        t.innerText = msg;
        t.style.display = 'block';
        t.style.opacity = '1';
        setTimeout(() => { t.style.opacity = '0'; setTimeout(() => t.style.display = 'none', 300); }, 2500);
    }
    </script>
    </c:if>

    <%-- ===== SẢN PHẨM NỔI BẬT ===== --%>
    <c:if test="${not empty featuredProducts}">
    <section class="featured-section">
        <div class="home-section">
            <div class="section-header">
                <h2 class="section-title">Sản Phẩm Nổi Bật</h2>
                <a href="products" class="section-link">Xem tất cả <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="fp-grid">
                <c:forEach var="p" items="${featuredProducts}">
                <div class="fp-card">
                    <c:if test="${p.stock == 0}">
                        <span class="fp-badge fp-badge-out">Hết hàng</span>
                    </c:if>
                    <c:if test="${p.soldCount >= 10}">
                        <span class="fp-badge fp-badge-hot"><i class="fas fa-fire"></i> Hot</span>
                    </c:if>

                    <a href="product-detail?id=${p.id}" class="fp-img-wrap">
                        <img src="images/${p.image}" alt="${p.name}" onerror="this.src='images/LogoRemake.png'"/>
                    </a>

                    <div class="fp-hover-actions">
                        <c:choose>
                            <c:when test="${p.stock == 0}">
                                <span class="fp-btn-disabled">Hết hàng</span>
                            </c:when>
                            <c:otherwise>
                                <a href="add-to-cart?id=${p.id}" class="fp-btn-cart">
                                    <i class="fas fa-cart-plus"></i> Thêm giỏ
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <a href="product-detail?id=${p.id}" class="fp-btn-detail">
                            <i class="fas fa-eye"></i> Xem
                        </a>
                    </div>

                    <div class="fp-body">
                        <div class="fp-category">${p.category.name}</div>
                        <div class="fp-name">
                            <a href="product-detail?id=${p.id}">${p.name}</a>
                        </div>
                        <div class="fp-stars">
                            <c:set var="rating" value="${p.averageRating}"/>
                            <c:forEach var="i" begin="1" end="5">
                                <c:choose>
                                    <c:when test="${i <= rating}"><i class="fas fa-star star-full"></i></c:when>
                                    <c:when test="${i - 0.5 <= rating}"><i class="fas fa-star-half-alt star-half"></i></c:when>
                                    <c:otherwise><i class="far fa-star star-empty"></i></c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${p.reviewCount > 0}">
                                    <span class="fp-rc"><fmt:formatNumber value="${p.averageRating}" maxFractionDigits="1"/> (${p.reviewCount})</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="fp-rc">Chưa có đánh giá</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="fp-bottom">
                            <div class="fp-price">
                                <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫
                            </div>
                            <c:if test="${p.soldCount > 0}">
                                <div class="fp-sold">
                                    <i class="fas fa-shopping-bag" style="color:#f82c97;"></i>${p.soldCount} đã bán
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
    </section>
    </c:if>

</main>

<%@ include file="components/footer.jsp" %>
</body>
</html>
