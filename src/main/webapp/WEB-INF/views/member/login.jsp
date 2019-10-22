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
<link rel="stylesheet" href="/css/loginForm.css">
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

    <form>
        <div class="row loginForm-row" style="margin-top: 60px;">
            <div class="col-md-4 col-md-offset-4">
                <input type="text" class="form-control" id="inputId" placeholder="아이디">
            </div>
            <div class="col-md-4 col-md-offset-4">
                <input type="password" class="form-control" id="inputPassword" placeholder="비밀번호">
            </div>
            <div class="col-md-4 col-md-offset-4">
                <button type="submit" class="btn btn-default btn-block login-btn">로그인</button>
            </div>
            <div class="col-md-4 col-md-offset-4">
                <div class="checkbox">
                    <label><input type="checkbox"> <span>아이디 저장</span></label>
                </div>
            </div>
            <div class="col-md-4 col-md-offset-4" style="text-align: center; margin-bottom: 40px;">
                <span><a href="/member/join">회원가입</a> | 
                      <a href="/member/findId">아이디 찾기</a> | 
                      <a href="/member/findPw">비밀번호 찾기</a></span>
            </div>
            <div class="col-md-4 col-md-offset-4">
                <img src="/images/btn_facebook_login.gif">
                <img src="/images/btn_google_login.gif">
            </div>
            <div class="col-md-4 col-md-offset-4" style="margin-bottom: 150px;">
                <img src="/images/btn_kakao_login.gif">
                <img src="/images/btn_naver_login.gif">
            </div>
        </div>  
    </form>

    <!-- Login Form End -->
    
    <%@ include file="../includes/footer.jsp" %>
    
</div>
<!-- container end -->
</body>
</html>