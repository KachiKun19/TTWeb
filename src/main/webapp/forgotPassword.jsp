<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            background: #f6f5f7;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            font-family: 'Montserrat', sans-serif;
            height: 100vh;
            margin: 0;
            background-image: radial-gradient(#e0e0e0 1px, transparent 1px);
            background-size: 20px 20px;
        }

        .container {
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.1), 0 10px 10px rgba(0, 0, 0, 0.08);
            padding: 40px;
            width: 450px;
            max-width: 90%;
        }

        h1 {
            font-weight: 700;
            margin: 0 0 20px;
            color: #333;
            text-align: center;
        }

        p {
            font-size: 14px;
            font-weight: 300;
            line-height: 20px;
            letter-spacing: 0.5px;
            margin: 20px 0 30px;
            text-align: center;
            color: #666;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        input {
            background-color: #fff;
            border: 1px solid #e1e1e1;
            padding: 12px 15px;
            margin: 8px 0;
            width: 100%;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-family: 'Montserrat', sans-serif;
        }

        input:hover {
            border-color: #b2d8d8;
            background-color: #fcfcfc;
        }

        input:focus {
            outline: none;
            border-color: #2d7e7e;
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(45, 126, 126, 0.1);
            transform: scale(1.01);
        }

        button {
            border-radius: 25px;
            border: 1px solid #2d7e7e;
            background: linear-gradient(to right, #2d7e7e, #246666);
            color: #FFFFFF;
            font-size: 12px;
            font-weight: bold;
            padding: 12px 45px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s ease-in-out;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(45, 126, 126, 0.4);
            margin-top: 20px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(45, 126, 126, 0.6);
            background: linear-gradient(to right, #246666, #2d7e7e);
        }

        .alert {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            font-size: 13px;
            width: 100%;
            font-weight: 500;
            animation: fadeIn 0.5s ease;
        }

        .alert-error {
            background-color: #fee2e2;
            color: #991b1b;
            border-left: 4px solid #991b1b;
        }

        .alert-success {
            background-color: #dcfce7;
            color: #166534;
            border-left: 4px solid #166534;
        }

        .alert-info {
            background-color: #dbeafe;
            color: #1e40af;
            border-left: 4px solid #1e40af;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .otp-container {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin: 15px 0;
        }

        .otp-input {
            width: 50px !important;
            height: 50px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        .resend-link {
            text-align: center;
            margin-top: 12px;
            font-size: 13px;
        }

        a {
            color: #2d7e7e;
            font-size: 14px;
            text-decoration: none;
            text-align: center;
            margin-top: 20px;
            display: block;
        }

        a:hover {
            text-decoration: underline;
        }

        .btn-resend {
            background: transparent;
            border: 1px solid #2d7e7e;
            color: #2d7e7e;
            box-shadow: none;
            margin-top: 0;
            font-size: 12px;
            padding: 9px 28px;
        }

        .btn-resend:hover:not(:disabled) {
            background: rgba(45, 126, 126, 0.08);
            box-shadow: none;
            transform: none;
        }

        .btn-resend:disabled {
            opacity: 0.45;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }

        .otp-timer-wrap {
            text-align: center;
            font-size: 13px;
            color: #555;
            margin-bottom: 10px;
        }

        .alert-warning {
            background-color: #fff7ed;
            color: #92400e;
            border-left: 4px solid #f59e0b;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Quên mật khẩu</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
    </c:if>
    <c:if test="${not empty info}">
        <div class="alert alert-info"><i class="fas fa-info-circle"></i> ${info}</div>
    </c:if>

    <c:choose>
        <c:when test="${step == 'verify' || (step != 'reset' && not empty email)}">
            <%-- Bước 2: Nhập OTP --%>
            <p style="margin: 10px 0 12px;">Chúng tôi đã gửi mã OTP đến email:<br/><strong>${email}</strong></p>

            <%-- Đồng hồ đếm ngược 5 phút --%>
            <div class="otp-timer-wrap" id="otpTimerWrap">
                <i class="fas fa-clock" style="color:#2d7e7e;"></i>
                OTP hết hạn sau:
                <strong id="otpTimerDisplay" style="color:#2d7e7e; font-size:15px;">5:00</strong>
            </div>
            <div class="alert alert-error" id="otpExpiredMsg" style="display:none;">
                <i class="fas fa-hourglass-end"></i>
                Mã OTP đã hết hạn! Vui lòng nhấn <strong>Gửi lại OTP</strong> để nhận mã mới.
            </div>

            <form action="forgotPassword" method="post" id="verifyForm">
                <input type="hidden" name="action" value="verify">
                <input type="hidden" name="email" value="${email}">

                <div class="otp-container">
                    <input type="text" name="otp1" class="otp-input" maxlength="1" required autocomplete="off">
                    <input type="text" name="otp2" class="otp-input" maxlength="1" required autocomplete="off">
                    <input type="text" name="otp3" class="otp-input" maxlength="1" required autocomplete="off">
                    <input type="text" name="otp4" class="otp-input" maxlength="1" required autocomplete="off">
                    <input type="text" name="otp5" class="otp-input" maxlength="1" required autocomplete="off">
                    <input type="text" name="otp6" class="otp-input" maxlength="1" required autocomplete="off">
                </div>

                <button type="submit" id="btnSubmit">Xác nhận OTP</button>
            </form>

            <%-- Form ẩn để gửi lại OTP bằng POST --%>
            <form id="resendForm" action="forgotPassword" method="post" style="display:none;">
                <input type="hidden" name="action" value="resend">
                <input type="hidden" name="email" value="${email}">
            </form>

            <div class="resend-link">
                <button type="button" id="resendBtn" class="btn-resend" disabled onclick="doResendOtp()">
                    Gửi lại OTP
                </button>
                <div id="resendTimerWrap" style="margin-top:6px; font-size:12px; color:#888;">
                    <i class="fas fa-rotate-right"></i>
                    Có thể gửi lại sau: <strong id="resendCountdown" style="color:#2d7e7e;">60</strong>s
                </div>
            </div>
        </c:when>

        <c:when test="${step == 'reset'}">
            <%-- Bước 3: Đặt mật khẩu mới --%>
            <p style="margin: 10px 0 20px;">
                <i class="fas fa-check-circle" style="color:#16a34a;"></i>
                Xác thực thành công! Vui lòng nhập mật khẩu mới cho tài khoản:<br/>
                <strong>${email}</strong>
            </p>

            <form action="forgotPassword" method="post" id="resetForm">
                <input type="hidden" name="action" value="reset">

                <input type="password" id="newPass" name="newPassword" placeholder="Mật khẩu mới" required
                       oninput="validatePassword()">
                <input type="password" id="confirmPass" name="confirmPassword" placeholder="Xác nhận mật khẩu mới"
                       required oninput="validatePassword()">

                <div id="passwordError" style="color: red; font-size: 12px; margin-bottom: 10px; display: none;"></div>

                <button type="submit" id="btnSubmit" onclick="return validatePassword()">Đặt lại mật khẩu</button>
            </form>
        </c:when>

        <c:otherwise>
            <%-- Bước 1: Nhập email --%>
            <p>Nhập email đã đăng ký, chúng tôi sẽ gửi mã OTP để đặt lại mật khẩu.</p>
            <form action="forgotPassword" method="post">
                <input type="hidden" name="action" value="request">
                <input type="email" name="email" placeholder="Email đăng ký" required autocomplete="off">
                <button type="submit">Gửi mã OTP</button>
            </form>
        </c:otherwise>
    </c:choose>

    <a href="login.jsp"><i class="fas fa-arrow-left"></i> Quay lại đăng nhập</a>
</div>

<script>

    // ── OTP input navigation ──────────────────────────────────────────
    const otpInputs = document.querySelectorAll('.otp-input');
    otpInputs.forEach((input, index) => {
        input.addEventListener('input', (e) => {
            if (e.target.value.length === 1 && index < otpInputs.length - 1) {
                otpInputs[index + 1].focus();
            }
        });
        input.addEventListener('keydown', (e) => {
            if (e.key === 'Backspace' && !e.target.value && index > 0) {
                otpInputs[index - 1].focus();
            }
        });
    });

    document.addEventListener('paste', (e) => {
        const activeElement = document.activeElement;
        if (activeElement && activeElement.classList.contains('otp-input')) {
            const pastedData = e.clipboardData.getData('text');
            if (pastedData.length === 6) {
                otpInputs.forEach((input, index) => {
                    if (index < pastedData.length) input.value = pastedData[index];
                });
                otpInputs[5].focus();
                e.preventDefault();
            }
        }
    });

    // ── OTP timer + resend cooldown ───────────────────────────────────
    (function () {
        var sentAtEl = document.getElementById('otpTimerWrap');
        if (!sentAtEl) return; // không ở bước verify

        var OTP_SENT_AT = ${not empty otpSentAt ? otpSentAt : 0};
        if (OTP_SENT_AT === 0) return;

        var now = Date.now();
        var elapsed = Math.floor((now - OTP_SENT_AT) / 1000);

        var otpRemaining = Math.max(0, 300 - elapsed); // 5 phút
        var resendRemaining = Math.max(0, 60 - elapsed); // 60 giây

        var timerWrap = document.getElementById('otpTimerWrap');
        var timerDisplay = document.getElementById('otpTimerDisplay');
        var expiredMsg = document.getElementById('otpExpiredMsg');
        var btnSubmit = document.getElementById('btnSubmit');
        var resendBtn = document.getElementById('resendBtn');
        var resendCdEl = document.getElementById('resendCountdown');

        function fmt(s) {
            var m = Math.floor(s / 60), sec = s % 60;
            return m + ':' + (sec < 10 ? '0' : '') + sec;
        }

        function applyOtpExpired() {
            timerWrap.style.display = 'none';
            expiredMsg.style.display = 'block';
            btnSubmit.disabled = true;
            btnSubmit.style.opacity = '0.45';
            btnSubmit.style.cursor = 'not-allowed';
        }

        var resendTimerWrap = document.getElementById('resendTimerWrap');

        function applyResendReady() {
            resendBtn.disabled = false;
            resendTimerWrap.style.display = 'none';
        }

        // Render trạng thái ban đầu
        if (otpRemaining === 0) {
            applyOtpExpired();
        } else {
            timerDisplay.textContent = fmt(otpRemaining);
        }

        if (resendRemaining === 0) {
            applyResendReady();
        } else {
            resendCdEl.textContent = resendRemaining;
        }

        if (otpRemaining === 0 && resendRemaining === 0) return;

        var interval = setInterval(function () {
            if (otpRemaining > 0) otpRemaining--;
            if (resendRemaining > 0) resendRemaining--;

            // Cập nhật đồng hồ OTP
            if (otpRemaining > 0) {
                timerDisplay.textContent = fmt(otpRemaining);
                if (otpRemaining <= 60) timerDisplay.style.color = '#dc2626';
            } else {
                applyOtpExpired();
            }

            // Cập nhật đếm ngược gửi lại
            if (resendRemaining > 0) {
                resendCdEl.textContent = resendRemaining;
            } else {
                applyResendReady();
            }

            if (otpRemaining === 0 && resendRemaining === 0) clearInterval(interval);
        }, 1000);
    })();

    function doResendOtp() {
        document.getElementById('resendForm').submit();
    }

    // ── Validate password ─────────────────────────────────────────────
    function validatePassword() {
        var password = document.getElementById("newPass").value;
        var confirmPassword = document.getElementById("confirmPass").value;
        var errorDiv = document.getElementById("passwordError");
        var msg = "";

        if (password.length < 6) {
            msg = "Mật khẩu phải có ít nhất 6 ký tự.";
        } else if (!/\d/.test(password)) {
            msg = "Mật khẩu phải chứa ít nhất 1 số.";
        } else if (!/[A-Z]/.test(password)) {
            msg = "Mật khẩu phải chứa ít nhất 1 chữ hoa.";
        } else if (password !== confirmPassword && confirmPassword.length > 0) {
            msg = "Mật khẩu xác nhận không khớp.";
        }

        if (msg !== "") {
            errorDiv.style.display = "block";
            errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle"></i> ' + msg;
            return false;
        } else {
            errorDiv.style.display = "none";
            return true;
        }
    }
</script>
</body>
</html>