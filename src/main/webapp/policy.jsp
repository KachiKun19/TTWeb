<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/22/2026
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Privacy Policy</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="style.css"/>
    <link
            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
            rel="stylesheet"/>
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
            rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    </style>
</head>
<body class="flex flex-col min-h-screen">

<jsp:include page="components/header2.jsp"/>

<!-- Content -->
<main class="flex-grow bg-white p-6">
    <div class="max-w-5xl mx-auto mt-10 bg-white p-8 rounded-2xl shadow-lg">

        <h2 class="text-3xl font-bold text-gray-800 mb-6">Chính sách bảo mật</h2>

        <div class="space-y-6 text-gray-600">

            <div>
                <h3 class="font-semibold text-lg text-gray-800">1. Thu thập thông tin</h3>
                <p>Chúng tôi thu thập thông tin cá nhân như tên, email và số điện thoại khi bạn đăng ký hoặc đặt hàng.</p>
            </div>

            <div>
                <h3 class="font-semibold text-lg text-gray-800">2. Mục đích sử dụng</h3>
                <p>Thông tin của bạn được sử dụng để xử lý đơn hàng, cải thiện dịch vụ và hỗ trợ khách hàng tốt hơn.</p>
            </div>

            <div>
                <h3 class="font-semibold text-lg text-gray-800">3. Bảo mật thông tin</h3>
                <p>Chúng tôi áp dụng các biện pháp bảo mật để bảo vệ dữ liệu cá nhân khỏi truy cập trái phép.</p>
            </div>

            <div>
                <h3 class="font-semibold text-lg text-gray-800">4. Chia sẻ thông tin</h3>
                <p>Chúng tôi không bán hoặc chia sẻ thông tin cá nhân của bạn cho bên thứ ba khi chưa có sự đồng ý.</p>
            </div>

            <div>
                <h3 class="font-semibold text-lg text-gray-800">5. Liên hệ</h3>
                <p>Nếu có thắc mắc, vui lòng liên hệ qua email
                    <span class="text-blue-600">Kachi-Kun-Shop@gmail.com</span>.
                </p>
            </div>

        </div>

    </div>
</main>
<!-- Footer -->
<jsp:include page="components/footer.jsp"/>

</body>
</html>