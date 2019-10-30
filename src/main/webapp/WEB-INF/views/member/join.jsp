t<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/joinForm.css">
</head>
<body>

<!-- Daum 우편번호 찾기 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function openZipSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();
            }
        }).open();
    }
</script>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container joinForm-container" style="margin-left:22%">

    <!-- Join Form Start -->
    <div class="row joinLabel-row" style="margin-top: 80px;">
        <div class="col-md-10 col-md-offset-1">
            <p>MEMBER JOIN</p>
        </div>
    </div>

    <div class="row" style="margin-bottom: 50px; margin-top: 30px;">
        <div class="col-md-10 col-md-offset-1 eSite-login-form line-div">
            <div class="col-md-3 col-md-offset-3 high-row"><img src="/images/btn_facebook_login.gif"></div>
            <div class="col-md-3 high-row"><img src="/images/btn_google_login.gif"></div>
            <div class="col-md-3 col-md-offset-3 low-row"><img src="/images/btn_kakao_login.gif"></div>
            <div class="col-md-3 low-row"><img src="/images/btn_naver_login.gif"></div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
            <div class="col-md-6" style="padding: 0;">
                <span style="font-weight: bold;">기본정보</span>
            </div>
            <div class="col-md-6" style="text-align: right; padding: 0;">
                <span><img src="/images/ico_required.gif"> 필수입력사항</span>
            </div>
        </div>
    </div>
	
	<form action="/member/join" method="post" id="joinform">
	    <div class="row" style="margin-bottom: 50px;">
	        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
	            <table class="table table-bordered join-table">
	                <tr>
	                    <th>아이디 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="id" id="id" maxlength="16" /><span id="id_check_text"></span> (영문소문자/숫자, 4~16자)</td>
	                </tr>
	                <tr>
	                    <th>비밀번호 <img src="/images/ico_required.gif"></th>
	                    <td><input type="password" name="password" id="password" maxlength="16" /> (영문 대소문자/숫자 4자~16자)</td>
	                </tr>
	                <tr>
	                    <th>비밀번호 확인 <img src="/images/ico_required.gif"></th>
	                    <td><input type="password" id="password_check" maxlength="16" /> <span id="pwd_check_text"></span> </td>
	                </tr>
	                <tr>
	                    <th>비밀번호 확인 질문 <img src="/images/ico_required.gif"></th>
	                    <td>
	                        <select name="pwd_confirm_q">
	                            <option value="q1">기억에 남는 추억의 장소는?</option>
	                            <option value="q2">자신의 인생 좌우명은?</option>
	                            <option value="q3">자신의 보물 제1호는?</option>
	                            <option value="q4">가장 기억에 남는 선생님은?</option>
	                            <option value="q5">타인이 모르는 자신만의 신체 비밀이 있다면?</option>
	                            <option value="q6">추억하고 싶은 날짜가 있다면?</option>
	                            <option value="q7">받았던 선물 중 기억에 남는 독특한 선물은?</option>
	                            <option value="q8">유년시절 가장 생각나는 친구 이름은?</option>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>비밀번호 확인 답변 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="pwd_confirm_a" id="pwd_confirm_a" /></td>
	                </tr>
	                <tr>
	                    <th>이름 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="name" id="name" /> </td>
	                </tr>
	                <tr>
	                	<th>주소</th>
	                    <td>
	                        <input type="text" name="zipcode" id="zipcode" placeholder="우편번호" style="width: 100px; margin-bottom: 5px;" readonly="readonly">
	                        <input type="button" onclick="openZipSearch()" value="우편번호 찾기"><br>
	                        <input type="text" name="address1" id="address1" style="width: 196px; margin-bottom: 5px;" placeholder="주소" readonly="readonly"><br>
	                        <input type="text" name="address2" id="address2" placeholder="상세주소">
	                        <input type="text" id="extraAddress" placeholder="참고항목" readonly="readonly" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>일반전화</th>
	                    <td>
	                        <select name="tel1" id="tel1" style="width: 70px; height: 23px;">
	                            <option>02</option>
	                            <option>031</option>
	                            <option>032</option>
	                            <option>033</option>
	                            <option>041</option>
	                            <option>042</option>
	                            <option>043</option>
	                            <option>044</option>
	                        </select> - 
	                        <input type="text" name="tel2" id="tel2" maxlength="4" style="width: 100px;" /> - 
	                        <input type="text" name="tel3" id="tel3" maxlength="4" style="width: 100px;" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>휴대전화</th>
	                    <td>
	                        <select name="phone1" id="phone1" style="width: 70px; height: 23px;">
	                            <option>010</option>
	                            <option>011</option>
	                            <option>016</option>
	                            <option>017</option>
	                            <option>018</option>
	                            <option>019</option>
	                        </select> - 
	                        <input type="text" name="phone2" id="phone2" maxlength="4" style="width: 100px;" /> - 
	                        <input type="text" name="phone3" id="phone3" maxlength="4" style="width: 100px;" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>이메일 <img src="/images/ico_required.gif"></th>
	                    <td>
	                        <input type="text" name="email1" id="email1" /> @ 
	                        <input type="text" name="email2" id="email2" />
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
                            <input type="text" name="birth1" id="birth1" maxlength="4" style="width: 80px;" />년
	                        <input type="text" name="birth2" id="birth2" maxlength="2" style="width: 50px;" />월
	                        <input type="text" name="birth3" id="birth3" maxlength="2" style="width: 50px;" />일
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

    <div class="row" style="margin-bottom: 50px;">
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
            <span style="font-weight: bold;">이용약관 동의</span>
        </div>
        <div class="col-md-10 col-md-offset-1 use-agreement">
        	<%@ include file="../includes/use_agreement_1.jsp" %>
        </div>
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
         	이용약관에 동의하십니까? <input type="checkbox" name="agreement" id="agree1">동의함
        </div>
    </div>

	<div class="row" style="margin-bottom: 200px;">
		<div class="col-md-10 col-md-offset-1" style="padding: 0;">
			<span style="font-weight: bold;">개인정보 수집 및 이용 동의</span>
		</div>
		<div class="col-md-10 col-md-offset-1 use-agreement">
			<%@ include file="../includes/use_agreement_2.jsp" %>
		</div>
		<div class="col-md-10 col-md-offset-1" style="padding: 0; margin-bottom: 30px;">
			개인정보 수집 및 이용에 동의하십니까?  <input type="checkbox" name="agreement" id="agree2">동의함
        </div>
        <div class="col-md-10 col-md-offset-1" style="text-align: center;">
			<button type="submit" class="btn btn-default" id="submitBtn"
				style="background-color: #404549; color: white;">회원가입</button>
			<button type="button" class="btn btn-default" onclick="location.href='/index'">회원가입 취소</button>
	    </div>
	</div>
    <!-- Join Form End -->

    <%@ include file="../includes/footer.jsp" %>

</div> <!-- container end -->

<script type="text/javascript">

	// 아이디 중복 확인
	var checkDuplService = (function(){
		
		function check(id, callback) {
			
            $.get(
                "/member/checkDuplId/" + id,
                function(result) {
                    if(callback) {
                        callback(result);
                    }
                }
            ); // $.get

		} // check

        return {check : check};
    })();

	$(document).ready(function() {

        // submit 시에도 사용하기 위해 전역 변수로 선언
        var checkDupl = "";

        // 아이디 포커스 아웃될 때
        $("#id").blur(function() {
            var id = $("#id").val();
            
            
            // 아이디 중복 확인
            checkDuplService.check(id, function(data){
                checkDupl = data;
                console.log("checkDupl : " + checkDupl);

                if(checkDupl != "") { // 아이디가 중복일 경우
                    $("#id_check_text").text(id + '는 이미 사용중인 아이디입니다.');
                } else if(id.length < 4) { // 아이디가 4글자 보다 짧을 경우
                    $("#id_check_text").text('아이디는 영문소문자 또는 숫자 4~16자로 입력해 주세요.');
                } else if(checkId(id)) { // 아이디 유효성 검사에 문제가 있을 경우
                    $("#id_check_text").text('공백/특수문자/대문자가 포함되어 있는 아이디는 사용할 수 없습니다.');
                } else if(checkDupl == "") { // 중복이 아닌 경우
                    $("#id_check_text").text(id + "는 사용 가능한 아이디입니다.");
                }
            });

        });

        // 비밀번호, 비밀번호 확인 포커스 아웃될 때
        $("#password, #password_check").blur(function() {
        	var password = $("#password").val();

            if($("#password").val() != $("#password_check").val()) { // 비밀번호화 비밀번호 확인 값이 같지 않다면 불일치 텍스트 표시
                $("#pwd_check_text").text('비밀번호가 일치하지 않습니다.');
            } else if(password.length < 4) { // 비밀번호가 4글자 보다 짧은 경우
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

            // 일반전화가 비어있을 경우 phone = ""
            if(!phone2 && !phone3) {
                phone = "";
            }

            // 각각의 텍스트 값을 하나의 데이터로 만들어 전달
            $("#tel").val(tel);
            $("#phone").val(phone);
            $("#email").val(email);
            $("#birth").val(birth);

            if(!id) { // text id empty
                alert("아이디 항목은 필수 입력값 입니다.");
                $("#id").focus();
            } else if(!password) { // text password empty
                alert("비밀번호 항목은 필수 입력값 입니다.");
                $("#password").focus();
            } else if(!password_check) { // text password_check empty
                alert("비밀번호 항목은 필수 입력값 입니다.");
                $("#password_check").focus();
            } else if(!name) { // text name empty
                alert("이름 항목은 필수 입력값 입니다.");
                $("#name").focus();
            } else if(!email1 || !email2) { // text email empty
                alert("이메일 항목은 필수 입력값 입니다.");
                $("#email1").focus();
            } else if(!pwd_confirm_a) { // text pwd_confirm_a empty
                alert("비밀번호 확인 답변 항목은 필수 입력값 입니다.");
                $("#pwd_confirm_a").focus();
            } else if(id.length < 4) { // 아이디가 4글자 보다 짧을 경우
                alert("아이디는 영문소문자 또는 숫자 4~16자로 입력해 주세요.");
                $("#id").focus();
            } else if(checkId(id)) { // 아이디 유효성 검사에 문제가 있을 경우
                alert("공백/특수문자/대문자가 포함되어 있는 아이디는 사용할 수 없습니다.");
                $("#id").focus();
            } else if(checkDupl != "") {
                alert("이미 사용중인 아이디입니다.");
                $("#id").focus();
            } else if(password != password_check) { // 비밀번호 값과 비밀번호 확인 값이 일치하지 않을 때
                alert("비밀번호가 일치하지 않습니다.");
                $("#password").focus();
            } else if(password.length < 4) { // 비밀번호가 4글자 보다 짧은 경우
            	alert("비밀번호는 영문 대/소문자 또는 숫자 4~16자로 입력해 주세요.");
            } else if(checkPassword(password)) { // 비밀번호 유효성 검사에 문제가 있을 경우
            	alert("공백/특수문자가 포함되어 있는 비밀번호는 사용할 수 없습니다.");
            	$("#password").focus();
            } else if((birth1 || birth2 || birth3) && // 생년월일이 한 칸이라도 채워져 있을 경우, 모두 채워져 있지 않을 경우
                        !(birth1 && birth2 && birth3)) { 
           		alert("생년월일을 다시 확인해주세요.");
                $("#birth1").focus();
            } else if(checkBirth(birth1, birth2, birth3)) {
            	alert("생년월일에는 숫자만 입력할 수 있습니다.");
            } else if((tel2 || tel3) && !(tel2 && tel3)) { // 일반전화 체크
                alert("일반전화를 다시 확인해주세요.");
                $("#tel2").focus();
            } else if((phone2 || phone3) && !(phone2 && phone3)) { // 휴대전화 체크
                alert("휴대전화를 다시 확인해주세요.");
                $("#phone2").focus();
            } else if(!$("#agree1").is(":checked")) { // 이용 약관 동의 언체크
                alert("이용약관에 동의하세요.");
            } else if(!$("#agree2").is(":checked")) { // 개인정보 동의 언체크
            	alert("개인 정보 수집 및 이용에 동의하세요.")
            } else { // 입력값에 문제 없을 경우 서브밋
            	$("#joinform").submit();
            }

        });
	});

    // 아이디 유효성 검사
    function checkId(id) {
        var pattern1 = /\s/; // 공백 여부
        var pattern2 = /[A-Z]/; // 대문자 여부
        var pattern3 = /[[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 여부

        // 3가지 중 한 가지라도 포함 되어 있으면 true
        if(pattern1.test(id) || pattern2.test(id) || pattern3.test(id)) {
            return true;
        } else {
            return false;
        }
    }
    
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