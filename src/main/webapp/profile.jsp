<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Tài khoản của tôi - Kachi-Kun Shop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <style>
        .tab-btn { transition: all .2s; border-bottom: 2px solid transparent; }
        .tab-btn.active { color: #f82c97; border-bottom-color: #f82c97; }
        .tab-panel { display: none; }
        .tab-panel.active { display: block; }
    </style>
</head>
<body class="min-h-screen flex flex-col" style="background:linear-gradient(135deg,#fdf2f8 0%,#f3f4f6 60%);">

<%@ include file="components/header2.jsp" %>

<main class="flex-1 container mx-auto px-4 py-10 max-w-5xl">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 items-start">

        <%-- ===== SIDEBAR ===== --%>
        <div class="md:col-span-1">
            <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                <%-- Banner gradient --%>
                <div class="h-24" style="background:linear-gradient(135deg,#f82c97 0%,#a855f7 100%);"></div>

                <%-- Avatar + info --%>
                <div class="flex flex-col items-center -mt-12 px-6 pb-6">
                    <div id="avatarCircle"
                         class="w-20 h-20 rounded-full border-4 border-white shadow-md flex items-center justify-center text-2xl font-extrabold text-white select-none"
                         style="background:linear-gradient(135deg,#f82c97,#a855f7);">?</div>

                    <p class="mt-3 text-lg font-bold text-gray-800 text-center">${sessionScope.user.fullName}</p>
                    <p class="text-sm text-gray-400">@${sessionScope.user.username}</p>

                    <span class="mt-2 px-3 py-0.5 rounded-full text-xs font-semibold
                        ${sessionScope.user.role == 1 ? 'bg-yellow-100 text-yellow-700' : 'bg-pink-100 text-pink-600'}">
                        <c:choose>
                            <c:when test="${sessionScope.user.role == 1}"><i class="fas fa-crown mr-1"></i>Admin</c:when>
                            <c:otherwise><i class="fas fa-user mr-1"></i>Khách hàng</c:otherwise>
                        </c:choose>
                    </span>

                    <%-- Info rows --%>
                    <div class="mt-5 w-full space-y-2 border-t pt-4">
                        <div class="flex items-center gap-3">
                            <div class="w-8 h-8 rounded-lg bg-pink-50 flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-envelope text-pink-400 text-xs"></i>
                            </div>
                            <span class="text-sm text-gray-600 truncate">${sessionScope.user.email}</span>
                        </div>
                    </div>

                    <%-- Nav buttons --%>
                    <div class="mt-5 w-full space-y-2">
                        <a href="order-history"
                           class="flex items-center gap-3 w-full px-4 py-2.5 rounded-xl bg-gray-50 text-gray-700 text-sm font-medium hover:bg-pink-50 hover:text-pink-600 transition group">
                            <div class="w-7 h-7 rounded-lg bg-white shadow-sm flex items-center justify-center group-hover:bg-pink-100 transition">
                                <i class="fas fa-receipt text-gray-400 text-xs group-hover:text-pink-500 transition"></i>
                            </div>
                            Đơn mua của tôi
                        </a>
                        <a href="logout"
                           class="flex items-center gap-3 w-full px-4 py-2.5 rounded-xl bg-red-50 text-red-500 text-sm font-medium hover:bg-red-100 transition">
                            <div class="w-7 h-7 rounded-lg bg-white shadow-sm flex items-center justify-center">
                                <i class="fas fa-sign-out-alt text-red-400 text-xs"></i>
                            </div>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <%-- ===== MAIN CONTENT ===== --%>
        <div class="md:col-span-2">
            <div class="bg-white rounded-2xl shadow-sm overflow-hidden">

                <%-- Tab nav --%>
                <div class="flex border-b border-gray-100 px-6 overflow-x-auto">
                    <button onclick="switchTab('info')" id="tab-info"
                            class="tab-btn active py-4 px-1 mr-6 text-sm font-semibold text-gray-400 whitespace-nowrap -mb-px">
                        <i class="fas fa-user mr-1.5"></i>Thông tin
                    </button>
                    <button onclick="switchTab('security')" id="tab-security"
                            class="tab-btn py-4 px-1 mr-6 text-sm font-semibold text-gray-400 whitespace-nowrap -mb-px">
                        <i class="fas fa-lock mr-1.5"></i>Bảo mật
                    </button>
                    <c:if test="${not empty savedDiscounts}">
                    <button onclick="switchTab('coupons')" id="tab-coupons"
                            class="tab-btn py-4 px-1 text-sm font-semibold text-gray-400 whitespace-nowrap -mb-px">
                        <i class="fas fa-tags mr-1.5"></i>Mã giảm giá
                    </button>
                    </c:if>
                </div>

                <div class="p-6">

                    <%-- ===== TAB: THÔNG TIN ===== --%>
                    <div id="panel-info" class="tab-panel active">

                        <c:if test="${not empty infoError}">
                            <div class="mb-5 px-4 py-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-sm flex items-center gap-2">
                                <i class="fas fa-exclamation-circle"></i> ${infoError}
                            </div>
                        </c:if>
                        <c:if test="${not empty infoSuccess}">
                            <div class="mb-5 px-4 py-3 bg-green-50 border border-green-200 text-green-600 rounded-xl text-sm flex items-center gap-2">
                                <i class="fas fa-check-circle"></i> ${infoSuccess}
                            </div>
                        </c:if>

                        <form action="profile" method="POST" class="space-y-5">
                            <input type="hidden" name="action" value="updateInfo"/>

                            <div>
                                <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1.5">Tên đăng nhập</label>
                                <input type="text" value="${sessionScope.user.username}" disabled
                                       class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-gray-50 text-gray-400 text-sm cursor-not-allowed"/>
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1.5">Họ và tên <span class="text-red-400 normal-case font-normal">*</span></label>
                                <input type="text" name="fullName" value="${sessionScope.user.fullName}" required
                                       class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1.5">Email <span class="text-red-400 normal-case font-normal">*</span></label>
                                <input type="email" name="email" value="${sessionScope.user.email}" required
                                       class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                            </div>
                            <div>
                                <button type="submit"
                                        class="px-7 py-2.5 rounded-xl text-sm font-semibold text-white shadow-sm hover:opacity-90 transition"
                                        style="background:linear-gradient(135deg,#f82c97,#a855f7);">
                                    <i class="fas fa-save mr-2"></i>Lưu thay đổi
                                </button>
                            </div>
                        </form>
                    </div>

                    <%-- ===== TAB: BẢO MẬT ===== --%>
                    <div id="panel-security" class="tab-panel">

                        <c:if test="${not empty pwError}">
                            <div class="mb-5 px-4 py-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-sm flex items-center gap-2">
                                <i class="fas fa-exclamation-circle"></i> ${pwError}
                            </div>
                        </c:if>
                        <c:if test="${not empty pwSuccess}">
                            <div class="mb-5 px-4 py-3 bg-green-50 border border-green-200 text-green-600 rounded-xl text-sm flex items-center gap-2">
                                <i class="fas fa-check-circle"></i> ${pwSuccess}
                            </div>
                        </c:if>
                        <c:if test="${not empty pwInfo}">
                            <div class="mb-5 px-4 py-3 bg-blue-50 border border-blue-200 text-blue-600 rounded-xl text-sm flex items-center gap-2">
                                <i class="fas fa-info-circle"></i> ${pwInfo}
                            </div>
                        </c:if>

                        <c:choose>
                            <%-- Bước 2: Nhập OTP --%>
                            <c:when test="${pwStep == 'verify'}">
                                <div class="text-center mb-6">
                                    <div class="inline-flex items-center justify-center w-14 h-14 rounded-full bg-pink-50 mb-3">
                                        <i class="fas fa-envelope-open-text text-pink-500 text-2xl"></i>
                                    </div>
                                    <p class="text-sm text-gray-500">Chúng tôi đã gửi mã OTP đến</p>
                                    <p class="font-semibold text-gray-700 text-sm">${sessionScope.user.email}</p>
                                </div>

                                <div class="mb-4 text-center text-sm text-gray-500" id="cpTimerWrap">
                                    <i class="fas fa-clock text-pink-400 mr-1"></i>
                                    OTP hết hạn sau: <strong id="cpTimerDisplay" class="text-pink-500">5:00</strong>
                                </div>
                                <div class="mb-4 px-4 py-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-sm hidden" id="cpExpiredMsg">
                                    <i class="fas fa-hourglass-end"></i> Mã OTP đã hết hạn! Vui lòng nhấn <strong>Gửi lại OTP</strong>.
                                </div>

                                <form action="profile" method="POST" id="cpVerifyForm">
                                    <input type="hidden" name="action" value="verifyCpOtp"/>
                                    <div class="flex gap-2 justify-center mb-5">
                                        <input type="text" name="otp1" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                        <input type="text" name="otp2" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                        <input type="text" name="otp3" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                        <input type="text" name="otp4" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                        <input type="text" name="otp5" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                        <input type="text" name="otp6" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                    </div>
                                    <button type="submit" id="cpBtnSubmit"
                                            class="w-full py-2.5 rounded-xl text-sm font-semibold text-white shadow-sm hover:opacity-90 transition"
                                            style="background:linear-gradient(135deg,#f82c97,#a855f7);">
                                        <i class="fas fa-check mr-2"></i>Xác nhận OTP
                                    </button>
                                </form>

                                <form id="cpResendForm" action="profile" method="POST" class="hidden">
                                    <input type="hidden" name="action" value="resendCpOtp"/>
                                </form>

                                <div class="mt-4 flex items-center justify-center gap-3">
                                    <button type="button" id="cpResendBtn" disabled onclick="doCpResend()"
                                            class="px-4 py-1.5 border border-pink-300 text-pink-500 rounded-xl text-xs font-semibold disabled:opacity-40 disabled:cursor-not-allowed hover:bg-pink-50 transition">
                                        Gửi lại OTP
                                    </button>
                                    <span id="cpResendTimerWrap" class="text-gray-400 text-xs">
                                        Có thể gửi lại sau: <strong id="cpResendCountdown" class="text-pink-500">60</strong>s
                                    </span>
                                </div>

                                <script>
                                    (function () {
                                        var OTP_SENT_AT = ${not empty cpOtpSentAt ? cpOtpSentAt : 0};
                                        if (!OTP_SENT_AT) return;
                                        var elapsed = Math.floor((Date.now() - OTP_SENT_AT) / 1000);
                                        var otpRem = Math.max(0, 300 - elapsed);
                                        var rsdRem = Math.max(0, 60 - elapsed);
                                        var timerWrap = document.getElementById('cpTimerWrap');
                                        var timerDisp = document.getElementById('cpTimerDisplay');
                                        var expiredMsg = document.getElementById('cpExpiredMsg');
                                        var btnSubmit = document.getElementById('cpBtnSubmit');
                                        var resendBtn = document.getElementById('cpResendBtn');
                                        var resendWrap = document.getElementById('cpResendTimerWrap');
                                        var resendCd = document.getElementById('cpResendCountdown');
                                        function fmt(s) { var m = Math.floor(s / 60), sc = s % 60; return m + ':' + (sc < 10 ? '0' : '') + sc; }
                                        function markExpired() { timerWrap.classList.add('hidden'); expiredMsg.classList.remove('hidden'); btnSubmit.disabled = true; btnSubmit.style.opacity = '.4'; }
                                        if (otpRem === 0) markExpired(); else timerDisp.textContent = fmt(otpRem);
                                        if (rsdRem === 0) { resendBtn.disabled = false; resendWrap.classList.add('hidden'); } else resendCd.textContent = rsdRem;
                                        if (otpRem === 0 && rsdRem === 0) return;
                                        var iv = setInterval(function () {
                                            if (otpRem > 0) otpRem--;
                                            if (rsdRem > 0) rsdRem--;
                                            if (otpRem > 0) { timerDisp.textContent = fmt(otpRem); if (otpRem <= 60) timerDisp.style.color = '#dc2626'; } else markExpired();
                                            if (rsdRem > 0) resendCd.textContent = rsdRem; else { resendBtn.disabled = false; resendWrap.classList.add('hidden'); }
                                            if (otpRem === 0 && rsdRem === 0) clearInterval(iv);
                                        }, 1000);
                                    })();
                                    var cpOtpInputs = document.querySelectorAll('.cp-otp');
                                    cpOtpInputs.forEach(function (inp, i) {
                                        inp.addEventListener('input', function (e) { if (e.target.value.length === 1 && i < cpOtpInputs.length - 1) cpOtpInputs[i + 1].focus(); });
                                        inp.addEventListener('keydown', function (e) { if (e.key === 'Backspace' && !e.target.value && i > 0) cpOtpInputs[i - 1].focus(); });
                                    });
                                    document.addEventListener('paste', function (e) {
                                        if (e.target.classList.contains('cp-otp')) {
                                            var d = e.clipboardData.getData('text');
                                            if (d.length === 6) { cpOtpInputs.forEach(function (inp, i) { inp.value = d[i] || ''; }); cpOtpInputs[5].focus(); e.preventDefault(); }
                                        }
                                    });
                                    function doCpResend() { document.getElementById('cpResendForm').submit(); }
                                </script>
                            </c:when>

                            <%-- Bước 1: Nhập mật khẩu --%>
                            <c:otherwise>
                                <form action="profile" method="POST" class="space-y-5" onsubmit="return cpValidatePw()">
                                    <input type="hidden" name="action" value="requestChangePassword"/>
                                    <div>
                                        <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1.5">Mật khẩu cũ <span class="text-red-400 normal-case font-normal">*</span></label>
                                        <input type="password" name="oldPassword" required
                                               class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                                    </div>
                                    <div>
                                        <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1.5">Mật khẩu mới <span class="text-red-400 normal-case font-normal">*</span></label>
                                        <input type="password" id="cpNewPw" name="newPassword" required oninput="cpValidatePw()"
                                               class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                                    </div>
                                    <div>
                                        <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1.5">Xác nhận mật khẩu mới <span class="text-red-400 normal-case font-normal">*</span></label>
                                        <input type="password" id="cpConfirmPw" name="confirmPassword" required oninput="cpValidatePw()"
                                               class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                                    </div>
                                    <div id="cpPwError" class="text-red-500 text-xs hidden"></div>
                                    <div>
                                        <button type="submit"
                                                class="px-7 py-2.5 rounded-xl text-sm font-semibold text-white shadow-sm hover:opacity-90 transition"
                                                style="background:linear-gradient(135deg,#f82c97,#a855f7);">
                                            <i class="fas fa-paper-plane mr-2"></i>Xác nhận &amp; Gửi OTP
                                        </button>
                                    </div>
                                </form>
                                <script>
                                    function cpValidatePw() {
                                        var pw = document.getElementById('cpNewPw').value;
                                        var cpw = document.getElementById('cpConfirmPw').value;
                                        var err = document.getElementById('cpPwError');
                                        var msg = '';
                                        if (pw.length > 0 && pw.length < 6) msg = 'Mật khẩu phải có ít nhất 6 ký tự.';
                                        else if (pw.length >= 6 && !/\d/.test(pw)) msg = 'Mật khẩu phải chứa ít nhất 1 chữ số.';
                                        else if (pw.length >= 6 && !/[A-Z]/.test(pw)) msg = 'Mật khẩu phải chứa ít nhất 1 chữ hoa.';
                                        else if (cpw.length > 0 && pw !== cpw) msg = 'Mật khẩu xác nhận không khớp.';
                                        if (msg) { err.textContent = msg; err.classList.remove('hidden'); return false; }
                                        err.classList.add('hidden'); return true;
                                    }
                                </script>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%-- ===== TAB: MÃ GIẢM GIÁ ===== --%>
                    <c:if test="${not empty savedDiscounts}">
                    <div id="panel-coupons" class="tab-panel">
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                            <c:forEach var="d" items="${savedDiscounts}">
                            <div class="relative overflow-hidden rounded-xl p-4"
                                 style="background:linear-gradient(135deg,#fff7fb,#fdf4ff);border:1.5px dashed #f9a8d4;">
                                <div class="absolute top-0 left-0 h-full w-1.5 rounded-l-xl"
                                     style="background:linear-gradient(180deg,#f82c97,#a855f7);"></div>
                                <div class="pl-3">
                                    <div class="text-lg font-extrabold tracking-widest mb-1" style="color:#f82c97;">${d.code}</div>
                                    <div class="space-y-0.5 text-xs text-gray-500">
                                        <div>
                                            <c:choose>
                                                <c:when test="${d.discountType eq 'PERCENT'}">
                                                    <i class="fas fa-percent text-pink-400 mr-1 w-3"></i>Giảm ${d.discountValue}%
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-tag text-pink-400 mr-1 w-3"></i>Giảm <fmt:formatNumber value="${d.discountValue}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div><i class="fas fa-shopping-cart text-pink-300 mr-1 w-3"></i>Đơn từ <fmt:formatNumber value="${d.minOrderValue}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫</div>
                                        <c:if test="${d.expiresAt != null}">
                                            <div><i class="fas fa-calendar-alt text-pink-300 mr-1 w-3"></i>HSD: <fmt:formatDate value="${d.expiresAt}" pattern="dd/MM/yyyy"/></div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                    </c:if>

                </div>
            </div>
        </div>

    </div>
</main>

<%@ include file="components/footer.jsp" %>

<script src="script.js"></script>
<script>
    // Avatar initials
    (function () {
        var name = '${sessionScope.user.fullName}'.trim();
        var parts = name.split(/\s+/);
        var initials = parts.length >= 2
            ? (parts[0][0] + parts[parts.length - 1][0]).toUpperCase()
            : name.substring(0, 2).toUpperCase();
        document.getElementById('avatarCircle').textContent = initials;
    })();

    // Tab switching
    function switchTab(tab) {
        document.querySelectorAll('.tab-btn').forEach(function (b) { b.classList.remove('active'); });
        document.querySelectorAll('.tab-panel').forEach(function (p) { p.classList.remove('active'); });
        var btn = document.getElementById('tab-' + tab);
        var panel = document.getElementById('panel-' + tab);
        if (btn) btn.classList.add('active');
        if (panel) panel.classList.add('active');
    }

    // Auto-switch tab based on server state
    <c:if test="${not empty pwError or not empty pwSuccess or not empty pwInfo or pwStep == 'verify'}">
    switchTab('security');
    </c:if>
    <c:if test="${not empty infoError or not empty infoSuccess}">
    switchTab('info');
    </c:if>
</script>
</body>
</html>
