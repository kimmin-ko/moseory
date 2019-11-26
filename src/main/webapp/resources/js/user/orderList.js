$(function() {
	$('.hasDatepicker').datepicker({
		format : "yyyy-mm-dd", // 데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
		autoclose : true, // 사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
		templates : {
			leftArrow : '&laquo;',
			rightArrow : '&raquo;'
		}, // 다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징
		todayHighlight : true, // 오늘 날짜에 하이라이팅 기능 기본값 :false
		weekStart : 1,// 달력 시작 요일 선택하는 것 기본값은 0인 일요일
		language : "ko" // 달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
	});
}); // end datepicker

// 기간 세팅
function setPeriod(period) {
	var today = new Date();

	var startDate = '';
	var endDate = convertDateToString(today);

	switch (period) {
	case 'today':
		break;
	case '1week':
		today.setDate(today.getDate() - 7);
		break;
	case '1month':
		today.setMonth(today.getMonth() - 1);
		break;
	case '3month':
		today.setMonth(today.getMonth() - 3);
		break;
	case 'all':
		today.setDate(today.getDate() + 1);
		endDate = '';
		break;
	default:
		alert('잘못된 양식입니다.');
		break;
	}

	startDate = convertDateToString(today);

	$('#startDate').val(startDate);
	$('#endDate').val(endDate);
} // end setPeriod

// Date -> String ('yyyy-mm-dd')
function convertDateToString(object) {
	// all (전체 시기) 빈 문자열 리턴
	var now = new Date();
	if (object > now)
		return '';

	var year = object.getFullYear() + '';
	var month = object.getMonth() + 1 + '';
	var date = object.getDate() + '';

	if (month.length < 2)
		month = '0' + month;
	if (date.length < 2)
		date = '0' + date;

	return [ year, month, date ].join('-');
} // end convertDateToString

// String -> Date
function convertStringToDate(str) {
	var str = str.split('-');
	return new Date(str[0], str[1], str[2]);
} // end convertStringToDate

$(document).ready(function() {

	$('#startDate').on("change", function() {
		// Date Type으로 변환
		var startDate = convertStringToDate($(this).val());
		var endDate = convertStringToDate($('#endDate').val());

		if (startDate.getTime() > endDate.getTime()) {
			$('#endDate').val($(this).val());
		}

	}); // end startDate onchange

	$('#endDate').on("change", function() {
		// Date Type으로 변환
		var startDate = convertStringToDate($('#startDate').val());
		var endDate = convertStringToDate($(this).val());

		if (startDate.getTime() > endDate.getTime()) {
			$('#startDate').val($(this).val());
		}

	}); // end endDate onchange
	
	// 검색 조건으로 주문 조회
	$('.getOrderList').on("click", function() {
		
		var state = $('select[name=state]').val();
		var startDate = $('input[name=startDate]').val();
		var endDate = $('input[name=endDate]').val();
		
		state = 'state=' + state;
		if(startDate != '' || startDate != null)
			startDate = '&startDate=' + startDate;
		if(endDate != '' || endDate != null)
			endDate = '&endDate=' + endDate;
		
		location.href='/user/orderList?' + state + startDate + endDate;
		
	}); // end getOrderList
	

}); // end document

// 주문 취소
function orderCancel(order_code) {
	var c = confirm("주문을 취소하시겠습니까?\n(※ 해당 주문 번호의 모든 주문이 취소됩니다.)")
	
	if(c) {
		var form = $('<form></form>');
		form.attr('method', 'post');
		form.attr('action', '/user/orderCancel');
		form.appendTo('body');
		
		form.append($('<input type="hidden" name="order_code" value="' + order_code + '">'));
		form.submit();
	} else {
		return;
	}
}















