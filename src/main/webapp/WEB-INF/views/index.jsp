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
<link rel="stylesheet" href="/css/sidebar.css">
<link rel="stylesheet" href="/css/footer.css">
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
				<ul class="prod-list">
					<li>
						<a href="/product/productInfo">
							<img src="/images/1.jpg" class="weekly-img">
							<div class="caption">
								<p>포니 헨리 넥 셔츠</p>
								<p>37,000원</p>
							</div>
						</a>
					</li>
					<li><img src="/images/2.jpg" class="weekly-img">
						<div class="caption">
							<p>스프라이트 보트넥 티셔츠</p>
							<p>29,000원</p>
						</div></li>
					<li><img src="/images/3.jpg" class="weekly-img">
						<div class="caption">
							<p>쿼츠 컷팅 데님 팬츠</p>
							<p>39,000원</p>
						</div></li>
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
			<div class="col-md-10 col-md-offset-1" style="font-weight: bold;">NEW
				ARRIVAL</div>
		</div>

		<div class="row ma-bo-50" id="newArrivalList">
			<div class="col-md-10 col-md-offset-1">
				<div class="col-md-4 prod-desc ma-bo-50">
					<a href="#"><img src="/images/001.gif"></a>
					<p>
						<a href="#">1+1 오버핏 셔츠 + 와이드 슬랙스</a>
					</p>
					<p>47,900원</p>
					<p>가격대비 가성비가 엄청 우수한 제품입니다. 노마진 제품! 적극 추천드립니다.</p>
				</div>
				<div class="col-md-4 prod-desc ma-bo-50">
					<img src="/images/002.gif">
					<p>1+1 베이직 셔츠+슬림 슬랙스</p>
					<p>42,900원</p>
					<p>가격대비 가성비가 엄청 우수한 제품입니다. 노마진 제품! 적극 추천드립니다.</p>
				</div>
				<div class="col-md-4 prod-desc ma-bo-50">
					<img src="/images/7.jpg">
					<p>1+1 20수 오버슬라브 티셔츠</p>
					<p>16,000원</p>
					<p>노마진 진행! 20가지 컬러와 M,L 사이즈 입니다.강츄!</p>
				</div>

				<div class="col-md-4 prod-desc ma-bo-50">
					<img src="/images/001.gif">
					<p>1+1 오버핏 셔츠 + 와이드 슬랙스</p>
					<p>47,900원</p>
					<p>가격대비 가성비가 엄청 우수한 제품입니다. 노마진 제품! 적극 추천드립니다.</p>
				</div>
				<div class="col-md-4 prod-desc ma-bo-50">
					<img src="/images/002.gif">
					<p>1+1 베이직 셔츠+슬림 슬랙스</p>
					<p>42,900원</p>
					<p>가격대비 가성비가 엄청 우수한 제품입니다. 노마진 제품! 적극 추천드립니다.</p>
				</div>
				<div class="col-md-4 prod-desc ma-bo-50">
					<img src="/images/7.jpg">
					<p>1+1 20수 오버슬라브 티셔츠</p>
					<p>16,000원</p>
					<p>노마진 진행! 20가지 컬러와 M,L 사이즈 입니다.강츄!</p>
				</div>
			</div>
		</div>
		<!-- NEW ARRIVAL ROW -->

		<%@ include file="includes/footer.jsp" %>

	</div>
	<!-- container div -->
</body>

</body>
</html>