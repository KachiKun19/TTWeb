const backgroundElement = document.getElementById("banner-background");
const dots = document.querySelectorAll(".slider-nav .dot");

if (backgroundElement && dots.length > 0) {
    const images = [
        "https://cdn.sforum.vn/sforum/wp-content/uploads/2022/02/9-9-960x538.jpg",
        "https://cdn2.fptshop.com.vn/unsafe/0x0/hinh_nen_may_tinh_bang_8_f5284d566e.jpg",
        "https://cdn2.fptshop.com.vn/unsafe/0x0/hinh_nen_may_tinh_bang_9_a5b793ee3d.jpg",
        "https://cdn2.fptshop.com.vn/unsafe/0x0/hinh_nen_may_tinh_bang_11_90150a3686.jpg",
    ];
    let currentIndex = 0;
    let slideInterval;

    function updateSlider(index) {
        backgroundElement.style.backgroundImage = `url('${images[index]}')`;
        dots.forEach((dot) => dot.classList.remove("active"));
        dots[index].classList.add("active");
        currentIndex = index;
    }

    function nextSlide() {
        updateSlider((currentIndex + 1) % images.length);
    }

    function startSlideShow() {
        clearInterval(slideInterval);
        slideInterval = setInterval(nextSlide, 5000);
    }

    dots.forEach((dot) => {
        dot.addEventListener("click", () => {
            let targetIndex = parseInt(dot.dataset.slide);
            if (targetIndex !== currentIndex) {
                updateSlider(targetIndex);
                startSlideShow();
            }
        });
    });

    updateSlider(0);
    startSlideShow();
}

const openSearchBtn = document.getElementById("open-search");
const closeSearchBtn = document.getElementById("close-search");
const searchOverlay = document.getElementById("search-overlay");
const searchInput = document.querySelector(".search-overlay-input");

if (openSearchBtn && closeSearchBtn && searchOverlay) {
    openSearchBtn.addEventListener("click", function (event) {
        event.preventDefault();
        searchOverlay.classList.add("active");
        setTimeout(() => { if (searchInput) searchInput.focus(); }, 400);
    });

    closeSearchBtn.addEventListener("click", function () {
        searchOverlay.classList.remove("active");
    });
}

document.addEventListener("DOMContentLoaded", function () {
    const userBtn = document.getElementById("user-menu-btn");
    const userDropdown = document.getElementById("user-dropdown");

    if (userBtn && userDropdown) {
        userBtn.addEventListener("click", function (e) {
            e.stopPropagation();
            userDropdown.classList.toggle("hidden");
        });
        document.addEventListener("click", function (e) {
            if (!userBtn.contains(e.target) && !userDropdown.contains(e.target)) {
                userDropdown.classList.add("hidden");
            }
        });
    }

    document.querySelectorAll('a[href="logout"]').forEach(function (logoutLink) {
        logoutLink.addEventListener("click", function () {
            sessionStorage.removeItem('kachikun_sort');
        });
    });
});

function initCustomAccordion() {
    const buttons = document.querySelectorAll(
        "#filter-heading-brands button, #filter-heading-connection button, #filter-heading-material button, #filter-heading-size button"
    );

    buttons.forEach((button) => {
        button.addEventListener("click", () => {
            const content = button.parentElement.nextElementSibling;
            const icon = button.querySelector("svg[data-accordion-icon]");
            content.classList.toggle("active");
            if (icon) icon.classList.toggle("rotate-180");
        });
    });
}

initCustomAccordion();

function initPageSlider() {
    const navButtons = document.querySelectorAll("a[data-target]");

    navButtons.forEach((button) => {
        button.addEventListener("click", (e) => {
            e.preventDefault();
            const targetPage = document.getElementById(button.dataset.target);
            const currentPage = document.querySelector(".page-content.active");

            if (!targetPage || targetPage === currentPage) return;

            currentPage.classList.add("slide-out-left");
            currentPage.classList.remove("active");
            targetPage.classList.add("active");

            setTimeout(() => currentPage.classList.remove("slide-out-left"), 400);
        });
    });
}

initPageSlider();

document.addEventListener("DOMContentLoaded", () => {
    const hash = window.location.hash.substring(1);
    if (hash) {
        const targetPage = document.getElementById("page-" + hash);
        if (targetPage) {
            const defaultActivePage = document.querySelector(".page-content.active");
            if (defaultActivePage) defaultActivePage.classList.remove("active");
            targetPage.classList.add("active");
        }
    }
});

function searchByName(param) {
    var txtSearch = param.value;
    var resultContainer = document.getElementById("search-results");

    if (txtSearch.trim() === "") {
        resultContainer.classList.add("hidden");
        resultContainer.innerHTML = "";
        return;
    }

    fetch("ajaxSearch?txt=" + encodeURIComponent(txtSearch))
        .then(response => response.text())
        .then(data => {
            resultContainer.classList.remove("hidden");
            resultContainer.innerHTML = data;
        })
        .catch(error => console.error('Lỗi:', error));
}

document.addEventListener("DOMContentLoaded", function () {
    const categoryList = document.getElementById('categoryList');
    const btnPrev = document.getElementById('btnPrev');
    const btnNext = document.getElementById('btnNext');

    if (categoryList && btnPrev && btnNext) {
        btnNext.addEventListener('click', () => {
            const val = categoryList.querySelector('.category-item').offsetWidth + 20;
            categoryList.scrollLeft += val;
        });
        btnPrev.addEventListener('click', () => {
            const val = categoryList.querySelector('.category-item').offsetWidth + 20;
            categoryList.scrollLeft -= val;
        });
    }
});

function filterProducts(index = 1) {
    let params = new URLSearchParams();
    params.append("index", index);
    params.append("sort", sessionStorage.getItem('kachikun_sort') || 'newest');

    const categoryInput = document.getElementById("current-category-slug");
    if (categoryInput && categoryInput.value) params.append("category", categoryInput.value);

    document.querySelectorAll('input[id^="filter-brand-"]:checked').forEach(chk => params.append("brand", chk.value));
    document.querySelectorAll('input[id^="filter-connection-"]:checked').forEach(chk => params.append("connection", chk.value));
    document.querySelectorAll('input[id^="filter-material-"]:checked').forEach(chk => params.append("material", chk.value));
    document.querySelectorAll('input[id^="filter-size-"]:checked').forEach(chk => params.append("size", chk.value));

    fetch("ajaxFilter?" + params.toString())
        .then(response => response.text())
        .then(data => {
            const productGrid = document.getElementById("productGrid");
            if (productGrid) productGrid.innerHTML = data;

            const defaultPagination = document.getElementById("default-pagination");
            if (defaultPagination) defaultPagination.classList.add("hidden");

            const hiddenTotal = document.getElementById("ajax-total-res");
            const countDisplay = document.getElementById("count-display");
            if (hiddenTotal && countDisplay) {
                countDisplay.innerText = "Hiển thị " + hiddenTotal.value + " sản phẩm";
            }
        })
        .catch(error => console.error('Lỗi lọc:', error));
}

document.addEventListener("DOMContentLoaded", function () {
    const checkboxes = document.querySelectorAll('.filter-content input[type="checkbox"]');
    checkboxes.forEach(chk => chk.addEventListener("change", () => filterProducts(1)));
});

// Modal hủy đơn
function openCancelModal(orderId) {
    const inputId = document.getElementById('cancelOrderId');
    if (inputId) {
        inputId.value = orderId;
        document.getElementById('cancelModal').classList.remove('hidden');
    }
}

function closeCancelModal() {
    document.getElementById('cancelModal').classList.add('hidden');
}

// Modal đánh giá
async function openReviewModal(orderId, contextPath) {
    const cleanId = orderId.toString().trim();
    if (!cleanId) return;

    document.getElementById('modalOrderId').textContent = cleanId;
    document.getElementById('reviewModal').classList.remove('hidden');

    try {
        const res = await fetch(`${contextPath}/order-review?orderId=${cleanId}`);
        if (!res.ok) throw new Error(`Lỗi: ${res.status}`);
        document.getElementById('reviewContent').innerHTML = await res.text();
    } catch (e) {
        console.error(e);
        alert("Không thể tải form đánh giá.");
    }
}

function closeReviewModal() {
    document.getElementById('reviewModal').classList.add('hidden');
}

function executeSetRating(productId, value) {
    const input = document.getElementById('rating-' + productId);
    if (input) input.value = value;

    const label = document.getElementById('rating-label-' + productId);
    if (label) label.textContent = value + ' sao';

    const starsContainer = document.getElementById('stars-' + productId);
    if (starsContainer) {
        starsContainer.querySelectorAll('.star-btn').forEach((s, index) => {
            s.classList.toggle('text-yellow-400', index < value);
            s.classList.toggle('text-gray-300', index >= value);
        });
    }
}

async function submitBulkReviews() {
    const orderId = document.getElementById('bulkOrderId').value;
    const reviews = [];

    document.querySelectorAll('.review-item').forEach(item => {
        reviews.push({
            productId: item.getAttribute('data-product-id'),
            rating: item.querySelector('.product-rating').value,
            comment: item.querySelector('.product-comment').value
        });
    });

    try {
        const response = await fetch('review-bulk', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ orderId, reviews })
        });

        if (response.ok) {
            const mainContent = document.getElementById('reviewMainContent');
            const successMsg = document.getElementById('reviewSuccessMessage');
            if (mainContent && successMsg) {
                mainContent.classList.add('hidden');
                successMsg.classList.remove('hidden');
            }
        }
    } catch (error) {
        console.error("Error:", error);
    }
}

function toggleNoti() {
    const box = document.getElementById("notiDropdown");
    if (box) box.classList.toggle("hidden");
}
// đưa thông báo vào giỏ hàng
function showToast(message, type = 'success') {
    const existing = document.getElementById('cart-toast');
    if (existing) existing.remove();

    const bgColor = type === 'success' ? '#22c55e' : '#ef4444';
    const icon    = type === 'success' ? 'fa-circle-check' : 'fa-circle-xmark';

    const toast = document.createElement('div');
    toast.id = 'cart-toast';
    toast.style.cssText = `
        position: fixed;
        bottom: 24px;
        right: 24px;
        z-index: 9999;
        display: flex;
        align-items: center;
        gap: 12px;
        background-color: ${bgColor};
        color: white;
        padding: 12px 20px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        font-family: Montserrat, sans-serif;
        font-size: 14px;
        font-weight: 500;
        transform: translateY(80px);
        opacity: 0;
        transition: transform 0.3s ease, opacity 0.3s ease;
        max-width: 360px;
    `;
    toast.innerHTML = `
        <i class="fas ${icon}" style="font-size:18px;flex-shrink:0;"></i>
        <span>${message}</span>
    `;
    document.body.appendChild(toast);

    requestAnimationFrame(() => {
        requestAnimationFrame(() => {
            toast.style.transform = 'translateY(0)';
            toast.style.opacity = '1';
        });
    });

    // ẩn sau 3 giây
    setTimeout(() => {
        toast.style.transform = 'translateY(80px)';
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 350);
    }, 3000);
}

function updateCartBadge(cartSize) {
    const badge = document.getElementById('cart-badge');
    if (badge) {
        badge.textContent = cartSize;
        badge.style.display = cartSize > 0 ? 'inline-flex' : 'none';
    }
}

async function addToCartAjax(productId) {
    try {
        const response = await fetch(`add-to-cart?id=${productId}&redirect=stay`, {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        });

        if (!response.ok) throw new Error('Lỗi server');

        const data = await response.json();
        showToast(data.message, data.success ? 'success' : 'error');
        if (data.success) updateCartBadge(data.cartSize);

    } catch (err) {
        console.error('Lỗi thêm vào giỏ:', err);
        showToast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

document.addEventListener('click', function (e) {

    if (!e.target.closest('#notiBtn')) {
        const notiDropdown = document.getElementById("notiDropdown");
        if (notiDropdown) notiDropdown.classList.add("hidden");
    }

    const star = e.target.closest('.star-btn');
    if (star) {
        const container = star.closest('.star-container');
        if (container) {
            const productId = container.getAttribute('data-product-id');
            const value = parseInt(star.getAttribute('data-value'));
            if (productId && value) executeSetRating(productId, value);
        }
    }

    // Thêm vào giỏ
    const addBtn = e.target.closest('.btn-add-to-cart');
    if (addBtn) {
        e.preventDefault();
        addToCartAjax(addBtn.getAttribute('data-id'));
        return;
    }

    // Mua ngay
    const buyBtn = e.target.closest('.btn-buy-now');
    if (buyBtn) {
        e.preventDefault();
        window.location.href = `add-to-cart?id=${buyBtn.getAttribute('data-id')}`;
    }
});

// banner thông báo của orderHistory
document.addEventListener('DOMContentLoaded', function () {
    var banner = document.getElementById('review-success-banner');
    if (banner) {
        setTimeout(function () {
            banner.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            banner.style.opacity = '0';
            banner.style.transform = 'translateY(-8px)';
            setTimeout(function () { banner.remove(); }, 500);
        }, 4000);
    }
});