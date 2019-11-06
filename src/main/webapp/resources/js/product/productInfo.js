

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
				if(data)
					callback(data);
			}
		});
		
	} // addWishList
	
	return {
		getReviewList : getReviewList,
		addWishList : addWishList
	}
	
})();