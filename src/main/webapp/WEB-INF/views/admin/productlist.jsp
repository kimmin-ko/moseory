<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" href="/css/notice.css">
<script src="/resources/ckeditor/ckeditor.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모서리</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/notice.css">
</head>

<body>

	<%@ include file="../includes/sidebar.jsp"%>
	<script>
	
	</script>
	<div class="container" style="margin-left: 22%;">
	
		<!-- Notice Start -->
		<div class="row">
			<div class="col-md-10 col-md-offset-1 noticeLabel-row">
				<h2>Product List</h2>
			</div>
		</div>
		<!-- row -->

		<div class="row" >
			<div class="col-md-10 col-md-offset-1">
				<table class="table notice-board table-hover">
					<thead>
						<tr>
							<td width = "10%" align = "center">NO</td>
							<td width = "20%" align="center">상품명</td>
							<td width = "20%" align="center">색상</td>
							<td width = "10%" align="center">가격</td>
							<td width = "20%" align="center">카테고리</td>
							<td width = "10%" align="center">좋아요</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var = "products" items="${productList}" varStatus="status">
							<tr onclick = "window.location='${pageContext.request.contextPath}/product/productInfo?code=${products.code }'">
								<td>${products.code }	</td>
								<td>${products.name }</td>
								<td>색깔	</td>
								<td>${products.price }	</td>
								<td>${highCates[status.index] }/${lowCates[status.index] }</td>
								<td>${products.wish_count }	</td>
							</tr>
							
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<form method = "get" action = "${pageContext.request.contextPath }/admin/productlist">
			<div class="col-md-10 col-md-offset-1">
				<span class="form-inline search-area">
					<select class="form-control" name = "searchType" style="width: 130px">
						<option value="name">상품명</option>
						<option value="high_code">상위카테고리</option>
						<option value="low_code">하위카테고리</option>
					</select>
					<input type="text" name = "keyword" class="form-control" style="width: 180px;" required />
					<button class="btn btn-default submit">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
				</span>
			</div>
		</form>
		
		<div class="col-md-10 col-md-offset-1 pagination-div"
				style="margin-bottom: 30px;">
				<nav>
					<ul class="pagination">
						<c:if test="${paging.curBlock ne 1 }">
							<li class ="button_first"><a href="${pageContext.request.contextPath }/admin/productlist?curPage=${paging.startPage }">처음</a></li>
						</c:if>
						<c:if test="${paging.curPage ne 1 }">
							<li class ="button_previous"><a href="${pageContext.request.contextPath }/admin/productlist?curPage=${paging.prevPage }">이전</a></li>
						</c:if>
						<c:forEach var = "pageNumber" begin = "${paging.startPage }" end = "${paging.endPage }">
							<c:choose>
								<c:when test="${pageNumber eq paging.curPage }">
									<li class ="paginate_button active"><span>${pageNumber }</span></li>
								</c:when>
								<c:otherwise>
									<li class ="paginate_button"><a href = "${pageContext.request.contextPath }/admin/productlist?curPage=${pageNumber}">${pageNumber }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test = "${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">	
							<li class ="button_next"><a href="${pageContext.request.contextPath }/admin/productlist?curPage=${paging.nextPage }">다음</a></li>
						</c:if>
						<c:if test = "${paging.curBlock ne paging.blockCnt && paging.blockCnt > 0 }">
							<li class ="button_end"><a href="${pageContext.request.contextPath }/admin/productlist?curPage=${paging.endPage }">끝</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		
	</div>
</body>
</html>