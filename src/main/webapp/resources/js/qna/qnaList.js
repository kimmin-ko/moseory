var qnaJs = (function() {
	
	function getOriginalWriter(no, callback) {
		$.ajax({
			type : 'get',
			url : '/qna/getOriginalWriter/' + no,
			async : false,
			success : function(origin_writer) {
				if(callback)
					callback(origin_writer);
			}
		}); // end ajax
	}
	
	return {
		getOriginalWriter : getOriginalWriter
	}
	
})();