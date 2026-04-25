<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Liên Hệ - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <script src="https://cdn.tailwindcss.com"></script>

    <style>

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-in-up {
            animation: fadeInUp 0.8s ease-out forwards;
        }


        .glass-panel {
            background: rgba(17, 24, 39, 0.85);
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body class="bg-gray-100 font-['Montserrat'] flex flex-col min-h-screen">

<jsp:include page="components/header2.jsp"/>

<div class="flex-grow flex items-center justify-center py-16 px-4 relative overflow-hidden">

    <div class="absolute top-0 left-0 w-full h-full opacity-10 pointer-events-none z-0">
        <img src="https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=2070&auto=format&fit=crop"
             class="w-full h-full object-cover">
    </div>

    <div class="max-w-6xl w-full bg-white rounded-2xl shadow-2xl overflow-hidden flex flex-col md:flex-row z-10 animate-fade-in-up">

        <div class="md:w-5/12 relative text-white p-10 flex flex-col justify-between"
             style="background-image: url('https://images.unsplash.com/photo-1593305841991-05c29736cec7?q=80&w=1000&auto=format&fit=crop'); background-size: cover; background-position: center;">

            <div class="absolute inset-0 bg-gradient-to-br from-slate-900/90 to-blue-900/80 z-0"></div>

            <div class="relative z-10">
                <h2 class="text-4xl font-extrabold mb-2 tracking-wide text-transparent bg-clip-text bg-gradient-to-r from-pink-400 to-blue-400">
                    Get in Touch
                </h2>
                <p class="text-gray-300 mb-8 font-medium">Bạn có thắc mắc về sản phẩm? Team Kachi-Kun luôn sẵn sàng hỗ
                    trợ 24/7.</p>

                <div class="space-y-6">
                    <div class="flex items-start group">
                        <div class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-pink-500 transition duration-300 shrink-0">
                            <i class="fas fa-map-marker-alt text-xl"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-lg">Địa chỉ Store</h4>
                            <p class="text-sm text-gray-300">Khu phố 6, Linh Trung, Thủ Đức<br>TP. Hồ Chí Minh</p>
                        </div>
                    </div>

                    <div class="flex items-start group">
                        <div class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-blue-500 transition duration-300 shrink-0">
                            <i class="fas fa-phone-alt text-xl"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-lg">Hotline</h4>
                            <p class="text-sm text-gray-300">+84 862 210 723<br>Hỗ trợ kỹ thuật: Phím 1</p>
                        </div>
                    </div>

                    <div class="flex items-start group">
                        <div class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-purple-500 transition duration-300 shrink-0">
                            <i class="fas fa-envelope text-xl"></i>
                        </div>
                        <div class="ml-4">
                            <h4 class="font-bold text-lg">Email</h4>
                            <p class="text-sm text-gray-300">support@kachikun.com<br>jobs@kachikun.com</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="relative z-10 mt-10 rounded-xl overflow-hidden shadow-lg border-2 border-white/20 h-40">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.231171196204!2d106.8008654146215!3d10.86991836043217!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527587e9ad5bf%3A0xafa66f9c8be3c91!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBDw7RuZyBuZ2jhu4cgVGjDtG5nIHRpbiAtIMSQSFFHIFRQLkhDTQ!5e0!3m2!1svi!2s!4v1646732338875!5m2!1svi!2s"
                        width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </div>

        <div class="md:w-7/12 p-10 md:p-14 bg-white">

            <div class="mb-8">
                <h3 class="text-2xl font-bold text-gray-800">Gửi tin nhắn cho chúng tôi</h3>
                <p class="text-gray-500 text-sm mt-1">Vui lòng điền thông tin bên dưới, chúng tôi sẽ phản hồi trong vòng
                    24h.</p>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="bg-green-50 border-l-4 border-green-500 text-green-700 p-4 rounded mb-6 flex items-center animate-pulse">
                    <i class="fas fa-check-circle mr-3 text-xl"></i>
                    <span class="font-medium">${successMessage}</span>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded mb-6 flex items-center">
                    <i class="fas fa-exclamation-triangle mr-3 text-xl"></i>
                    <span class="font-medium">${errorMessage}</span>
                </div>
            </c:if>

            <form action="contact" method="post" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-user"></i>
                            </span>
                        <input type="text" name="fullname" required placeholder="Họ và tên"
                               class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white"
                               value="${sessionScope.user.fullName}">
                    </div>
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-envelope"></i>
                            </span>
                        <input type="email" name="email" required placeholder="Địa chỉ Email"
                               class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white"
                               value="${sessionScope.user.email}">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-phone"></i>
                            </span>
                        <input type="tel" name="phone" placeholder="Số điện thoại"
                               class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white">
                    </div>
                    <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                                <i class="fas fa-tag"></i>
                            </span>
                        <select name="subject" required
                                class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white">
                            <option value="">-- Chọn chủ đề --</option>
                            <option value="product_error">Lỗi sản phẩm</option>
                            <option value="return">Đổi / Trả</option>
                            <option value="consult">Tư vấn</option>
                            <option value="other">Khác</option>
                        </select>
                    </div>
                </div>

                <div class="relative group">
                        <span class="absolute top-3 left-0 flex items-center pl-3 text-gray-400 group-focus-within:text-pink-500 transition">
                            <i class="fas fa-pen"></i>
                        </span>
                    <textarea name="message" rows="4" required placeholder="Nội dung tin nhắn..."
                              class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-100 transition bg-gray-50 focus:bg-white"></textarea>
                </div>

                <button type="submit"
                        class="w-full bg-gradient-to-r from-pink-600 to-purple-600 hover:from-pink-700 hover:to-purple-700 text-white font-bold py-4 rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition duration-300 flex justify-center items-center text-lg uppercase tracking-wide">
                    <span>Gửi Tin Nhắn</span>
                    <i class="fas fa-paper-plane ml-3"></i>
                </button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="components/footer.jsp"/>
</body>
</html>