<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<link rel="stylesheet" href="/css/sidebar.css">

<!-- jquery js -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<!-- bootstrap js -->
<script src="/js/bootstrap.js"></script>

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
				<a href="/member/logout">LOGOUT</a>
			</div>
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
			<a href="/cart/cartList">CART(0)</a>
		</div>
		<div class="col-md-5 font-12">
			<a href="/user/myPage">MY PAGE</a>
		</div>
	</div>

	<div class="row ma-bo-50">
		<div class="col-md-3 col-md-offset-2 font-12">
			<a href="/admin/productregist">상품등록</a>
		</div>
	</div>
	
	<div class="row ma-bo-5">
		<div class="col-md-10 col-md-offset-2">
			<a href="${pageContext.request.contextPath }/product/productList?high_code=1">OUTER</a>&nbsp;<small class="cate-sm">아우터</small>
		</div>
	</div>
	<div class="row ma-bo-5">
		<div class="col-md-10 col-md-offset-2">
			<a href="${pageContext.request.contextPath }/product/productList?high_code=2">TOP</a>&nbsp;<small class="cate-sm">상의</small>
		</div>
	</div>
	<div class="row ma-bo-5">
		<div class="col-md-10 col-md-offset-2">
			<a href="${pageContext.request.contextPath }/product/productList?high_code=3">SHIRTS</a>&nbsp;<small class="cate-sm">셔츠</small>
		</div>
	</div>
	<div class="row ma-bo-5">
		<div class="col-md-10 col-md-offset-2">
			<a href="${pageContext.request.contextPath }/product/productList?high_code=4">BOTTOM</a>&nbsp;<small class="cate-sm">하의</small>
		</div>
	</div>
	<div class="row ma-bo-5">
		<div class="col-md-10 col-md-offset-2">
			<a href="${pageContext.request.contextPath }/product/productList?high_code=5">BAG</a>&nbsp;<small class="cate-sm">가방</small>
		</div>
	</div>
	<div class="row ma-bo-5">
		<div class="col-md-10 col-md-offset-2">
			<a href="${pageContext.request.contextPath }/product/productList?high_code=6">SHOES</a>&nbsp;<small class="cate-sm">신발</small>
		</div>
	</div>
	<div class="row ma-bo-5">
		<div class="col-md-10 col-md-offset-2">
			<a href="${pageContext.request.contextPath }/product/productList?high_code=7">ACC</a>&nbsp;<small class="cate-sm">액세서리</small>
		</div>
	</div>
	<div class="row ma-bo-50">
		<div class="col-md-10 col-md-offset-2">
			<a href="#">SALE</a>&nbsp;<small class="cate-sm">세일</small>
		</div>
	</div>

	<div class="row ma-bo-50">
		<div class="col-md-10 col-md-offset-2 form-inline">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="검색어"
					style="width: 120px;" />
				<button class="btn btn-default">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
			</div>
		</div>
	</div>
	<!-- search div -->

	<div class="row ma-bo-50">
		<div class="col-md-10 col-md-offset-2 font-12">
			<a href="/notice/noticeList">NOTICE</a>&nbsp; <a href="#">Q&A</a>&nbsp; <a href="#">REVIEW</a>
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
