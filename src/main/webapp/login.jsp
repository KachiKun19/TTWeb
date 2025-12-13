<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập & Đăng ký - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        /* --- GIỮ NGUYÊN CSS CŨ --- */
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
        h1 { font-weight: 700; margin: 0; color: #333; }
        p { font-size: 14px; font-weight: 300; line-height: 20px; letter-spacing: 0.5px; margin: 20px 0 30px; }
        span { font-size: 12px; color: #666; margin-top: 10px;}
        a { color: #333; font-size: 14px; text-decoration: none; margin: 15px 0; transition: color 0.3s ease; }
        a:hover { color: #2d7e7e; font-weight: 600; }
        
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
        button:active { transform: scale(0.95); }
        button:focus { outline: none; }
        button.ghost { background: transparent; border-color: #FFFFFF; box-shadow: none; }
        button.ghost:hover { background-color: rgba(255, 255, 255, 0.1); transform: translateY(-2px); }

        form { background-color: #FFFFFF; display: flex; align-items: center; justify-content: center; flex-direction: column; padding: 0 50px; height: 100%; text-align: center; }
        input { background-color: #fff; border: 1px solid #e1e1e1; padding: 12px 15px; margin: 8px 0; width: 100%; border-radius: 8px; transition: all 0.3s ease; font-family: 'Montserrat', sans-serif; }
        input:hover { border-color: #b2d8d8; background-color: #fcfcfc; }
        input:focus { outline: none; border-color: #2d7e7e; background-color: #fff; box-shadow: 0 0 0 4px rgba(45, 126, 126, 0.1); transform: scale(1.01); }

        .container { background-color: #fff; border-radius: 20px; box-shadow: 0 14px 28px rgba(0,0,0,0.1), 0 10px 10px rgba(0,0,0,0.08); position: relative; overflow: hidden; width: 850px; max-width: 100%; min-height: 600px; }
        .form-container { position: absolute; top: 0; height: 100%; transition: all 0.6s ease-in-out; }
        .sign-up-container { left: 0; width: 50%; opacity: 0; z-index: 1; }
        .sign-in-container { left: 0; width: 50%; z-index: 2; }
        .container.right-panel-active .sign-in-container { transform: translateX(100%); }
        .container.right-panel-active .sign-up-container { transform: translateX(100%); opacity: 1; z-index: 5; animation: show 0.6s; }
        @keyframes show { 0%, 49.99% { opacity: 0; z-index: 1; } 50%, 100% { opacity: 1; z-index: 5; } }

        .overlay-container { position: absolute; top: 0; left: 50%; width: 50%; height: 100%; overflow: hidden; transition: transform 0.6s ease-in-out; z-index: 100; }
        .container.right-panel-active .overlay-container { transform: translateX(-100%); }
        .overlay { background: #2d7e7e; background: linear-gradient(135deg, #2d7e7e 0%, #1a5c5c 100%); background-repeat: no-repeat; background-size: cover; background-position: 0 0; color: #FFFFFF; position: relative; left: -100%; height: 100%; width: 200%; transform: translateX(0); transition: transform 0.6s ease-in-out; }
        .container.right-panel-active .overlay { transform: translateX(50%); }
        .overlay-panel { position: absolute; display: flex; align-items: center; justify-content: center; flex-direction: column; padding: 0 40px; text-align: center; top: 0; height: 100%; width: 50%; transform: translateX(0); transition: transform 0.6s ease-in-out; }
        .overlay-left { transform: translateX(-20%); }
        .container.right-panel-active .overlay-left { transform: translateX(0); }
        .overlay-right { right: 0; transform: translateX(0); }
        .container.right-panel-active .overlay-right { transform: translateX(20%); }

        .social-container { margin: 20px 0; }
        .social-container a { border: 1px solid #DDDDDD; border-radius: 50%; display: inline-flex; justify-content: center; align-items: center; margin: 0 5px; height: 40px; width: 40px; transition: all 0.3s ease; color: #333; }
        .social-container a:hover { border-color: #2d7e7e; background-color: #2d7e7e; color: white; transform: rotate(360deg); }
        .alert { padding: 12px; margin-bottom: 15px; border-radius: 8px; font-size: 13px; width: 100%; font-weight: 500; animation: fadeIn 0.5s ease; }
        .alert-error { background-color: #fee2e2; color: #991b1b; border-left: 4px solid #991b1b; }
        .alert-success { background-color: #dcfce7; color: #166534; border-left: 4px solid #166534; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        /* --- CSS MỚI CHO LOGO TRONG OVERLAY --- */
        .overlay-logo {
            width: 120px;  /* Kích thước logo */
            height: auto;
            margin-bottom: 20px; /* Cách chữ Xin chào 20px */
            
            /* Mẹo: Dùng filter này để biến logo màu đen/xanh thành màu TRẮNG tinh */
            /* Nếu logo bạn đã trắng sẵn rồi thì xóa dòng này đi nhé */
            filter: brightness(0) invert(1); 
            
            transition: transform 0.5s ease;
        }

        /* Hiệu ứng khi hover vào vùng overlay thì logo phóng to nhẹ */
        .overlay-panel:hover .overlay-logo {
            transform: scale(1.1) rotate(-5deg);
        }
    </style>
</head>
<body>

<div class="container" id="container">
    
    <div class="form-container sign-up-container">
        <form action="register" method="post">
            <h1 class="mb-4">Tạo tài khoản</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>hoặc sử dụng email để đăng ký</span>
            <c:if test="${not empty registerError}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${registerError}</div>
            </c:if>
            <input type="text" name="username" placeholder="Tên đăng nhập" required autocomplete="off"/>
            <input type="text" name="fullname" placeholder="Họ và tên" required autocomplete="off"/>
            <input type="email" name="email" placeholder="Email" required autocomplete="off"/>
            <input type="password" name="password" placeholder="Mật khẩu" required />
            <input type="password" name="repassword" placeholder="Nhập lại mật khẩu" required />
            <button type="submit" class="mt-4">Đăng Ký</button>
        </form>
    </div>

    <div class="form-container sign-in-container">
        <form action="login" method="post">
            <h1 class="mb-4">Đăng nhập</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>hoặc sử dụng tài khoản của bạn</span>
            <c:if test="${not empty error}">
                <div class="alert alert-error"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
            </c:if>
            <c:if test="${not empty param.msg}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${param.msg}</div>
            </c:if>
            <input type="text" name="username" placeholder="Tên đăng nhập" required />
            <input type="password" name="password" placeholder="Mật khẩu" required />
            <a href="#">Quên mật khẩu?</a>
            <button type="submit">Đăng Nhập</button>
        </form>
    </div>

    <div class="overlay-container">
        <div class="overlay">
            
            <div class="overlay-panel overlay-left">
                <img src="images/LogoRemake.png" alt="Logo" class="overlay-logo">
                
                <h1>Chào bạn cũ!</h1>
                <p>Để giữ kết nối với chúng tôi, vui lòng đăng nhập bằng thông tin cá nhân của bạn</p>
                <button class="ghost" id="signIn">Đăng Nhập</button>
            </div>
            
            <div class="overlay-panel overlay-right">
                <img src="images/LogoRemake.png" alt="Logo" class="overlay-logo">
                
                <h1>Xin chào!</h1>
                <p>Nhập thông tin cá nhân của bạn và bắt đầu hành trình mua sắm cùng Kachi-Kun Shop</p>
                <button class="ghost" id="signUp">Đăng Ký</button>
            </div>
        </div>
    </div>
</div>

<script>
    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('container');

    signUpButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
    });

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
    });
    
    <c:if test="${not empty registerError}">
        container.classList.add("right-panel-active");
    </c:if>
    
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('action') === 'signup') {
        container.classList.add("right-panel-active");
    }
</script>

</body>
</html>