<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<%@ page import="com.kachikun.shop.dao.CategoryDAO"%>
<%@ page import="com.kachikun.shop.model.Category"%>
<%@ page import="java.util.List"%>

<%

	CategoryDAO dao = new CategoryDAO();
	List<Category> list = dao.getAllCategories();


	request.setAttribute("listCategories", list);
%>
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
			rel="stylesheet" />
	<link
			href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css"
			rel="stylesheet" />

	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
		  integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
		  crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<%@ include file="components/header.jsp" %>

<main class="main-content">
	<section class="product-categories bg-white">
		<div class="container">
			<div class="category-wrapper" style="position: relative;">

				<button class="nav-btn prev-btn" id="btnPrev">
					<i class="fas fa-chevron-left"></i>
				</button>

				<div class="category-grid" id="categoryList">
					<c:forEach items="${listCategories}" var="cate">
						<a href="products?category=${cate.name}" class="category-item">
							<i class="${cate.icon}"></i> <span>${cate.name}</span>
						</a>
					</c:forEach>
				</div>

				<button class="nav-btn next-btn" id="btnNext">
					<i class="fas fa-chevron-right"></i>
				</button>

			</div>
		</div>
	</section>
</main>

<%@ include file="components/footer.jsp" %>

</body>
</html>