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
	
	// 리뷰 등록할 때 평점, 5 초기화
	var grade = new Number(5);
	
	// 별점 스크립트
	$('.starRev span').on("click", function(){
		$(this).parent().children('span').removeClass('on');
		$(this).addClass('on').prevAll('span').addClass('on');
		
		grade = Number($(this).text());
		//console.log(member_id);
		
		return false;
	});
	
	// 등록 버튼
	$('.review_regist').on('click', function() {
		var title = $('.review_title').val();
		var content = $('.review_content').val();
		var order_code = $('.review_order_code').val();
		var product_detail_no = $('.review_pdNo').val();
		
		if(!title) {
			alert('제목을 입력해주세요.');
			$('.review_title').focus();
		} else if(!content) {
			alert('내용을 입력해주세요.');
			$('.review_content').focus();
		}
		
		var reviewReg = {
			member_id : member_id,
			title : title,
			content : content,
			order_code : order_code,
			product_detail_no : product_detail_no,
			grade : grade
		};
		
		orderListJs.registReview(reviewReg, function(result) {
			if(result == 'success') {
				alert('등록 완료!\n500원이 적립되었습니다.');
				$('.review-modal').modal('hide');
				location.reload();
				return;
			} else {
				alert('리뷰 등록에 실패했습니다.');
				$('.review-modal').modal('hide');
				return;
			}
		});
		
	}); // end reg btn
	

}); // end document

//리뷰 작성 모달창 초기화 및 보여주기
function showReviewModal(order_code, product_detail_no) {
	
	orderListJs.getModalInfo(order_code, product_detail_no, function(order_info) {
		// 색상과 사이즈가 존재하면 사이즈 앞에 / 붙임
		var color = order_info.product_color;
		var size = order_info.product_size;
		
		if(color) {
			if(size) 
				size = ' / ' + size;
			else
				size = '';
		} else { // 컬러 x 사이즈 o
			color = '';
		}
		
		$('.review_prod_img').attr('src', order_info.file_path);
		$('.review_prod_name').text(order_info.name);
		$('.review_prod_option').text('[옵션 : ' + color + size + ' ]');
	});
	
	// 리뷰 등록할 때 필요한 pdNo, order_code 넘겨주기
	$('.review_pdNo').val(product_detail_no);
	$('.review_order_code').val(order_code);
	
	$('.review-modal').modal({backdrop:'static'});
}

// 주문 취소
function orderCancel(order_code) {
	var c = confirm("주문을 취소하시겠습니까?\n(※ 해당 주문 번호의 모든 주문이 취소됩니다.)");
	
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

// 교환 요청
function changeOrderState(order_code, product_detail_no, state) {
	var q = '';
	
	switch(state) {
		case 'exchange' : 
			q = '해당 상품으로 교환하시겠습니까?';
			break;
		case 'return' : 
			q = '해당 상품을 환불하시겠습니까?';
			break;
	}
	
	var c = confirm(q);
	
	if(c) {
		var form = $('<form></form>');
		form.attr('method', 'post');
		form.attr('action', '/user/changeOrderState');
		form.appendTo('body');
		
		form.append($('<input type="hidden" name="state" value="' + state + '">'));
		form.append($('<input type="hidden" name="order_code" value="' + order_code + '">'));
		form.append($('<input type="hidden" name="product_detail_no" value="' + product_detail_no + '">'));
		form.submit();
	} else {
		return;
	}
	
}

// 구매 확정
function orderConfirm(order_code, product_detail_no, point, amount) {
	
	var c = confirm("해당 상품을 구매 확정하시겠습니까?");
	
	if(c) {
		var form = $('<form></form>');
		form.attr('method', 'post');
		form.attr('action', '/user/orderConfirm');
		form.appendTo('body');
		
		form.append($('<input type="hidden" name="order_code" value="' + order_code + '">'));
		form.append($('<input type="hidden" name="product_detail_no" value="' + product_detail_no + '">'));
		form.append($('<input type="hidden" name="point" value="' + point + '">'));
		form.append($('<input type="hidden" name="amount" value="' + amount + '">'));
		form.submit();
	} else {
		return;
	}
	
}

// 교환 요청 모달창 초기화 및 보여주기
function showExchangeModal(order_code, product_detail_no) {
	
	var product_code = new Number();
	var first_color = '';
	
	orderListJs.getModalInfo(order_code, product_detail_no, function(order_info) {
		// 색상과 사이즈가 존재하면 사이즈 앞에 / 붙임
		var color = order_info.product_color;
		var size = order_info.product_size;
		
		if(color) {
			if(size) 
				size = ' / ' + size;
			else
				size = '';
		} else { // 컬러 x 사이즈 o
			color = '';
		}
		
		$('#modal_prod_img').attr('src', order_info.file_path);
		$('.modal_prod_name').text(order_info.name);
		$('.modal_prod_option').text('[옵션 : ' + color + size + ' ]');
		$('.modal_prod_quantity').text(order_info.quantity + '개');
		
		// getColor에서 사용하기 위해 초기화
		product_code = order_info.product_code;
	})
	
	orderListJs.getColor(product_code, function(color) {
		first_color = color[0];
		
		var html_color = '<select class="form-control modal_select" id="modal_prod_color" onchange="getSize(\'' + product_code + '\', \'' + first_color + '\')">'
					   + '	<option>선택하세요.</option>'
					   + '</select>';
		
		if(color.length > 0) {
			$('.modal_color_size').append(html_color);
			
			for(var i = 0; i < color.length; i++) {
				$('#modal_prod_color').append('<option>' + color[i] + '</option>');
			}
		}
	});
	
	orderListJs.getSize(product_code, first_color, function(product) {
		var html_size = '<select class="form-control modal_select" id="modal_prod_size">'
			   		  + '	<option>선택하세요.</option>'
			   		  + '</select>';

		if(product[0].product_size != null) {
			$('.modal_color_size').append(html_size);
		}
	})
	
	// 교환 요청 버튼에 onclick 속성 초기화
	$('.exchangeReqBtn').attr('onclick', 'changeOrderState(\'' + order_code + '\', \'' + product_detail_no + '\', \'exchange\')');
	
	// 모달 창 띄우기
	$('.exchange-modal-sm').modal({backdrop:'static'});
}

function getSize(product_code, color) {
	
	$('#modal_prod_size').empty();
	
	orderListJs.getSize(product_code, color, function(product) {
		$('#modal_prod_size').append('<option>선택하세요.</option>');
		
		for(var i = 0; i < product.length; i++) {
			$('#modal_prod_size').append('<option>' + product[i].product_size + '</option>');
		}
	});
	
}

function clearSelectOption(){
	$('.modal_color_size').empty();
}

var orderListJs = (function() {
	
	function getModalInfo(order_code, product_detail_no, callback) {
		
		$.ajax({
			type : 'get',
			url : '/user/getExchangeModalInfo/' + order_code + '/' + product_detail_no,
			dataType : 'json',
			async : false,
			success : function(data) {
				if(callback)
					callback(data);
			}
		});
		
	} // getModalInfo
	
	function getSize(product_code, color, callback) {
		
		$.ajax({
			type : 'get',
			url : '/product/getSize/' + product_code + '/' + color,
			dataType : 'json',
			async : false,
			success : function(data) {
				if(callback)
					callback(data);
			}
		});
		
	} // getSize
	
	function getColor(product_code, callback) {
		
		$.ajax({
			type : 'get',
			url : '/product/getColor/' + product_code,
			dataType : 'json',
			async : false,
			success : function(data) {
				if(callback)
					callback(data);
			}
		});
		
	}// getColor
	
	function registReview(reviewReg, callback) {
		
		$.ajax({
			type : 'post',
			url : '/user/registReview',
			data : JSON.stringify(reviewReg),
			contentType : 'application/json; charset=utf-8',
			dataType : 'text',
			success : function(data) {
				if(callback)
					callback(data);
			}
		});
		
	}
	
	return {
		getModalInfo : getModalInfo,
		getSize : getSize,
		getColor : getColor,
		registReview : registReview
	}
})();










