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

							
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
			<!-- 상위 카테고리 -->
			<h5>${highCate.name}</h5>	
				<hr>
			<h6>
				<span style="float:left">
					<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}">전체</a>
					<c:forEach var = "lowCate" items = "${lowCate}">
						<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}&lowCode=${lowCate.code}">${lowCate.name}</a>
					</c:forEach>
				</span>
				<span style="float:right">
					<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}&orderByType=code">등록순</a>
					<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}&orderByType=price">인기순</a>
					<a href = "${pageContext.request.contextPath}/product/productList?high_code=${high_code}&orderByType=sale_count">가격순</a>
				</span>
			</h6>
			<!-- 하위 카테고리 -->
				
			</div>
		</div>
		
		<div class="row ma-to-30 ma-bo-20">
		</div>
		<div class="row ma-bo-50" id="newArrivalList">
			<div class="col-md-10 col-md-offset-1">
				
				<c:forEach var = "product" items = "${productVO }">
					<div class="col-md-4 prod-desc ma-bo-50">
						<a href="${pageContext.request.contextPath }/product/productInfo?code=${product.code}">
							<img src = "${product.file_path }${product.thumbnail_name}" width = "300px" height = "300px">
						</a>	
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
		<div class="col-md-10 col-md-offset-1 pagination-div" style="margin-bottom: 30px;">
			<nav>
				<ul class="pagination">
					<c:if test="${paging.curBlock ne 1 }">
						<li class ="button_first"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}&curPage=${paging.startPage }">처음</a></li>
					</c:if>
					<c:if test="${paging.curPage ne 1 }">
						<li class ="button_previous"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}&curPage=${paging.prevPage }">이전</a></li>
					</c:if>
					<c:forEach var = "pageNumber" begin = "${paging.startPage }" end = "${paging.endPage }">
						<c:choose>
							<c:when test="${pageNumber eq paging.curPage }">
								<li class ="paginate_button active"><span>${pageNumber }</span></li>
							</c:when>
						</c:choose>
					</c:forEach>
					<c:if test = "${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">	
						<li class ="button_next"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}&curPage=${paging.nextPage }">다음</a></li>
					</c:if>
					<c:if test = "${paging.curBlock ne paging.blockCnt && paging.blockCnt > 0 }">
						<li class ="button_end"><a href="${pageContext.request.contextPath }/product/productList?high_code=${high_code}&curPage=${paging.endPage }">끝</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
		<!-- paging End -->
		<%@ include file="../includes/footer.jsp" %>

	</div>
	<!-- container div -->
</body>

</body>
</html>