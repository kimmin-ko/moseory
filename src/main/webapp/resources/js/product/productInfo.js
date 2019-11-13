

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
		
		console.log("ajax color : " + color);
		console.log("ajax originSize : " + originSize);
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
			dataTyle : 'text',
			async : false,
			success : function(data) {
				if(callback)
					callback(data);
			}
		});
		
	} // addToCart
	
	return {
		getReviewList : getReviewList,
		addWishList : addWishList,
		getProductDetailNo : getProductDetailNo,
		addToCart : addToCart
	}
	
})();