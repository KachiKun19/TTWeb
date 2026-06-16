<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Giỏ hàng - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <style>
        select {
            background-color: white !important;
            color: black !important;
        }

        option {
            background-color: white !important;
            color: black !important;
        }

        .qty-input::-webkit-outer-spin-button,
        .qty-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .cart-checkbox {
            width: 18px;
            height: 18px;
            accent-color: #e11d48;
            cursor: pointer;
            flex-shrink: 0;
        }
    </style>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen">
<jsp:include page="components/header2.jsp"/>

<main class="flex-grow container mx-auto px-4 py-8">

    <nav class="flex mb-5" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-1 md:space-x-3 text-sm">
            <li class="inline-flex items-center">
                <a href="home" class="text-gray-400 hover:text-black inline-flex items-center">
                    <i class="fa-solid fa-house mr-2"></i> Trang chủ
                </a>
            </li>
            <li>
                <div class="flex items-center">
                    <i class="fa-solid fa-chevron-right text-gray-600 mx-2"></i>
                    <span class="text-pink-500 font-semibold ml-2">Giỏ hàng</span>
                </div>
            </li>
        </ol>
    </nav>

    <h1 class="text-3xl font-bold mb-8 uppercase border-b-2 border-black inline-block pb-2 text-black">
        Giỏ hàng của bạn
    </h1>

    <c:if test="${empty sessionScope.cart}">
        <div class="text-center py-16 bg-white rounded shadow-sm">
            <div class="text-6xl text-gray-300 mb-4"><i class="fas fa-shopping-basket"></i></div>
            <p class="text-xl text-gray-500 mb-6">Giỏ hàng của bạn đang trống trơn!</p>
            <a href="home" class="bg-black text-white px-8 py-3 rounded hover:bg-gray-800 transition uppercase font-bold">
                Tiếp tục mua sắm
            </a>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.cart}">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">

            <c:set var="serverError" value="${requestScope.stockError != null ? requestScope.stockError : sessionScope.stockError}"/>

            <div id="error-alert" class="col-span-1 md:col-span-3 ${not empty serverError ? '' : 'hidden'}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative shadow-md flex items-center animate-pulse" role="alert">
                    <i class="fas fa-exclamation-triangle text-2xl mr-3"></i>
                    <div>
                        <strong class="font-bold">Thông báo:</strong>
                        <span id="error-msg" class="block sm:inline">${serverError}</span>
                    </div>
                    <span onclick="document.getElementById('error-alert').classList.add('hidden')" class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer hover:text-red-900">
                        <i class="fas fa-times"></i>
                    </span>
                </div>
                <c:remove var="stockError" scope="session"/>
            </div>

                <%-- Danh sách sản phẩm --%>
            <div class="md:col-span-2 space-y-4">
                <div class="bg-white rounded shadow overflow-hidden">
                    <div class="hidden md:grid grid-cols-12 gap-4 p-4 bg-gray-100 font-bold text-gray-700 text-sm uppercase">
                        <div class="col-span-1 flex items-center justify-center">
                            <input type="checkbox" id="select-all" class="cart-checkbox" onchange="toggleSelectAll(this)" checked/>
                        </div>
                        <div class="col-span-5">Sản phẩm</div>
                        <div class="col-span-2 text-center">Đơn giá</div>
                        <div class="col-span-2 text-center">Số lượng</div>
                        <div class="col-span-2 text-right">Thành tiền</div>
                    </div>

                    <c:forEach items="${sessionScope.cart}" var="item">
                        <div id="row-${item.product.id}" class="grid grid-cols-1 md:grid-cols-12 gap-4 p-4 items-center border-b last:border-0 hover:bg-gray-50 transition">

                            <div class="col-span-1 flex items-center justify-center">
                                <input type="checkbox" name="selectedIds" value="${item.product.id}" class="cart-checkbox item-checkbox" data-price="${item.totalPrice}" checked onchange="recalcSelected()"/>
                            </div>

                            <div class="col-span-5 flex gap-4 items-center">
                                <a href="product-detail?id=${item.product.id}" class="w-20 h-20 flex-shrink-0 border rounded overflow-hidden hover:opacity-80 transition">
                                    <img src="images/${item.product.image}" alt="${item.product.name}" class="w-full h-full object-cover">
                                </a>
                                <div>
                                    <h3 class="font-bold text-gray-800 hover:text-blue-600 transition">
                                        <a href="product-detail?id=${item.product.id}">${item.product.name}</a>
                                    </h3>
                                    <div class="text-xs text-gray-500 mt-1 flex items-center flex-wrap gap-2">
                                        <span>Mã SP: #${item.product.id}</span>
                                        <span class="text-gray-300">|</span>
                                        <span class="font-semibold ${item.product.stock < 10 ? 'text-red-500' : 'text-blue-600'}">
                                            <i class="fas fa-box-open mr-1"></i> Kho còn: ${item.product.stock}
                                        </span>
                                    </div>
                                    <a href="update-cart?id=${item.product.id}&mod=-999" class="text-red-500 text-xs mt-2 hover:underline flex items-center gap-1 cursor-pointer">
                                        <i class="fas fa-trash"></i> Xóa
                                    </a>
                                </div>
                            </div>

                            <div class="col-span-2 text-center font-medium text-gray-600">
                                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/>
                            </div>

                            <div class="col-span-2 flex justify-center">
                                <div class="flex items-center border rounded border-gray-300">
                                    <button type="button" onclick="updateQuantityAjax(${item.product.id}, -1)" class="px-3 py-1 text-gray-600 hover:bg-gray-100 font-bold border-r border-gray-200 focus:outline-none transition h-full">
                                        -
                                    </button>
                                    <input type="number" id="qty-${item.product.id}" value="${item.quantity}" onchange="updateQuantityDirectly(${item.product.id}, this)" class="w-16 text-center border-0 text-sm font-bold text-gray-900 focus:ring-0 bg-transparent p-0 qty-input"/>
                                    <button type="button" onclick="updateQuantityAjax(${item.product.id}, 1)" class="px-3 py-1 text-gray-600 hover:bg-gray-100 font-bold border-l border-gray-200 focus:outline-none transition h-full">
                                        +
                                    </button>
                                </div>
                            </div>

                            <div class="col-span-2 text-right font-bold text-red-600">
                                <span id="item-total-${item.product.id}">
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="text-right">
                    <a href="home" class="text-blue-600 hover:underline text-sm">
                        <i class="fas fa-arrow-left"></i> Tiếp tục mua hàng
                    </a>
                </div>
            </div>

                <%-- Sidebar thanh toán --%>
            <div class="md:col-span-1">
                <div class="bg-white p-6 rounded shadow sticky top-24">
                    <h2 class="text-lg font-bold mb-4 uppercase border-b pb-2 text-black">Thông tin thanh toán</h2>

                    <c:set var="cartSubtotal" value="0"/>
                    <c:forEach items="${sessionScope.cart}" var="item">
                        <c:set var="cartSubtotal" value="${cartSubtotal + item.totalPrice}"/>
                    </c:forEach>

                        <%-- Tóm tắt đơn hàng --%>
                    <div class="mb-4 space-y-2 text-sm">
                        <div class="flex justify-between text-gray-600">
                            <span>Tạm tính (<span id="selected-count">0</span> SP):</span>
                            <span id="cart-total-display">
                                <fmt:formatNumber value="${cartSubtotal}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                        <div id="discount-row" class="flex justify-between text-green-600 hidden">
                            <span>Giảm giá (<span id="discount-label"></span>):</span>
                            <span id="discount-amount-display"></span>
                        </div>
                        <div class="flex justify-between text-gray-600">
                            <span>Phí vận chuyển:</span>
                            <span id="shipping-fee">0₫</span>
                        </div>
                        <div class="flex justify-between font-bold border-t pt-2">
                            <span class="text-gray-800">Tổng cộng:</span>
                            <span id="final-total-display" class="text-red-600 text-base">
                                <fmt:formatNumber value="${cartSubtotal}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                    </div>

                        <%-- Nhập mã giảm giá --%>
                    <div class="mb-4">
                        <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Mã giảm giá</label>
                        <div class="flex gap-2">
                            <input type="text" id="discount-input" placeholder="Nhập mã..." class="flex-1 text-sm p-2 border border-gray-300 rounded focus:ring-black focus:border-black" oninput="this.value = this.value.toUpperCase()">
                            <button type="button" onclick="applyDiscount()" class="bg-black text-white px-3 py-2 rounded text-sm font-bold hover:bg-gray-800 transition whitespace-nowrap">
                                Áp dụng
                            </button>
                        </div>
                        <p id="discount-msg" class="text-xs mt-1 hidden"></p>
                    </div>

                        <%-- Gợi ý mã đã lưu --%>
                    <c:if test="${not empty savedDiscounts}">
                        <div class="mb-4">
                            <button type="button" onclick="openDiscountModal()" class="w-full flex items-center justify-center gap-2 border border-dashed border-pink-400 rounded-lg px-3 py-2 text-pink-600 font-semibold text-sm hover:bg-pink-50 transition">
                                <i class="fas fa-bookmark"></i> Chọn mã đã lưu của tôi
                            </button>
                        </div>
                    </c:if>

                    <form action="checkout" method="post" class="space-y-4">
                        <input type="hidden" name="discountCode" id="discount-code-hidden" value="">

                        <hr class="border-dashed">

                        <div>
                            <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Họ tên người nhận *</label>
                            <input type="text" name="fullname" pattern="^[A-Za-zÀ-ỹ\s]+$" oninvalid="this.setCustomValidity('Chỉ được nhập chữ cái, không có số!')" oninput="this.setCustomValidity('')" placeholder="Nguyễn Văn A" required class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Số điện thoại *</label>
                            <input type="text" name="phone" pattern="0[0-9]{9}" placeholder="09xxxxxxx" required class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Địa chỉ giao hàng *</label>
                            <div class="space-y-3">
                                <div>
                                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Tỉnh / Thành phố</label>
                                    <select id="province" class="w-full border border-gray-300 rounded p-2 text-sm bg-white text-black">
                                        <option value="">-- Chọn tỉnh --</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Quận / Huyện</label>
                                    <select id="districtSelect" class="w-full border border-gray-300 rounded p-2 text-sm bg-white text-black">
                                        <option value="">-- Chọn quận --</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Phường / Xã</label>
                                    <select id="wardSelect" class="w-full border border-gray-300 rounded p-2 text-sm bg-white text-black">
                                        <option value="">-- Chọn phường --</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Địa chỉ chi tiết</label>
                                    <textarea name="address" rows="3" placeholder="Số nhà, tên đường..." required class="w-full text-sm p-2.5 border border-gray-300 rounded text-black"></textarea>
                                </div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-gray-700 uppercase mb-2">Phương thức thanh toán</label>
                            <div class="space-y-2">
                                <label for="payment-cod" class="payment-card flex items-center gap-3 border-2 border-gray-200 rounded-xl p-3 cursor-pointer hover:border-green-400 transition-all has-[:checked]:border-green-500 has-[:checked]:bg-green-50">
                                    <input id="payment-cod" type="radio" value="COD" name="payment_method" checked class="hidden peer">
                                    <div class="w-9 h-9 rounded-full bg-green-100 flex items-center justify-center flex-shrink-0">
                                        <i class="fas fa-money-bill-wave text-green-600 text-sm"></i>
                                    </div>
                                    <div class="flex-1">
                                        <p class="text-sm font-bold text-gray-900">Thanh toán khi nhận hàng</p>
                                        <p class="text-xs text-gray-500">Trả tiền mặt khi shipper giao hàng (COD)</p>
                                    </div>
                                    <div class="w-4 h-4 rounded-full border-2 border-gray-300 flex-shrink-0 cod-dot"></div>
                                </label>

<label for="payment-vnpay" class="payment-card flex items-center gap-3 border-2 border-gray-200 rounded-xl p-3 cursor-pointer hover:border-indigo-400 transition-all has-[:checked]:border-indigo-500 has-[:checked]:bg-indigo-50">
                                    <input id="payment-vnpay" type="radio" value="VNPAY" name="payment_method" class="hidden peer">
                                    <div class="w-9 h-9 rounded-full bg-indigo-100 flex items-center justify-center flex-shrink-0">
                                        <i class="fas fa-qrcode text-indigo-600 text-sm"></i>
                                    </div>
                                    <div class="flex-1">
                                        <p class="text-sm font-bold text-gray-900">VNPay</p>
                                        <p class="text-xs text-gray-500">Thanh toán qua ví VNPay, thẻ ATM / Visa</p>
                                    </div>
                                    <div class="w-4 h-4 rounded-full border-2 border-gray-300 flex-shrink-0 vnpay-dot"></div>
                                </label>
                            </div>
                        </div>

                        <button type="submit" id="btn-submit-order" class="w-full bg-red-600 text-white py-3 rounded font-bold hover:bg-red-700 transition uppercase shadow-lg transform hover:-translate-y-1">
                            Tiến hành đặt hàng
                        </button>

                        <p class="text-xs text-gray-400 text-center mt-2">
                            <i class="fas fa-shield-alt"></i> Bảo mật thanh toán 100%
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </c:if>
</main>

<jsp:include page="components/footer.jsp"/>

<%-- Modal thông báo sau thanh toán --%>
<c:if test="${not empty msg}">
    <div id="paymentModal" class="fixed inset-0 bg-black bg-opacity-60 overflow-y-auto h-full w-full z-[9999] flex items-center justify-center backdrop-blur-sm p-4">

        <%-- COD Modal --%>
        <c:if test="${paymentMethod == 'COD'}">
            <div class="relative w-full max-w-sm bg-white rounded-3xl shadow-2xl overflow-hidden">
                <div class="bg-gradient-to-br from-green-400 to-emerald-600 px-6 pt-10 pb-16 text-center text-white">
                    <div class="mx-auto w-20 h-20 rounded-full bg-white bg-opacity-20 flex items-center justify-center mb-4">
                        <i class="fas fa-check-circle text-white text-4xl"></i>
                    </div>
                    <h3 class="text-2xl font-extrabold">Đặt hàng thành công!</h3>
                    <p class="text-green-100 text-sm mt-1">Cảm ơn bạn đã tin tưởng Kachi-Kun Shop</p>
                </div>

                <div class="-mt-8 mx-4 bg-white rounded-2xl shadow-lg p-5">
                    <div class="flex items-center gap-3 bg-green-50 border border-green-200 rounded-xl p-3 mb-4">
                        <i class="fas fa-money-bill-wave text-green-500 text-xl"></i>
                        <div>
                            <p class="text-xs text-gray-500 font-semibold uppercase">Phương thức</p>
                            <p class="text-sm font-bold text-gray-800">Thanh toán khi nhận hàng (COD)</p>
                        </div>
                    </div>
                    <div class="flex justify-between text-sm py-2 border-b border-dashed border-gray-100">
                        <span class="text-gray-500">Tổng thanh toán</span>
                        <span class="font-bold text-red-600 text-base">
                            <fmt:formatNumber value="${finalTotal}" type="currency" currencySymbol="₫"/>
                        </span>
                    </div>
                    <p class="text-xs text-gray-400 mt-3 text-center">Shipper sẽ liên hệ bạn sớm nhất có thể</p>
                </div>

                <div class="px-4 pb-6 pt-4 space-y-2">
                    <button onclick="window.location.href='order-history'" class="w-full bg-green-600 hover:bg-green-700 text-white py-3 rounded-xl font-bold transition text-sm shadow">
                        <i class="fas fa-list-alt mr-2"></i>Xem đơn hàng của tôi
                    </button>
                    <button onclick="window.location.href='home'" class="w-full text-gray-500 hover:text-gray-800 py-2 text-sm font-medium underline underline-offset-2 transition">
                        Tiếp tục mua sắm
                    </button>
                </div>
            </div>
        </c:if>

        <%-- Banking Modal --%>
        <c:if test="${paymentMethod == 'BANKING'}">
            <div class="relative w-full max-w-sm bg-white rounded-3xl shadow-2xl overflow-hidden">
                <div class="bg-gradient-to-br from-blue-500 to-indigo-700 px-6 pt-8 pb-14 text-center text-white">
                    <div class="mx-auto w-16 h-16 rounded-full bg-white bg-opacity-20 flex items-center justify-center mb-3">
                        <i class="fas fa-university text-white text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-extrabold">Thông tin chuyển khoản</h3>
                    <p class="text-blue-100 text-xs mt-1">Vui lòng chuyển khoản để xác nhận đơn hàng</p>
                </div>

                <div class="-mt-6 mx-4 bg-white rounded-2xl shadow-lg overflow-hidden">
                    <%-- QR code --%>
                    <div class="bg-gray-50 p-4 text-center border-b border-gray-100">
                        <img src="images/qr.jpg" alt="QR Code" class="mx-auto w-40 h-40 rounded-xl border border-gray-200 shadow">
                        <p class="text-xs text-gray-400 mt-2">Quét mã QR để chuyển khoản nhanh</p>
                    </div>

                    <%-- Bank info --%>
                    <div class="p-4 space-y-2 text-sm">
                        <div class="flex justify-between py-1.5 border-b border-dashed border-gray-100">
                            <span class="text-gray-500">Ngân hàng</span>
                            <span class="font-bold text-gray-900">Vietcombank (VCB)</span>
                        </div>
                        <div class="flex justify-between py-1.5 border-b border-dashed border-gray-100">
                            <span class="text-gray-500">Chủ tài khoản</span>
                            <span class="font-bold text-gray-900 uppercase">TRAN XUAN HUNG</span>
                        </div>
                        <div class="flex justify-between items-center py-1.5 border-b border-dashed border-gray-100">
                            <span class="text-gray-500">Số tài khoản</span>
                            <div class="flex items-center gap-1.5">
                                <span id="bank-acc-num" class="font-mono font-bold text-blue-700 tracking-wider">9355849425</span>
                                <button type="button" onclick="copyToClipboard()" id="copy-btn" class="text-gray-300 hover:text-blue-500 transition" title="Sao chép">
                                    <i class="far fa-copy text-sm"></i>
                                </button>
                            </div>
                        </div>
                        <div class="flex justify-between items-center py-1.5 border-b border-dashed border-gray-100">
                            <span class="text-gray-500">Số tiền</span>
                            <span class="font-bold text-red-600 text-base">
                                <fmt:formatNumber value="${finalTotal}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                        <div class="flex justify-between py-1.5">
                            <span class="text-gray-500">Nội dung CK</span>
                            <span class="font-bold text-gray-900 italic">Thanh toan don hang</span>
                        </div>
                    </div>
                </div>

                <div class="px-4 pt-3 pb-1">
                    <div class="flex items-start gap-2 bg-yellow-50 border border-yellow-300 rounded-xl px-3 py-2.5">
                        <i class="fas fa-camera text-yellow-500 mt-0.5 flex-shrink-0"></i>
                        <p class="text-xs text-yellow-800 font-medium leading-relaxed">
                            Vui lòng <span class="font-bold">chụp màn hình</span> hoặc lưu lại thông tin chuyển khoản để đối chiếu khi cần.
                        </p>
                    </div>
                </div>

                <div class="px-4 pb-6 pt-3 space-y-2">
                    <button onclick="window.location.href='order-history'" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-xl font-bold transition text-sm shadow">
                        <i class="fas fa-check mr-2"></i>Đã chuyển khoản xong
                    </button>
                    <button onclick="window.location.href='home'" class="w-full text-gray-500 hover:text-gray-800 py-2 text-sm font-medium underline underline-offset-2 transition">
                        Để sau, về trang chủ
                    </button>
                </div>
            </div>
        </c:if>
    </div>
    <script>
        function copyToClipboard() {
            var rawText = document.getElementById("bank-acc-num").innerText.replace(/\s/g, '');
            navigator.clipboard.writeText(rawText).then(function () {
                var btn = document.getElementById('copy-btn');
                btn.innerHTML = '<i class="fas fa-check text-sm text-green-500"></i>';
                setTimeout(function() { btn.innerHTML = '<i class="far fa-copy text-sm"></i>'; }, 2000);
            });
        }
    </script>
</c:if>

<c:if test="${not empty savedDiscounts}">
    <div id="discount-modal" onclick="if(event.target===this)closeDiscountModal()" class="fixed inset-0 z-50 flex items-center justify-center hidden" style="background:rgba(0,0,0,0.5);">
        <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md mx-4 p-6">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-base font-bold text-gray-800 flex items-center gap-2">
                    <i class="fas fa-bookmark text-pink-500"></i> Mã giảm giá của bạn
                </h3>
                <button type="button" onclick="closeDiscountModal()" class="text-gray-400 hover:text-gray-600 text-xl leading-none">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="flex flex-col gap-3 max-h-80 overflow-y-auto pr-1">
                <c:forEach var="sd" items="${savedDiscounts}">
                    <button type="button" onclick="selectSavedCode('${sd.code}')" class="flex items-center justify-between w-full border border-dashed border-pink-400 rounded-xl px-4 py-3 hover:bg-pink-50 transition text-left group">
                        <div>
                            <div class="font-bold text-pink-600 text-sm tracking-wider">${sd.code}</div>
                            <div class="text-xs text-gray-500 mt-0.5">
                                <c:choose>
                                    <c:when test="${sd.discountType eq 'PERCENT'}">Giảm ${sd.discountValue}%</c:when>
                                    <c:otherwise>Giảm <fmt:formatNumber value="${sd.discountValue}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫</c:otherwise>
                                </c:choose>
                                &nbsp;·&nbsp; Đơn từ <fmt:formatNumber value="${sd.minOrderValue}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫
                                <c:if test="${sd.expiresAt != null}">
                                    &nbsp;·&nbsp; HSD: <fmt:formatDate value="${sd.expiresAt}" pattern="dd/MM/yyyy"/>
                                </c:if>
                            </div>
                        </div>
                        <span class="text-xs text-gray-400 group-hover:text-pink-500 transition whitespace-nowrap ml-3">
                            Chọn <i class="fas fa-arrow-right"></i>
                        </span>
                    </button>
                </c:forEach>
            </div>
        </div>
    </div>
    <script>
        function openDiscountModal() {
            document.getElementById('discount-modal').classList.remove('hidden');
        }

        function closeDiscountModal() {
            document.getElementById('discount-modal').classList.add('hidden');
        }

        function selectSavedCode(code) {
            closeDiscountModal();
            applySavedCode(code);
        }
    </script>
</c:if>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
<script>
    var subtotalRaw = ${not empty cartSubtotal ? cartSubtotal : 0};
    var discountAmountRaw = 0;
    var shippingFeeRaw = 0;

    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
    }

    function updateFinalTotal() {
        var finalTotal = subtotalRaw - discountAmountRaw + shippingFeeRaw;
        document.getElementById('final-total-display').innerText = formatVND(finalTotal);
    }

    function recalcSelected() {
        var checkboxes = document.querySelectorAll('.item-checkbox');
        var total = 0, count = 0;
        checkboxes.forEach(function (chk) {
            if (chk.checked) {
                total += parseFloat(chk.getAttribute('data-price')) || 0;
                count++;
            }
        });

        subtotalRaw = total;
        discountAmountRaw = 0;
        shippingFeeRaw = 0;

        document.getElementById('cart-total-display').innerText = formatVND(total);
        document.getElementById('selected-count').innerText = count;
        document.getElementById('shipping-fee').innerText = '0₫';

        // Reset discount vì subtotal đã thay đổi
        document.getElementById('discount-row').classList.add('hidden');
        document.getElementById('discount-code-hidden').value = '';
        var msgEl = document.getElementById('discount-msg');
        if (msgEl) msgEl.classList.add('hidden');

        updateFinalTotal();

        var selectAll = document.getElementById('select-all');
        if (selectAll) {
            var total_boxes = checkboxes.length;
            selectAll.checked = (count === total_boxes && total_boxes > 0);
            selectAll.indeterminate = (count > 0 && count < total_boxes);
        }
    }

    function toggleSelectAll(masterChk) {
        document.querySelectorAll('.item-checkbox').forEach(function (chk) {
            chk.checked = masterChk.checked;
        });
        recalcSelected();
    }

    // ─── Mã giảm giá ────────────────────────────────────────────────────────
    function applySavedCode(code) {
        document.getElementById('discount-input').value = code;
        applyDiscount();
    }

    function applyDiscount() {
        var code = document.getElementById('discount-input').value.trim();
        if (!code) {
            showDiscountMsg('Vui lòng nhập mã giảm giá!', 'error');
            return;
        }
        if (subtotalRaw <= 0) {
            showDiscountMsg('Vui lòng chọn sản phẩm trước!', 'error');
            return;
        }

        fetch('apply-discount?code=' + encodeURIComponent(code) + '&subtotal=' + subtotalRaw)
            .then(function (r) {
                return r.json();
            })
            .then(function (data) {
                if (data.status === 'ok') {
                    discountAmountRaw = data.discountAmount;
                    document.getElementById('discount-code-hidden').value = data.code;
                    document.getElementById('discount-label').innerText = data.code;
                    document.getElementById('discount-amount-display').innerText = '-' + formatVND(data.discountAmount);
                    document.getElementById('discount-row').classList.remove('hidden');
                    showDiscountMsg('Áp dụng mã giảm giá thành công!', 'success');
                    updateFinalTotal();
                } else {
                    clearDiscount();
                    showDiscountMsg(data.message, 'error');
                }
            })
            .catch(function () {
                showDiscountMsg('Có lỗi xảy ra, vui lòng thử lại!', 'error');
            });
    }

    function clearDiscount() {
        discountAmountRaw = 0;
        document.getElementById('discount-code-hidden').value = '';
        document.getElementById('discount-row').classList.add('hidden');
        var msgEl = document.getElementById('discount-msg');
        if (msgEl) msgEl.classList.add('hidden');
        updateFinalTotal();
    }

    function showDiscountMsg(msg, type) {
        var el = document.getElementById('discount-msg');
        el.innerText = msg;
        el.className = 'text-xs mt-1 ' + (type === 'error' ? 'text-red-600' : 'text-green-600');
        el.classList.remove('hidden');
        setTimeout(function () {
            el.classList.add('hidden');
        }, 4000);
    }

    // ─── Cập nhật số lượng ──────────────────────────────────────────────────
    function updateQuantityAjax(productId, mod) {
        callAjax('ajaxUpdateCart?id=' + productId + '&mod=' + mod, productId);
    }

    function updateQuantityDirectly(productId, inputElement) {
        var newQty = inputElement.value;
        if (newQty === "" || isNaN(newQty) || parseInt(newQty) < 1) {
            alert("Vui lòng nhập số lượng hợp lệ!");
            location.reload();
            return;
        }
        callAjax('ajaxUpdateCart?id=' + productId + '&qty=' + newQty, productId);
    }

    function callAjax(url, productId) {
        var qtyInput = document.getElementById("qty-" + productId);
        var itemTotalSpan = document.getElementById("item-total-" + productId);
        var rowDiv = document.getElementById("row-" + productId);
        var errorAlert = document.getElementById("error-alert");
        var errorMsg = document.getElementById("error-msg");

        fetch(url)
            .then(function (r) {
                return r.json();
            })
            .then(function (data) {
                if (data.status === 'error') {
                    if (errorMsg) errorMsg.innerText = data.message;
                    if (errorAlert) {
                        errorAlert.classList.remove("hidden");
                        errorAlert.scrollIntoView({behavior: "smooth", block: "center"});
                    }
                    if (data.currentQty && qtyInput) qtyInput.value = data.currentQty;

                } else if (data.status === 'removed') {
                    if (errorAlert) errorAlert.classList.add("hidden");
                    if (rowDiv) rowDiv.remove();
                    recalcSelected();
                    updateCartCount(data.cartSize);

                } else {
                    if (errorAlert) errorAlert.classList.add("hidden");
                    if (qtyInput) qtyInput.value = data.newQty;
                    if (itemTotalSpan) itemTotalSpan.innerText = formatVND(data.itemTotalRaw);

                    var chk = document.querySelector('.item-checkbox[value="' + productId + '"]');
                    if (chk) chk.setAttribute('data-price', data.itemTotalRaw);

                    recalcSelected();
                    updateCartCount(data.cartSize);
                }
            })
            .catch(function (e) {
                console.error('Lỗi:', e);
            });
    }

    function updateCartCount(count) {
        document.querySelectorAll(".absolute.-top-1.-right-2").forEach(function (b) {
            b.innerText = count;
        });
        if (count === 0) location.reload();
    }

    const _ghn = {};

    async function loadProvinces() {
        const sel = document.getElementById('province');
        sel.disabled = true;
        sel.innerHTML = '<option value="">⏳ Đang tải tỉnh thành...</option>';
        try {
            if (!_ghn.provinces) {
                const res = await fetch('ghn-provinces');
                const data = await res.json();
                if (!data.data) throw new Error(data.message || 'Lỗi hệ thống API');
                _ghn.provinces = data.data; // Lưu bộ nhớ đệm
            }
            sel.innerHTML = '<option value="">-- Chọn tỉnh --</option>';
            _ghn.provinces.forEach(p => sel.append(new Option(p.ProvinceName, p.ProvinceID)));
        } catch (e) {
            console.warn('GHN provinces error:', e.message);
            sel.innerHTML = '<option value="">Không tải được tỉnh thành</option>';
        } finally {
            sel.disabled = false;
        }
    }

    async function loadDistricts() {
        const provinceId = document.getElementById('province').value;
        const distSel = document.getElementById('districtSelect');
        const wardSel = document.getElementById('wardSelect');
        if (!provinceId) return;

        distSel.disabled = true;
        distSel.innerHTML = '<option value="">⏳ Đang tải quận huyện...</option>';
        wardSel.innerHTML = '<option value="">-- Chọn phường --</option>';
        wardSel.disabled = true;
        document.getElementById('shipping-fee').innerText = '0₫';
        shippingFeeRaw = 0;
        updateFinalTotal();

        const key = 'dist_' + provinceId;
        try {
            if (!_ghn[key]) {
                const res = await fetch('ghn-districts?provinceId=' + provinceId);
                const data = await res.json();
                if (!data.data) throw new Error(data.message || 'Lỗi hệ thống API');
                _ghn[key] = data.data;
            }
            distSel.innerHTML = '<option value="">-- Chọn quận --</option>';
            _ghn[key].forEach(d => distSel.append(new Option(d.DistrictName, d.DistrictID)));
        } catch (e) {
            console.warn('GHN districts error:', e.message);
            distSel.innerHTML = '<option value="">Không tải được quận huyện</option>';
        } finally {
            distSel.disabled = false;
            wardSel.disabled = false;
        }
    }

    async function loadWards() {
        const districtId = document.getElementById('districtSelect').value;
        const wardSel = document.getElementById('wardSelect');
        if (!districtId) return;

        wardSel.disabled = true;
        wardSel.innerHTML = '<option value="">⏳ Đang tải phường xã...</option>';
        document.getElementById('shipping-fee').innerText = '0₫';
        shippingFeeRaw = 0;
        updateFinalTotal();

        const key = 'ward_' + districtId;
        try {
            if (!_ghn[key]) {
                const res = await fetch('ghn/wards?district_id=' + districtId);
                const data = await res.json();
                if (!data.data) throw new Error(data.message || 'Lỗi hệ thống API');
                _ghn[key] = data.data;
            }
            wardSel.innerHTML = '<option value="">-- Chọn phường --</option>';
            _ghn[key].forEach(w => wardSel.append(new Option(w.WardName, w.WardCode)));
        } catch (e) {
            console.warn('GHN wards error:', e.message);
            wardSel.innerHTML = '<option value="">Không tải được phường xã</option>';
        } finally {
            wardSel.disabled = false;
        }
    }

    async function calculateShipping() {
        const districtId = document.getElementById('districtSelect').value;
        const wardCode = document.getElementById('wardSelect').value;
        if (!districtId || !wardCode) return;

        const submitBtn = document.getElementById('btn-submit-order');
        document.getElementById('shipping-fee').innerText = '⏳ Đang tính...';
        if(submitBtn) submitBtn.disabled = true;

        try {
            const res = await fetch('ghn/shipping-fee', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'district_id=' + districtId + '&ward_code=' + wardCode
            });
            const data = await res.json();
            if (data.data && data.data.total) {
                shippingFeeRaw = data.data.total;
                document.getElementById('shipping-fee').innerText = formatVND(shippingFeeRaw);
                updateFinalTotal();
            } else {
                console.warn('GHN fee error:', data.message || data.code);
                document.getElementById('shipping-fee').innerText = 'Không hỗ trợ';
            }
        } catch (e) {
            console.warn('GHN shipping net error:', e.message);
            document.getElementById('shipping-fee').innerText = 'Không hỗ trợ';
        } finally {
            if(submitBtn) submitBtn.disabled = false;
        }
    }

    function initPaymentCards() {
        var radios = document.querySelectorAll('input[name="payment_method"]');
        function updateCards() {
            document.querySelectorAll('.payment-card').forEach(function(card) {
                var radio = card.querySelector('input[type="radio"]');
                var dot = card.querySelector('.cod-dot, .bank-dot');
                if (radio && radio.checked) {
                    if (dot) dot.classList.add('border-green-500', 'bg-green-500');
                } else {
                    if (dot) dot.classList.remove('border-green-500', 'bg-green-500');
                }
            });
var vnpayDot = document.querySelector('.vnpay-dot');
            var vnpayRadio = document.getElementById('payment-vnpay');
            if (vnpayRadio && vnpayRadio.checked) {
                if (vnpayDot) { vnpayDot.classList.remove('border-green-500', 'bg-green-500'); vnpayDot.classList.add('border-indigo-500', 'bg-indigo-500'); }
            } else {
                if (vnpayDot) vnpayDot.classList.remove('border-indigo-500', 'bg-indigo-500');
            }
        }
        radios.forEach(function(r) { r.addEventListener('change', updateCards); });
        updateCards();
    }

    document.addEventListener('DOMContentLoaded', function () {
        recalcSelected();
        loadProvinces();
        initPaymentCards();

        document.getElementById('province').addEventListener('change', loadDistricts);
        document.getElementById('districtSelect').addEventListener('change', loadWards);
        document.getElementById('wardSelect').addEventListener('change', calculateShipping);

        document.querySelector('form[action="checkout"]').addEventListener('submit', function (e) {
            var form = this;
            form.querySelectorAll('input[name="selectedIds"]').forEach(function (el) {
                el.remove();
            });

            var checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
            if (checkedBoxes.length === 0) {
                e.preventDefault();
                alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
                return;
            }
            checkedBoxes.forEach(function (chk) {
                var hidden = document.createElement('input');
                hidden.type = 'hidden';
                hidden.name = 'selectedIds';
                hidden.value = chk.value;
                form.appendChild(hidden);
            });
        });
    });
</script>
</body>
</html>