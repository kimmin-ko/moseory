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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모서리</title>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="/css/bootstrap.css">
	<link rel="stylesheet" href="/css/orderManageList.css">
	<!-- Bootstrap Datepicker CSS -->
	<link rel="stylesheet" href="/css/bootstrap-datepicker3.standalone.min.css">
</head>

<body>

	<%@ include file="../includes/sidebar.jsp"%>
	<script>
		$(document).ready(function(){
			$('.selectTerm').change(function(){
				var selectTerm = $('.selectTerm:checked').val();
				console.log(selectTerm);
				 $.ajax({
					 type : "post",
				        url : "/admin/statsResult",
				        data : selectTerm, 
				        dataType: "json",
				        contentType : "application/json; charset=utf-8",
						success: function(result){
							var time = new Date();
							
							if(selectTerm == "termYear"){
								$('#resultPrint').empty();
								$('#resultPrint').append("<tr><th>년도</th><th>매출액</th><th>주문건수</th><th>비율</th></tr>")
								$('#resultPrint').append("<tr><td> 오늘 매출액(" + time.getFullYear() + "년)</td><td>" + result[0].amount + "</td><td>" + result[0].quantity + "</td><td></td>")
							}
							else if(selectTerm == "termDay"){
								$('#resultPrint').empty();
								$('#resultPrint').append("<tr><th>오늘</th><th>매출액</th><th>주문건수</th></tr>")
								$('#resultPrint').append("<tr><td> 오늘 매출액(" + time.getDate() + "일)</td><td>" + result[0].amount + "</td><td>" + result[0].quantity + "</td>")
							}
							else if(selectTerm == "termMonth"){
								$('#resultPrint').empty();
								$('#resultPrint').append("<tr><th>월</th><th>매출액</th><th>주문건수</th><th>비율</th></tr>")
								for(var i = 0 in result){
									$('#resultPrint').append("<tr><td>" + result[i].date + "월</td><td>" + result[i].amount + "</td><td>" + result[i].quantity + "</td><td></td>")
								}
							}
							else if(selectTerm == "termWeek"){
								$('#resultPrint').empty();
								$('#resultPrint').append("<tr><th>요일</th><th>매출액</th><th>주문건수</th><th>비율</th></tr>");
								for(var i = 0 in result){
									$('#resultPrint').append("<tr><td>" + result[i].date + "</td><td>" + result[i].amount + "</td><td>" + result[i].quantity + "</td><td></td>")
								}
							}
						}
							
				 });
				 
				 
				 
			});
			
			
		});
	</script>
	
	<!-- Bootstrap Datepicker JS -->
	<script src="/js/bootstrap-datepicker.min.js"></script>
	<!-- KO Datepicker JS -->
	<script src="/js/bootstrap-datepicker.ko.min.js"></script>
	
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
					<!-- <li class="nav-item">
						<a class="nav-link " data-toggle="tab" href="#asd">결제수단별 통계</a>
					</li> -->
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane fade show" id="qwe">
						<div class="col-md-10 col-md-offset-1">
        		        		<div class="col-md-12">
					        		<div class="col-md-6" style = "margin : 10px 10px">
					        			<span class="span_name">기간</span> 
					        			<input type="text" class="hasDatepicker form-control" id="startDate" name="startDate"
							            autocomplete="false" placeholder="-">
							            - 
							            <input type="text" class="hasDatepicker form-control" id="endDate" name="endDate"
							            autocomplete="false" placeholder="-">
					        		</div>
					        		<div class="col-md-8">
					        			<input type = "radio" name = "selectTerm" checked>기간 선택
					        			<input type = "radio" class = "selectTerm" name = "selectTerm" value = "termYear" >년별
					        			<input type = "radio" class = "selectTerm" name = "selectTerm" value = "termMonth" >월별
					        			<input type = "radio" class = "selectTerm" name = "selectTerm" value = "termWeek">요일별
					        			<input type = "radio" class = "selectTerm" name = "selectTerm" value = "termDay">일별
					        		</div>
				        		</div>
						</div>
						<table class="table table-bordered">
							<thead id = "resultPrint">
							</thead>
						</table>
					</div>
					<!-- <div class="tab-pane fade show" id="asd">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th width = "10%">결제방법</th>
									<th width = "20%">매출액</th>
									<th width = "10%">주문건수</th>
									<th width = "10%">비율</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
								</tr>
							</tbody>
						</table>					
					</div> -->
				</div>
			</div>
		</div>
		
		
	</div>
</body>
</html>