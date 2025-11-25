<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png" />
    <link rel="stylesheet" href="style.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
      integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
      rel="stylesheet"
    />
  </head>
  <body>
    <div class="top-bar">
      <ul class="bar-list">
        <li><a href="#">Tư vấn chuẩn, chọn đúng gear</a></li>
        <li><a href="#">Bảo hành gọn, xử lí nhanh</a></li>
        <li><a href="#">Giao nhanh 0-3 ngày</a></li>
        <li><a href="#">Miễn phí ship từ 1 triệu</a></li>
        <li><a href="#">Trả góp 0%</a></li>
      </ul>
    </div>

    <div class="header-banner-wrapper">
      <header class="main-header">
        <div class="container">
          <div class="logo">
            <a href="index4.html" class="flex items-center">
              <img
                src="images/LogoChuan.png"
                alt="Kachi-Kun Shop Logo"
                class="logo-img w-24 h-auto"
              />

              <span class="text-white text-xl font-bold ml-0 whitespace-nowrap">
                Kachi-Kun Shop
              </span>
            </a>
          </div>

          <nav class="nav">
            <ul class="nav-list">
              <li>
                <a
                  href="#"
                  class="flex items-center"
                  data-dropdown-toggle="dropdownGaming"
                >
                  Gaming Gear <i class="fas fa-chevron-down ml-1 text-xs"></i>
                </a>
                <div
                  id="dropdownGaming"
                  class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700"
                >
                  <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                    <li>
                      <a
                        href="#"
                        class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                        >Chuột Gaming</a
                      >
                    </li>
                    <li>
                      <a
                        href="#"
                        class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                        >Bàn phím cơ</a
                      >
                    </li>
                    <li>
                      <a
                        href="#"
                        class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                        >Tai nghe</a
                      >
                    </li>
                  </ul>
                </div>
              </li>
              <li>
                <a
                  href="#"
                  class="flex items-center"
                  data-dropdown-toggle="dropdownOffice"
                >
                  Office Gear <i class="fas fa-chevron-down ml-1 text-xs"></i>
                </a>
                <div
                  id="dropdownOffice"
                  class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700"
                >
                  <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                    <li>
                      <a
                        href="#"
                        class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                        >Ghế công thái học</a
                      >
                    </li>
                    <li>
                      <a
                        href="#"
                        class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                        >Bàn nâng hạ</a
                      >
                    </li>
                    <li>
                      <a
                        href="#"
                        class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white"
                        >Phụ kiện</a
                      >
                    </li>
                  </ul>
                </div>
              </li>
              <li><a href="#">Liên Hệ</a></li>
            </ul>
          </nav>

          <div class="flex items-center space-x-8 text-white">
            <a
              href="#"
              id="open-search"
              class="text-xl transition-opacity duration-200 hover:opacity-80"
            >
              <i class="fas fa-search"></i>
            </a>

            <a
              href="#"
              class="text-xl transition-opacity duration-200 hover:opacity-80"
            >
              <i class="fas fa-user"></i>
            </a>

            <a
              href="#"
              id="open-cart"
              class="text-xl transition-opacity duration-200 hover:opacity-80"
            >
              <i class="fas fa-shopping-basket"></i>
            </a>
          </div>
        </div>
      </header>

      <section class="banner-section">
        <div
          id="banner-background"
          class="banner-bg"
          style="
            background-image: url('https://cdn.sforum.vn/sforum/wp-content/uploads/2022/02/9-9-960x538.jpg');
          "
        ></div>

        <div class="banner-content">
          <p class="banner-subtitle">
            Story cho các streamer và game thủ lựa chọn!
          </p>
          <h1 class="banner-title">
            Tuyển thủ Kachi-Kun /<br />KhanhNgo Edition
          </h1>
          <a href="#" class="banner-button">Xem thêm</a>
        </div>

        <div class="slider-nav">
          <button class="dot active" data-slide="0">1</button>
          <button class="dot" data-slide="1">2</button>
          <button class="dot" data-slide="2">3</button>
          <button class="dot" data-slide="3">4</button>
        </div>
      </section>
    </div>
    <div id="cart-overlay" class="cart-overlay">
      <button id="close-cart" class="cart-overlay-close">&times;</button>
      <div class="cart-overlay-content">
        <h2>Giỏ hàng của bạn</h2>
        <div class="cart-items-container">
          <p class="cart-empty-message">Chưa có sản phẩm nào trong giỏ hàng.</p>
        </div>
      </div>
    </div>
    <div id="search-overlay" class="search-overlay">
      <button id="close-search" class="search-overlay-close">&times;</button>
      <div class="search-overlay-content">
        <input
          type="text"
          placeholder="Tìm kiếm..."
          class="search-overlay-input"
        />
      </div>
    </div>
    <main class="main-content">
      <section class="product-categories">
        <div class="container">
          <div class="category-grid">
            <a href="Product_test?category=mouse" class="category-item">
              <i class="fa-solid fa-mouse"></i>
              <span>Chuột gaming</span>
            </a>
            <a href="Product_test?category=keyboard" class="category-item">
              <i class="fa-solid fa-keyboard"></i>
              <span>Bàn phím cơ & HE</span>
            </a>
            <a href="Product_test?category=mousepad" class="category-item">
              <i class="fa-solid fa-tablet-screen-button"></i>
              <span>Lót chuột</span>
            </a>
            <a href="Product_test?category=chair" class="category-item">
              <i class="fa-solid fa-chair"></i>
              <span>Ghế công thái học</span>
            </a>
          </div>
        </div>
      </section>
      </main>

    <footer class="footer">
      <div class="container">
        <div>
          <h3>GROUP 14</h3>
          <p>
            Linh Trung Ward<br />
            Thu Duc - Ho Chi Minh City - Viet Nam<br />
            <strong>Phone:</strong> +0862210723<br />
            <strong>Email:</strong> group14@gmail.com
          </p>
          <div class="social-icons">
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-skype"></i></a>
            <a href="#"><i class="fab fa-linkedin-in"></i></a>
          </div>
        </div>
        <div>
          <h3>Useful Links</h3>
          <p><a href="#">Home</a></p>
          <p><a href="#">About us</a></p>
          <p><a href="#">Services</a></p>
          <p><a href="#">Terms of service</a></p>
          <p><a href="#">Privacy policy</a></p>
        </div>
        <div>
          <h3>Our Services</h3>
          <p><a href="#">Web Design</a></p>
          <p><a href="#">Web Development</a></p>
          <p><a href="#">Product Management</a></p>
          <p><a href="#">Marketing</a></p>
          <p><a href="#">Graphic Design</a></p>
        </div>
        <div>
          <h3>Our Newsletter</h3>
          <p>
            Your support is our greatest motivation. Join us for the best
            experience
          </p>
          <form class="newsletter">
            <input type="email" placeholder="Email" />
            <input type="submit" value="Subscribe" />
          </form>
        </div>
      </div>
    </footer>
    <div class="footer-bottom">
      <p>© Copyright <strong>GROUP 14</strong>. All Rights Reserved</p>
      <p>Designed by GROUP 14</p>
    </div>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="script.js"></script>
  </body>
</html>