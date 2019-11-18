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
			
			var actionForm = $("#actionForm");		
			
			$(".paginate_button a").on("click",function(e){
				e.preventDefault();
				console.log("click");
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			//게시글 제목에만 걸어주면, pageNum과 amount가 전송되지 않는다
			$(".move").on("click",function(e){
				e.preventDefault();
				actionForm.append("<input type ='hidden' name='no' value ='"+$(this).attr("href")+"'>");
				actionForm.attr("action","/notice/noticeGet");
				actionForm.submit();
			})
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
								<td>${list.no}</td>
								<!-- TITLE -->
								<td>
									<a class ='move' href ='<c:out value="${list.no}"/>'><c:out value ="${list.title }"/></a>
								</td>
								<!-- NAME -->
								<td>모서리</td>
								<!-- DATE -->
								<td>${list.reg_date}</td>
								<!-- HIT -->
								<td>${list.hit}</td>
							</tr>
						</c:forEach>	
					</tbody>
					
				

					</tbody>
				</table>
			</div>

			<div class="col-md-10 col-md-offset-1 pagination-div"
				style="margin-bottom: 30px;">
				<nav>
					<ul class="pagination">
						<c:if test ="${pageMaker.prev}">
							<li class ="paginate_button previous"><a href="${pageMaker.startPage-1 }">이전</a></li>
						</c:if>
						
						<c:forEach var="num" begin ="${pageMaker.startPage }" end = "${pageMaker.endPage }">
							<li class ="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num }">${num }</a></li>
						</c:forEach>
						
						<c:if test ="${pageMaker.next }">
							<li class ="paginate_button next"><a href="${pageMaker.endPage+1 }">다음</a></li>
						</c:if>
						
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
		<form id ="actionForm" action ="/notice/noticeList" method ="get">
			<input type='hidden' name='pageNum' value ="${pageMaker.cri.pageNum }">
			<input type='hidden' name='amount' value ="${pageMaker.cri.amount }">
		</form>



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