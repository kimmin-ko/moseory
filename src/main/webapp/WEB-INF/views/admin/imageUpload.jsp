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
/* var fileData = $('#getImage').prop('file')[0];
console.log("1 = " + fileData)
var formData = new FormData();
for(var i = 0; i < $('#getImage')[0].files.length;i++){
	formData.append('uploadfile',$('#getImage')[0].files[i])
	
}
console.log("2 = " + formData); */
	/* 
reader.onload = function(e){
	var base64data = reader.result;
	console.log("base64data = " + base64data);
	var data = base64data.split(',')[1];
	var sendSize = 1024;
	var fileLength = data.length;
	var pos = 0;
	var upload = function(){
		$.ajax({
			type : 'POST',
			dataType : 'json',
			data : {
				fileName : fileName,
				fileLength : fileLength,
				filepos : pos,
				data : data.substring(pos, pos + sendSize)
			},
			url : "/admin/imageUpload",
			success : function(data){
				if(pos < fileLength){
					setTimeout(upload, 1);
				}
				pos = pos + sendSize;
				if(pos > fileLength){
					pos = fileLength;
				}
				$('#progress').text(pos + ' / ' + filelength);
			}
		});
	};
	setTimeout(upload, 1);
}
reader.readAsDataURL(file);
} */

	function imageUpload() {
		console.log("되나?");
		fileUpload();
		console.log("되나?");
		$("#fileBtn").submit();
	}
	function fileUpload() {
		
		var file = $('#getImage')[0].files[0];
	
		var fileName = file.name;
		var formData = new FormData();
		console.log(fileName);
		
		for(var i = 0; i < $('#getImage')[0].files.length; i++){
			console.log("i = " + i);
			console.log($('#getImage')[0].files[i]);
			var files = $('#getImage')[0].files[i];
			formData.append('files',files);
		}
		
 		var fileRequest = $.ajax({
			url : "/admin/imageUpload",
			enctype: 'multipart/form-data',
			type : "post",
			data : formData,
			contentType : false,
			processData : false,
			success: function(result){
				console.log("성공??");
			}
		}); 
	}
	
	
</script>
	<h1>이미지 업로드 테스트</h1>
	<hr>
		파일 : <input type = "file" id = "getImage" name = "files" multiple>
		<br>
		<input type = "button" value = "등록" id = "fileBtn"  class = "btn btn-primary btn-md" onclick="imageUpload()">
		
		
</body>
</html>