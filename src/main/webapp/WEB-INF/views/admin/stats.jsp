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

<body>

	<%@ include file="../includes/sidebar.jsp"%>
	<script>
	
	</script>
	<div class="container" style="margin-left: 22%;">
	
		<!-- Notice Start -->
		<div class="row">
			<div class="col-md-10 col-md-offset-1 noticeLabel-row">
				<h2>통계 페이지</h2>
			</div>
		</div>
		<!-- row -->
		
		<div class = "row">
			<div class = "col-md-10 col-md-offset-1">
				<ul class="nav nav-tabs">
					<li class="nav-item">
						<a class="nav-link active" data-toggle="tab" href="#qwe">매출 통계</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " data-toggle="tab" href="#asd">상품 통계</a>
					</li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane fade show" id="qwe">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th width = "10%">결제방법</th>
								<th width = "20%">매출액</th>
								<th width = "10%">주문건수</th>
								<th width = "10%">비율</th>
							</tr>
						</thead>
					</table>
					</div>
					<div class="tab-pane fade show" id="asd">
						<p>Nunc vitae turpis id nibh sodales commodo et non augue. Proin fringilla ex nunc. Integer tincidunt risus ut facilisis tristique.</p>
					</div>
				</div>
				
				
			</div>
		</div>
		
		
		
		
		
	</div>
</body>
</html>