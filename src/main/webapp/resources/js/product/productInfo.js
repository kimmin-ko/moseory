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
	
	return {
		getReviewList : getReviewList
	}
	
})();