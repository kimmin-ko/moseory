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
<style>
	.modifyOk-row {
		margin-top: 250px;
		margin-bottom: 400px;
	}
</style>
</head>
<body>

	<%@ include file="../includes/sidebar.jsp" %>
	
	<div class="container modifyForm-container" style="margin-left:22%">
		
		<div class="row modifyOk-row">

			<div class="col-md-10 col-md-offset-1 text-center">
				<p class="text-center">
					회원님의 정보 변경이 완료 되었습니다.
				</p>

				<button class="btn btn-default btn-sm" onclick="location.href='/index'">메인화면</button>
				<button class="btn btn-default btn-sm" onclick="location.href='/user/myPage'">마이페이지</button>
			</div>

		</div> <!-- row end -->
		
		<%@ include file="../includes/footer.jsp" %>
		
	</div> <!-- container end -->
	
</body>
</html>