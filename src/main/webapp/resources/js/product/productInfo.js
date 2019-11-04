var productJs = (function() {
	
	function getReviewList(product_code, type, callback) {
		
		$.ajax({
			type : 'get',
			url : '/product/getReviewList/' + product_code + '/' + type,
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