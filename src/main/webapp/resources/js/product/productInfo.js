$(document).ready(function() {
	
	// qnaY cookie가 있을 경우 실행
	if($.cookie('qnaY')) {
		// 스크롤 위치 이동 후 쿠키 삭제
		$(window).scrollTop($.cookie('qnaY'));
		$.removeCookie('qnaY');
	}
	
	function setQnaTopCookie() {
		var qnaY = $('.qna-header').offset().top;
		$.cookie('qnaY', qnaY);
	}
	
	var actionForm = $('#actionForm');
	
	// 페이지 번호 클릭
	$('.paginate_button a').on('click', function(e) {
		e.preventDefault();
		
		$('input[name=pageNum]').val($(this).attr('href'));
		
		// div qna-header의 y값을 쿠키에 저장
		setQnaTopCookie();
		
		actionForm.submit();
	});
	
	// 글 제목 클릭
	$('.title').on('click', function(e) {
		// a 태그 막기
		e.preventDefault();
		
		// div qna-header의 y값을 쿠키에 저장
		setQnaTopCookie();
		
		// 글 조회를 위한 번호
		var no = $(this).find('input[name=no]').val();
		
		// cri가 담겨있는 form
		var actionForm = $('#actionForm');
		actionForm.attr('action', '/qna/qnaGet');
		actionForm.append('<input type="hidden" name="no" value="' + no + '">');
		
		// 비밀글 여부
		var secret = $(this).attr('href');
		
		// 작성자
		var writer = $(this).find('input[name=writer]').val();

		if(secret == '1') { // 비밀글
			if(member_id == writer) { // 작성자와 접속중인 사용자가 동일한 경우 
				actionForm.submit(); // 문의글 조회 이동
			} else { // 작성자가 아닌 경우
				alert("비밀글은 작성자만 조회할 수 있습니다.");
				return false;
			}
		} else { // 공개글
			actionForm.submit(); // 문의글 조회 이동
		 }
		
	});
	
	// Q&A 글쓰기 버튼 클릭
	$('.qna_reg_btn').on('click', function() {
		// div qna-header의 y값을 쿠키에 저장
		setQnaTopCookie();
		
		actionForm.attr('action', '/qna/qnaRegistOnProductInfo');
		actionForm.submit();
	});
	
	// info 메뉴 클릭
	$('.menu_info').on('click', function() {
		var y = $('.info_row').offset().top;
		$(window).scrollTop(y);
	});
	
	// 리뷰 메뉴 클릭
	$('.menu_review').on('click', function() {
		var y = $('.review-header').offset().top;
		$(window).scrollTop(y);
	});
	
	// Q&A 메뉴 클릭
	$('.menu_qna').on('click', function() {
		var y = $('.qna-header').offset().top;
		$(window).scrollTop(y);
	});
	
}); // end document


var productJs = (function() {
	
	function getReviewList(product_code, type, limit, callback) {
		
		$.ajax({
			type : 'get',
			url : '/product/getReviewList/' + product_code + '/' + type + '/' + limit,
			success : function(reviewList) {
				if(callback) {
					callback(reviewList);
				}
			}  
		}); // ajax
		
	} // getReviewList
	
	function addWishList(member_id, product_code, callback) {
		var wishList = {
				member_id : member_id,
				product_code : product_code
		};
		
		$.ajax({
			type : 'post',
			url : '/user/addWishList',
			data : JSON.stringify(wishList),
			contentType : 'application/json; charset=utf-8',
			dataType : 'text',
			success : function(data) {
				if(callback)
					callback(data);
			}
		});
		
	} // addWishList
	
	function getProductDetailNo(product_code, color, originSize, callback) {
		/* url로 데이터를 넘길 때 null 값이나 공백이 포함되면 서버에서 PathVariable로 받을 수없다.
		 * 그래서 RequestParam을 이용하는데, 이 때 key에 value가 null이거나 공백일 경우 500에러가 발생한다.
		 * value가 없을 경우 key도 없어야 하기 때문에 value가 공백이 아닐 경우에 key를 붙여서 넘겨준다.
		 * */
		if(color != '') color = '&product_color=' + color; 
		if(originSize != '') originSize = '&product_size=' + originSize;
		
		$.ajax({
			type : 'get',
			url : '/product/getProductDetailNo?product_code=' + product_code + color + originSize,
			async : false,
			success : function(data) {
				if(callback)
					callback(data);
			},
			error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }

		});
		
	} // getProductDetailNo
	
	function addToCart(cart, callback) {
		
		$.ajax({
			type : 'post',
			url : '/user/addToCart',
			data : JSON.stringify(cart),
			contentType : 'application/json; charset=utf-8',
			dataType : 'text',
			async : false,
			success : function(data) {
				if(callback)
					callback(data);
			}
		});
		
	} // addToCart
	
	function getProductStock(pdNo, callback) {
		
		$.ajax({
			type : 'get',
			url : '/product/getProductStock?product_detail_no=' + pdNo,
			async : false,
			success : function(data) {
				if(callback)
					callback(data);
			}
		}); // end ajax
		
	} // end getProductStock
	
	return {
		getReviewList : getReviewList,
		addWishList : addWishList,
		getProductDetailNo : getProductDetailNo,
		addToCart : addToCart,
		getProductStock : getProductStock
	}
	
})();