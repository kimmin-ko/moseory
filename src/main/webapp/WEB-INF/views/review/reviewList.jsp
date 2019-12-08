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
<link rel="stylesheet" href="/css/reviewList.css">
<script src="/resources/ckeditor/ckeditor.js"></script>
</head>

<body>

	<%@ include file="../includes/sidebar.jsp"%>

	<script type="text/javascript">
	$(document).ready(
        function() {
            var result = '<c:out value="${reviewResult}"/>';
            checkModal(result);

            history.replaceState({}, null, null);

            function checkModal(result) {
                if (result === '' || history.state) {
                    return;
                }
                if (parseInt(result) >= 0) {
                    $(".modal-body").html("게시글이 등록 되었습니다");
                }
                $("#myModal").modal("show");

            }

            var actionForm = $("#actionForm");

            $(".paginate_button a").on(
                "click",
                function(e) {
                    e.preventDefault();
                    console.log("click");
                    actionForm
                        .find("input[name='reviewPageNum']")
                        .val($(this).attr("href"));
                    actionForm.submit();
                });

            //게시글 제목에만 걸어주면, pageNum과 amount가 전송되지 않는다
            $(".move")
                .on(
                    "click",
                    function(e) {
                        e.preventDefault();
                        actionForm
                            .append("<input type ='hidden' name='no' value ='" +
                                $(this).attr(
                                    "href") +
                                "'>");
                        actionForm.attr("action",
                            "/review/reviewGet");
                        actionForm.submit();
                    })

           

            var searchForm = $("#search");

            $("#search button").on("click",
                    function(e) {
                        if (!searchForm.find("option:selected").val()) {
                            alert("검색 종류를 선택해 주세요");
                            return false;
                        }

                        if (!searchForm.find("input[name='reviewKeyword']").val()) {
                            alert("검색어를 입력하세요");
                            return false;
                        }

                        searchForm.find("input[name='reviewPageNum']").val("1");
                        e.preventDefault();

                        searchForm.submit();
                    });
	
        });
	</script>

	<div class="container" style="margin-left: 22%;">

		<!-- Notice Start -->
		<div class="row">
			<div class="col-md-10 col-md-offset-1 noticeLabel-row">
				<p>REVIEW</p>
			</div>
		</div>
		<!-- row -->

		<div class="row" style="margin-bottom: 150px;">
			<div class="col-md-10 col-md-offset-1">
				<table class="table notice-board">
					<colgroup>
						<col width= 50px;> <!-- NO -->
						<col width= 250px;> <!-- TITLE -->
						<col width= 80px;> <!-- NAME -->
						<col width= 80px;> <!-- DATE -->
						<col width= 50px;> <!-- HIT -->
					</colgroup>
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
						<c:forEach items="${reviewList}" var="review">
							<tr>
								<!-- NO -->
								<td>${review.no}</td>
								<!-- TITLE -->
								<td class="qna_title"><a class='move' href='<c:out value="${review.no}"/>'>
									<c:out value="${review.title }" /></a></td>
								<!-- NAME -->
								<td><c:out value="${fn:substring(review.member_id, 0, 2).concat('*****') }" /></td>
								<!-- DATE -->
								<td>${review.reg_date}</td>
								<!-- HIT -->
								<td>${review.hit}</td>
							</tr>
						</c:forEach>
					</tbody>



					</tbody>
				</table>
			</div>
			
			<!-- 검색 처리 기능 -->
			<div class="col-md-5 col-md-offset-1">
				<form id='search' action="/review/reviewList" method="get">
					<select class="form-control" style="width: 130px; display:inline-block;" name="reviewType">
						<option value=""
							<c:out value="${reviewPageMaker.reviewCri.reviewType == null ?'selected':''}"/>>검색조건</option>
						<option value="T"
							<c:out value="${reviewPageMaker.reviewCri.reviewType == 'T' ?'selected':''}"/>>제목</option>
						<option value="C"
							<c:out value="${reviewPageMaker.reviewCri.reviewType == 'C' ?'selected':''}"/>>내용</option>
						<option value="TC"
							<c:out value="${reviewPageMaker.reviewCri.reviewType == 'TC' ?'selected':''}"/>>제목
							+ 내용</option>
					</select> 
					<input type="text" class="form-control" name="reviewKeyword"
						style="width: 180px; display:inline-block;" value="${reviewPageMaker.reviewCri.reviewKeyword}" /> <input
						type='hidden' name='reviewPageNum' value="${reviewPageMaker.reviewCri.reviewPageNum }">
					<input type='hidden' name='reviewAmount' value="${reviewPageMaker.reviewCri.reviewAmount }">
					<button class="btn btn-default">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
					
				</form>
			</div>
			<div class="col-md-5 reg_btn_area">
				<button type="button" class="btn btn-default btn-sm" onclick="location.href ='/review/reviewText'">글쓰기</button>
			</div>
			



			<!-- 페이징 처리 -->
			<div class="col-md-10 col-md-offset-1 pagination-div"
				style="margin-bottom: 30px;">
				<nav>
					<ul class="pagination">
						<c:if test="${reviewPageMaker.prev}">
							<li class="paginate_button previous"><a
								href="${reviewPageMaker.startPage-1 }">이전</a></li>
						</c:if>

						<c:forEach var="num" begin="${reviewPageMaker.startPage }"
							end="${reviewPageMaker.endPage }">
							<li class="paginate_button ${reviewPageMaker.reviewCri.reviewPageNum == num ? 'active':'' }"><a
								href="${num }">${num }</a></li>
						</c:forEach>

						<c:if test="${reviewPageMaker.next }">
							<li class="paginate_button next"><a
								href="${reviewPageMaker.endPage+1 }">다음</a></li>
						</c:if>


					</ul>
				</nav>
			</div>



		</div>

		<!-- row -->
		<!-- Notice End -->
		
		<form id="actionForm" action="/review/reviewList" method="get">
			<input type="hidden" name='reviewPageNum' value="${reviewPageMaker.reviewCri.reviewPageNum }">
			<input type="hidden" name='reviewAmount' value="${reviewPageMaker.reviewCri.reviewAmount }">
			<input type="hidden" name="reviewType" value="${reviewPageMaker.reviewCri.reviewType}">
			<input type="hidden" name="reviewKeyword" value="${reviewPageMaker.reviewCri.reviewKeyword}">
		</form>


	</div>

	<!--  Modal 추가 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
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