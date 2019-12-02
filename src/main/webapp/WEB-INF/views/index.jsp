<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/index.css">
</head>
<body>

	<%@ include file="includes/sidebar.jsp" %>

	<!-- Page Content -->
	<div class="container" style="margin-left: 22%">

		<div class="row ma-to-30 ma-bo-10">
			<div class="col-lg-10 col-lg-offset-1" style="font-weight: bold;">WEEKLY BEST ITEM</div>
		</div>

		<div class="row ma-bo-50">
			<div class="col-lg-10 col-lg-offset-1">
			
				<ul class="prod-list"> <!-- 3개의 상품만 출력 -->
					<c:forEach var="product" items="${productSaleCount }" begin="0" end="2">
					<li>
						<img src=" class="weekly-img">
						<div class="caption" onclick='location.href="/product/productInfo?code=<c:out value='${product.code }' />"'>
							<p><c:out value="${product.name }" /></p>
							<p><fmt:formatNumber value="${product.price }" pattern="#,###" />원</p>
						</div>
					</li>
					</c:forEach>
				</ul>
				
			</div>
		</div>
		<!-- WEEKLY BEST ITEM ROW -->

		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<hr>
			</div>
		</div>

		<div class="row ma-to-30 ma-bo-20">
			<div class="col-md-10 col-md-offset-1" style="font-weight: bold;">NEW ARRIVAL</div>
		</div>

		<div class="row ma-bo-50" id="newArrivalList">
			<div class="col-md-10 col-md-offset-1">
				<c:forEach var="product" items="${productNew }">
				<div class="col-md-4 prod-desc ma-bo-50">
					<a href="/product/productInfo?code=<c:out value='${product.code }' />">
						<img src=''></a>
					<p> 
						<a href="#"><c:out value="${product.name }" /></a>
					</p>
					<p><fmt:formatNumber value="${product.price }" pattern="#,###" />원</p>
				</div>
				</c:forEach>
			</div>
		</div>
		<!-- NEW ARRIVAL ROW -->

		<%@ include file="includes/footer.jsp" %>

	</div>
	<!-- container div -->
</body>

</body>
</html>