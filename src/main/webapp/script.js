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
        dots.forEach((dot) => {
            dot.classList.remove("active");
        });
        dots[index].classList.add("active");
        currentIndex = index;
    }

    function nextSlide() {
        let nextIndex = (currentIndex + 1) % images.length;
        updateSlider(nextIndex);
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
        setTimeout(() => {
            if (searchInput) searchInput.focus();
        }, 400);
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
        "#filter-heading-brands button, #filter-heading-connection button, #filter-heading-material button,#filter-heading-size button"
    );

    buttons.forEach((button) => {
        button.addEventListener("click", () => {
            const h2 = button.parentElement;
            const content = h2.nextElementSibling;
            const icon = button.querySelector("svg[data-accordion-icon]");

            content.classList.toggle("active");

            if (icon) {
                icon.classList.toggle("rotate-180");
            }
        });
    });
}

initCustomAccordion();


function initPageSlider() {
    const navButtons = document.querySelectorAll("a[data-target]");

    navButtons.forEach((button) => {
        button.addEventListener("click", (e) => {
            e.preventDefault();

            const targetPageId = button.dataset.target;
            const targetPage = document.getElementById(targetPageId);

            const currentPage = document.querySelector(".page-content.active");

            if (!targetPage || targetPage === currentPage) {
                return;
            }

            currentPage.classList.add("slide-out-left");
            currentPage.classList.remove("active");
            targetPage.classList.add("active");

            setTimeout(() => {
                currentPage.classList.remove("slide-out-left");
            }, 400);
        });
    });
}

initPageSlider();


document.addEventListener("DOMContentLoaded", () => {
    const hash = window.location.hash.substring(1);

    if (hash) {
        const targetId = "page-" + hash;
        const targetPage = document.getElementById(targetId);

        if (targetPage) {
            const defaultActivePage = document.querySelector(".page-content.active");
            if (defaultActivePage) {
                defaultActivePage.classList.remove("active");
            }
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
            const item = categoryList.querySelector('.category-item');
            const val = item.offsetWidth + 20;
            categoryList.scrollLeft += val;
        });

        btnPrev.addEventListener('click', () => {
            const item = categoryList.querySelector('.category-item');
            const val = item.offsetWidth + 20;
            categoryList.scrollLeft -= val;
        });
    }
});


// filterProducts đọc sort từ sessionStorage
function filterProducts(index = 1) {
    let params = new URLSearchParams();

    params.append("index", index);

    const sortHienTai = sessionStorage.getItem('kachikun_sort') || 'newest';
    params.append("sort", sortHienTai);

    const categoryInput = document.getElementById("current-category-slug");
    if (categoryInput && categoryInput.value) {
        params.append("category", categoryInput.value);
    }

    document.querySelectorAll('input[id^="filter-brand-"]:checked').forEach(chk => params.append("brand", chk.value));
    document.querySelectorAll('input[id^="filter-connection-"]:checked').forEach(chk => params.append("connection", chk.value));
    document.querySelectorAll('input[id^="filter-material-"]:checked').forEach(chk => params.append("material", chk.value));
    document.querySelectorAll('input[id^="filter-size-"]:checked').forEach(chk => params.append("size", chk.value));

    fetch("ajaxFilter?" + params.toString())
        .then(response => response.text())
        .then(data => {
            const productGrid = document.getElementById("productGrid");
            if (productGrid) {
                productGrid.innerHTML = data;
            }
            const defaultPagination = document.getElementById("default-pagination");
            if (defaultPagination) {
                defaultPagination.classList.add("hidden");
            }

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
    checkboxes.forEach(chk => {
        chk.addEventListener("change", () => filterProducts(1));
    });
});


// model đánh giá
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

async function openReviewModal(orderId, contextPath) {
    const cleanId = orderId.toString().trim();
    if (!cleanId) return;

    document.getElementById('modalOrderId').textContent = cleanId;
    document.getElementById('reviewModal').classList.remove('hidden');

    try {
        const res = await fetch(`${contextPath}/order-review?orderId=${cleanId}`);
        if (!res.ok) throw new Error(`Lỗi: ${res.status}`);

        const html = await res.text();
        document.getElementById('reviewContent').innerHTML = html;
    } catch (e) {
        console.error(e);
        alert("Không thể tải form đánh giá.");
    }
}

function closeReviewModal() {
    document.getElementById('reviewModal').classList.add('hidden');
}

document.addEventListener('click', function (e) {
    const star = e.target.closest('.star-btn');
    if (star) {
        const container = star.closest('.star-container');
        if (container) {
            const productId = container.getAttribute('data-product-id');
            const value = parseInt(star.getAttribute('data-value'));
            if (productId && value) {
                executeSetRating(productId, value);
            }
        }
    }
});

function executeSetRating(productId, value) {
    const input = document.getElementById('rating-' + productId);
    if (input) input.value = value;

    const label = document.getElementById('rating-label-' + productId);
    if (label) label.textContent = value + ' sao';

    const starsContainer = document.getElementById('stars-' + productId);
    if (starsContainer) {
        const stars = starsContainer.querySelectorAll('.star-btn');
        stars.forEach((s, index) => {
            if (index < value) {
                s.classList.add('text-yellow-400');
                s.classList.remove('text-gray-300');
            } else {
                s.classList.remove('text-yellow-400');
                s.classList.add('text-gray-300');
            }
        });
    }
}

async function submitBulkReviews() {
    const orderId = document.getElementById('bulkOrderId').value;
    const items = document.querySelectorAll('.review-item');
    const reviews = [];

    items.forEach(item => {
        const productId = item.getAttribute('data-product-id');
        const rating = item.querySelector('.product-rating').value;
        const comment = item.querySelector('.product-comment').value;

        reviews.push({
            productId: productId,
            rating: rating,
            comment: comment
        });
    });

    try {
        const response = await fetch('review-bulk', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                orderId: orderId,
                reviews: reviews
            })
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
    box.classList.toggle("hidden");
}

window.onclick = function (event) {
    if (!event.target.closest('#notiBtn')) {
        document.getElementById("notiDropdown").classList.add("hidden");
    }
}