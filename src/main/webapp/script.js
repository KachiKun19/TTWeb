
const backgroundElement = document.getElementById("banner-background");
const dots = document.querySelectorAll(".slider-nav .dot"); // Lấy tất cả các nút bấm

// 2. Danh sách ảnh (giữ nguyên như cũ)
if (backgroundElement && dots.length > 0) {
	const images = [
		"https://cdn.sforum.vn/sforum/wp-content/uploads/2022/02/9-9-960x538.jpg",
		"https://cdn2.fptshop.com.vn/unsafe/0x0/hinh_nen_may_tinh_bang_8_f5284d566e.jpg",
		"https://cdn2.fptshop.com.vn/unsafe/0x0/hinh_nen_may_tinh_bang_9_a5b793ee3d.jpg",
		"https://cdn2.fptshop.com.vn/unsafe/0x0/hinh_nen_may_tinh_bang_11_90150a3686.jpg",
	];
	let currentIndex = 0; // Vị trí ảnh hiện tại
	let slideInterval; // Biến để giữ bộ đếm thời gian

	/**
	 * Hàm trung tâm: Cập nhật giao diện (ảnh và dấu chấm)
	 * @param {number} index - Vị trí của ảnh/dấu chấm cần hiển thị
	 */
	function updateSlider(index) {
		// Cập nhật ảnh nền
		backgroundElement.style.backgroundImage = `url('${images[index]}')`;

		// Cập nhật các dấu chấm
		dots.forEach((dot) => {
			dot.classList.remove("active"); // Xóa active khỏi tất cả các chấm
		});
		dots[index].classList.add("active"); // Thêm active vào chấm được chọn

		// Cập nhật lại vị trí hiện tại
		currentIndex = index;
	}

	/**
	 * Hàm tự động chuyển sang slide tiếp theo
	 */
	function nextSlide() {
		let nextIndex = (currentIndex + 1) % images.length; // Lấy vị trí tiếp theo, quay vòng
		updateSlider(nextIndex);
	}

	/**
	 * Hàm khởi động hoặc khởi động lại bộ đếm thời gian
	 */
	function startSlideShow() {
		clearInterval(slideInterval); // Xóa bộ đếm cũ (nếu có)
		slideInterval = setInterval(nextSlide, 5000); // Đặt bộ đếm mới (5 giây)
	}

	// 3. Gắn sự kiện "click" cho từng dấu chấm
	dots.forEach((dot) => {
		dot.addEventListener("click", () => {
			let targetIndex = parseInt(dot.dataset.slide); // Lấy vị trí (0, 1, 2, 3)

			// Chỉ cập nhật nếu bấm vào chấm không phải là chấm hiện tại
			if (targetIndex !== currentIndex) {
				updateSlider(targetIndex);
				startSlideShow(); // Bấm xong thì reset lại bộ đếm
			}
		});
	});

	// 4. Khởi chạy slider khi tải trang
	updateSlider(0); // Hiển thị ảnh đầu tiên
	startSlideShow(); // Bắt đầu tự động chạy
}
// --- Bắt đầu code cho Search Overlay ---

// (Lấy các phần tử của Search)
const openSearchBtn = document.getElementById("open-search");
const closeSearchBtn = document.getElementById("close-search");
const searchOverlay = document.getElementById("search-overlay");
const searchInput = document.querySelector(".search-overlay-input");

// (Sự kiện cho Search)
if (openSearchBtn && closeSearchBtn && searchOverlay) {
    openSearchBtn.addEventListener("click", function(event) {
        event.preventDefault();
        searchOverlay.classList.add("active");
        setTimeout(() => {
            if(searchInput) searchInput.focus();
        }, 400);
    });

    closeSearchBtn.addEventListener("click", function() {
        searchOverlay.classList.remove("active");
    });
}

// Code cho phần User Dropdown
document.addEventListener("DOMContentLoaded", function() {
    const userBtn = document.getElementById("user-menu-btn");
    const userDropdown = document.getElementById("user-dropdown");

    if (userBtn && userDropdown) {
        // Khi bấm vào icon user -> Bật/Tắt class 'hidden'
        userBtn.addEventListener("click", function(e) {
            e.stopPropagation(); // Ngăn sự kiện click lan ra ngoài
            userDropdown.classList.toggle("hidden");
        });

        // Khi bấm ra ngoài -> Ẩn menu
        document.addEventListener("click", function(e) {
            if (!userBtn.contains(e.target) && !userDropdown.contains(e.target)) {
                userDropdown.classList.add("hidden");
            }
        });
    }
});

// phần lọc
function initCustomAccordion() {
	// Tìm tất cả các nút bấm (Thương hiệu, Kết nối)
	const buttons = document.querySelectorAll(
		"#filter-heading-brands button, #filter-heading-connection button, #filter-heading-material button,#filter-heading-size button"
	);

	buttons.forEach((button) => {
		button.addEventListener("click", () => {
			// Lấy h2 (thẻ cha)
			const h2 = button.parentElement;
			// Lấy content div (là thẻ em tiếp theo)
			const content = h2.nextElementSibling;
			// Lấy icon (mũi tên)
			const icon = button.querySelector("svg[data-accordion-icon]");

			// 1. Thêm/xóa class "active" trên content div
			content.classList.toggle("active");

			// 2. Xoay mũi tên
			if (icon) {
				icon.classList.toggle("rotate-180");
			}
		});
	});
}

// Chạy hàm này
initCustomAccordion();

// --- Kết thúc code cho Custom Accordion ---

function initPageSlider() {
	// Tìm TẤT CẢ các nút bấm có [data-target]
	const navButtons = document.querySelectorAll("a[data-target]");

	navButtons.forEach((button) => {
		button.addEventListener("click", (e) => {
			e.preventDefault();

			const targetPageId = button.dataset.target; // Lấy ID trang đích (VD: "page-phim")
			const targetPage = document.getElementById(targetPageId);

			// Tìm trang đang active
			const currentPage = document.querySelector(".page-content.active");

			// Nếu không tìm thấy trang hoặc bấm vào chính nó thì không làm gì
			if (!targetPage || targetPage === currentPage) {
				return;
			}

			// 1. Thêm class trượt ra cho trang CŨ
			currentPage.classList.add("slide-out-left");
			// 2. Bỏ active trang CŨ
			currentPage.classList.remove("active");

			// 3. Thêm active cho trang MỚI (CSS sẽ tự làm nó trượt vào)
			targetPage.classList.add("active");

			// 4. Dọn dẹp class 'slide-out-left' sau khi animation xong (400ms)
			setTimeout(() => {
				currentPage.classList.remove("slide-out-left");
			}, 400); // 400ms = 0.4s (phải khớp với 0.4s trong CSS)
		});
	});
}

// Chạy hàm này
initPageSlider();

// chạy trang mình muốn
document.addEventListener("DOMContentLoaded", () => {
	// 1. Lấy hash từ URL (ví dụ: "phim" từ #phim)
	const hash = window.location.hash.substring(1);

	if (hash) {
		// 2. Xây dựng ID của trang mục tiêu (ví dụ: "page-phim")
		const targetId = "page-" + hash;
		const targetPage = document.getElementById(targetId);

		if (targetPage) {
			// 3. Tìm trang đang active mặc định (là trang chuột)
			const defaultActivePage = document.querySelector(".page-content.active");

			// 4. Tắt trang mặc định và Bật trang mục tiêu
			if (defaultActivePage) {
				defaultActivePage.classList.remove("active");
			}
			targetPage.classList.add("active");
		}
	}
});

// tìm kiếm sản phẩm
function searchByName(param) {
	var txtSearch = param.value;
	var resultContainer = document.getElementById("search-results");

	// Nếu ô input trống thì ẩn khung kết quả đi
	if (txtSearch.trim() === "") {
		resultContainer.classList.add("hidden");
		resultContainer.innerHTML = "";
		return;
	}

	// Gọi AJAX (Sử dụng fetch API có sẵn của trình duyệt, không cần thư viện)
	fetch("ajaxSearch?txt=" + encodeURIComponent(txtSearch))
		.then(response => response.text())
		.then(data => {
			// Hiển thị khung kết quả
			resultContainer.classList.remove("hidden");
			// Đổ HTML nhận được vào khung
			resultContainer.innerHTML = data;
		})
		.catch(error => console.error('Lỗi:', error));
}

document.addEventListener("DOMContentLoaded", function() {
	// Lấy tất cả nút "Chọn nhanh"
	const buttons = document.querySelectorAll(".add-to-cart");

	buttons.forEach(btn => {
		btn.addEventListener("click", function(e) {
			e.preventDefault(); // Chặn hành vi mặc định thẻ a (nếu có)

			// Lấy ID sản phẩm
			const productId = this.getAttribute("data-id");

			// Gọi Servlet thêm vào giỏ
			// Lưu ý: Đường dẫn này sẽ chuyển trang ngay lập tức
			window.location.href = "add-to-cart?id=" + productId;
		});
	});
});

//cuộn ngang thanh icons
document.addEventListener("DOMContentLoaded", function() {
	const categoryList = document.getElementById('categoryList');
	const btnPrev = document.getElementById('btnPrev');
	const btnNext = document.getElementById('btnNext');

	// Kiểm tra xem các thẻ có tồn tại không thì mới chạy code
	if (categoryList && btnPrev && btnNext) {

		// --- XỬ LÝ NÚT NEXT (BÊN PHẢI) ---
		btnNext.addEventListener('click', () => {
		            const item = categoryList.querySelector('.category-item');
		            // Lấy chiều rộng 1 ô + khoảng cách (20px)
		            const val = item.offsetWidth + 20;

		            // CHỈ CỘNG VỊ TRÍ, ĐỂ CSS TỰ LO HIỆU ỨNG TRƯỢT
		            categoryList.scrollLeft += val; 
		        });

		        // --- XỬ LÝ NÚT PREV ---
		        btnPrev.addEventListener('click', () => {
		            const item = categoryList.querySelector('.category-item');
		            const val = item.offsetWidth + 20;

		            // CHỈ TRỪ VỊ TRÍ
		            categoryList.scrollLeft -= val;
		        });
		    }
		});
		
		// xử lí lọc sản phẩm
		function filterProducts() {
		    let params = new URLSearchParams();

		    // 1. Lấy Brand
		    document.querySelectorAll('input[id^="filter-brand-"]:checked').forEach(chk => params.append("brand", chk.value));

		    // 2. Lấy Connection
		    document.querySelectorAll('input[id^="filter-connection-"]:checked').forEach(chk => params.append("connection", chk.value));

		    // 3. Lấy Material
		    document.querySelectorAll('input[id^="filter-material-"]:checked').forEach(chk => params.append("material", chk.value));

		    // 4. Lấy Size (MỚI)
		    document.querySelectorAll('input[id^="filter-size-"]:checked').forEach(chk => {
		        params.append("size", chk.value);
		    });

		    // Gửi AJAX
		    fetch("ajaxFilter?" + params.toString())
		        .then(response => response.text())
		        .then(data => {
		            const productGrid = document.getElementById("productGrid");
		            if (productGrid) {
		                productGrid.innerHTML = data;
		            }
		        })
		        .catch(error => console.error('Lỗi lọc:', error));
		}
		document.addEventListener("DOMContentLoaded", function() {
		    // Tìm tất cả các input type checkbox trong vùng lọc
		    const checkboxes = document.querySelectorAll('.filter-content input[type="checkbox"]');
		    
		    checkboxes.forEach(chk => {
		        chk.addEventListener("change", filterProducts); 
		    });
		});