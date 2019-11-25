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
    <link rel="stylesheet" href="/css/manage.css">
</head>
<body>
    
<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%">

    <!-- Manage Start -->
    <div class="row mypage">

		 <!-- MANAGE-header Start -->
        <div class="col-md-10 col-md-offset-1 mypage-header text-center">
            <p>MANAGE</p>
		</div>
		<!-- Manage-header End -->

		<!-- Manage-body Start -->
		<div class="col-md-10 col-md-offset-1 mypage-body">
			<table class="table body-table">
				<tr>
					<td class="i-td text-cent">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="/admin/category">카테고리</a></h6>
						<p>
							카테고리를 추가, 변경, 삭제<br>
							할 수 있는 공간입니다.
						</p>
					</td>
					<td class="i-td">
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="/admin/userManagement">회원 관리</a></h6>
						<p>
							가입하신 회원들을 모아보고<br>
							관리하는 공간입니다.
						</p>
					</td>
				</tr> <!-- 1 tr -->
				<tr>
					<td class="i-td text-cent">
						<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="${pageContext.request.contextPath }/admin/productlist">상품 관리</a></h6>
						<p>
							상품을 모아보고 <br>
							관리하는 공간입니다.
						</p>
					</td>
					<td class="i-td">
						<span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="${pageContext.request.contextPath }/admin/stats">통계</a></h6>
						<p>
							현재까지 매출 추이를<br>
							확인할 수 있는 공간입니다.
						</p>
					</td>
				</tr> <!-- 2 tr -->
				<tr>
					<td class="i-td text-cent">
						<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="#">주문 관리</a></h6>
						<p>
							회원들의 주문 내역을<br>
							한눈에 관리할 수 있습니다.
						</p>
					</td>
					<td class="i-td">
						<span class="glyphicon glyphicon-pencil
						" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="#">공지사항 관리</a></h6>
						<p>
							관리자님께서 공지사항을 관리하는 공간입니다.<br>
							관리자님께서 작성하신 공지를 한눈에 확인하실 수 있습니다.
						</p>
					</td>
				</tr> <!-- 3 tr -->
			</table>
		</div>
		<!-- Manage-body End -->
    </div>  
    <!-- Manage End -->

	<%@ include file="../includes/footer.jsp" %>
	
</div>
</body>
</html>