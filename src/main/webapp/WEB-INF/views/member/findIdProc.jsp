<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="/css/find_id.css">
</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

	<div class="container" style="margin-left:22%">
	
	    <!-- Find Id Start -->
	    <div class="row" style="margin-top: 80px;">
	        <div class="col-md-10 col-md-offset-1 findIdLabel-row">
	            <p>MEMBER ID</p>
	        </div>
	    </div>
	
		<div class="findId">    
	        <p class="desc">고객님 아이디 찾기가 완료 되었습니다.</p>
	        <div class="memberInfo">
	            <p class="info">저희 쇼핑몰를 이용해주셔서 감사합니다.<br>다음정보로 가입된 아이디가 총 <span>${findIdCount}</span>개 있습니다.</p>
	            <ul>
					<!-- <li>이름 : <span>${name}</span></li>
	                <li>이메일 : <span>${email}</span></li> --> 
	                <li>
	                	<c:forEach var="model" items="${findIds}" varStatus="status"> 
	                		<label><input type="radio" name="fid" checked>
	                		<span class="id">${model.ID}</span> <span class="gaip">( 개인회원, ${model.join_date}가입 )</span></label><br>
	                	</c:forEach>
	                <li style="text-align:center">고객님 즐거운 쇼핑 하세요!</li>
	            </ul>
			</div>
		    <p class="copy">
			          고객님의 아이디 찾기가 성공적으로 이루어졌습니다. 항상 고객님의 <br>
			          즐겁고 편리한 쇼핑을 위해 최선의 노력을 다하는 쇼핑몰이 되도록 하겠습니다.
		    </p>
		    <p class="button">
		        <a href="/member/login" class="bu_board1 buboard1 ">로그인</a>
		        <a href="/member/findPw" class="bu_boardall buboarddall ">비밀번호 찾기</a>        
		    </p>
	    </div>
		<%@ include file="../includes/footer.jsp" %>
	</div>
</body>
<script>
$(document).ready(function(){

});
</script>
</html>