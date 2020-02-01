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
	
	<script type="text/javascript">
		$(document).ready(function() {
			var withdrawal_result = '<c:out value="${withdrawal_result}" />';
			
			checkAlert(withdrawal_result);
			
			history.replaceState({}, null, null);
			
			function checkAlert(result) {
				if(result === '' || history.state) {
					return;
				}
				
				alert(result);
				
			} 
			
		});
	</script>

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
						<img src='<c:out value="${product.file_path.concat(product.thumbnail_name) }" />' class="weekly-img" />
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
				
						<div class="col-md-4 prod-desc ma-bo-50 description">
							<a href="${pageContext.request.contextPath }/product/productInfo?code=${product.code}">
								<img src = "${product.file_path }${product.thumbnail_name}" width = "300px" height = "300px">
							</a>
							<p>
								<c:if test="${product.sale_count >= 5}"><img class="icon_img" src="/images/best.gif"></img></c:if>
								<fmt:parseDate var="regDate" value="${product.reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate var="regDates" value="${regDate}" pattern="yyyyMMdd"/>
								<c:if test="${(nowDays-regDates) le 30}">
									<img class="icon_img" src="/images/new.gif"></img>
								</c:if>
								<c:if test="${product.product_stock == 0}"><img class="icon_img" src="/images/soldout.gif"></img></c:if>
								<c:if test="${product.product_stock le 50 && product.product_stock != 0}"><img class="icon_img" src="/images/md.gif"></img></c:if>
								<c:if test="${product.wish_count >= 2}"><img class="icon_img" src="/images/good.gif"></img></c:if>
							</p>	
							<p>
								<a href = "${pageContext.request.contextPath }/product/productInfo?code=${product.code}">${product.name }</a>
							</p>
							<p><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}"/>원</p> 
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