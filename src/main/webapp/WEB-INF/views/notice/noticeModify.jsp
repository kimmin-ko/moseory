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
<script src="/ckeditor/ckeditor.js"></script>
</head>

<body>
	<%@ include file="../includes/sidebar.jsp"%>

	<script>
	$(document).ready(function(){
		var formObj = $("form");
		$('button').on("click",function(e){
			e.preventDefault();
			var oper = $(this).data("oper");
			
			if(oper === 'remove'){
				formObj.attr("action","/notice/noticeDelete").submit();
			}
			else if(oper === 'list'){
				formObj.attr("action","/notice/noticeList").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag - $("input[name='type']").clone();
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}
			formObj.submit();
		});
	});
	</script>


	<div class="container" style="margin-left: 22%;">
		<form role="form" action="/notice/noticeModify" method="post">

			<input type="hidden" name="no" value="${board.no}"> <input
				type="hidden" name="pageNum" value="${cri.pageNum }"> <input
				type="hidden" name="amount" value="${cri.amount }">
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
				<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			<div class="col-md-10 col-md-offset-1">

				<table class="table table-striped notice-table">
					<tr>
						<td>&nbsp;</td>
						<td align="center">NOTICE</td>
						<td>공지 사항 관련된 게시판 입니다</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td align="center">제목</td>
						<td><input type="text" name="title" size="100"
							maxlength="100" value="${board.title}"> <!--  값 입력하기  --></td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td align="center"></td>
						<td><textarea name="content" cols="100" rows="13">
								${board.content}
	
								</textarea></td>

								<script>
									var ckeditor_config = {
										resize_enaleb : false,
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode : CKEDITOR.ENTER_P,
										filebrowserUploadUrl : "/admin/goods/ckUpload"
									};

									CKEDITOR
											.replace("content", ckeditor_config);
								</script>

						<td>&nbsp;</td>
					</tr>


					<tr align="center">
						<td>&nbsp;</td>
						<td colspan="2">
							<button type="submit" data-oper='modify' class='btn btn-dark'>수정
								완료</button>
							<button type="submit" data-oper='remove' class='btn btn-dark'>삭제</button>
							<button type="submit" data-oper='list' class='btn btn-dark'>목록</button>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>
			</form>
			<%@ include file="../includes/footer.jsp"%>

			</div>
		
</body>
</html>