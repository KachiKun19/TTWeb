<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        * { box-sizing: border-box; }
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
            box-shadow: 0 14px 28px rgba(0,0,0,0.1), 0 10px 10px rgba(0,0,0,0.08);
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
        input:hover { border-color: #b2d8d8; background-color: #fcfcfc; }
        input:focus { outline: none; border-color: #2d7e7e; background-color: #fff; box-shadow: 0 0 0 4px rgba(45, 126, 126, 0.1); transform: scale(1.01); }
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
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
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
            margin-top: 15px;
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
            <c:when test="${step == 'verify' || not empty email}">
                <%-- Bước 2: Nhập OTP --%>
                <p>Chúng tôi đã gửi mã OTP đến email: <strong>${email}</strong></p>
                <form action="forgotPassword" method="post">
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
                    
                    <input type="password" id="newPass" name="newPassword" placeholder="Mật khẩu mới" required oninput="validatePassword()">
<input type="password" id="confirmPass" name="confirmPassword" placeholder="Xác nhận mật khẩu mới" required oninput="validatePassword()">

<div id="passwordError" style="color: red; font-size: 12px; margin-bottom: 10px; display: none;"></div>

<button type="submit" id="btnSubmit" onclick="return validatePassword()">Đặt lại mật khẩu</button>
                </form>
                
                <div class="resend-link">
                    Không nhận được mã? <a href="forgotPassword?email=${email}&action=resend">Gửi lại mã OTP</a>
                </div>
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
                        if (index < pastedData.length) {
                            input.value = pastedData[index];
                        }
                    });
                    otpInputs[5].focus();
                    e.preventDefault();
                }
            }
        });
        
        function validatePassword() {
            var password = document.getElementById("newPass").value;
            var confirmPassword = document.getElementById("confirmPass").value;
            var errorDiv = document.getElementById("passwordError");
            var btnSubmit = document.getElementById("btnSubmit");
            var msg = "";

            
            if (password.length < 6) {
                msg = "Mật khẩu phải có ít nhất 6 ký tự.";
            } 
            
            else if (!/\d/.test(password)) {
                msg = "Mật khẩu phải chứa ít nhất 1 số.";
            }
            
            else if (!/[A-Z]/.test(password)) {
                msg = "Mật khẩu phải chứa ít nhất 1 chữ hoa.";
            }
            
            else if (password !== confirmPassword && confirmPassword.length > 0) {
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