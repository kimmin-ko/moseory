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
<style>
	.searchArea {
		margin: 0 0 20px;
	    padding: 17px 20px 35px 130px;
	    border: 5px solid #e8e8e8;
    }
</style>
<body>

	<%@ include file="../includes/sidebar.jsp"%>
	<script>
	
	</script>
	<div class="container" style="margin-left: 22%;">
		
		<!-- Notice Start -->
		<div class="row">
			<div class="col-md-10 col-md-offset-1 noticeLabel-row">
				<h2>Search</h2>
			</div>
		</div>
		<!-- row -->
		<div class = "row">
			<div class = "col-md-10 col-md-offset-1" >
				<div class = "searchArea">
					<form method = "get" action = "${pageContext.request.contextPath}/product/search">
						<table class="table notice-board">
							<tr>
								<th>상품분류</th>
								<td> 
									<select name = "searchType">
										<option>상품명</option>
									</select>
									<input type = "text" name = "keyword">
								</td>
							</tr>
							<tr>
								<th>제외검색어</th>
								<td><input type = "text" name = "exceptkeyword">
							</tr>
							<tr>
								<th>판매가격대</th>
								<td><input type = "text" name = "lowestprice">-<input type = "text" name = "highestprice">
							</tr>
							<tr>
								<th>검색정렬기준</th>
								<td>
									<select name = "orderby">
										<option>::: 기준 선택 :::</option>
										<option>신상품 순</option>
										<option value = "name">상품명 순</option>
										<option value = "price">낮은가격 순</option>
										<option value = "price">높은가격 순</option>
										<option value = "wish_count">인기 순</option>
										<option value = "">사용후기 순</option>
									</select>
								</td>
							</tr>
						</table>
						<div class = "searchButton  text-center">
							<input type = "submit" value = "검색" class = "btn btn-default">
						</div>
					</form>
				</div>
				
				<!-- <div class = "result_order">
					<p class = "result">
						총 개의 상품이 검색되었습니다.
					</p>
					<ul>
						<li>상품명 |</li>
						<li>낮은가격 |</li>
						<li>높은가격 |</li>
						<li>인기 |</li>
						<li>사용후기</li>
					</ul>
				</div> -->
			</div>
		</div>
		
		<div class = "row">
			<div class="row ma-bo-50" id="newArrivalList">
				<div class="col-md-10 col-md-offset-1">
						<div class="col-md-4 prod-desc ma-bo-50">
							<a href="#"><img src="/images/001.gif" width = "200px"></a>
							<div class = "info">
								<p><a href = "#">슬랙스</a></p>
								<p>30000</p>
								<p>comment</p>
							</div>
						</div>
				</div>
			</div>
		</div>
		
		
		
		<div class="col-md-10 col-md-offset-1 pagination-div" style="margin-bottom: 30px;">
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
									<li class ="paginate_button"><a href = "${pageContext.request.contextPath }/admin/productlist?curPage=${pageNumber}&searchType=${searchType}&keyword=${keyword}">${pageNumber }</a></li>
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