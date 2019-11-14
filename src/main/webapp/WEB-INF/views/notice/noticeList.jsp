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
	
	<script type="text/javascript">
		$(document).ready(function(){
			var result = '<c:out value="${result}"/>';
			checkModal(result);
			
			history.replaceState({},null,null);
			
			function checkModal(result){
				if(result === '' || history.state){
					return;
				}
				if(parseInt(result) >= 0){
					$(".modal-body").html("게시글이 등록 되었습니다");
				}
				$("#myModal").modal("show");
					
			}
		});
	</script>

	<div class="container" style="margin-left: 22%;">

		<!-- Notice Start -->
		<div class="row">
			<div class="col-md-10 col-md-offset-1 noticeLabel-row">
				<p>NOTICE</p>
			</div>
		</div>
		<!-- row -->

		<div class="row" style="margin-bottom: 150px;">
			<div class="col-md-10 col-md-offset-1">
				<table class="table notice-board">
					<thead>
						<tr>
							<td>NO</td>
							<td>TITLE</td>
							<td>NAME</td>
							<td>DATE</td>
							<td>HIT</td>
						</tr>
					</thead>

					<tbody>
					
					<tbody>
						<c:forEach items="${list}" var="list">
							<tr>
								<!-- NO -->
								<td>${list.NO}</td>
								<!-- TITLE -->
								<td>
									<a href="/notice/noticeGet?NO=${list.NO}">${list.TITLE }</a>
								</td>
								<!-- NAME -->
								<td>모서리</td>
								<!-- DATE -->
								<td>${list.REG_DATE}</td>
								<!-- HIT -->
								<td>${list.HIT}</td>
							</tr>
						</c:forEach>	
					</tbody>
					
					<tr>
						<!-- NO -->
						<td>2</td>
						<!-- TITLE -->
						<td><a href="/notice/noticeView">회원 등급제에 관하여 설명 드릴게요!</a></td>
						<!-- NAME -->
						<td>모서리</td>
						<!-- DATE -->
						<td>2019-10-14 12:52:29</td>
						<!-- HIT -->
						<td>5589</td>
					</tr>
					
					<tr>
						<!-- NO -->
						<td>1</td>
						<!-- TITLE -->
						<td><a href="/notice/noticeView">모서리를 오픈하며...</a></td>
						<!-- NAME -->
						<td>모서리</td>
						<!-- DATE -->
						<td>2019-10-14 12:50:29</td>
						<!-- HIT -->
						<td>7798</td>
					</tr>

					</tbody>
				</table>
			</div>

			<div class="col-md-10 col-md-offset-1 pagination-div"
				style="margin-bottom: 30px;">
				<nav>
					<ul class="pagination">
						<li><a href="#" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>

			<div class="col-md-10 col-md-offset-1">
				<span class="form-inline search-area"> 검색어 <select
					class="form-control" style="width: 130px">
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="subject_Content">제목 + 내용</option>
				</select>
					<div class="form-group">
						<input type="text" class="form-control" style="width: 180px;" />
						<button class="btn btn-default">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</div>
				</span>
			</div>

		</div>
		<!-- row -->
		<!-- Notice End -->



	</div>
	
	<!--  Modal 추가 -->
	<div class ="modal fade" id="myModal" tabindex ="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">게시글 확인</h4>
				</div>
				<div class="modal-body">처리가 완료 되었습니다</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary">저장</button>
				</div>
			</div>
			<!-- Modal-content -->
		</div>
		<!-- Modal-dialog -->
	</div>
	<!-- Modal -->

</body>
</html>