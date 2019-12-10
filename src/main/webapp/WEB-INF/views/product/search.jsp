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
    .resultArea {
			overflow: hidden;
			border: 1px solid #d7d5d5;
			text-align: right;
			line-height: 38px;
    }
    .resultArea p{
		margin: 0;
	    float: left;
	    padding: 0 0 0 8px;
	    color: #000;
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
										<option <c:if test = "${param.searchType == 'name' }">selected</c:if> value = "name">상품명</option>
										<option <c:if test = "${param.searchType == 'high_code' }">selected</c:if> value = "high_code">상위카테고리</option>
										<option <c:if test = "${param.searchType == 'low_code' }">selected</c:if> value = "low_code">하위카테고리</option>
									</select>
									<input type = "text" value = "${param.keyword }" name = "keyword" required>
								</td>
							</tr>
							<tr>
								<th>제외검색어</th>
								<td><input type = "text" value = "${param.exceptkeyword }" name = "exceptkeyword"></td>
							</tr>
							<tr>
								<th>판매가격대</th>
								<td><input type = "text" value = "${param.lowestprice }" name = "lowestprice">-<input type = "text" value = "${param.highestprice }" name = "highestprice"></td>
							</tr>
							<tr>
								<th>검색정렬기준</th>
								<td>
									<select name = "orderby">
										<option>::: 기준 선택 :::</option>
										<option <c:if test = "${param.orderby == 'code' }">selected</c:if> value = "code">상품코드 순</option>
										<option <c:if test = "${param.orderby == 'name' }">selected</c:if> value = "name">상품명 순</option>
										<option <c:if test = "${param.orderby == 'price' }">selected</c:if> value = "price asc">낮은가격 순</option>
										<option <c:if test = "${param.orderby == 'price' }">selected</c:if> value = "price desc">높은가격 순</option>
										<option <c:if test = "${param.orderby == 'wish_count' }">selected</c:if> value = "wish_count">인기 순</option>
									</select>
								</td>
							</tr>
						</table>
						<div class = "searchButton  text-center">
							<input type = "submit" value = "검색" class = "btn btn-default">
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class = "row">
			<div class="row ma-bo-50">
				<div class="col-md-10 col-md-offset-1 resultArea">
					<p>총 ${resultCount} 개의 상품이 검색되었습니다.</p>
				</div>
			</div>
		</div>
		<div class = "row">
			<div class="row ma-bo-50" id="productlist">
				<div class="col-md-10 col-md-offset-1">
					<c:forEach var = "resultProduct" items="${resultProduct }">
						<div class="col-md-3 prod-desc ma-bo-50">
							<a href="${pageContext.request.contextPath }/product/productInfo?code=${resultProduct.code}">
								<img src = "${resultProduct.file_path }${resultProduct.thumbnail_name}" width = "200px" height = "200px">
							</a>
							<div class = "info">
								<p><a href = "${pageContext.request.contextPath }/product/productInfo?code=${resultProduct.code}">${resultProduct.name }</a></p>
								<p>${resultProduct.price }</p>
								<p>${fn:substring(resultProduct.product_comment, 0, 20) }</p> 
							</div>
						</div>							
					</c:forEach>	
				</div>
			</div>
		</div>
		
		
		
		<div class="col-md-10 col-md-offset-1 pagination-div" style="margin-bottom: 30px;">
				<nav>
					<ul class="pagination">
						<c:if test="${paging.curBlock ne 1 }">
							<li class ="button_first"><a href="${pageContext.request.contextPath }/product/search?
																																							curPage=${paging.startPage }&
																																							searchType=${param.searchType}&
																																							keyword=${param.keyword}&
																																							exceptkeyword=${param.exceptkeyword}&
																																							lowestprice=${param.lowestprice}&
																																							highestprice=${param.highestprice}">처음</a></li>
						</c:if>
						<c:if test="${paging.curPage ne 1 }">
							<li class ="button_previous"><a href="${pageContext.request.contextPath }/product/search?
																												curPage=${prevPage}&
																												searchType=${param.searchType}&
																												keyword=${param.keyword}&
																												exceptkeyword=${param.exceptkeyword}&
																												lowestprice=${param.lowestprice}&
																												highestprice=${param.highestprice}">이전</a></li>
						</c:if>
						<c:forEach var = "pageNumber" begin = "${paging.startPage }" end = "${paging.endPage }">
							<c:choose>
								<c:when test="${pageNumber eq paging.curPage }">
									<li class ="paginate_button active"><span>${pageNumber }</span></li>
								</c:when>
								<c:otherwise>
									<li class ="paginate_button"><a href = "${pageContext.request.contextPath }/product/search?
																												curPage=${pageNumber}&
																												searchType=${param.searchType}&
																												keyword=${param.keyword}&
																												exceptkeyword=${param.exceptkeyword}&
																												lowestprice=${param.lowestprice}&
																												highestprice=${param.highestprice}">${pageNumber }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test = "${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">	
							<li class ="button_next"><a href="${pageContext.request.contextPath }/product/search?
																																							curPage=${paging.nextPage }
																																							searchType=${param.searchType}&
																																							keyword=${param.keyword}&
																																							exceptkeyword=${param.exceptkeyword}&
																																							lowestprice=${param.lowestprice}&
																																							highestprice=${param.highestprice}">${pageNumber }다음</a></li>
						</c:if>
						<c:if test = "${paging.curBlock ne paging.blockCnt && paging.blockCnt > 0 }">
							<li class ="button_end"><a href="${pageContext.request.contextPath }/product/search?
																																						curPage=${paging.endPage }
																																						searchType=${param.searchType}&
																																						keyword=${param.keyword}&
																																						exceptkeyword=${param.exceptkeyword}&
																																						lowestprice=${param.lowestprice}&
																																						highestprice=${param.highestprice}">${pageNumber }끝</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		
	</div>
</body>
</html>