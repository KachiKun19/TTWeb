<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Đăng nhập & Đăng ký - Kachi-Kun Shop</title>
	<link rel="icon" type="image/png" href="images/LogoRemake.png" />
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
	<link
			href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap"
			rel="stylesheet">

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

		h1 {
			font-weight: 700;
			margin: 0;
			color: #333;
		}

		p {
			font-size: 14px;
			font-weight: 300;
			line-height: 20px;
			letter-spacing: 0.5px;
			margin: 20px 0 30px;
		}

		span {
			font-size: 12px;
			color: #666;
			margin-top: 10px;
		}

		a {
			color: #333;
			font-size: 14px;
			text-decoration: none;
			margin: 15px 0;
			transition: color 0.3s ease;
		}

		a:hover {
			color: #2d7e7e;
			font-weight: 600;
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
		}

		button:hover {
			transform: translateY(-2px);
			box-shadow: 0 6px 20px rgba(45, 126, 126, 0.6);
			background: linear-gradient(to right, #246666, #2d7e7e);
		}

		button:active {
			transform: scale(0.95);
		}

		button:focus {
			outline: none;
		}

		button.ghost {
			background: transparent;
			border-color: #FFFFFF;
			box-shadow: none;
		}

		button.ghost:hover {
			background-color: rgba(255, 255, 255, 0.1);
			transform: translateY(-2px);
		}

		form {
			background-color: #FFFFFF;
			display: flex;
			align-items: center;
			justify-content: center;
			flex-direction: column;
			padding: 0 50px;
			height: 100%;
			text-align: center;
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

		.container {
			background-color: #fff;
			border-radius: 20px;
			box-shadow: 0 14px 28px rgba(0, 0, 0, 0.1), 0 10px 10px
			rgba(0, 0, 0, 0.08);
			position: relative;
			overflow: hidden;
			width: 850px;
			max-width: 100%;
			min-height: 600px;
		}

		.form-container {
			position: absolute;
			top: 0;
			height: 100%;
			transition: all 0.6s ease-in-out;
		}

		.sign-up-container {
			left: 0;
			width: 50%;
			opacity: 0;
			z-index: 1;
		}

		.sign-in-container {
			left: 0;
			width: 50%;
			z-index: 2;
		}

		.container.right-panel-active .sign-in-container {
			transform: translateX(100%);
		}

		.container.right-panel-active .sign-up-container {
			transform: translateX(100%);
			opacity: 1;
			z-index: 5;
			animation: show 0.6s;
		}

		@
		keyframes show { 0%, 49.99% {
			opacity: 0;
			z-index: 1;
		}

			50
			%
			,
			100
			%
			{
				opacity
				:
						1;
				z-index
				:
						5;
			}
		}
		.overlay-container {
			position: absolute;
			top: 0;
			left: 50%;
			width: 50%;
			height: 100%;
			overflow: hidden;
			transition: transform 0.6s ease-in-out;
			z-index: 100;
		}

		.container.right-panel-active .overlay-container {
			transform: translateX(-100%);
		}

		.overlay {
			background: #2d7e7e;
			background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%);
			background-repeat: no-repeat;
			background-size: cover;
			background-position: 0 0;
			color: #FFFFFF;
			position: relative;
			left: -100%;
			height: 100%;
			width: 200%;
			transform: translateX(0);
			transition: transform 0.6s ease-in-out;
		}

		.container.right-panel-active .overlay {
			transform: translateX(50%);
		}

		.overlay-panel {
			position: absolute;
			display: flex;
			align-items: center;
			justify-content: center;
			flex-direction: column;
			padding: 0 40px;
			text-align: center;
			top: 0;
			height: 100%;
			width: 50%;
			transform: translateX(0);
			transition: transform 0.6s ease-in-out;
		}

		.overlay-left {
			transform: translateX(-20%);
		}

		.container.right-panel-active .overlay-left {
			transform: translateX(0);
		}

		.overlay-right {
			right: 0;
			transform: translateX(0);
		}

		.container.right-panel-active .overlay-right {
			transform: translateX(20%);
		}

		.social-container {
			margin: 20px 0;
		}

		.social-container a {
			border: 1px solid #DDDDDD;
			border-radius: 50%;
			display: inline-flex;
			justify-content: center;
			align-items: center;
			margin: 0 5px;
			height: 40px;
			width: 40px;
			transition: all 0.3s ease;
			color: #333;
		}

		.social-container a:hover {
			border-color: #2d7e7e;
			background-color: #2d7e7e;
			color: white;
			transform: rotate(360deg);
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

		@
		keyframes fadeIn {from { opacity:0;
			transform: translateY(-10px);
		}

			to {
				opacity: 1;
				transform: translateY(0);
			}

		}


		.overlay-logo {
			width: 120px;
			height: auto;
			margin-bottom: 20px;


			filter: brightness(0) invert(1);
			transition: transform 0.5s ease;
		}


		.overlay-panel:hover .overlay-logo {
			transform: scale(1.1) rotate(-5deg);
		}

		.otp-box {
			width: 42px;
			height: 48px;
			text-align: center;
			font-size: 22px;
			font-weight: bold;
			border: 1px solid #e1e1e1;
			border-radius: 8px;
			padding: 0;
			transition: border-color 0.3s ease;
		}

		.otp-box:focus {
			outline: none;
			border-color: #2d7e7e;
			box-shadow: 0 0 0 4px rgba(45, 126, 126, 0.1);
		}
	</style>
</head>
<body>

<div class="container" id="container">

	<div class="form-container sign-up-container">

		<%-- BƯỚC 1: Form đăng ký thông tin --%>
		<c:if test="${empty registerStep}">
			<form action="register" method="post" id="registerForm">
				<input type="hidden" name="step" value="sendOtp" />
				<h1 class="mb-4">Tạo tài khoản</h1>

				<div class="social-container">
					<a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
					<a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
					<a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
				</div>
				<span>hoặc sử dụng email để đăng ký</span>

				<c:if test="${not empty registerError}">
					<div class="alert alert-error">
						<i class="fas fa-exclamation-circle"></i> ${registerError}
					</div>
				</c:if>

				<input type="text" name="username" placeholder="Tên đăng nhập"
					   value="${usernameValue}" required autocomplete="off" />

				<input type="text" name="fullname" placeholder="Họ và tên"
					   value="${fullnameValue}" required autocomplete="off" />

				<input type="email" name="email" placeholder="Email"
					   value="${emailValue}" required autocomplete="off" />

				<input type="password" id="regPass" name="password" placeholder="Mật khẩu"
					   required onkeyup="showStrengthBar();" autocomplete="new-password" />

				<div id="password-strength" style="width: 100%; height: 5px; margin-bottom: 10px; transition: all 0.3s; border-radius: 2px;"></div>
				<small id="password-msg" style="color: red; display: none; margin-bottom: 10px; font-weight: bold; font-size: 12px;"></small>

				<input type="password" id="rePass" name="repassword" placeholder="Nhập lại mật khẩu" required />

				<button type="submit" class="mt-4">Gửi mã xác nhận</button>
			</form>
		</c:if>

		<%-- BƯỚC 2: Nhập OTP --%>
		<c:if test="${registerStep eq 'otp'}">
			<form action="register" method="post" id="otpForm">
				<input type="hidden" name="step" value="verifyOtp" />
				<h1 class="mb-2" style="font-size:20px;">Xác nhận email</h1>
				<p style="font-size:13px; color:#666; margin: 10px 0 20px;">
					Mã OTP đã gửi đến<br/><strong>${reg_email_display}</strong>
				</p>

				<c:if test="${not empty registerError}">
					<div class="alert alert-error">
						<i class="fas fa-exclamation-circle"></i> ${registerError}
					</div>
				</c:if>

				<div style="display:flex; gap:8px; justify-content:center; margin-bottom:16px;">
					<input type="text" name="otp1" class="otp-box" maxlength="1" required autocomplete="off" />
					<input type="text" name="otp2" class="otp-box" maxlength="1" required autocomplete="off" />
					<input type="text" name="otp3" class="otp-box" maxlength="1" required autocomplete="off" />
					<input type="text" name="otp4" class="otp-box" maxlength="1" required autocomplete="off" />
					<input type="text" name="otp5" class="otp-box" maxlength="1" required autocomplete="off" />
					<input type="text" name="otp6" class="otp-box" maxlength="1" required autocomplete="off" />
				</div>

				<button type="submit">Hoàn tất đăng ký</button>
				<a href="login.jsp" style="font-size:12px; margin-top:10px; display:block;">Nhập sai email? Quay lại</a>
			</form>
		</c:if>

	</div>

	<div class="form-container sign-in-container">
		<form action="login" method="post">
			<h1 class="mb-4">Đăng nhập</h1>
			<div class="social-container">
				<a href="#" class="social"><i class="fab fa-facebook-f"></i></a> <a
					href="#" class="social"><i class="fab fa-google-plus-g"></i></a> <a
					href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
			</div>
			<span>hoặc sử dụng tài khoản của bạn</span>
			<c:if test="${not empty error}">
				<div class="alert alert-error">
					<i class="fas fa-exclamation-triangle"></i> ${error}
				</div>
			</c:if>
			<c:if test="${not empty param.msg}">
				<div class="alert alert-success">
					<i class="fas fa-check-circle"></i> ${param.msg}
				</div>
			</c:if>
			<input type="text" name="username" placeholder="Tên đăng nhập"
				   required /> <input type="password" name="password"
									  placeholder="Mật khẩu" required />
			<a href="forgotPassword.jsp">Quên mật khẩu?</a>
			<button type="submit">Đăng Nhập</button>
		</form>
	</div>

	<div class="overlay-container">
		<div class="overlay">

			<div class="overlay-panel overlay-left">
				<img src="images/LogoRemake.png" alt="Logo" class="overlay-logo">

				<h1>Chào bạn cũ!</h1>
				<p>Để giữ kết nối với chúng tôi, vui lòng đăng nhập bằng thông
					tin cá nhân của bạn</p>
				<button class="ghost" id="signIn">Đăng Nhập</button>
			</div>

			<div class="overlay-panel overlay-right">
				<img src="images/LogoRemake.png" alt="Logo" class="overlay-logo">

				<h1>Xin chào!</h1>
				<p>Nhập thông tin cá nhân của bạn và bắt đầu hành trình mua sắm
					cùng Kachi-Kun Shop</p>
				<button class="ghost" id="signUp">Đăng Ký</button>
			</div>
		</div>
	</div>
</div>

<script>
	const signUpButton = document.getElementById('signUp');
	const signInButton = document.getElementById('signIn');
	const container = document.getElementById('container');


	signUpButton.addEventListener('click', () => container.classList.add("right-panel-active"));
	signInButton.addEventListener('click', () => container.classList.remove("right-panel-active"));




	const urlParams = new URLSearchParams(window.location.search);
	const msg = urlParams.get('msg');

	// Mở panel đăng ký nếu có lỗi hoặc đang ở bước OTP
	<c:if test="${not empty registerError or registerStep eq 'otp'}">
	container.classList.add("right-panel-active");
	</c:if>

	// Auto-focus và chuyển ô khi nhập OTP
	const otpBoxes = document.querySelectorAll('.otp-box');
	otpBoxes.forEach((box, index) => {
		box.addEventListener('input', () => {
			if (box.value.length === 1 && index < otpBoxes.length - 1) {
				otpBoxes[index + 1].focus();
			}
		});
		box.addEventListener('keydown', (e) => {
			if (e.key === 'Backspace' && !box.value && index > 0) {
				otpBoxes[index - 1].focus();
			}
		});
	});

	// Paste toàn bộ 6 số cùng lúc
	document.addEventListener('paste', (e) => {
		if (document.activeElement.classList.contains('otp-box')) {
			const pasted = e.clipboardData.getData('text').replace(/\D/g, '');
			if (pasted.length === 6) {
				otpBoxes.forEach((box, i) => box.value = pasted[i] || '');
				otpBoxes[5].focus();
				e.preventDefault();
			}
		}
	});


	if (msg) {
		container.classList.remove("right-panel-active");


	}

	function showStrengthBar() {
		var password = document.getElementById("regPass").value;
		var strengthBar = document.getElementById("password-strength");


		var score = 0;
		if (password.length >= 8) score++;
		if (/[A-Z]/.test(password)) score++;
		if (/[0-9]/.test(password)) score++;
		if (/[^A-Za-z0-9]/.test(password)) score++;


		if (password.length === 0) strengthBar.style.backgroundColor = "transparent";
		else if (score < 3) strengthBar.style.backgroundColor = "red";
		else if (score < 4) strengthBar.style.backgroundColor = "orange";
		else strengthBar.style.backgroundColor = "green";
	}


	const registerForm = document.getElementById("registerForm");
	if (registerForm) {
		registerForm.addEventListener("submit", function(event) {
			var password = document.getElementById("regPass").value;
			var msg = document.getElementById("password-msg");

			var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

			if (!strongRegex.test(password)) {
				event.preventDefault();
				msg.style.display = "block";
				msg.innerText = "Mật khẩu yếu! Cần 8 ký tự, có chữ Hoa, Thường, Số và Ký tự đặc biệt.";
				document.getElementById("regPass").value = "";
				document.getElementById("rePass").value = "";
				document.getElementById("regPass").focus();
				document.getElementById("password-strength").style.backgroundColor = "transparent";
			}
		});
	}
</script>

</body>
</html>