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
	<jsp:useBean id="now" class="java.util.Date"/>
	
	<fmt:formatDate value='${now}' pattern='yyyyMMdd' var="nowDays"/>

	
	<!-- Page Content -->
	<div class="container" style="margin-left: 22%">
	
		
		<div class="row ma-bo-50">
			<div class="col-lg-10 col-lg-offset-1">
				<!-- <ul class="prod-list">
					<c:forEach var = "bests" items = "${bestProducts}" varStatus="status">
						<li>
							<div class = "best_title">
								<h2>
									<span>BEST. ${status.count}</span>
								</h2>
							</div>
							<div class = "thumnail">
								<a href = "${pageContext.request.contextPath }/product/productInfo?code=${bests.code }">
									<img src="" class="weekly-img">
								</a> 
							</div>
							<div class = "desc">
								<p>${bests.name }</p>
								<p>${bests.price }</p>
							</div>
						</li>
					</c:forEach>
				</ul> -->
			</div>
		</div>
		<!-- WEEKLY BEST ITEM ROW -->

							
		<form id="form" action="productList" method="get">
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
				<!-- 상위 카테고리 -->
				
				<div style="float:left;">
					${highCate.name}
				</div>
				<div style="float:right;">
					<button type="button" class="btn-link" id="code_btn">등록순</button>
					<button type="button" class="btn-link" id="name_btn">이름순</button>
					<button type="button" class="btn-link" id="sale_count_btn">인기순</button>
					<button type="button" class="btn-link" id="price_btn">가격순</button>
				</div><hr/>
				<h6>
					<span style="float:left">
						<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}">전체</a>
						<c:forEach var = "lowCate" items = "${lowCate}">
							<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}&low_code=${lowCate.code}">${lowCate.name}</a>
						</c:forEach>
					</span>
						
				</h6>
				<!-- 하위 카테고리 -->
					
				</div>
			</div>
			<input type="hidden" name="high_code" value="${high_code }"/>
			<input type="hidden" name="low_code" value="${low_code }"/>
		</form>
		
		

		<c:if test="${!empty productVO }">
			<div class="row ma-to-30 ma-bo-20">
			</div>
			<div class="row ma-bo-50" id="newArrivalList">
				<div class="col-md-10 col-md-offset-1">				
					<c:forEach var = "product" items = "${productVO }">
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
							<p class="comment">${product.product_comment}</p> 
						</div>
					</c:forEach> 
				</div>
			</div>
		
			<!-- NEW ARRIVAL ROW -->
			<div class="col-md-10 col-md-offset-1 pagination-div" style="margin-bottom: 30px;">
				<nav>
					<ul class="pagination">
						<c:if test="${paging.curBlock ne 1 }">
							<li class ="button_first"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}
							<c:if test="${!empty low_code}">&low_code=${low_code}</c:if>
							&curPage=${paging.startPage }">처음</a></li>
						</c:if>
						<c:if test="${paging.curPage ne 1 }">
							<li class ="button_previous"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}
							<c:if test="${!empty low_code}">&low_code=${low_code}</c:if>
							&curPage=${paging.prevPage }">이전</a></li>
						</c:if>
						<c:forEach var = "pageNumber" begin = "${paging.startPage }" end = "${paging.endPage }">
							<c:choose>
								<c:when test="${pageNumber eq paging.curPage }">
									<li class ="paginate_button active"><span>${pageNumber }</span></li>
								</c:when>
							</c:choose>
						</c:forEach>
						<c:if test = "${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">	
							<li class ="button_next"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}
							<c:if test="${!empty low_code}">&low_code=${low_code}</c:if>
							&curPage=${paging.nextPage }">다음</a></li>
						</c:if>
						<c:if test = "${paging.curBlock ne paging.blockCnt && paging.blockCnt > 0 }">
							<li class ="button_end"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}
							<c:if test="${!empty low_code}">&low_code=${low_code}</c:if>
							&curPage=${paging.endPage }">끝</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</c:if>
		<c:if test="${empty productVO }">
	       	<img class="img_null_product" src="/images/Preparing.jpg">
		</c:if>
		<!-- paging End -->
		<%@ include file="../includes/footer.jsp" %>

	</div>
	<!-- container div -->
</body>
<script>
$(document).ready(function(){
	var form = $("#form");
	var html = "";
	$("#code_btn").click(function(){
		html += '<input type="hidden" name="orderByType" value="code"/>';
		form.append(html);
		form.submit();
	});
	$("#sale_count_btn").click(function(){
		html += '<input type="hidden" name="orderByType" value="sale_count"/>';
		form.append(html);
		form.submit();
	});
	$("#name_btn").click(function(){
		html += '<input type="hidden" name="orderByType" value="name"/>';
		form.append(html);
		form.submit();
	});
	$("#price_btn").click(function(){
		html += '<input type="hidden" name="orderByType" value="price"/>';
		form.append(html);
		form.submit();
	});
})
</script>

</body>
</html>
