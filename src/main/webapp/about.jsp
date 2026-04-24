<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/22/2026
  Time: 3:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>About Us</title>
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
</head>

<body class="flex flex-col min-h-screen">

<jsp:include page="components/header2.jsp"/>

<!-- Content -->
<main class="flex-grow bg-white p-6">
    <div class="max-w-5xl mx-auto mt-10 bg-white p-8 rounded-2xl shadow">
        <p class="text-gray-600 mb-4">
            Chào mừng bạn đến với
            <span class="font-semibold text-blue-600">Kachi-Kun Shop</span> —
            nơi cung cấp các sản phẩm chất lượng và trải nghiệm mua sắm tuyệt vời.
        </p>

        <p class="text-gray-600 mb-4">
            Chúng tôi luôn nỗ lực mang đến sản phẩm tốt với giá hợp lý,
            giao hàng nhanh chóng và dịch vụ khách hàng tận tâm.
        </p>

        <p class="text-gray-600 mb-6">
            Sứ mệnh của chúng tôi là mang lại sự tiện lợi và hài lòng cho khách hàng mỗi ngày.
        </p>

        <!-- Stats -->
        <div class="grid grid-cols-3 gap-6 text-center mt-8">
            <div class="bg-blue-50 p-4 rounded-xl">
                <h3 class="text-2xl font-bold text-blue-600">1000+</h3>
                <p class="text-gray-500">Khách hàng</p>
            </div>
            <div class="bg-blue-50 p-4 rounded-xl">
                <h3 class="text-2xl font-bold text-blue-600">500+</h3>
                <p class="text-gray-500">Sản phẩm</p>
            </div>
            <div class="bg-blue-50 p-4 rounded-xl">
                <h3 class="text-2xl font-bold text-blue-600">24/7</h3>
                <p class="text-gray-500">Hỗ trợ</p>
            </div>
        </div>

    </div>
</main>

<jsp:include page="components/footer.jsp"/>

</body>
</html>