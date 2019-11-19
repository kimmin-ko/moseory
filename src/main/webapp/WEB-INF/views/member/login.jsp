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
<link rel="stylesheet" href="/css/loginForm.css">
<script type="text/javascript">
var message = "${msg}";
if(message != ""){
	alert(message);
}
</script>
</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

<!-- Page Content -->
<div class="container" style="margin-left:22%">

    <!-- Login Form Start -->

    <div class="row loginLabel-row" style="margin-top: 80px;">
        <div class="col-md-10 col-md-offset-1">
            <p>MEMBER LOGIN</p>
        </div>
    </div>

    <form action="/member/loginProc" method="post" id="loginProc">
        <div class="row loginForm-row" style="margin-top: 60px;">
            <div class="col-md-4 col-md-offset-4">
                <input type="text" class="form-control" name="inputId" placeholder="아이디">
            </div>
            <div class="col-md-4 col-md-offset-4">
                <input type="password" class="form-control" name="inputPassword" placeholder="비밀번호">
            </div>
            <div class="col-md-4 col-md-offset-4">
                <button type="button" id="loginBtn" class="btn btn-default btn-block login-btn">로그인</button>
            </div>
            <div class="col-md-4 col-md-offset-4">
                <div class="checkbox">
                    <label><input type="checkbox" id="checkId"> <span>아이디 저장</span></label>
                </div>
            </div>
            <div class="col-md-4 col-md-offset-4" style="text-align: center; margin-bottom: 40px;">
                <span><a href="/member/join">회원가입</a> | 
                      <a href="/member/findId">아이디 찾기</a> | 
                      <a href="/member/findPw">비밀번호 찾기</a></span>
            </div>
            <div class="col-md-4 col-md-offset-4" style="margin-bottom: 150px;">
	            <a href="https://kauth.kakao.com/oauth/authorize?client_id=b419ae28c858db8583adbbee9c54f3bc&redirect_uri=http://localhost:9090/member/kakaoLogin&response_type=code">
	                <img src="/images/btn_kakao_login.gif">
	            </a>
                <img src="/images/btn_naver_login.gif">
            </div>
        </div>  
    </form>

    <!-- Login Form End -->
    
    <%@ include file="../includes/footer.jsp" %>
    
</div>
<!-- container end -->
</body>
<script>
$(document).ready(function(){
	var form = $("#loginProc");
	$("#loginBtn").click(function(){
		if($('input[name="inputId"]').val() == "" || $('input[name="inputId"]').val() == null){
			alert("아이디를 입력해주세요.");
			$('input[name="inputId"]').focus();
			return false;
		}
		if($('input[name="inputPassword"]').val() == "" || $('input[name="inputPassword"]').val() == null){
			alert("비밀번호를 입력해주세요.");
			$('input[name="inputPassword"]').focus();
			return false;
		}
		form.submit();
	})
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name='inputId']").val(userInputId); 
     
    if($("input[name='inputId']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='inputId']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='inputId']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='inputId']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
	
	
});


function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

</script>
</html>