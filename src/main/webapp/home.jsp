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
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
          rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
        .featured-section {
            background: #fff;
            padding: 48px 0 60px;
            border-top: 1px solid #f0f0f0;
        }

        .featured-section .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 30px;
        }

        .featured-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 32px;
        }

        .featured-heading h2 {
            font-size: 24px;
            font-weight: 700;
            color: #111;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .featured-heading h2::before {
            content: '';
            display: inline-block;
            width: 5px;
            height: 28px;
            background: #f82c97;
            border-radius: 3px;
        }

        .featured-heading a {
            font-size: 14px;
            font-weight: 600;
            color: #f82c97;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: opacity .2s;
        }

        .featured-heading a:hover {
            opacity: .75;
        }

        /* Grid */
        .fp-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        /* Card */
        .fp-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: box-shadow .25s;
            position: relative;
        }

        .fp-card:hover {
            box-shadow: 0 6px 20px rgba(0, 0, 0, .1);
        }

        /* Badges */
        .fp-badge {
            position: absolute;
            top: 10px;
            font-size: 11px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
            z-index: 2;
        }

        .fp-badge-out {
            left: 10px;
            background: #ef4444;
            color: #fff;
        }

        .fp-badge-hot {
            right: 10px;
            background: #f97316;
            color: #fff;
        }

        /* Image */
        .fp-img-wrap {
            position: relative;
            display: block;
            width: 100%;
            height: 220px;
            background: #f9fafb;
            overflow: hidden;
        }

        .fp-img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 12px;
            transition: transform .3s;
        }

        .fp-card:hover .fp-img-wrap img {
            transform: scale(1.05);
        }

        /* Hover action buttons */
        .fp-hover-actions {
            position: absolute;
            bottom: 10px;
            left: 10px;
            right: 10px;
            display: flex;
            gap: 8px;
            opacity: 0;
            transition: opacity .25s;
        }

        .fp-card:hover .fp-hover-actions {
            opacity: 1;
        }

        .fp-btn-cart {
            flex: 1;
            background: #fff;
            color: #f82c97;
            border: 1.5px solid #f82c97;
            padding: 8px 6px;
            border-radius: 7px;
            font-family: 'Montserrat', sans-serif;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            text-decoration: none;
            transition: background .2s, color .2s;
        }

        .fp-btn-cart:hover {
            background: #fff0f6;
        }

        .fp-btn-detail {
            flex: 1;
            background: #f82c97;
            color: #fff;
            border: 1.5px solid #f82c97;
            padding: 8px 6px;
            border-radius: 7px;
            font-family: 'Montserrat', sans-serif;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            text-decoration: none;
            transition: background .2s;
        }

        .fp-btn-detail:hover {
            background: #d41a82;
            border-color: #d41a82;
        }

        .fp-btn-disabled {
            flex: 1;
            background: #e5e7eb;
            color: #9ca3af;
            border: 1.5px solid #e5e7eb;
            padding: 8px 6px;
            border-radius: 7px;
            font-family: 'Montserrat', sans-serif;
            font-size: 12px;
            font-weight: 600;
            text-align: center;
            cursor: not-allowed;
        }

        /* Info */
        .fp-body {
            padding: 12px 14px 14px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .fp-category {
            font-size: 11px;
            font-weight: 600;
            color: #f82c97;
            text-transform: uppercase;
            letter-spacing: .4px;
        }

        .fp-name {
            font-size: 14px;
            font-weight: 600;
            color: #111;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .fp-name a {
            color: inherit;
            text-decoration: none;
        }

        .fp-name a:hover {
            color: #f82c97;
        }

        .fp-stars {
            display: flex;
            align-items: center;
            gap: 2px;
            font-size: 12px;
            margin-top: 2px;
        }

        .fp-stars .star-full {
            color: #f59e0b;
        }

        .fp-stars .star-half {
            color: #f59e0b;
        }

        .fp-stars .star-empty {
            color: #d1d5db;
        }

        .fp-stars .fp-rc {
            color: #9ca3af;
            font-size: 11px;
            margin-left: 4px;
        }

        .fp-bottom {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 4px;
        }

        .fp-price {
            font-size: 16px;
            font-weight: 700;
            color: #111;
        }

        .fp-sold {
            font-size: 11px;
            color: #9ca3af;
            display: flex;
            align-items: center;
            gap: 3px;
        }

        .fp-sold i {
            color: #f82c97;
        }

        /* Empty */
        .featured-empty {
            text-align: center;
            padding: 60px 20px;
            color: #9ca3af;
        }

        .featured-empty i {
            font-size: 48px;
            margin-bottom: 14px;
            display: block;
        }
    </style>
</head>
<body>
<%@ include file="components/header.jsp" %>

<main class="main-content">
    <!-- Danh mục -->
    <section class="product-categories bg-white">
        <div class="container">
            <div class="category-wrapper" style="position: relative;">
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

    <!-- Sản phẩm nổi bật -->
    <c:if test="${not empty featuredProducts}">
        <section class="featured-section">
            <div class="container">
                <div class="featured-heading">
                    <h2>Sản Phẩm Nổi Bật</h2>
                    <a href="products">Xem tất cả <i class="fas fa-arrow-right"></i></a>
                </div>

                <div class="fp-grid">
                    <c:forEach var="p" items="${featuredProducts}">
                        <div class="fp-card">

                                <%-- Badges --%>
                            <c:if test="${p.stock == 0}">
                                <span class="fp-badge fp-badge-out">Hết hàng</span>
                            </c:if>
                            <c:if test="${p.soldCount >= 10}">
                                <span class="fp-badge fp-badge-hot"><i class="fas fa-fire"></i> Bán chạy</span>
                            </c:if>

                                <%-- Ảnh + hover buttons --%>
                            <a href="product-detail?id=${p.id}" class="fp-img-wrap">
                                <img src="images/${p.image}" alt="${p.name}"
                                     onerror="this.src='images/LogoRemake.png'"/>
                            </a>

                            <div class="fp-hover-actions">
                                <c:choose>
                                    <c:when test="${p.stock == 0}">
                                        <span class="fp-btn-disabled">Hết hàng</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="add-to-cart?productId=${p.id}" class="fp-btn-cart">
                                            <i class="fas fa-cart-plus"></i> Thêm giỏ
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="product-detail?id=${p.id}" class="fp-btn-detail">
                                    <i class="fas fa-eye"></i> Xem
                                </a>
                            </div>

                                <%-- Thông tin --%>
                            <div class="fp-body">
                                <div class="fp-category">${p.category.name}</div>
                                <div class="fp-name">
                                    <a href="product-detail?id=${p.id}">${p.name}</a>
                                </div>

                                <div class="fp-stars">
                                    <c:set var="rating" value="${p.averageRating}"/>
                                    <c:forEach var="i" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${i <= rating}">
                                                <i class="fas fa-star star-full"></i>
                                            </c:when>
                                            <c:when test="${i - 0.5 <= rating}">
                                                <i class="fas fa-star-half-alt star-half"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="far fa-star star-empty"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${p.reviewCount > 0}">
											<span class="fp-rc">
												<fmt:formatNumber value="${p.averageRating}"
                                                                  maxFractionDigits="1"/> (${p.reviewCount})
											</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="fp-rc">Chưa có đánh giá</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="fp-bottom">
                                    <div class="fp-price">
                                        <fmt:formatNumber value="${p.price}" type="number"
                                                          maxFractionDigits="0" groupingUsed="true"/>₫
                                    </div>
                                    <c:if test="${p.soldCount > 0}">
                                        <div class="fp-sold">
                                            <i class="fas fa-shopping-bag"></i>${p.soldCount} đã bán
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
