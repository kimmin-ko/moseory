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
	<!-- <script>
		var formObj = $("#readForm");
		
		$("#delete_btn").click(function(){
			formObj.attr("action","/notice/noticeDelete");
			formObj.attr("method","get");
			formObj.submit();
		});
		
	</script> -->
	
	<form name="readForm">
	<div class="container" style="margin-left: 22%;"width:100% role="form">

		<table width="100%">
				<input type="hidden" name="member_id" value="${user.id}" readonly="readonly">
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
								<td><input type="text" name="TITLE" size="100"
									maxlength="100" readonly="readonly" value="${board.TITLE}"> <!--  값 입력하기  --></td>
								<td>&nbsp;</td>
							</tr>

							<tr>
								<td>&nbsp;</td>
								<td align="center"></td>
								<td><textarea name="CONTENT" cols="100" rows="13" readonly="readonly" >
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
								<td><input name="title2" size="50" maxlength="50" readonly="readonly"></td>
							</tr>

							<tr>
								<td>&nbsp;</td>
								<td align="center">비밀번호</td>
								<td><input type="password" name="password" size="50"
									maxlength="50" readonly="readonly"></td>
							</tr>

							<tr>
								<td>&nbsp;</td>
								<td align="center">비밀글설정</td>
								<td><input type="checkbox" name="chk_info1" value="공개글"
									checked="checked" disabled>공개글 <input type="checkbox"
									name="chk_info2" value="비밀글" readonly="readonly">비밀글</td>
							</tr>

							<tr align="center">
								
								<td>&nbsp;</td>
								<td colspan="2"><input type=submit value="등록"
									class="btn btn-dark"> <input type=button value="취소"
									class="btn btn-dark" OnClick="javascript:history.back(-1)">
									<input type="button" class="btn btn-dark" value="수정하기" onclick="location.href='/notice/noticeModify?NO=${board.NO}'">
									<!--  form안에 hidden을 만들어서 , hidden안에 게시판 번호를 넘겨서 delete를 구현한다  inputtype에 게시판번호-->
									<button type="button" class="btn btn-dark" id="delete_btn" method="post" onclick="location.href='/notice/noticeDelete?NO=${board.NO}'">삭제하기</button>
								<td>&nbsp;</td>
								
							</tr>
						
						</table>
					</td>
				</tr>
		</table>
	</div>
	</form>
	<%@ include file="../includes/footer.jsp"%>



</body>
</html>