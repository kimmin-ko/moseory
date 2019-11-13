<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/joinForm.css">

<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
</head>
<body>


<script>
	
	function imageUpload() {
		console.log("되나?");
		fileUpload();
		console.log("되나?");
		$("#fileBtn").submit();
	}
	function fileUpload() {
		/* var fileData = $('#getImage').prop('files')[0];
		console.log("1 = " + fileData)
		var formData = new FormData();
		for(var i = 0; i < $('#getImage')[0].files.length;i++){
			formData.append('uploadfile',$('#getImage')[0].files[i])
			
		}
		console.log("2 = " + formData); */
		var formData = new FormData();
		
		var fileRequest = $.ajax({
			url : "/admin/imageUpload",
			type : "post",
			data : formData,
			contentType : false,
			processData : false,
			success: function(result){
				console.log("되나??");
			}
		});
	}

</script>


	<h1>이미지 업로드 테스트</h1>
	<hr>
		파일 : <input type = "file" id = "getImage" name = "file" multiple>
		<br>
		<input type = "button" value = "등록" id = "fileBtn"  class = "btn btn-primary btn-md" onclick="imageUpload()">
</body>
</html>