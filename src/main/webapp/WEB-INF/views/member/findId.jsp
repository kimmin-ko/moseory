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
<link rel="stylesheet" href="/css/find_id.css">
</head>
<script type="text/javascript">
var message = "${msg}";
if(message != ""){
	alert(message);
}
</script>
<body>

	<%@ include file="../includes/sidebar.jsp" %>

	<div class="container" style="margin-left:22%">
	
	    <!-- Find Id Proc Start -->
	    <div class="row" style="margin-top: 80px;">
	        <div class="col-md-10 col-md-offset-1 findIdLabel-row">
	            <p>MEMBER ID</p>
	        </div>
	    </div>
	
		<form id="findProc" action="findIdProc" method="post">	
		    <div class="row" style="margin-bottom: 100px;">
		        <div class="col-md-4 col-md-offset-4">
		            <table class="table table-condensed" style="font-size: 13px;">
		                <tr>
		                    <th style="width: 150px;">찾는 방법</th>
		                    <td>
		                        <input type="radio" id="e_radio" name="findType" value="email" onchange="changeFind('email')" checked="checked" />이메일 &nbsp;
		                        <input type="radio" id="p_radio" name="findType" value="phone" onchange="changeFind('phone')" />휴대폰번호
		                    </td>
		                </tr>
		                <tr>
		                    <th>이름</th>
		                    <td><input type="text" name="name" /></td>
		                </tr>
		                <tr id="find_email">
		                    <th>이메일로 찾기</th>
		                    <td><input type="text" name="email" /></td>
		                </tr>
		                <tr id="find_phone" style="display: none;">
		                    <th>휴대폰 번호로 찾기</th>
		                    <td><input type="text" name="phone1" style="width: 40px;" /> - 
		                        <input type="text" name="phone2" style="width: 50px;" /> - 
		                        <input type="text" name="phone3" style="width: 50px;" /></td>
		                </tr>
		                <tr>
		                    <td colspan="2" style="text-align: center;"><button type="button" id="submitBtn" class="btn btn-default">확인</button></td>
		                </tr>
		            </table>
		        </div>
		    </div>
	    </form>
	    <!-- Find Id End -->
		<%@ include file="../includes/footer.jsp" %>
	</div>	
</body>
<script type="text/javascript">
function changeFind(type) {
    if(type == 'email') {
        $("#find_phone").css("display", "none");
        $("#find_email").css("display", "");
    } else {
        $("#find_email").css("display", "none");
        $("#find_phone").css("display", "");
    }
}

$(document).ready(function(){
	var form = $("#findProc");
	$("#submitBtn").click(function(){
		var findType = $('input[name="findType"]:checked').val();
		
		if($('input[name="name"]').val() == "" || $('input[name="name"]').val() == null){
			alert('이름을 입력해주세요.'); 
			$('input[name="name"]').focus();
			return false;
		}
		
		if(findType == "email"){
			if($('input[name=email]').val() == ""  || $('input[name=email]').val() == null){
				alert('이메일을 입력해주세요.'); 
				$('input[name="email"]').focus();
				return false;
			}
				
		}else if(findType == "phone"){
			if($('input[name=phone1]').val() == ""  || $('input[name=phone1]').val() == null){
				alert('핸드폰 번호를 입력해주세요.');
				$('input[name=phone1]').val();
				$('input[name=phone1]').focus();
				return false;
			}
			if($('input[name=phone2]').val() == ""  || $('input[name=phone2]').val() == null){
				alert('핸드폰 번호를 입력해주세요.');
				$('input[name=phone2]').val();
				$('input[name=phone2]').focus();
				return false;
			}
			if($('input[name=phone3]').val() == ""  || $('input[name=phone3]').val() == null){
				alert('핸드폰 번호를 입력해주세요.');
				$('input[name=phone3]').val();
				$('input[name=phone3]').focus();
				return false;
			}
		}
	form.submit();
	})
});

</script>
</html>