<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모서리</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/wishList.css">
</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%;">

    <!-- WishList Start -->
    <div class="col-md-10 col-md-offset-1 wishlist-Label">
        <p>WISHLIST</p>
    </div>
    
    <div class="col-md-10 col-md-offset-1 wl-list">
		
		<c:if test="${wishList ne null }">
			<c:forEach var="wish" items="${wishList.products }">
	        <div class="col-md-3 wl-prod">
	            <div class="col-md-4">
	                <img src='<c:out value="${wish.file_path }" />'>
	            </div>
	            <div class="col-md-8">
	                <p><a href="/product/productInfo?code=<c:out value='${wish.code }' />"><c:out value="${wish.name }" /></a></p>
	                <p><fmt:formatNumber value="${wish.price }" pattern="#,###" />원</p>
	                <p class="wl-count">
	                	<i class="glyphicon glyphicon-heart"></i>&nbsp;
	                	<fmt:formatNumber value="${wish.wish_count }" pattern="#,###" />
	                </p>
	                <p><button type="button" class="btn btn-wl-delete" onclick="deleteWishList(${wish.code })">삭제</button></p>
	            </div>
	        </div>
	        </c:forEach>
		</c:if>
    </div>
    <!-- Wish List End -->    
    
	<%@ include file="../includes/footer.jsp" %>
	
	
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	// wish list 삭제
	function deleteWishList(product_code) {
		
		var member_id = "${user.id}";
		
		var param = {
			member_id : member_id, 
			product_code : product_code
		};
		
		$.ajax({
			type : 'post',
			url : '/user/deleteWishList',
			data : JSON.stringify(param),
			contentType : 'application/json; charset=utf-8',
			dataType : 'text',
			success : function(data) {
				if(data == 'success') {
					alert("해당 상품이 WISHLIST에서 삭제되었습니다.");
					location.reload(true);
				} else {
					alert("해당 상품이 WISHLIST에 존재하지 않습니다.");
					location.reload(true);
				}
			}
		});
		
	} // deleteWishLsit
</script>

</body>
</html>









