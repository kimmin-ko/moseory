<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/css/sidebar.css">

<!-- jquery js -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<!-- bootstrap js -->
<script src="/js/bootstrap.js"></script>

<script type="text/javascript">
//#,### formatNumber
Number.prototype.format = function() {
	if (this == 0)
		return 0;

	var reg = /(^[+-]?\d+)(\d{3})/;
	var n = (this + '');

	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');

	return n;
};

String.prototype.format = function() {
	var num = parseFloat(this);
	if (isNaN(num))
		return "0";

	return num.format();
};
</script>

<!-- Sidebar -->
<div class="w3-sidebar w3-light-grey w3-bar-block container" style="width: 22%">

	<div class="row brand-row">
		<div class="col-md-10 col-md-offset-2">
			<h3>
				<b><a href="/index">MOSEORY</a></b>
			</h3>
		</div>
	</div>

	<div class="row">
		<c:if test="${empty user}">
			<div class="col-md-3 col-md-offset-2 font-12">
				<a href="/member/login">LOG-IN</a>
			</div>
		</c:if>
		<c:if test="${!empty user}">
			<div class="col-md-3 col-md-offset-2 font-12">
				<a href="/user/logout">LOGOUT</a>
			</div>
			<c:if test="${user.auth == 1}">
				<div class="col-md-5 font-12">
					<a href="/admin/manage">MANAGE</a>
				</div>
			</c:if>
		</c:if>
		<c:if test="${empty user }">
			<div class="col-md-5 font-12 joinus">
				<a href="/member/join">JOIN US</a>
			</div>
		</c:if>
		<c:if test="${!empty user }">
			<div class="col-md-5 font-12 joinus">
				
			</div>
		</c:if>
	</div>

	<div class="row ma-bo-50">
		<div class="col-md-3 col-md-offset-2 font-12">
			<a href="/user/cart">CART</a>
		</div>
		<div class="col-md-5 font-12">
			<a href="/user/myPage">MY PAGE</a>
		</div>
	</div>
	
	<c:forEach var="cate" items="${highCateList}" varStatus="status">
		<div class="row ma-bo-5">
			<div class="col-md-10 col-md-offset-2">
				<a href="${pageContext.request.contextPath }/product/productList?high_code=${cate.code}">
					${cate.name }
				</a>&nbsp;<small class="cate-sm">${cate.kname}</small>
			</div>
		</div>
	</c:forEach>
	<form method="get" action = "${pageContext.request.contextPath }/product/search">
		<div class="row ma-bo-50 ma-to-30">
			<div class="col-md-10 col-md-offset-2 form-inline">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="검색어" name = "keyword"
						style="width: 120px;" required />
					<button class="btn btn-default submit">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
				</div>
			</div>
		</div>
	</form>
	<!-- search div -->
	<div class="row ma-bo-50">
		<div class="col-md-10 col-md-offset-2 font-12">
			<a href="/notice/noticeList">NOTICE</a>&nbsp; <a href="/qna/qnaList">Q&A</a>&nbsp;<a href="/review/reviewList">REVIEW</a>
		</div>
	</div>

	<div class="row">
		<div class="col-md-10 col-md-offset-2">
			<span class="glyphicon glyphicon-phone-alt"></span>&nbsp;010-3725-9670
		</div>
		<div class="col-md-10 col-md-offset-2 font-12">MON - FRI AM
			11:00 ~ PM 6:00</div>
		<div class="col-md-10 col-md-offset-2 font-12">LUNCH , PM 12:00
			~ PM 1:00</div>
		<div class="col-md-10 col-md-offset-2 font-12">SAT.SUN.HOLIDAY
			OFF</div>
	</div>

</div>
<!-- SIDEBAR -->
