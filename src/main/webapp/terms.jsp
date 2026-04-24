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
    <title>Terms of Service</title>
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
<main class="flex-grow bg-white p-6">
    <div class="max-w-5xl mx-auto mt-10 bg-white p-8 rounded-2xl shadow-lg">

        <h2 class="text-3xl font-bold text-gray-800 mb-6">Điều khoản sử dụng</h2>

        <div class="space-y-6 text-gray-600">

            <p>
                Khi sử dụng website của chúng tôi, bạn đồng ý tuân thủ các điều khoản và điều kiện được đề ra.
            </p>

            <p>
                Bạn không được sử dụng dịch vụ vào mục đích sai trái hoặc vi phạm pháp luật hiện hành.
            </p>

            <p>
                Chúng tôi có quyền thay đổi, cập nhật các điều khoản bất cứ lúc nào mà không cần thông báo trước.
            </p>

            <p>
                Mọi nội dung trên website đều thuộc quyền sở hữu của <strong>Kachi-Kun Shop</strong>.
            </p>

        </div>

    </div>
</main>
<jsp:include page="components/footer.jsp"/>
</body>
</html>