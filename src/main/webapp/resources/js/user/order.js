// 수령인 유효성 검사
function checkRecipient(recipient) {
	var pattern1 = /\s/; // 공백 여부
	var pattern2 = /[[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 여부
	var pattern3 = /[0-9]/;

	if (pattern1.test(recipient) || pattern2.test(recipient)
			|| pattern3.test(recipient)) {
		return true;
	} else {
		return false;
	}
}

// 휴대전화 유효성 검사
function checkTel(tel1, tel2) {
	var pattern = /[^0-9]/; // 숫자 외에 문자 여부

	if (pattern.test(tel1) || pattern.test(tel2)) {
		return true;
	} else {
		// 번호가 숫자일 때 tel1은 3 또는 4글자. tel2는 4글자 이어야한다.
		if ((tel1.length == 3 || tel1.length == 4) && tel2.length == 4
				|| tel1.length == 0 || tel2.length == 0)
			return false;
		else
			return true;
	}
}

// 이메일 유효성 검사
function checkEmail(email1, email2) {
	var pattern1 = /\s/; // 공백 여부
	var pattern2 = /[A-Z]/; // 대문자 여부
	var pattern3 = /[[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 여부
	var pattern4 = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글 여부

	if (pattern1.test(email1) || pattern2.test(email1) || pattern3.test(email1)
			|| pattern4.test(email1) || pattern1.test(email2)
			|| pattern2.test(email2) || pattern3.test(email2)
			|| pattern4.test(email2) || !email2.includes(".")) {
		return true;
	} else {
		return false;
	}
}

// 배송지 정보를 바꿔줌


function changeEmail() {
	var select_email = $("#select_email").val();
	$("#email").val(select_email);
}

function changePaymentMethod(value) {
	var pay_method_guide = "";

	switch (value) {
	case 'card':
		pay_method_guide += "<strong>안전결제(ISP)? (국민카드/BC카드/우리카드)</strong><br>";
		pay_method_guide += "<span class='method_explan'>온라인 쇼핑시 주민등록번호, 비밀번호 등의 주요 개인정보를 입력하지 않고 고객님이 사전에 미리 설정한 안전결제(ISP) 비밀번호만 입력, ";
		pay_method_guide += "결제하도록 하여 개인정보 유출 및 카드 도용을 방지하는 서비스입니다.</span><br><br>";
		pay_method_guide += "<strong>안심 클릭 결제? (삼성/외환/롯데/현대/신한/시티/하나/NH/수협/전북/광주/산업은행/제주은행)</strong><br>";
		pay_method_guide += "<span class='method_explan'>온라인 쇼핑시 주민등록번호, 비밀번호 등의 주요 개인 정보를 입력하지 않고 고객님이 사전에 미리 설정한 전자 상거래용 안심 클릭 ";
		pay_method_guide += "비밀번호를 입력하여 카드 사용자 본인 여부를 확인함으로써 온라인상에서의 카드 도용을 방지하는 서비스입니다.</span>";
		break;
	case 'trans':
		pay_method_guide += "<strong>계좌이체 안내</strong><br>";
		pay_method_guide += "<span class='method_explan'>계좌이체는 ATM이나 은행 홈페이지에 접속하지 않고 무신사 홈페이지 내에서 즉시 결제, 출금되는 결제 방식입니다. ";
		pay_method_guide += "현재 약 20여 개의 은행이 가능하며 현금영수증 발행은 결제 시 즉시 발급받으실 수 있습니다.</span>";
		break;
	case 'vbank':
		pay_method_guide += "<strong>가상 계좌 안내</strong><br>";
		pay_method_guide += "<span class='method_explan'>가상계좌는 주문 시 고객님께 발급되는 일회성 계좌번호 이므로 입금자명이 다르더라도 입금 확인이 가능합니다. ";
		pay_method_guide += "단, 선택하신 은행을 통해 결제 금액을 1원 단위까지 정확히 맞추셔야 합니다. 가상 계좌의 입금 유효 기간은 주문 후 2일 이내이며, ";
		pay_method_guide += "기간 초과 시 계좌번호는 소멸되어 입금되지 않습니다. 구매 가능 수량이 1개로 제한된 상품은 주문 취소 시, ";
		pay_method_guide += "24시간 내 가상 계좌를 통한 재주문이 불가 합니다. 인터넷뱅킹, 텔레뱅킹, ATM/CD기계, 은행 창구 등에서 입금할 수 있습니다.<br>";
		pay_method_guide += "ATM 기기는 100원 단위 입금이 되지 않으므로 통장 및 카드로 계좌이체 해주셔야 합니다. ";
		pay_method_guide += "은행 창구에서도 1원 단위 입금이 가능합니다. 자세한 내용은 FAQ를 확인하여 주시기 바랍니다.</span>";
		break;
	case 'phone':
		pay_method_guide += "<strong>휴대폰 결제(수수료) 안내</strong><br>";
		pay_method_guide += "<span class='method_explan'>휴대폰 결제는 통신사와 결제 대행사의 정책/ 높은 수수료/늦은 정산 주기로 인해 50만 원 이하 상품만 가능하며 ";
		pay_method_guide += "결제하실 금액의 5%가 결제 수수료로 추가됩니다.<br>";
		pay_method_guide += "예) 판매 금액 50,000원 상품을 휴대폰 결제할 경우 52,500원이 결제됩니다. 환불 시에는 수수료를 포함한 결제 금액이 환불됩니다.<br><br>";
		pay_method_guide += "※ 저렴한 구매를 원하실 경우 타 결제 수단(신용카드, 가상 계좌, 계좌이체)를 이용하시기 바랍니다.<br>";
		pay_method_guide += "※ 부분환불/결제 월이 지난 경우, 계좌로 환불됩니다.</span>";
		break;
	case 'payco':
		pay_method_guide += "<strong>PAYCO 간편결제 안내</strong><br>";
		pay_method_guide += "<span class='method_explan'>PAYCO는 온/오프라인 쇼핑은 물론 송금, 멤버십 적립까지 가능한 통합 서비스입니다.<br>";
		pay_method_guide += "휴대폰과 카드 명의자가 동일해야 결제 가능하며, 결제금액 제한은 없습니다.<br>";
		pay_method_guide += "-지원카드 : 모든 국내 신용/체크카드<br>";
		pay_method_guide += "-첫 구매 시(1만원 이상) 2,000원 즉시 할인 쿠폰 지급</span>";
		break;
	}

	$(".payment_guide").html(pay_method_guide);
}














