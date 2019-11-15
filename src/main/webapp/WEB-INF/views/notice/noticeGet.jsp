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
	
	<script type ="text/javascript">
		$(document).ready(function(){
			var operForm = $("#operForm");
			$("button[data-oper ='modify']").on("click",function(e){
				operForm.attr("action","/notice/noticeModify").submit();
			});
			
			$("button[data-oper='list']").on("click",function(e){
				operForm.find("#NO").remove();
				operForm.attr("action","/notice/noticeList");
				operForm.submit();
			});
			
		});
	
	</script>
	
	
	<div class="container" style="margin-left: 22%;"width:100% role="form">

		<table width="100%">
				
				<tr>
					<td>
						<table class="table table-striped" margin-top:"50px"-->
							<tr>
								<td>&nbsp;</td>
								<td align="center">NOTICE</td>
								<td>공지 사항 관련된 게시판 입니다</td>
								<td>&nbsp;</td>
							</tr>


							<tr>
								<td>&nbsp;</td>
								<td align="center">제목</td>
								<td><p> ${board.TITLE}</p>
								<td>&nbsp;</td>
							</tr>

							<tr>
								<td>&nbsp;</td>
								<td align="center"></td>
								<td><textarea name="CONTENT" cols="100" rows="13" disabled >
								${board.CONTENT}
									
								</textarea></td>

								<script>
									var ckeditor_config = {
										resize_enaleb : false,
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode : CKEDITOR.ENTER_P,
										filebrowserUploadUrl : "/admin/goods/ckUpload"
									};

									CKEDITOR
											.replace("CONTENT", ckeditor_config);
								</script>
								<td>&nbsp;</td>
							</tr>


							<tr>
								<td>&nbsp;</td>
								<td align="center">UCC URL</td>
								<td><input name="title2" size="50" maxlength="50" disabled></td>
							</tr>

							<tr>
								<td>&nbsp;</td>
								<td align="center">비밀번호</td>
								<td><input type="password" name="password" size="50"
									maxlength="50" disabled></td>
							</tr>

							<tr>
								<td>&nbsp;</td>
								<td align="center">비밀글설정</td>
								<td><input type="checkbox" name="chk_info1" value="공개글"
									checked="checked" disabled>공개글 <input type="checkbox"
									name="chk_info2" value="비밀글" disabled>비밀글</td>
							</tr>

							<tr align="center">
								
								<td>&nbsp;</td>
								<td colspan="2">
									<button data-oper ='modify' class='btn btn-dark'>수정</button>
									<button data-oper ='list' class='btn btn-dark'>목록</button>
									
									<form id='operForm' action="/notice/noticeModify" method="get">
									<input type='hidden' name='NO'
										value='<c:out value = "${board.NO }"/>'> <input
										type='hidden' name='pageNum'
										value='<c:out value = "${cri.pageNum }"/>'> <input
										type='hidden' name='amount'
										value='<c:out value = "${cri.amount }"/>'>
									</form> 
							
								<td>&nbsp;</td>
								
							</tr>
						
						</table>
					</td>
				</tr>
		</table>
	</div>
	

	<%@ include file="../includes/footer.jsp"%>



</body>
</html>