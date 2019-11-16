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
<link rel="stylesheet" href="/css/noticeView.css">
<link rel="stylesheet" href="/css/sidebar.css">
<link rel="stylesheet" href="/css/footer.css">
</head>

<body>
	<%@ include file="../includes/sidebar.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			var operForm = $("#operForm");
			$("button[data-oper ='modify']").on("click", function(e) {
				operForm.attr("action", "/notice/noticeModify").submit();
			});

			$("button[data-oper='list']").on("click", function(e) {
				operForm.find("#no").remove();
				operForm.attr("action", "/notice/noticeList");
				operForm.submit();
			});

		});
	</script>


	<div class="container" style="margin-left:22%;">

		<div class="row" style="margin-top: 70px; margin-bottom: 30px;">

			<div class="col-md-10 col-md-offset-1 noticeLabel-row"
				style="margin-bottom: 50px;">
				<table class="table table-bordered noticeView-table">

					<tr>
						<td class="view_title">제목</td>
						<td colspan="3">${board.title}</td>
					</tr>

					<tr>
						<td class="view_title">작성자</td>
						<td colspan="3">모서리</td>
					</tr>

					<tr>
						<td class="view_title">작성일</td>
						<td>${board.reg_date}</td>
						<td class="view_title">조회수</td>
						<td>${board.hit }</td>
					</tr>

					<tr>
						<td colspan="4" height ="300px" width="300px">${board.content };</td>
					</tr>
				</table>

				<button data-oper="modify" class="btn btn-default btn-sm">수정</button>
				<button data-oper="list" class="btn btn-default btn-sm">목록</button>
			</div>

			<div class="col-md-10 col-md-offset-1">
				<table class="table table-bordered noticeOtherView-table">
					<tr>
						<td class="otherView_title"><img
							src="/images/otherView_pre.jpg">이전글</td>
						<td><a href="#">온라인 쇼핑몰에서 옷 실패 없이 사는 방법!</a></td>
					</tr>
					<tr>
						<td class="otherView_title"><img
							src="/images/otherView_next.jpg">다음글</td>
						<td><a href="#">모서리를 오픈하며...</a></td>
					</tr>
				</table>
			</div>
		</div>
		

			<form id='operForm' action="/notice/noticeModify" method="get">
				<input type='hidden' name='no'
					value='<c:out value = "${board.no }"/>'> <input
					type='hidden' name='pageNum'
					value='<c:out value = "${cri.pageNum }"/>'> <input
					type='hidden' name='amount'
					value='<c:out value = "${cri.amount }"/>'>
			</form>


<%@ include file="../includes/footer.jsp"%>
</div>
</body>
</html>