<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm - Phong Cách Xanh Clone</title>
    <link rel="stylesheet" href="CSS/home.css">
    <link rel="stylesheet" href="CSS/Products.css">

</head>
<body>
    <header class="header">
    <div class="header-content">
        <div class="logo-section">
    <a href="home" style="text-decoration: none; display: flex; align-items: center; color: inherit;">
        <img src="https://ih1.redbubble.net/image.2333101821.2174/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg" alt="logo">
        <span class="font-semibold">Asuka</span>
    </a>
</div>
        
        <nav class="nav">
            <!-- Gaming Gear Dropdown -->
            <div class="nav-item group">
                <a href="#" class="nav-link">
                    Gaming Gear
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </a>
                <div class="dropdown">
                    <a href="products?category=1" class="dropdown-link">Chuột Gaming</a>
                    <a href="products?category=2" class="dropdown-link">Bàn phím Cơ</a>
                    <a href="products?category=3" class="dropdown-link">Tai nghe</a>
                    <a href="products?category=4" class="dropdown-link">Lót chuột</a>
                    <a href="products?category=5" class="dropdown-link">Ghế Gaming</a>
                </div>
            </div>
            
            <!-- Office Gear Dropdown -->
            <div class="nav-item group">
                <a href="#" class="nav-link">
                    Office Gear
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </a>
                <div class="dropdown">
                    <a href="#" class="dropdown-link">Bàn làm việc</a>
                    <a href="#" class="dropdown-link">Ghế văn phòng</a>
                    <a href="#" class="dropdown-link">Đèn bàn</a>
                    <a href="#" class="dropdown-link">Phụ kiện văn phòng</a>
                </div>
            </div>
            
            <!-- Góc game thủ Dropdown -->
            <div class="nav-item group">
                <a href="#" class="nav-link">
                    Góc game thủ
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </a>
                <div class="dropdown">
                    <a href="#" class="dropdown-link">Review sản phẩm</a>
                    <a href="#" class="dropdown-link">Hướng dẫn setup</a>
                    <a href="#" class="dropdown-link">Tin tức gaming</a>
                    <a href="#" class="dropdown-link">E-sports</a>
                </div>
            </div>
            
            <!-- Các mục menu không có dropdown -->
            <a href="#" class="nav-link">Sản phẩm 2N</a>
            <a href="#" class="nav-link">Tích điểm</a>
            <a href="#" class="nav-link">Liên hệ</a>
        </nav>
        
        <div class="header-icons">
            <!-- Icon tài khoản -->
            <div class="icon-group group">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="icon">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
                </svg>
                <div class="dropdown group-hover-opacity-100 group-hover-visible">
                    <a href="#" class="dropdown-link">Đăng nhập</a>
                    <a href="#" class="dropdown-link">Đăng ký</a>
                    <div class="border-t my-1"></div>
                    <a href="#" class="dropdown-link">Tài khoản của tôi</a>
                    <a href="#" class="dropdown-link">Đơn hàng</a>
                    <a href="#" class="dropdown-link">Đăng xuất</a>
                </div>
            </div>
            
            <!-- Icon tìm kiếm -->
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="icon">
                <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
            </svg>
            
            <!-- Icon giỏ hàng -->
            <div class="icon-group relative">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="icon">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 1 0-7.5 0v4.5m11.356-1.993 1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 0 1-1.12-1.243l1.264-12A1.125 1.125 0 0 1 5.513 7.5h12.974c.576 0 1.059.435 1.119 1.007ZM8.625 10.5a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm7.5 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
                </svg>
            </div>
        </div>
    </div>
</header>

    <div class="products-page">
        <h1 class="page-title">Sản phẩm</h1>
        
        <div class="products-container">
            <!-- Filter sidebar -->
            <aside class="filter-sidebar">
                <div class="filter-card">
                    <div class="filter-header">Bộ lọc</div>
                    <form action="products" method="get" class="filter-content">
                        <!-- Category filter -->
                        <div class="filter-group">
                            <div class="filter-group-title">Danh mục</div>
                            <div class="filter-option">
                                <input type="checkbox" id="cat-all" name="category" value="all" checked>
                                <label for="cat-all">Tất cả danh mục</label>
                            </div>
                            <c:forEach var="category" items="${categories}">
                                <div class="filter-option">
                                    <input type="checkbox" id="cat-${category.categoryId}" name="category" value="${category.categoryId}">
                                    <label for="cat-${category.categoryId}">${category.categoryName}</label>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Brand filter -->
                        <div class="filter-group">
                            <div class="filter-group-title">Thương hiệu</div>
                            <div class="filter-option">
                                <input type="checkbox" id="brand-all" name="brand" value="all" checked>
                                <label for="brand-all">Tất cả thương hiệu</label>
                            </div>
                            <c:forEach var="brand" items="${brands}">
                                <div class="filter-option">
                                    <input type="checkbox" id="brand-${brand.brandId}" name="brand" value="${brand.brandId}">
                                    <label for="brand-${brand.brandId}">${brand.brandName}</label>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Price filter -->
                        <div class="filter-group">
                            <div class="filter-group-title">Khoảng giá</div>
                            <div class="price-range">
                                <input type="number" class="price-input" name="minPrice" placeholder="Từ" min="0">
                                <span>-</span>
                                <input type="number" class="price-input" name="maxPrice" placeholder="Đến" min="0">
                            </div>
                        </div>
                        
                        <!-- Stock filter -->
                        <div class="filter-group">
                            <div class="filter-group-title">Tình trạng</div>
                            <div class="filter-option">
                                <input type="checkbox" id="stock-all" name="stock" value="all" checked>
                                <label for="stock-all">Tất cả</label>
                            </div>
                            <div class="filter-option">
                                <input type="checkbox" id="stock-in" name="stock" value="in">
                                <label for="stock-in">Còn hàng</label>
                            </div>
                            <div class="filter-option">
                                <input type="checkbox" id="stock-out" name="stock" value="out">
                                <label for="stock-out">Hết hàng</label>
                            </div>
                        </div>
                        
                        <input type="hidden" name="page" value="1">
                        
                        <button type="submit" class="filter-button">Áp dụng bộ lọc</button>
                        <button type="button" class="reset-button" onclick="window.location.href='products'">Đặt lại bộ lọc</button>
                    </form>
                </div>

            </aside>
            
            <!-- Products main content -->
            <main class="products-main">
                <div class="products-toolbar">
                    <div class="products-count">
                        Hiển thị 
                        <c:choose>
                            <c:when test="${empty products}">0</c:when>
                            <c:otherwise>${(currentPage-1)*16+1} - ${(currentPage-1)*16 + products.size()}</c:otherwise>
                        </c:choose>
                         của ${totalProducts} sản phẩm
                    </div>
                    
                    <div>
                        <select class="sort-select" onchange="window.location.href='products?sort=' + this.value">
                            <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                            <option value="price-low" ${param.sort == 'price-low' ? 'selected' : ''}>Giá: Thấp đến cao</option>
                            <option value="price-high" ${param.sort == 'price-high' ? 'selected' : ''}>Giá: Cao đến thấp</option>
                            <option value="name-asc" ${param.sort == 'name-asc' ? 'selected' : ''}>Tên: A-Z</option>
                            <option value="name-desc" ${param.sort == 'name-desc' ? 'selected' : ''}>Tên: Z-A</option>
                        </select>
                    </div>
                </div>
                
                <!-- Products grid -->
                <div class="products-grid">
                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="no-products">
                                <h3 class="no-products-title">Không tìm thấy sản phẩm nào</h3>
                                <p class="no-products-text">Hãy thử thay đổi bộ lọc hoặc tìm kiếm sản phẩm khác.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="product" items="${products}">
                                <div class="product-card">
                                    <img src="${product.imageUrl}" alt="${product.name}" class="product-image" onerror="this.src='placeholder.jpg'">
                                    <div class="product-info">
                                        <div class="product-brand">${product.brand.brandName}</div>
                                        <h3 class="product-name">${product.name}</h3>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                                        </div>
                                        <div class="product-stock ${product.stock == 0 ? 'out-of-stock' : ''}">
                                            <c:choose>
                                                <c:when test="${product.stock == 0}">Hết hàng</c:when>
                                                <c:when test="${product.stock <= 10}">Sắp hết hàng (${product.stock} cái)</c:when>
                                                <c:otherwise>Còn hàng</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="product-actions">
                                            <a href="cart?action=add&id=${product.productId}" class="add-to-cart-btn">
                                                Thêm vào giỏ
                                            </a>
                                            <a href="productDetail?id=${product.productId}" class="view-detail-btn">
                                                Chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <!-- Previous page -->
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <a href="products?page=${currentPage-1}<c:if test="${not empty param.category}">&category=${param.category}</c:if><c:if test="${not empty param.brand}">&brand=${param.brand}</c:if><c:if test="${not empty param.sort}">&sort=${param.sort}</c:if>" class="pagination-link">
                                    &laquo; Trước
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="pagination-link disabled">&laquo; Trước</span>
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                            <c:choose>
                                <c:when test="${pageNum == currentPage}">
                                    <span class="pagination-link active">${pageNum}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="products?page=${pageNum}<c:if test="${not empty param.category}">&category=${param.category}</c:if><c:if test="${not empty param.brand}">&brand=${param.brand}</c:if><c:if test="${not empty param.sort}">&sort=${param.sort}</c:if>" class="pagination-link">
                                        ${pageNum}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        
                        <!-- Next page -->
                        <c:choose>
                            <c:when test="${currentPage < totalPages}">
                                <a href="products?page=${currentPage+1}<c:if test="${not empty param.category}">&category=${param.category}</c:if><c:if test="${not empty param.brand}">&brand=${param.brand}</c:if><c:if test="${not empty param.sort}">&sort=${param.sort}</c:if>" class="pagination-link">
                                    Sau &raquo;
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="pagination-link disabled">Sau &raquo;</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </main>
        </div>
    </div>
    
    <!-- Simple JavaScript for filter handling (non-intrusive) -->
    <script>
        // Handle category checkboxes - only one category can be selected
        document.addEventListener('DOMContentLoaded', function() {
            const categoryCheckboxes = document.querySelectorAll('input[name="category"]');
            const brandCheckboxes = document.querySelectorAll('input[name="brand"]');
            const stockCheckboxes = document.querySelectorAll('input[name="stock"]');
            
            // Category checkboxes - make "all" exclusive
            categoryCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    if (this.value === 'all' && this.checked) {
                        categoryCheckboxes.forEach(cb => {
                            if (cb.value !== 'all') cb.checked = false;
                        });
                    } else if (this.checked) {
                        document.getElementById('cat-all').checked = false;
                    }
                });
            });
            
            // Brand checkboxes - make "all" exclusive
            brandCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    if (this.value === 'all' && this.checked) {
                        brandCheckboxes.forEach(cb => {
                            if (cb.value !== 'all') cb.checked = false;
                        });
                    } else if (this.checked) {
                        document.getElementById('brand-all').checked = false;
                    }
                });
            });
            
            // Stock checkboxes - make "all" exclusive
            stockCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    if (this.value === 'all' && this.checked) {
                        stockCheckboxes.forEach(cb => {
                            if (cb.value !== 'all') cb.checked = false;
                        });
                    } else if (this.checked) {
                        document.getElementById('stock-all').checked = false;
                    }
                });
            });
            
            // Preselect filters based on URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const categoryParam = urlParams.get('category');
            const brandParam = urlParams.get('brand');
            const stockParam = urlParams.get('stock');
            
            if (categoryParam) {
                document.getElementById('cat-all').checked = false;
                const categoryCheckbox = document.getElementById('cat-' + categoryParam);
                if (categoryCheckbox) categoryCheckbox.checked = true;
            }
            
            if (brandParam) {
                document.getElementById('brand-all').checked = false;
                const brandCheckbox = document.getElementById('brand-' + brandParam);
                if (brandCheckbox) brandCheckbox.checked = true;
            }
            
            if (stockParam) {
                document.getElementById('stock-all').checked = false;
                const stockCheckbox = document.getElementById('stock-' + stockParam);
                if (stockCheckbox) stockCheckbox.checked = true;
            }
        });
    </script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Lazy loading images
        const lazyImages = document.querySelectorAll('.product-image[loading="lazy"]');
        
        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        observer.unobserve(img);
                    }
                });
            });

            lazyImages.forEach(img => {
                imageObserver.observe(img);
            });
        }

        // Handle image loading
        const productImages = document.querySelectorAll('.product-image');
        
        productImages.forEach(img => {
            // Remove skeleton when image loads
            img.addEventListener('load', function() {
                const skeleton = this.parentNode.querySelector('.skeleton');
                if (skeleton) {
                    skeleton.style.opacity = '0';
                    setTimeout(() => skeleton.remove(), 300);
                }
                this.classList.add('loaded');
            });

            // Handle image errors
            img.addEventListener('error', function() {
                this.src = 'placeholder.jpg';
                this.classList.add('loaded');
                const skeleton = this.parentNode.querySelector('.skeleton');
                if (skeleton) {
                    skeleton.style.opacity = '0';
                    setTimeout(() => skeleton.remove(), 300);
                }
            });
            
            // Force load if already loaded (for cached images)
            if (img.complete) {
                img.dispatchEvent(new Event('load'));
            }
        });
    });
</script>
</body>
</html>