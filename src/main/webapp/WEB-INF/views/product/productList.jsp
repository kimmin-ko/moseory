<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
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

	<%@ include file="../includes/sidebar.jsp" %>

	<!-- Page Content -->
	<div class="container" style="margin-left: 22%">

		
		<div class="row ma-bo-50">
			<div class="col-lg-10 col-lg-offset-1">
				<ul class="prod-list">
					<li>
						<div class = "best_title">
							<h2>
								<span>BEST.1</span>
							</h2>
						</div>
						<div class = "thumnail">
							<a href = "#">
								<img src="/images/1.jpg" class="weekly-img">
							</a>
						</div>
						<div class = "desc">
							<p>포니 헨리 넥 셔츠</p>
							<p>37,000원</p>
						</div>
					</li>
					<li>
						<div class = "best_title">
							<h2>
								<span>BEST.2</span>
							</h2>
						</div>
						<div class = "thumnail">
							<a href = "#">
								<img src="/images/1.jpg" class="weekly-img">
							</a>
						</div>
						<div class = "desc">
							<p>스프라이트 보트넥 티셔츠</p>
							<p>29,000원</p>
						</div>
					</li>
					<li>
						<div class = "best_title">
							<h2>
								<span>BEST.3</span>
							</h2>
						</div>
						<div class = "thumnail">
							<a href = "#">
								<img src="/images/1.jpg" class="weekly-img">
							</a>
						</div>
						<div class = "desc">
							<p>쿼츠 컷팅 데님 팬츠</p>
							<p>39,000원</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- WEEKLY BEST ITEM ROW -->

							
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
			<!-- 상위 카테고리 -->
			<h5>${highCate.name}</h5>	
				<hr>
			<h6>
				<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}">전체</a>
				<c:forEach var = "lowCate" items = "${lowCate}">
					<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}&lowCode=${lowCate.code}">${lowCate.name}</a>
				</c:forEach>
			</h6>
			<!-- 하위 카테고리 -->
				
			</div>
		</div>
		
		<div class="row ma-to-30 ma-bo-20">
			<div class="col-md-10 col-md-offset-1" style="font-weight: bold;">NEW
				ARRIVAL</div>
		</div>
		<div class="row ma-bo-50" id="newArrivalList">
			<div class="col-md-10 col-md-offset-1">
				
				<c:forEach var = "product" items = "${productVO }">
					<div class="col-md-4 prod-desc ma-bo-50">
						<a href="${pageContext.request.contextPath }/product/productInfo?code=${product.code}"><img src="/images/001.gif"></a>
						<p>
							<a href = "${pageContext.request.contextPath }/product/productInfo?code=${product.code}">${product.name }</a>
						</p>
						<p>${product.price }</p>
						<p>comment</p>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- NEW ARRIVAL ROW -->

		<%@ include file="../includes/footer.jsp" %>

	</div>
	<!-- container div -->
</body>

</body>
</html>