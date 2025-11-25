<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sản phẩm - Kachi-Kun Shop</title>
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
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
      integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
  </head>

  <body class="bg-white text-black">
    <div class="top-bar">
      <ul class="bar-list">
        <li><a href="#">Tư vấn chuẩn, chọn đúng gear</a></li>
        <li><a href="#">Bảo hành gọn, xử lí nhanh</a></li>
        <li><a href="#">Giao nhanh 0-3 ngày</a></li>
        <li><a href="#">Miễn phí ship từ 1 triệu</a></li>
        <li><a href="#">Trả góp 0%</a></li>
      </ul>
    </div>

    <header class="main-header sticky top-0 z-50" style="background-color: #1a1a1a">
      <div class="container">
        <div class="logo">
          <a href="home" class="flex items-center">
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
              <a href="#" class="flex items-center" data-dropdown-toggle="dropdownGaming">
                Gaming Gear <i class="fas fa-chevron-down ml-1 text-xs"></i>
              </a>
              <div id="dropdownGaming" class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
                <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                  <li><a href="products?category=mouse" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Chuột Gaming</a></li>
                  <li><a href="products?category=keyboard" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Bàn phím cơ</a></li>
                  <li><a href="products?category=headset" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Tai nghe</a></li>
                  </ul>
              </div>
            </li>
             <li>
                <a href="#" class="flex items-center" data-dropdown-toggle="dropdownOffice">
                    Office Gear <i class="fas fa-chevron-down ml-1 text-xs"></i>
                </a>
                <div id="dropdownOffice" class="z-50 hidden bg-black divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700">
                     <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Ghế công thái học</a></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Bàn nâng hạ</a></li>
                     </ul>
                </div>
            </li>
            <li><a href="#">Liên Hệ</a></li>
          </ul>
        </nav>

        <div class="flex items-center space-x-8 text-white">
          <a href="#" id="open-search" class="text-xl transition-opacity duration-200 hover:opacity-80"><i class="fas fa-search"></i></a>
          <a href="#" class="text-xl transition-opacity duration-200 hover:opacity-80"><i class="fas fa-user"></i></a>
          <a href="#" id="open-cart" class="text-xl transition-opacity duration-200 hover:opacity-80"><i class="fas fa-shopping-basket"></i></a>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="page-container">
        <div class="page-content active" id="page-category">
          <div class="container py-12">
            
            <div class="flex items-center mb-8">
              <c:set var="cat" value="${param.category}" />
              
              <c:if test="${cat == 'keyboard' || cat == 'headset'}">
                 <a href="products?category=${cat == 'keyboard' ? 'mouse' : 'keyboard'}" class="section-scroll-link mr-3" title="Quay lại">
                    <i class="fas fa-chevron-left"></i>
                 </a>
              </c:if>

              <h1 class="text-3xl font-bold">
                 <c:choose>
                    <c:when test="${not empty currentCategory}">
                        ${currentCategory.categoryName}
                    </c:when>
                    <c:otherwise>Tất cả sản phẩm</c:otherwise>
                 </c:choose>
              </h1>

              <c:if test="${empty cat || cat == 'mouse' || cat == 'keyboard'}">
                 <a href="products?category=${empty cat || cat == 'mouse' ? 'keyboard' : 'headset'}" class="section-scroll-link ml-3" title="Tiếp theo">
                    <i class="fas fa-chevron-right"></i>
                 </a>
              </c:if>
            </div>

            <div class="flex flex-col lg:flex-row lg:space-x-8">
              <aside class="w-full lg:w-1/4 mb-8 lg:mb-0">
                <div id="filter-accordion">
                  
                  <h2 id="filter-heading-brands">
                    <button type="button" class="flex items-center justify-between w-full py-5 font-semibold text-left text-gray-900 border-b border-gray-200">
                      <span class="text-base">Thương hiệu</span>
                      <svg data-accordion-icon class="w-4 h-4 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5"/>
                      </svg>
                    </button>
                  </h2>
                  <div id="filter-body-brands" class="filter-content" aria-labelledby="filter-heading-brands">
                    <div class="inner-list py-5 border-b border-gray-200 space-y-4">
                      <c:forEach var="brand" items="${brands}">
                          <div class="flex items-center">
                            <input id="filter-brand-${brand.brandId}" type="checkbox" value="${brand.brandId}" class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
                            <label for="filter-brand-${brand.brandId}" class="ml-3 text-sm font-medium text-gray-700">${brand.brandName}</label>
                          </div>
                      </c:forEach>
                      <c:if test="${empty brands}">
                          <p class="text-sm text-gray-500">Đang cập nhật...</p>
                      </c:if>
                    </div>
                  </div>

                  <h2 id="filter-heading-connection">
                    <button type="button" class="flex items-center justify-between w-full py-5 font-semibold text-left text-gray-900 border-b border-gray-200">
                      <span class="text-base">Kết nối</span>
                      <svg data-accordion-icon class="w-4 h-4 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5" />
                      </svg>
                    </button>
                  </h2>
                  <div id="filter-body-connection" class="filter-content" aria-labelledby="filter-heading-connection">
                    <div class="inner-list py-5 border-b border-gray-200 space-y-4">
                      <div class="flex items-center">
                        <input id="filter-connection-1" type="checkbox" value="wired" class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
                        <label for="filter-connection-1" class="ml-3 text-sm font-medium text-gray-700">Có dây</label>
                      </div>
                      <div class="flex items-center">
                        <input id="filter-connection-2" type="checkbox" value="bluetooth" class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
                        <label for="filter-connection-2" class="ml-3 text-sm font-medium text-gray-700">Bluetooth</label>
                      </div>
                      <div class="flex items-center">
                        <input id="filter-connection-3" type="checkbox" value="usb" class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
                        <label for="filter-connection-3" class="ml-3 text-sm font-medium text-gray-700">USB</label>
                      </div>
                    </div>
                  </div>

                  <h2 id="filter-heading-material">
                    <button type="button" class="flex items-center justify-between w-full py-5 font-semibold text-left text-gray-900 border-b border-gray-200">
                      <span class="text-base">Chất liệu</span>
                      <svg data-accordion-icon class="w-4 h-4 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5" />
                      </svg>
                    </button>
                  </h2>
                  <div id="filter-body-material" class="filter-content" aria-labelledby="filter-heading-material">
                    <div class="inner-list py-5 border-b border-gray-200 space-y-4">
                      <div class="flex items-center">
                        <input id="filter-material-1" type="checkbox" value="pbt" class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
                        <label for="filter-material-1" class="ml-3 text-sm font-medium text-gray-700">Carbon</label>
                      </div>
                      <div class="flex items-center">
                        <input id="filter-material-2" type="checkbox" value="abs" class="w-5 h-5 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" />
                        <label for="filter-material-2" class="ml-3 text-sm font-medium text-gray-700">Nhựa</label>
                      </div>
                    </div>
                  </div>
                  
                </div>
              </aside>

              <section class="w-full lg:w-3/4">
                <div class="flex justify-between items-center mb-6">
                  <span class="text-sm text-gray-600">
                    Hiển thị 
                    <c:choose>
                        <c:when test="${not empty products}">
                            ${products.size()}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                    sản phẩm
                  </span>
                  
                  <div>
                    <button id="dropdownDefaultButton" data-dropdown-toggle="dropdownSort" class="text-gray-700 bg-gray-100 hover:bg-gray-200 focus:ring-2 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center inline-flex items-center" type="button">
                      Sắp xếp: Mặc định <i class="fas fa-chevron-down ml-2"></i>
                    </button>
                    <div id="dropdownSort" class="z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-60">
                      <ul class="py-2 text-sm text-gray-700" aria-labelledby="dropdownDefaultButton">
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Ngày (từ mới đến cũ)</a></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Giá (từ thấp đến cao)</a></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Giá (từ cao đến thấp)</a></li>
                      </ul>
                    </div>
                  </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6" id="productGrid">
                  <c:choose>
                    <c:when test="${not empty products}">
                      <c:forEach var="p" items="${products}">
                        <div class="product-card border rounded-lg overflow-hidden shadow-sm hover:shadow-lg transition-shadow duration-300 group product-item"
                             data-brand="${p.brand.brandId}"
                             data-price="${p.price}"
                             data-stock="${p.stock > 0 ? 'inStock' : 'outOfStock'}">
                          
                          <a href="product-detail?id=${p.productId}" class="relative block">
                            <img
                              src="${not empty p.imageUrl ? p.imageUrl : 'https://via.placeholder.com/300x300'}"
                              alt="${p.name}"
                              class="w-full h-56 object-contain p-4"
                            />
                            
                            <c:if test="${p.stock <= 0}">
                                <div class="absolute top-2 left-2 bg-gray-500 text-white text-xs font-bold px-2 py-1 rounded">Hết hàng</div>
                            </c:if>

                            <div class="absolute inset-x-4 bottom-4">
                                <c:choose>
                                    <c:when test="${p.stock > 0}">
                                      <button class="w-full bg-blue-600 text-white font-semibold py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300 add-to-cart"
                                              data-id="${p.productId}">
                                        + Chọn nhanh
                                      </button>
                                    </c:when>
                                    <c:otherwise>
                                      <button class="w-full bg-gray-400 text-white font-semibold py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300 cursor-not-allowed" disabled>
                                        Hết hàng
                                      </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                          </a>

                          <div class="p-4">
                            <h3 class="font-semibold text-base h-16 overflow-hidden line-clamp-2">
                              <a href="product-detail?id=${p.productId}" class="hover:text-blue-600">
                                ${p.name}
                              </a>
                            </h3>
                            <p class="text-lg font-bold text-gray-800 mt-2">
                              <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                            </p>
                          </div>
                        </div>
                      </c:forEach>
                      </c:when>
                    <c:otherwise>
                        <div class="col-span-3 text-center py-12">
                            <p class="text-gray-500 text-lg">Không tìm thấy sản phẩm nào trong danh mục này.</p>
                        </div>
                    </c:otherwise>
                  </c:choose>
                </div>
              </section>
            </div>
          </div>
        </div>
      </div>
    </main>

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
            Your support is our greatest motivation. Join us for the best experience
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
    <script src="script.js"></script>
  </body>
</html>