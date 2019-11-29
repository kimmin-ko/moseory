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
</head>
<body>

	<%@ include file="../includes/sidebar.jsp"%>
	<script type="text/javascript">
		//document.폼이름
		function writeCheck()
		{
			var form = document.writeform;
			var flag = true;
			
			if(form.title.value === ''){
				alert("제목을 입력해 주세요");
				form.title.focus();
				flag = false;
				
			}
			if(form.content.value === ''){
				alert("내용을 입력해 주세요");
				form.content.focus();
				flag = false;
				
			}
			
			if(flag){
				form.submit();
			}
			
		}
	</script>


	<script src="/ckeditor/ckeditor.js"></script>


	<div class="container" style="margin-left: 22%;">

		<div class="row">
			<div class="col-md-10 col-md-offset-1 notice-table">
				<form name="writeform" method="post">
					<table class="table table-striped">
						<tr>
							<td>&nbsp;</td>
							<td align="center">REVIEW</td>
							<td>리뷰 게시판 입니다</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td align="center">제목</td>
							<td><input type="text" name="title" size="100"
								maxlength="100"> <!--  값 입력하기  --></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td align="center">내용</td>
							<td><textarea name="content" cols="100" rows="13">     
							
							</textarea></td>

							<td>&nbsp;</td>
						</tr>
						<tr align="center">
							<td>&nbsp;</td>
							<td colspan="2">
							<input type="button" value="등록" class="btn btn-dark" OnClick="javascript:writeCheck()">
								<input type=button value="취소"
								class="btn btn-dark" OnClick="javascript:history.back(-1)">
							<td>&nbsp;</td>
						</tr>
						<input type = "hidden" name ="id" value="${member.id }"></input>
					</table>
				</form>
			</div>
		</div>
		<%@ include file="../includes/footer.jsp"%>
	</div>
	
	<script type="text/javascript">
		var ckeditor_config = {
			resize_enaleb : false,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			filebrowserUploadUrl : "/admin/goods/ckUpload"
		};

		CKEDITOR.replace("content", ckeditor_config);
	</script>

</body>
</html>