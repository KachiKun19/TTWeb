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
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.page-header h2 { font-size: 24px; color: #2d7e7e; }

.alert {
    padding: 15px; border-radius: 6px; margin-bottom: 20px;
    display: flex; align-items: center; gap: 10px;
}
.alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
.alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

/* Main card */
.card {
    background: white; border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,.05); overflow: hidden;
}
.card-header {
    background: #f0f7f7; padding: 14px 20px;
    border-bottom: 2px solid #e0f0f0;
    font-weight: 600; color: #2d7e7e; font-size: 16px;
    display: flex; align-items: center; gap: 8px;
}
.card-header span { font-weight: 400; font-size: 13px; color: #666; }

/* ── Tab bar (kiểu category home page) ─────────────────────────── */
.tab-wrapper {
    background: #fafafa;
    border-bottom: 1px solid #eee;
    padding: 16px 20px;
}

.tab-bar {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
}

.tab-btn {
    flex: 1;
    min-width: 100px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 10px;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    padding: 16px 12px;
    background: white;
    cursor: pointer;
    font-family: 'Montserrat', sans-serif;
    font-size: 12px;
    font-weight: 600;
    color: #333;
    transition: .25s;
    text-align: center;
    line-height: 1.3;
}

.tab-btn i {
    font-size: 2rem;
    color: #001f3f;
    transition: .25s;
}

.tab-btn:hover { border-color: #2d7e7e; color: #2d7e7e; }
.tab-btn:hover i { color: #2d7e7e; transform: scale(1.1); }

.tab-btn.active {
    background: #2d7e7e;
    border-color: #2d7e7e;
    color: white;
}
.tab-btn.active i { color: white; }

/* Search */
.search-bar { padding: 12px 20px; border-bottom: 1px solid #eee; }
.search-bar input {
    width: 100%; padding: 9px 14px; border: 1px solid #ddd;
    border-radius: 6px; font-size: 14px;
    font-family: 'Montserrat', sans-serif;
}
.search-bar input:focus { outline: none; border-color: #2d7e7e; }

/* Product grid */
.products-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 16px;
    padding: 20px;
    min-height: 80px;
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
    width: 100%; height: 130px; object-fit: contain;
    border-radius: 6px; background: #f8f8f8;
}
.product-card-name { font-weight: 600; font-size: 13px; color: #333; line-height: 1.4; }
.product-card-meta { font-size: 11px; color: #777; }
.product-card-price { font-weight: 700; color: #e74c3c; font-size: 14px; }
.card-actions { display: flex; gap: 8px; margin-top: auto; }

.btn-add {
    flex: 1; background: linear-gradient(135deg, #2d7e7e, #1a5c5c);
    color: white; border: none; padding: 8px 12px;
    border-radius: 6px; cursor: pointer;
    font-family: 'Montserrat', sans-serif; font-weight: 500; font-size: 12px;
    display: flex; align-items: center; justify-content: center; gap: 5px;
    transition: .3s;
}
.btn-add:hover { opacity: .85; }

.btn-remove {
    flex: 1; background: #f5576c; color: white; border: none;
    padding: 8px 12px; border-radius: 6px; cursor: pointer;
    font-family: 'Montserrat', sans-serif; font-weight: 500; font-size: 12px;
    display: flex; align-items: center; justify-content: center; gap: 5px;
    transition: .3s;
}
.btn-remove:hover { background: #e4465a; }

/* Pagination */
.pagination-controls {
    display: flex; align-items: center; justify-content: center;
    gap: 12px; padding: 16px 20px;
    border-top: 1px solid #eee;
}
.page-btn {
    background: #2d7e7e; color: white; border: none;
    padding: 7px 18px; border-radius: 6px; cursor: pointer;
    font-family: 'Montserrat', sans-serif; font-weight: 500; font-size: 13px;
    display: flex; align-items: center; gap: 6px; transition: .3s;
}
.page-btn:hover:not(:disabled) { background: #1a5c5c; }
.page-btn:disabled { background: #ccc; cursor: not-allowed; opacity: .7; }
.page-info { font-size: 14px; color: #555; font-weight: 600; min-width: 70px; text-align: center; }

.empty-state { text-align: center; padding: 50px; color: #999; grid-column: 1/-1; }
.empty-state i { font-size: 40px; margin-bottom: 12px; display: block; }

/* Toast */
.toast {
    position: fixed; top: 24px; right: 24px;
    padding: 13px 18px; border-radius: 8px;
    font-size: 13px; font-weight: 600;
    display: flex; align-items: center; gap: 9px;
    z-index: 9999; opacity: 0; transform: translateY(-8px);
    transition: opacity .25s, transform .25s;
    box-shadow: 0 4px 16px rgba(0,0,0,.15);
    pointer-events: none;
}
.toast.show { opacity: 1; transform: translateY(0); }
.toast-success { background: #d4edda; color: #155724; }
.toast-error   { background: #f8d7da; color: #721c24; }
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
                <i class="fas fa-list"></i> Tất cả sản phẩm
                <span>— Viền xanh = đang hiển thị nổi bật trên trang chủ</span>
            </div>

            <%-- Tab bar: giống category section ở home page --%>
            <div class="tab-wrapper">
                <div class="tab-bar" id="tabBar">
                    <%-- Tab "Tất cả" --%>
                    <button class="tab-btn active" data-cat="" onclick="selectTab('', this)">
                        <i class="fas fa-th-large"></i>
                        <span>Tất cả</span>
                    </button>

                    <%-- Một tab cho mỗi danh mục, dùng icon từ Category --%>
                    <c:forEach var="entry" items="${productsByCategory}">
                        <button class="tab-btn" data-cat="${entry.key}" onclick="selectTab('${entry.key}', this)">
                            <i class="${entry.value[0].category.icon}"></i>
                            <span>${entry.key}</span>
                        </button>
                    </c:forEach>
                </div>
            </div>

            <div class="search-bar">
                <input type="text" id="searchInput" placeholder="Tìm kiếm theo tên, thương hiệu..." oninput="onSearch()" />
            </div>

            <div class="products-grid" id="productsGrid">
                <c:choose>
                    <c:when test="${empty productsByCategory}">
                        <div class="empty-state">
                            <i class="fas fa-box-open"></i>
                            <p>Chưa có sản phẩm nào trong hệ thống.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="entry" items="${productsByCategory}">
                            <c:forEach var="p" items="${entry.value}">
                                <c:set var="isFeatured" value="false" />
                                <c:forEach var="fid" items="${featuredIds}">
                                    <c:if test="${fid == p.id}"><c:set var="isFeatured" value="true" /></c:if>
                                </c:forEach>

                                <div class="product-card ${isFeatured ? 'is-featured' : ''}"
                                     data-name="${p.name}"
                                     data-brand="${p.brand.name}"
                                     data-cat="${p.category.name}">

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
                                                <button class="btn-remove" style="width:100%;"
                                                        onclick="toggleFeatured(this,${p.id},'remove')">
                                                    <i class="fas fa-times"></i> Bỏ nổi bật
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn-add" style="width:100%;"
                                                        onclick="toggleFeatured(this,${p.id},'add')">
                                                    <i class="fas fa-star"></i> Thêm nổi bật
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="pagination-controls" id="paginationEl" style="display:none;">
                <button class="page-btn" id="prevBtn" onclick="goPage(-1)">
                    <i class="fas fa-chevron-left"></i> Trước
                </button>
                <span class="page-info" id="pageInfo">1 / 1</span>
                <button class="page-btn" id="nextBtn" onclick="goPage(1)">
                    Sau <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    const PAGE_SIZE = 4;
    const grid      = document.getElementById('productsGrid');
    const tabBar    = document.getElementById('tabBar');
    const pagEl     = document.getElementById('paginationEl');
    const prevBtn   = document.getElementById('prevBtn');
    const nextBtn   = document.getElementById('nextBtn');
    const pageInfo  = document.getElementById('pageInfo');

    const allCards = Array.from(grid.querySelectorAll('.product-card'));
    let activeCat  = '';
    let searchQ    = '';
    let currentPage = 0;

    // ── Tab click ──────────────────────────────────────────────────
    window.selectTab = function (cat, btn) {
        activeCat   = cat;
        currentPage = 0;
        tabBar.querySelectorAll('.tab-btn').forEach(t => t.classList.remove('active'));
        btn.classList.add('active');
        render();
    };

    // ── Search ─────────────────────────────────────────────────────
    window.onSearch = function () {
        searchQ     = document.getElementById('searchInput').value.toLowerCase().trim();
        currentPage = 0;
        render();
    };

    // ── Pagination ─────────────────────────────────────────────────
    window.goPage = function (delta) {
        const total = Math.max(1, Math.ceil(getFiltered().length / PAGE_SIZE));
        currentPage = Math.max(0, Math.min(total - 1, currentPage + delta));
        render();
    };

    // ── Core logic ─────────────────────────────────────────────────
    function getFiltered() {
        return allCards.filter(card => {
            const catOk    = !activeCat || card.dataset.cat === activeCat;
            const text     = (card.dataset.name + ' ' + card.dataset.brand + ' ' + card.dataset.cat).toLowerCase();
            const searchOk = !searchQ || text.includes(searchQ);
            return catOk && searchOk;
        });
    }

    function render() {
        const filtered    = getFiltered();
        const totalPages  = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
        currentPage       = Math.min(currentPage, totalPages - 1);

        // Hide all, then show current page slice
        allCards.forEach(c => c.style.display = 'none');
        const pageSlice = filtered.slice(currentPage * PAGE_SIZE, (currentPage + 1) * PAGE_SIZE);
        pageSlice.forEach(c => c.style.display = '');

        // Điều chỉnh số cột = số card hiển thị trên trang (tối đa 4)
        grid.style.gridTemplateColumns = 'repeat(' + (Math.min(pageSlice.length, 4) || 1) + ', 1fr)';

        // Pagination
        if (totalPages <= 1) {
            pagEl.style.display = 'none';
        } else {
            pagEl.style.display   = 'flex';
            prevBtn.disabled      = currentPage === 0;
            nextBtn.disabled      = currentPage >= totalPages - 1;
            pageInfo.textContent  = (currentPage + 1) + ' / ' + totalPages;
        }
    }

    render();

    setTimeout(() => {
        document.querySelectorAll('.alert').forEach(a => a.style.display = 'none');
    }, 4000);

    // ── AJAX toggle featured ───────────────────────────────────────
    window.toggleFeatured = async function (btn, productId, action) {
        btn.disabled  = true;
        const saved   = btn.innerHTML;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';

        try {
            const body = new URLSearchParams();
            body.append('action', action);
            body.append('productId', productId);

            const res = await fetch('adminFeaturedProducts', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body.toString()
            });

            if (res.url.includes('success=')) {
                const card = btn.closest('.product-card');
                if (action === 'add') {
                    card.classList.add('is-featured');
                    btn.className = 'btn-remove';
                    btn.innerHTML = '<i class="fas fa-times"></i> Bỏ nổi bật';
                    btn.onclick   = function () { toggleFeatured(this, productId, 'remove'); };
                    if (!card.querySelector('.featured-badge')) {
                        const badge = document.createElement('span');
                        badge.className = 'featured-badge';
                        badge.innerHTML = '<i class="fas fa-star"></i> Nổi bật';
                        card.insertBefore(badge, card.firstChild);
                    }
                    showToast('Đã thêm sản phẩm nổi bật!', 'success');
                } else {
                    card.classList.remove('is-featured');
                    btn.className = 'btn-add';
                    btn.innerHTML = '<i class="fas fa-star"></i> Thêm nổi bật';
                    btn.onclick   = function () { toggleFeatured(this, productId, 'add'); };
                    const badge = card.querySelector('.featured-badge');
                    if (badge) badge.remove();
                    showToast('Đã bỏ sản phẩm nổi bật!', 'success');
                }
            } else {
                btn.innerHTML = saved;
                showToast('Có lỗi xảy ra! Vui lòng thử lại.', 'error');
            }
        } catch (e) {
            btn.innerHTML = saved;
            showToast('Lỗi kết nối!', 'error');
        } finally {
            btn.disabled = false;
        }
    };

    // ── Toast ──────────────────────────────────────────────────────
    function showToast(msg, type) {
        const t = document.createElement('div');
        t.className = 'toast toast-' + type;
        t.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + msg;
        document.body.appendChild(t);
        requestAnimationFrame(() => t.classList.add('show'));
        setTimeout(() => {
            t.classList.remove('show');
            setTimeout(() => t.remove(), 300);
        }, 2800);
    }
})();
</script>
</body>
</html>
