<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/memberModify.css">
</head>
<body>

<!-- Daum 우편번호 찾기 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/address/daum_address.js"></script>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container modifyForm-container" style="margin-left:22%">

    <!-- Modify Form Start -->
    <div class="row modifyLabel-row" style="margin-top: 80px;">
        <div class="col-md-10 col-md-offset-1">
            <p>USER INFO EDIT</p>
        </div>
    </div>

    <div class="row">
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
            <div class="col-md-6" style="padding: 0;">
                <span style="font-weight: bold;">기본정보</span>
            </div>
        </div>
    </div>
	
	<form action="/admin/userModify" method="post" id="modifyForm">
	    <div class="row" style="margin-bottom: 30px;">
	        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
	            <table class="table table-bordered">
	                <tr>
	                    <th>아이디</th>
	                    <td>${member.id}</td>
	                </tr>
	                <tr>
	                    <th>비밀번호</th>
	                    <td><input type="password" name="password" id="password" maxlength="16" /> (영문 대소문자/숫자 4자~16자)</td>
	                </tr>
	                <tr>
	                    <th>비밀번호 확인 </th>
	                    <td><input type="password" id="password_check" maxlength="16" /> <span id="pwd_check_text"></span> </td>
	                </tr>
	                <tr>
	                    <th>비밀번호 확인 질문 <img src="/images/ico_required.gif"></th>
	                    <td>
	                        <select name="pwd_confirm_q">
	                            <option value="q1" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q1' ? 'selected' : '' }" />>기억에 남는 추억의 장소는?</option>
	                            <option value="q2" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q2' ? 'selected' : '' }" />>자신의 인생 좌우명은?</option>
	                            <option value="q3" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q3' ? 'selected' : '' }" />>자신의 보물 제1호는?</option>
	                            <option value="q4" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q4' ? 'selected' : '' }" />>가장 기억에 남는 선생님은?</option>
	                            <option value="q5" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q5' ? 'selected' : '' }" />>타인이 모르는 자신만의 신체 비밀이 있다면?</option>
	                            <option value="q6" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q6' ? 'selected' : '' }" />>추억하고 싶은 날짜가 있다면?</option>
	                            <option value="q7" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q7' ? 'selected' : '' }" />>받았던 선물 중 기억에 남는 독특한 선물은?</option>
	                            <option value="q8" 
	                            	<c:out value="${member.pwd_confirm_q eq 'q8' ? 'selected' : '' }" />>유년시절 가장 생각나는 친구 이름은?</option>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>비밀번호 확인 답변 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="pwd_confirm_a" id="pwd_confirm_a" value='<c:out value="${member.pwd_confirm_a }" />' /></td>
	                </tr>
	                <tr>
	                    <th>이름 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="name" id="name" value='<c:out value="${member.name }" />' /></td>
	                </tr>
	                <tr>
	                <th>주소</th>
	                    <td>
	                        <input type="text" name="zipcode" id="zipcode" placeholder="우편번호" value='<c:out value="${member.zipcode }" />' 
	                        	 readonly="readonly" />
	                        <input type="button" onclick="openZipSearch()" value="우편번호 찾기" /><br>
	                        <input type="text" name="address1" id="address1" value='${member.address1 }' readonly="readonly" placeholder="주소"  /><br>
	                        <input type="text" name="address2" id="address2" placeholder="상세주소" value='${member.address2 }' />
	                        <input type="text" id="extraAddress" placeholder="참고항목" readonly="readonly" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>일반전화</th>
	                    <td>
	                    	<c:set var="tel" value="${fn:split(member.tel, '-') }" />
	                        <select name="tel1" id="tel1" style="width: 70px; height: 23px;">
	                            <option <c:out value="${tel[0] eq '02' ? 'selected' : '' }" />>02</option>
	                            <option <c:out value="${tel[0] eq '031' ? 'selected' : '' }" />>031</option>
	                            <option <c:out value="${tel[0] eq '032' ? 'selected' : '' }" />>032</option>
	                            <option <c:out value="${tel[0] eq '033' ? 'selected' : '' }" />>033</option>
	                            <option <c:out value="${tel[0] eq '041' ? 'selected' : '' }" />>041</option>
	                            <option <c:out value="${tel[0] eq '042' ? 'selected' : '' }" />>042</option>
	                            <option <c:out value="${tel[0] eq '043' ? 'selected' : '' }" />>043</option>
	                            <option <c:out value="${tel[0] eq '044' ? 'selected' : '' }" />>044</option>
	                        </select> - 
	                        <input type="text" name="tel2" id="tel2" maxlength="4" value='<c:out value="${tel[1] }" />' style="width: 100px;" /> - 
	                        <input type="text" name="tel3" id="tel3" maxlength="4" value='<c:out value="${tel[2] }" />' style="width: 100px;" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>휴대전화</th>
	                    <td>
	                    	<c:set var="phone" value="${fn:split(member.phone, '-') }" />
	                        <select name="phone1" id="phone1" style="width: 70px; height: 23px;" >
	                            <option <c:out value="${phone[0] eq '010' ? 'selected' : '' }" />>010</option>
	                            <option <c:out value="${phone[0] eq '011' ? 'selected' : '' }" />>011</option>
	                            <option <c:out value="${phone[0] eq '016' ? 'selected' : '' }" />>016</option>
	                            <option <c:out value="${phone[0] eq '017' ? 'selected' : '' }" />>017</option>
	                            <option <c:out value="${phone[0] eq '018' ? 'selected' : '' }" />>018</option>
	                            <option <c:out value="${phone[0] eq '019' ? 'selected' : '' }" />>019</option>
	                        </select> - 
	                        <input type="text" name="phone2" id="phone2" maxlength="4" value='<c:out value="${phone[1] }" />' style="width: 100px;" /> - 
	                        <input type="text" name="phone3" id="phone3" maxlength="4" value='<c:out value="${phone[2] }" />' style="width: 100px;" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>이메일 <img src="/images/ico_required.gif"></th>
	                    <td>
	                   	 <c:set var="email" value="${fn:split(member.email, '@') }" />
	                        <input type="text" name="email1" id="email1" value='<c:out value="${email[0] }" />' /> @ 
	                        <input type="text" name="email2" id="email2" value='<c:out value="${email[1] }" />' />
	                        <select id="select_email" style="height: 23px;" onchange="changeEmail()">
	                            <option value="">-- 직접 입력 --</option>
	                            <option>naver.com</option>
	                            <option>daum.net</option>
	                            <option>nate.com</option>
	                            <option>gmail.com</option>
	                            <option>hotmail.com</option>
	                            <option>yahoo.com</option>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>생년월일</th>
	                    <td>
	                    	<c:set var="birth" value="${fn:split(member.birth, '-') }" />
                            <input type="text" name="birth1" id="birth1" maxlength="4" value='<c:out value="${birth[0] }" />' style="width: 80px;" />년
	                        <input type="text" name="birth2" id="birth2" maxlength="2" value='<c:out value="${birth[1] }" />' style="width: 50px;" />월
	                        <input type="text" name="birth3" id="birth3" maxlength="2" value='<c:out value="${birth[2] }" />' style="width: 50px;" />일
	                        &nbsp; <small>예) 2000년 01월 01일</small>
	                    </td>
	                </tr>
	                <tr>
	                    <th>POINT</th>
	                    <td>
	                        <input type="text" name="point" id="point" value='${member.point }' style="width: 50px;" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>LEVEL</th>
	                    <td>
	                        <select name="level">
		            			<option value="5" <c:if test="${member.level == 'VVIP'}">selected</c:if> >VVIP</option>
		            			<option value="4" <c:if test="${member.level == 'VIP'}">selected</c:if> >VIP</option>
		            			<option value="3" <c:if test="${member.level == 'GOLD'}">selected</c:if> >GOLD</option>
		            			<option value="2" <c:if test="${member.level == 'SILVER'}">selected</c:if> >SILVER</option>
		            			<option value="1" <c:if test="${member.level == 'BRONZE'}">selected</c:if> >BRONZE</option>
		            		</select>
	                    </td>
	                </tr>
	            </table>
	        </div>
	    </div> 
	    <!-- 일반전화, 휴대전화, 이메일을 하나의 데이터로 만들어 request 전달 -->
	    <input type="hidden" name="tel" id="tel" />
	    <input type="hidden" name="phone" id="phone" />
        <input type="hidden" name="email" id="email" />
        <input type="hidden" name="birth" id="birth" />
    </form>

	<div class="row" style="margin-bottom: 200px;">
        <div class="col-md-10 col-md-offset-1" style="text-align: center;">
			<button type="submit" class="btn btn-default btn-sm" id="submitBtn"
				style="background-color: #404549; color: white;">회원정보수정</button>
			<button type="button" class="btn btn-default btn-sm" onclick="location.href='/admin/userManagement'">취소</button>
		</div>
		<div class="col-md-10 col-md-offset-1" style="text-align: right;">
			<button type="button" class="btn btn-default btn-withdrawal btn-sm" 
				onclick="location.href='/user/withdrawal'">회원탈퇴</button>
	    </div>
	</div>
    <!-- Modify Form End -->

    <%@ include file="../includes/footer.jsp" %>

</div> <!-- container end -->

<script type="text/javascript">
	$(document).ready(function() {

        // 비밀번호, 비밀번호 확인 포커스 아웃될 때
        $("#password, #password_check").blur(function() {
        	var password = $("#password").val();

            if($("#password").val() != $("#password_check").val()) { // 비밀번호화 비밀번호 확인 값이 같지 않다면 불일치 텍스트 표시
                $("#pwd_check_text").text('비밀번호가 일치하지 않습니다.');
            } else if(password.length < 4 && (password != null && password != "") ) { // 비밀번호가 4글자 보다 짧은 경우
            	$("#pwd_check_text").text('비밀번호는 영문 대/소문자 또는 숫자 4~16자로 입력해 주세요.');
            } else if(checkPassword(password)) { // 비밀번호 유효성 검사에 문제가 있을 경우
            	$("#pwd_check_text").text('공백/특수문자가 포함되어 있는 비밀번호는 사용할 수 없습니다.');
            } else {
                $("#pwd_check_text").text('');
            }

        });

        // 서브밋 버튼 눌렀을 때
        $("#submitBtn").on("click", function() {
            var id = $("#id").val();
	        var password = $("#password").val();
	        var password_check = $("#password_check").val();
	        var pwd_confirm_a = $("#pwd_confirm_a").val();
	        var name = $("#name").val();

            var tel1 = $("#tel1").val();
            var tel2 = $("#tel2").val();
            var tel3 = $("#tel3").val();

            var phone1 = $("#phone1").val();
            var phone2 = $("#phone2").val();
            var phone3 = $("#phone3").val();

            var email1 = $("#email1").val();
            var email2 = $("#email2").val();

            var birth1 = $("#birth1").val();
            var birth2 = $("#birth2").val();
            var birth3 = $("#birth3").val();
	        
            var tel =  tel1 + '-' + tel2 + '-' + tel3;
            var phone = phone1 + '-' + phone2 + '-' + phone3;
	        var email = email1 + '@' + email2;
            var birth = null;
            
            // 사용자가 생년월일을 모두 입력 했을 경우
            if(birth1 && birth2 && birth3) {
                birth = birth1 + '-' + birth2 + '-' + birth3;
            }

            // 일반전화가 비어있을 경우 tel = ""
            if(!tel2 && !tel3) {
                tel = "";
            }

            // 휴대전화가 비어있을 경우 phone = ""
            if(!phone2 && !phone3) {
                phone = "";
            }

            // 각각의 텍스트 값을 하나의 데이터로 만들어 전달
            $("#tel").val(tel);
            $("#phone").val(phone);
            $("#email").val(email);
            $("#birth").val(birth);

            if(!name) { // text name empty
                alert("이름 항목은 필수 입력값 입니다.");
                $("#name").focus();
            } else if(!email1 || !email2) { // text email empty
                alert("이메일 항목은 필수 입력값 입니다.");
                $("#email1").focus();
            } else if(password.length < 4 && (password != null && password != "")) { // 비밀번호가 4글자 보다 짧은 경우
            	alert("비밀번호는 영문 대/소문자 또는 숫자 4~16자로 입력해 주세요.11");
            } else if(checkPassword(password)) { // 비밀번호 유효성 검사에 문제가 있을 경우
            	alert("공백/특수문자가 포함되어 있는 비밀번호는 사용할 수 없습니다.");
            	$("#password").focus();
            } else if((birth1 || birth2 || birth3) && // 생년월일이 한 칸이라도 채워져 있을 경우, 모두 채워져 있지 않을 경우
                        !(birth1 && birth2 && birth3)) { 
           		alert("생년월일을 다시 확인해주세요.");
                $("#birth1").focus();
            } else if(checkBirth(birth1, birth2, birth3)) {
            	alert("생년월일에는 숫자만 입력할 수 있습니다.");
            } else if(birth.length != 10) {
            	alert("생년월일을 다시 확인해주세요.");
            } else if((tel2 || tel3) && !(tel2 && tel3)) { // 일반전화 체크
                alert("일반전화를 다시 확인해주세요.");
                $("#tel2").focus();
            } else if((phone2 || phone3) && !(phone2 && phone3)) { // 휴대전화 체크
                alert("휴대전화를 다시 확인해주세요.");
                $("#phone2").focus();
            } else { // 입력값에 문제 없을 경우 서브밋
            	$("#modifyForm").submit();
            }

        });
	});

    // 패스워드 유효성 검사
    function checkPassword(password) {
    	var pattern1 = /\s/; // 공백 여부
    	var pattern2 = /[[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 여부
    	
    	// 2가지 중 한 가지라도 포함 되어 있으면 true
    	if(pattern1.test(password) || pattern2.test(password)) {
    		return true;
    	} else {
    		return false;
    	}
    }

    // 생년월일 유효성 검사
    function checkBirth(birth1, birth2, birth3) {
        var pattern1 = /[^0-9]/;

        if(pattern1.test(birth1) || pattern1.test(birth2) || pattern1.test(birth3)) {
            return true;
        } else {
            return false;
        }
    }

    // 셀렉트 박스에서 이메일 선택 시 email2에 자동 기입
    function changeEmail() {
        var select_email = $("#select_email").val();
        $("#email2").val(select_email);
    }
</script>

</body>
</html>