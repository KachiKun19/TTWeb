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
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
          rel="stylesheet"/>
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
        Giỏ hàng của bạn</h1>

    <%-- GIỎ TRỐNG --%>
    <c:if test="${empty sessionScope.cart}">
        <div class="text-center py-16 bg-white rounded shadow-sm">
            <div class="text-6xl text-gray-300 mb-4"><i class="fas fa-shopping-basket"></i></div>
            <p class="text-xl text-gray-500 mb-6">Giỏ hàng của bạn đang trống trơn!</p>
            <a href="home"
               class="bg-black text-white px-8 py-3 rounded hover:bg-gray-800 transition uppercase font-bold">
                Tiếp tục mua sắm
            </a>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.cart}">

        <c:set var="cartSubtotal" value="0"/>
        <c:forEach items="${sessionScope.cart}" var="item">
            <c:set var="cartSubtotal" value="${cartSubtotal + item.totalPrice}"/>
        </c:forEach>

        <form action="checkout" method="post" id="checkout-form">
            <input type="hidden" name="discountCode" id="discount-code-hidden" value="">

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">

                <c:set var="serverError"
                       value="${requestScope.stockError != null ? requestScope.stockError : sessionScope.stockError}"/>
                <div id="error-alert" class="col-span-1 md:col-span-3 ${not empty serverError ? '' : 'hidden'}">
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative shadow-md flex items-center animate-pulse"
                         role="alert">
                        <i class="fas fa-exclamation-triangle text-2xl mr-3"></i>
                        <div>
                            <strong class="font-bold">Thông báo:</strong>
                            <span id="error-msg" class="block sm:inline">${serverError}</span>
                        </div>
                        <span onclick="document.getElementById('error-alert').classList.add('hidden')"
                              class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer hover:text-red-900">
                            <i class="fas fa-times"></i>
                        </span>
                    </div>
                    <c:remove var="stockError" scope="session"/>
                </div>

                <div class="md:col-span-2 space-y-4">
                    <div class="bg-white rounded shadow overflow-hidden">

                            <%-- Header table --%>
                        <div class="hidden md:grid grid-cols-12 gap-4 p-4 bg-gray-100 font-bold text-gray-700 text-sm uppercase">
                            <div class="col-span-1 flex items-center justify-center">
                                <input type="checkbox" id="select-all" class="cart-checkbox"
                                       title="Chọn tất cả" onchange="toggleSelectAll(this)"/>
                            </div>
                            <div class="col-span-5">Sản phẩm</div>
                            <div class="col-span-2 text-center">Đơn giá</div>
                            <div class="col-span-2 text-center">Số lượng</div>
                            <div class="col-span-2 text-right">Thành tiền</div>
                        </div>

                            <%-- Từng dòng sản phẩm --%>
                        <c:forEach items="${sessionScope.cart}" var="item">
                            <div id="row-${item.product.id}"
                                 class="grid grid-cols-1 md:grid-cols-12 gap-4 p-4 items-center border-b last:border-0 hover:bg-gray-50 transition">

                                <div class="col-span-1 flex items-center justify-center">
                                    <input type="checkbox"
                                           name="selectedIds"
                                           value="${item.product.id}"
                                           class="cart-checkbox item-checkbox"
                                           data-price="${item.totalPrice}"
                                           checked
                                           onchange="recalcSelected()"/>
                                </div>

                                <div class="col-span-5 flex gap-4 items-center">
                                    <a href="product-detail?id=${item.product.id}"
                                       class="w-20 h-20 flex-shrink-0 border rounded overflow-hidden hover:opacity-80 transition">
                                        <img src="images/${item.product.image}" alt="${item.product.name}"
                                             class="w-full h-full object-cover">
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
                                        <a href="update-cart?id=${item.product.id}&mod=-999"
                                           class="text-red-500 text-xs mt-2 hover:underline flex items-center gap-1 cursor-pointer">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </div>
                                </div>

                                <div class="col-span-2 text-center font-medium text-gray-600">
                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/>
                                </div>

                                <div class="col-span-2 flex justify-center">
                                    <div class="flex items-center border rounded border-gray-300">
                                        <button type="button"
                                                onclick="updateQuantityAjax(${item.product.id}, -1)"
                                                class="px-3 py-1 text-gray-600 hover:bg-gray-100 font-bold border-r border-gray-200 focus:outline-none transition h-full">
                                            -
                                        </button>
                                        <input type="number" id="qty-${item.product.id}"
                                               value="${item.quantity}"
                                               onchange="updateQuantityDirectly(${item.product.id}, this)"
                                               class="w-16 text-center border-0 text-sm font-bold text-gray-900 focus:ring-0 bg-transparent p-0 qty-input"/>
                                        <button type="button"
                                                onclick="updateQuantityAjax(${item.product.id}, 1)"
                                                class="px-3 py-1 text-gray-600 hover:bg-gray-100 font-bold border-l border-gray-200 focus:outline-none transition h-full">
                                            +
                                        </button>
                                    </div>
                                </div>

                                <div class="col-span-2 text-right font-bold text-red-600">
                                    <span id="item-total-${item.product.id}">
                                        <fmt:formatNumber value="${item.totalPrice}" type="currency"
                                                          currencySymbol="₫"/>
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

                <div class="md:col-span-1">
                    <div class="bg-white p-6 rounded shadow sticky top-24">
                        <h2 class="text-lg font-bold mb-4 uppercase border-b pb-2 text-black">Thông tin thanh toán</h2>

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

                            <%-- Mã giảm giá --%>
                        <div class="mb-4">
                            <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Mã giảm giá</label>
                            <div class="flex gap-2">
                                <input type="text" id="discount-input" placeholder="Nhập mã..."
                                       class="flex-1 text-sm p-2 border border-gray-300 rounded focus:ring-black focus:border-black"
                                       oninput="this.value = this.value.toUpperCase()">
                                <button type="button" onclick="applyDiscount()"
                                        class="bg-black text-white px-3 py-2 rounded text-sm font-bold hover:bg-gray-800 transition whitespace-nowrap">
                                    Áp dụng
                                </button>
                            </div>
                            <p id="discount-msg" class="text-xs mt-1 hidden"></p>
                        </div>

                        <hr class="border-dashed mb-4">

                        <div class="space-y-4">
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Họ tên người nhận
                                    *</label>
                                <input type="text" name="fullname"
                                       pattern="^[A-Za-zÀ-ỹ\s]+$"
                                       oninvalid="this.setCustomValidity('Chỉ được nhập chữ cái, không có số!')"
                                       oninput="this.setCustomValidity('')"
                                       placeholder="Nguyễn Văn A" required
                                       class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
                            </div>
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Số điện thoại
                                    *</label>
                                <input type="number" name="phone" pattern="0[0-9]{9}"
                                       placeholder="09xxxxxxx" required
                                       class="w-full text-sm p-2.5 border border-gray-300 rounded focus:ring-black focus:border-black">
                            </div>
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Địa chỉ giao hàng
                                    *</label>
                                <div class="space-y-3">

                                    <div>
                                        <label class="block text-xs font-bold text-gray-700 uppercase mb-1">
                                            Tỉnh / Thành phố
                                        </label>

                                        <select id="province"
                                                class="w-full border border-gray-300 rounded p-2 text-sm bg-white text-black">
                                            <option value="">-- Chọn tỉnh --</option>
                                        </select>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-bold text-gray-700 uppercase mb-1">
                                            Quận / Huyện
                                        </label>

                                        <select id="districtSelect"
                                                onchange="loadWards()"
                                                class="w-full border border-gray-300 rounded p-2 text-sm bg-white text-black">
                                            <option value="">-- Chọn quận --</option>
                                        </select>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-bold text-gray-700 uppercase mb-1">
                                            Phường / Xã
                                        </label>

                                        <select id="wardSelect"
                                                onchange="calculateShipping()"
                                                class="w-full border border-gray-300 rounded p-2 text-sm bg-white text-black">
                                            <option value="">-- Chọn phường --</option>
                                        </select>
                                    </div>

                                    <div>
                                        <label class="block text-xs font-bold text-gray-700 uppercase mb-1">
                                            Địa chỉ chi tiết
                                        </label>

                                        <textarea name="address"
                                                  rows="3"
                                                  placeholder="Số nhà, tên đường..."
                                                  required
                                                  class="w-full text-sm p-2.5 border border-gray-300 rounded">
                                                    </textarea>
                                    </div>

                                </div>
                            </div>
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-2">Phương thức thanh
                                    toán</label>
                                <div class="flex items-center mb-2">
                                    <input id="payment-cod" type="radio" value="COD" name="payment_method" checked
                                           class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500">
                                    <label for="payment-cod" class="ml-2 text-sm font-medium text-gray-900">Thanh toán
                                        khi nhận hàng (COD)</label>
                                </div>
                                <div class="flex items-center">
                                    <input id="payment-bank" type="radio" value="BANKING" name="payment_method"
                                           class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500">
                                    <label for="payment-bank" class="ml-2 text-sm font-medium text-gray-900">Chuyển
                                        khoản ngân hàng</label>
                                </div>
                            </div>

                            <button type="button" onclick="submitCheckout()"
                                    class="w-full bg-red-600 text-white py-3 rounded font-bold hover:bg-red-700 transition uppercase shadow-lg transform hover:-translate-y-1">
                                Tiến hành đặt hàng
                            </button>
                            <p class="text-xs text-gray-400 text-center mt-2">
                                <i class="fas fa-shield-alt"></i> Bảo mật thanh toán 100%
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </form>

    </c:if>
</main>

<jsp:include page="components/footer.jsp"/>

<c:if test="${not empty msg}">
    <div id="paymentModal"
         class="fixed inset-0 bg-gray-800 bg-opacity-75 overflow-y-auto h-full w-full z-[9999] flex items-center justify-center backdrop-blur-sm">
        <div class="relative p-6 border w-[450px] shadow-2xl rounded-2xl bg-white text-center transform transition-all scale-100">

            <c:if test="${paymentMethod == 'COD'}">
                <div class="mt-2">
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-green-100 mb-4 animate-bounce">
                        <i class="fas fa-check text-green-600 text-3xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-2">Đặt hàng thành công!</h3>
                    <div class="mt-2 px-2 py-3">
                        <p class="text-gray-500">Cảm ơn bạn đã mua sắm tại Kachi-Kun Shop.<br>Đơn hàng của bạn đã được
                            ghi nhận.</p>
                    </div>
                    <div class="mt-4">
                        <button type="button" onclick="window.location.href='home'"
                                class="px-6 py-3 bg-green-600 text-white text-base font-bold rounded-lg w-full shadow hover:bg-green-700 transition duration-300">
                            Về trang chủ
                        </button>
                    </div>
                </div>
            </c:if>

            <c:if test="${paymentMethod == 'BANKING'}">
                <div class="mt-2">
                    <img src="https://cdn.tgdd.vn/2020/04/GameApp/icon-200x200.jpg" alt="VCB Logo"
                         class="h-10 mx-auto mb-4">
                    <h3 class="text-xl font-bold text-gray-800 mb-4 uppercase border-b pb-2">Thông tin chuyển khoản</h3>
                    <div class="mt-4 mb-6 text-center">
                        <img src="images/qr.jpg" alt="QR Code Thanh Toán"
                             class="mx-auto w-48 h-48 border border-gray-200 rounded-lg shadow-md">
                        <p class="text-sm text-gray-600 mt-2">Quét mã QR để chuyển khoản nhanh</p>
                    </div>
                    <div class="text-left bg-blue-50 p-5 rounded-xl border border-blue-200 shadow-inner mx-1">
                        <div class="mb-4 text-center">
                            <p class="text-gray-500 text-xs uppercase font-semibold tracking-wider mb-1">Số tài
                                khoản</p>
                            <div class="flex items-center justify-center gap-2">
                                <p id="bank-acc-num"
                                   class="text-blue-700 font-extrabold text-3xl tracking-widest font-mono">9355 849
                                    425</p>
                                <button type="button" onclick="copyToClipboard()"
                                        class="text-gray-400 hover:text-blue-600" title="Sao chép">
                                    <i class="far fa-copy"></i>
                                </button>
                            </div>
                        </div>
                        <div class="border-t border-blue-200 my-3 border-dashed"></div>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-600">Ngân hàng:</span>
                                <span class="font-bold text-gray-900">VCB</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Chủ tài khoản:</span>
                                <span class="font-bold text-gray-900 uppercase">TRAN XUAN HUNG</span>
                            </div>
                            <div class="flex justify-between items-center bg-white p-2 rounded border border-blue-100">
                                <span class="text-gray-600">Số tiền:</span>
                                <span class="text-red-600 font-bold text-lg">
                                    <fmt:formatNumber value="${finalTotal}" type="currency" currencySymbol="₫"/>
                                </span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Nội dung:</span>
                                <span class="font-bold text-gray-900 italic">Thanh toan don hang</span>
                            </div>
                        </div>
                    </div>
                    <p class="text-[11px] text-gray-500 mt-4 italic">*Vui lòng chuyển khoản đúng số tiền.</p>
                    <div class="mt-5 space-y-2">
                        <button type="button"
                                onclick="alert('Đơn hàng đang được xử lý. Cảm ơn bạn!'); window.location.href='home'"
                                class="px-4 py-3 bg-blue-700 text-white text-base font-bold rounded-lg w-full shadow-lg hover:bg-blue-800 transition transform hover:-translate-y-0.5">
                            Đã chuyển khoản xong
                        </button>
                        <button type="button" onclick="window.location.href='home'"
                                class="px-4 py-2 text-gray-500 text-sm hover:text-gray-800 underline">Để sau, về trang
                            chủ
                        </button>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    <script>
        function copyToClipboard() {
            var raw = document.getElementById("bank-acc-num").innerText.replace(/\s/g, '');
            navigator.clipboard.writeText(raw).then(() => alert("Đã sao chép: " + raw));
        }
    </script>
</c:if>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>

<script>
    var subtotalRaw = ${not empty cartSubtotal ? cartSubtotal : 0};
    var discountAmountRaw = 0;

    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
    }

    //Tính tổng từ các item đang được tích chọn
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

        document.getElementById('cart-total-display').innerText = formatVND(total);
        document.getElementById('final-total-display').innerText = formatVND(total);
        document.getElementById('selected-count').innerText = count;

        // Reset discount vì subtotal đã thay đổi
        document.getElementById('discount-row').classList.add('hidden');
        document.getElementById('discount-code-hidden').value = '';
        var msgEl = document.getElementById('discount-msg');
        if (msgEl) msgEl.classList.add('hidden');

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

    // ─phải chọn ít nhất 1 sp
    function submitCheckout() {
        var checked = document.querySelectorAll('.item-checkbox:checked');
        if (checked.length === 0) {
            alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
            return;
        }
        document.getElementById('checkout-form').submit();
    }

    //  Mã giảm giá
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

        fetch('apply-discount?code=' + encodeURIComponent(code))
            .then(r => r.json())
            .then(data => {
                if (data.status === 'ok') {
                    discountAmountRaw = data.discountAmount;
                    document.getElementById('discount-code-hidden').value = data.code;
                    document.getElementById('discount-label').innerText = data.code;
                    document.getElementById('discount-amount-display').innerText = '-' + formatVND(data.discountAmount);
                    document.getElementById('final-total-display').innerText = formatVND(subtotalRaw - data.discountAmount);
                    document.getElementById('discount-row').classList.remove('hidden');
                    showDiscountMsg('Áp dụng mã giảm giá thành công!', 'success');
                } else {
                    clearDiscount();
                    showDiscountMsg(data.message, 'error');
                }
            })
            .catch(() => showDiscountMsg('Có lỗi xảy ra, vui lòng thử lại!', 'error'));
    }

    function clearDiscount() {
        discountAmountRaw = 0;
        document.getElementById('discount-code-hidden').value = '';
        document.getElementById('discount-row').classList.add('hidden');
        document.getElementById('final-total-display').innerText = formatVND(subtotalRaw);
        var msgEl = document.getElementById('discount-msg');
        if (msgEl) msgEl.classList.add('hidden');
    }

    function showDiscountMsg(msg, type) {
        var el = document.getElementById('discount-msg');
        el.innerText = msg;
        el.className = 'text-xs mt-1 ' + (type === 'error' ? 'text-red-600' : 'text-green-600');
        el.classList.remove('hidden');
        setTimeout(() => el.classList.add('hidden'), 4000);
    }

    function updateQuantityAjax(productId, mod) {
        callAjax('ajaxUpdateCart?id=' + productId + '&mod=' + mod, productId);
    }

    function updateQuantityDirectly(productId, inputEl) {
        var newQty = inputEl.value;
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
                    if (data.currentQty != null && qtyInput) qtyInput.value = data.currentQty;

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

    let shippingFeeRaw = 0;

    const districtSelect =
        document.getElementById("districtSelect");

    const wardSelect =
        document.getElementById("wardSelect");

    function loadProvinces() {

        fetch('ghn-provinces')
            .then(res => res.json())
            .then(data => {

                console.log("PROVINCES:", data);

                const provinceSelect =
                    document.getElementById('province');

                provinceSelect.innerHTML =
                    '<option value="">-- Chọn tỉnh --</option>';

                data.data.forEach(p => {

                    const option = document.createElement("option");

                    option.value = p.ProvinceID;
                    option.textContent = p.ProvinceName;

                    provinceSelect.appendChild(option);
                });
            });
    }

    function loadDistricts() {

        const provinceId =
            document.getElementById('province').value;

        if (!provinceId) return;

        fetch('ghn-districts?provinceId=' + provinceId)
            .then(res => res.json())
            .then(data => {

                console.log("DISTRICTS:", data);

                const district =
                    document.getElementById('districtSelect');

                district.innerHTML =
                    '<option value="">-- Chọn quận --</option>';

                data.data.forEach(d => {

                    const option = document.createElement("option");

                    option.value = d.DistrictID;
                    option.textContent = d.DistrictName;

                    district.appendChild(option);
                });
            })
            .catch(err => console.log(err));
    }

    function loadWards() {

        const districtId =
            document.getElementById("districtSelect").value;

        if (!districtId) return;

        fetch('ghn/wards?district_id=' + districtId)
            .then(res => res.json())
            .then(data => {

                console.log("WARDS:", data);

                const wardSelect =
                    document.getElementById("wardSelect");

                wardSelect.innerHTML =
                    '<option value="">-- Chọn phường --</option>';

                data.data.forEach(ward => {

                    const option = document.createElement("option");

                    option.value = ward.WardCode;
                    option.textContent = ward.WardName;

                    wardSelect.appendChild(option);
                });
            })
            .catch(err => console.log(err));
    }

    function calculateShipping() {

        const districtId =
            document.getElementById('districtSelect').value;

        const wardCode =
            document.getElementById('wardSelect').value;

        if (!districtId || !wardCode) return;

        fetch('ghn/shipping-fee', {

            method: 'POST',

            headers: {
                'Content-Type':
                    'application/x-www-form-urlencoded'
            },

            body:
                'district_id=' + districtId +
                '&ward_code=' + wardCode
        })
            .then(res => res.json())

            .then(data => {

                console.log(data);

                shippingFeeRaw = data.data.total;

                document.getElementById("shipping-fee")
                    .innerText =
                    formatVND(shippingFeeRaw);

                updateFinalTotal(); // QUAN TRỌNG
            });
    }

    function updateFinalTotal() {
        const finalTotal =
            subtotalRaw - discountAmountRaw + shippingFeeRaw;
        document.getElementById('final-total-display')
            .innerText = formatVND(finalTotal);
    }

    document.addEventListener('DOMContentLoaded', function () {

        loadProvinces();

        document.getElementById('province')
            .addEventListener('change', loadDistricts);
    });
</script>
</body>
</html>
