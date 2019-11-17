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
    <link rel="stylesheet" href="/css/mypage.css">
</head>
<body>
    
<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%">

    <!-- My Page Start -->
    <div class="row mypage">

		 <!-- My Page-header Start -->
        <div class="col-md-10 col-md-offset-1 mypage-header text-center">
            <p>MY PAGE</p>

			<%@ include file="tierExplain.jsp" %>

			<div class="col-md-12 header-p-o">
				<div class="col-md-6">
					<span class="p-o-name">가용 적립금 : </span>
					<span id="point"></span>
				</div>
				<div class="col-md-6">
					<span class="p-o-name">총 구매금액 : </span>
					<span id="order"></span>
				</div>
			</div>
			
		</div>
		<!-- Mypage-header End -->

		<!-- Mypage-body Start -->
		<div class="col-md-10 col-md-offset-1 mypage-body">
			<table class="table body-table">
				<tr>
					<td class="i-td text-cent">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="#">주문조회</a></h6>
						<p>
							고객님의 주문내역을 확인하실 수 있습니다. <br>
							비회원의 경우, 주문번호와 비밀번호로 주문조회 가능
						</p>
					</td>
					<td class="i-td">
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="/user/modify">개인정보 관리</a></h6>
						<p>
							회원이신 고객님의 개인정보를<br>
							관리하는 공간입니다.
						</p>
					</td>
				</tr> <!-- 1 tr -->
				<tr>
					<td class="i-td text-cent">
						<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="/user/wishList">위시 리스트</a></h6>
						<p>
							관심상품으로 등록하신 상품의<br>
							목록을 보여드립니다.
						</p>
					</td>
					<td class="i-td">
						<span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="#">게시물</a></h6>
						<p>
							고객님께서 작성하신 게시물을<br>
							관리하는 공간입니다.
						</p>
					</td>
				</tr> <!-- 2 tr -->
				<tr>
					<td class="i-td text-cent">
						<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="#">배송주소 관리</a></h6>
						<p>
							자주 사용하는 배송지를<br>
							등록하고 관리하실 수 있습니다.
						</p>
					</td>
					<td class="i-td">
						<span class="glyphicon glyphicon-pencil
						" aria-hidden="true"></span>
					</td>
					<td class="con-td">
						<h6><a href="#">상품 리뷰 관리</a></h6>
						<p>
							고객님께서 작성하신 상품 리뷰글을 관리하는 공간입니다.<br>
							고객님께서 작성하신 리뷰를 한눈에 확인하실 수 있습니다.
						</p>
					</td>
				</tr> <!-- 3 tr -->
			</table>
		</div>
		<!-- Mypage-body End -->
		
    </div>  
    <!-- Mypage End -->

	<%@ include file="../includes/footer.jsp" %>
	
</div>

<script type="text/javascript">
	// #,### formatNumber
	Number.prototype.format = function(){
	    if(this==0) return 0;
	 
	    var reg = /(^[+-]?\d+)(\d{3})/;
	    var n = (this + '');
	 
	    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	 
	    return n;
	};
	
	String.prototype.format = function(){
	    var num = parseFloat(this);
	    if( isNaN(num) ) return "0";
	 
	    return num.format();
	};
	
	$(document).ready(function() {
		var memberJson = ${memberJson};
	
		$("#point").text(memberJson.point.format() + '원');
		$("#order").text(memberJson.total.format() + '원');
	});

</script>

</body>
</html>