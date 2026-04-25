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
    <link rel="stylesheet" href="style.css"/>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

<%@ include file="includes/header.jsp" %>

<main class="flex-1 container mx-auto px-4 py-10 max-w-4xl">

    <h1 class="text-2xl font-bold text-gray-800 mb-8 flex items-center gap-3">
        <i class="fas fa-user-circle text-pink-500"></i> Tài khoản của tôi
    </h1>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

        <!-- Sidebar avatar / info tóm tắt -->
        <div class="md:col-span-1">
            <div class="bg-white rounded-2xl shadow-sm p-6 text-center">
                <div class="w-24 h-24 rounded-full bg-pink-100 flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-user text-pink-500 text-4xl"></i>
                </div>
                <p class="text-lg font-bold text-gray-800">${sessionScope.user.fullName}</p>
                <p class="text-sm text-gray-400 mt-1">@${sessionScope.user.username}</p>
                <span class="inline-block mt-3 px-3 py-1 rounded-full text-xs font-semibold
                    ${sessionScope.user.role == 1 ? 'bg-yellow-100 text-yellow-700' : 'bg-pink-100 text-pink-600'}">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 1}">Admin</c:when>
                        <c:otherwise>Khách hàng</c:otherwise>
                    </c:choose>
                </span>

                <div class="mt-6 text-left space-y-2 text-sm text-gray-500">
                    <div class="flex items-center gap-2">
                        <i class="fas fa-envelope text-pink-400 w-4"></i>
                        <span class="truncate">${sessionScope.user.email}</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <i class="fas fa-id-badge text-pink-400 w-4"></i>
                        <span>ID: #${sessionScope.user.id}</span>
                    </div>
                </div>

                <div class="mt-6 space-y-2">
                    <a href="order-history"
                       class="block w-full py-2 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-pink-50 hover:text-pink-600 transition">
                        <i class="fas fa-receipt mr-2"></i>Đơn mua của tôi
                    </a>
                    <a href="logout"
                       class="block w-full py-2 rounded-xl bg-red-50 text-red-500 text-sm font-medium hover:bg-red-100 transition">
                        <i class="fas fa-sign-out-alt mr-2"></i>Đăng xuất
                    </a>
                </div>
            </div>
        </div>

        <!-- Phần chính: form cập nhật -->
        <div class="md:col-span-2 space-y-6">

            <!-- Cập nhật thông tin -->
            <div class="bg-white rounded-2xl shadow-sm p-6">
                <h2 class="text-base font-bold text-gray-700 mb-5 flex items-center gap-2">
                    <i class="fas fa-pen text-pink-500 text-sm"></i> Thông tin cá nhân
                </h2>

                <c:if test="${not empty infoError}">
                    <div class="mb-4 px-4 py-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-sm flex items-center gap-2">
                        <i class="fas fa-exclamation-circle"></i> ${infoError}
                    </div>
                </c:if>
                <c:if test="${not empty infoSuccess}">
                    <div class="mb-4 px-4 py-3 bg-green-50 border border-green-200 text-green-600 rounded-xl text-sm flex items-center gap-2">
                        <i class="fas fa-check-circle"></i> ${infoSuccess}
                    </div>
                </c:if>

                <form action="profile" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="updateInfo"/>

                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Tên đăng nhập</label>
                        <input type="text" value="${sessionScope.user.username}" disabled
                               class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-gray-50 text-gray-400 text-sm cursor-not-allowed"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Họ và tên <span class="text-red-400">*</span></label>
                        <input type="text" name="fullName" value="${sessionScope.user.fullName}" required
                               class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Email <span class="text-red-400">*</span></label>
                        <input type="email" name="email" value="${sessionScope.user.email}" required
                               class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                    </div>

                    <div class="pt-2">
                        <button type="submit"
                                class="px-6 py-2.5 bg-pink-500 hover:bg-pink-600 text-white text-sm font-semibold rounded-xl transition">
                            <i class="fas fa-save mr-2"></i>Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>

            <!-- Đổi mật khẩu -->
            <div class="bg-white rounded-2xl shadow-sm p-6">
                <h2 class="text-base font-bold text-gray-700 mb-5 flex items-center gap-2">
                    <i class="fas fa-lock text-pink-500 text-sm"></i> Đổi mật khẩu
                </h2>

                <c:if test="${not empty pwError}">
                    <div class="mb-4 px-4 py-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-sm flex items-center gap-2">
                        <i class="fas fa-exclamation-circle"></i> ${pwError}
                    </div>
                </c:if>
                <c:if test="${not empty pwSuccess}">
                    <div class="mb-4 px-4 py-3 bg-green-50 border border-green-200 text-green-600 rounded-xl text-sm flex items-center gap-2">
                        <i class="fas fa-check-circle"></i> ${pwSuccess}
                    </div>
                </c:if>
                <c:if test="${not empty pwInfo}">
                    <div class="mb-4 px-4 py-3 bg-blue-50 border border-blue-200 text-blue-600 rounded-xl text-sm flex items-center gap-2">
                        <i class="fas fa-info-circle"></i> ${pwInfo}
                    </div>
                </c:if>

                <c:choose>
                    <%-- Bước 2: Nhập OTP --%>
                    <c:when test="${pwStep == 'verify'}">
                        <p class="text-sm text-gray-500 mb-4">
                            Chúng tôi đã gửi mã OTP đến email: <strong class="text-gray-700">${sessionScope.user.email}</strong>
                        </p>

                        <div class="mb-3 text-sm text-gray-500" id="cpTimerWrap">
                            <i class="fas fa-clock text-pink-400"></i>
                            OTP hết hạn sau: <strong id="cpTimerDisplay" class="text-pink-500">5:00</strong>
                        </div>
                        <div class="mb-4 px-4 py-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-sm hidden" id="cpExpiredMsg">
                            <i class="fas fa-hourglass-end"></i> Mã OTP đã hết hạn! Vui lòng nhấn <strong>Gửi lại OTP</strong>.
                        </div>

                        <form action="profile" method="POST" id="cpVerifyForm">
                            <input type="hidden" name="action" value="verifyCpOtp"/>
                            <div class="flex gap-2 justify-center mb-4">
                                <input type="text" name="otp1" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                <input type="text" name="otp2" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                <input type="text" name="otp3" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                <input type="text" name="otp4" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                <input type="text" name="otp5" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                                <input type="text" name="otp6" class="cp-otp w-11 h-11 text-center text-xl font-bold border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="1" required autocomplete="off"/>
                            </div>
                            <button type="submit" id="cpBtnSubmit"
                                    class="px-6 py-2.5 bg-pink-500 hover:bg-pink-600 text-white text-sm font-semibold rounded-xl transition">
                                <i class="fas fa-check mr-2"></i>Xác nhận OTP
                            </button>
                        </form>

                        <form id="cpResendForm" action="profile" method="POST" class="hidden">
                            <input type="hidden" name="action" value="resendCpOtp"/>
                        </form>

                        <div class="mt-3 flex items-center gap-3 text-sm">
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
                            var otpRem  = Math.max(0, 300 - elapsed);
                            var rsdRem  = Math.max(0, 60  - elapsed);

                            var timerWrap   = document.getElementById('cpTimerWrap');
                            var timerDisp   = document.getElementById('cpTimerDisplay');
                            var expiredMsg  = document.getElementById('cpExpiredMsg');
                            var btnSubmit   = document.getElementById('cpBtnSubmit');
                            var resendBtn   = document.getElementById('cpResendBtn');
                            var resendWrap  = document.getElementById('cpResendTimerWrap');
                            var resendCd    = document.getElementById('cpResendCountdown');

                            function fmt(s) { var m = Math.floor(s/60), sc = s%60; return m+':'+(sc<10?'0':'')+sc; }

                            function markExpired() {
                                timerWrap.classList.add('hidden');
                                expiredMsg.classList.remove('hidden');
                                btnSubmit.disabled = true;
                                btnSubmit.classList.add('opacity-40', 'cursor-not-allowed');
                            }

                            if (otpRem === 0) markExpired(); else timerDisp.textContent = fmt(otpRem);
                            if (rsdRem === 0) { resendBtn.disabled = false; resendWrap.classList.add('hidden'); }
                            else resendCd.textContent = rsdRem;

                            if (otpRem === 0 && rsdRem === 0) return;

                            var iv = setInterval(function () {
                                if (otpRem > 0) otpRem--;
                                if (rsdRem > 0) rsdRem--;

                                if (otpRem > 0) { timerDisp.textContent = fmt(otpRem); if (otpRem <= 60) timerDisp.style.color = '#dc2626'; }
                                else markExpired();

                                if (rsdRem > 0) resendCd.textContent = rsdRem;
                                else { resendBtn.disabled = false; resendWrap.classList.add('hidden'); }

                                if (otpRem === 0 && rsdRem === 0) clearInterval(iv);
                            }, 1000);
                        })();

                        var cpOtpInputs = document.querySelectorAll('.cp-otp');
                        cpOtpInputs.forEach(function(inp, i) {
                            inp.addEventListener('input', function(e) {
                                if (e.target.value.length === 1 && i < cpOtpInputs.length - 1) cpOtpInputs[i+1].focus();
                            });
                            inp.addEventListener('keydown', function(e) {
                                if (e.key === 'Backspace' && !e.target.value && i > 0) cpOtpInputs[i-1].focus();
                            });
                        });
                        document.addEventListener('paste', function(e) {
                            if (e.target.classList.contains('cp-otp')) {
                                var d = e.clipboardData.getData('text');
                                if (d.length === 6) { cpOtpInputs.forEach(function(inp, i) { inp.value = d[i] || ''; }); cpOtpInputs[5].focus(); e.preventDefault(); }
                            }
                        });
                        function doCpResend() { document.getElementById('cpResendForm').submit(); }
                        </script>
                    </c:when>

                    <%-- Bước 1: Nhập mật khẩu cũ + mới → Xác nhận → gửi OTP --%>
                    <c:otherwise>
                        <form action="profile" method="POST" class="space-y-4" onsubmit="return cpValidatePw()">
                            <input type="hidden" name="action" value="requestChangePassword"/>
                            <div>
                                <label class="block text-sm font-medium text-gray-600 mb-1">Mật khẩu cũ <span class="text-red-400">*</span></label>
                                <input type="password" name="oldPassword" required
                                       class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"/>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-600 mb-1">Mật khẩu mới <span class="text-red-400">*</span></label>
                                <input type="password" id="cpNewPw" name="newPassword" required
                                       class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"
                                       oninput="cpValidatePw()" placeholder="Ít nhất 6 ký tự, có chữ hoa và số"/>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-600 mb-1">Xác nhận mật khẩu mới <span class="text-red-400">*</span></label>
                                <input type="password" id="cpConfirmPw" name="confirmPassword" required
                                       class="w-full px-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300 transition"
                                       oninput="cpValidatePw()"/>
                            </div>
                            <div id="cpPwError" class="text-red-500 text-xs hidden"></div>
                            <div class="pt-2">
                                <button type="submit"
                                        class="px-6 py-2.5 bg-pink-500 hover:bg-pink-600 text-white text-sm font-semibold rounded-xl transition">
                                    <i class="fas fa-paper-plane mr-2"></i>Xác nhận &amp; Gửi OTP
                                </button>
                            </div>
                        </form>
                        <script>
                        function cpValidatePw() {
                            var pw  = document.getElementById('cpNewPw').value;
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

        </div>
    </div>
</main>

<%@ include file="includes/footer.jsp" %>

<script src="script.js"></script>
</body>
</html>
