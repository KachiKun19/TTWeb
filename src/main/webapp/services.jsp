<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/22/2026
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Services</title>
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
    <div class="max-w-6xl mx-auto mt-10 bg-white p-8 rounded-2xl shadow-lg">

        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Dịch vụ của chúng tôi</h2>

        <div class="grid md:grid-cols-3 gap-6">

            <div class="bg-blue-50 p-6 rounded-xl text-center hover:shadow-lg transition">
                <h3 class="text-xl font-semibold text-blue-600 mb-2">Thiết kế website</h3>
                <p class="text-gray-600">Thiết kế giao diện hiện đại, thân thiện với người dùng.</p>
            </div>

            <div class="bg-blue-50 p-6 rounded-xl text-center hover:shadow-lg transition">
                <h3 class="text-xl font-semibold text-blue-600 mb-2">Phát triển website</h3>
                <p class="text-gray-600">Xây dựng hệ thống web chất lượng cao và dễ mở rộng.</p>
            </div>

            <div class="bg-blue-50 p-6 rounded-xl text-center hover:shadow-lg transition">
                <h3 class="text-xl font-semibold text-blue-600 mb-2">Marketing</h3>
                <p class="text-gray-600">Tăng độ nhận diện thương hiệu với chiến lược marketing hiệu quả.</p>
            </div>

        </div>

    </div>
</main>

<jsp:include page="/components/footer.jsp"/>


</body>
</html>
