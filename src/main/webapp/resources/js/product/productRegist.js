$(document).ready(function() {
    
    $(".add_colorAndSize").on("click", function() {
        var html = '<div class="area_colorAndSize">'
                 + '    <input type="text" class="product_color" placeholder="색상 입력 (ex 화이트)">&nbsp;'
                 + '    <input type="button" value="사이즈 추가" onclick="addSizeForColor(this)">&nbsp;'
                 + '    <input type="button" value="X" onclick="deletePrtDiv(this)"><br><br>'
                 + '</div>';
        
        $(".detailInfo").append(html);
    }); // end add_colorAndSize

    $(".add_color").on("click", function() {
        var html = '<div class="area_color">'
                 + '    <input type="text" class="product_color" placeholder="색상 입력 (ex 화이트)">&nbsp;'
                 + '    <input type="text" class="product_stock" placeholder="재고 입력"> 개&nbsp;'
                 + '    <input type="button" value="X" onclick="deletePrtDiv(this)">'
                 + '</div>';

        $(".detailInfo").append(html);
    }); // end add_color

    $(".add_size").on("click", function() {
        var html = '<div class="area_size">'
                 + '    <select class="product_size">'
                 + '        <option value="XS">XS</option>'
                 + '        <option value="S">S</option>'
                 + '        <option value="M">M</option>'
                 + '        <option value="L">L</option>'
                 + '    <option value="XL">XL</option>'
                 + '    </select>'
                 + '    <input type="text" class="product_stock" placeholder="재고 입력"> 개&nbsp;'
                 + '    <input type="button" value="X" onclick="deletePrtDiv(this)">'
                 + '</div>';
        
        $(".detailInfo").append(html);
    }); // end add_size

}); // end document

// 색상&사이즈에서 사이즈 추가
function addSizeForColor(add_btn) {
    var html = '<div class="area_size_in_color">'
             + '    <select class="product_size">'
             + '        <option value="XS">XS</option>'
             + '        <option value="S">S</option>'
             + '        <option value="M">M</option>'
             + '        <option value="L">L</option>'
             + '    <option value="XL">XL</option>'
             + '    </select>'
             + '    <input type="text" class="product_stock" placeholder="재고 입력"> 개&nbsp;'
             + '    <input type="button" class="delete_size" value="X" onclick="deletePrtDiv(this)">'
             + '</div>';

    $(add_btn).parent().append(html);
}

// 부모 div를 제거
function deletePrtDiv(delete_btn) {
    $(delete_btn).parent().remove();
}

function detailInfo() {
    var product_detail = null;
    
    var color_arr = [];
    var size_arr = [];
    var stock_arr = [];

    if($(".product_color").val() && $(".product_size").val()) { // 색상&사이즈
        $(".product_stock").each(function() {
            console.log($(this).parent().prevAll(".product_color").val());
            console.log($(this).prev().val());
            console.log(this.value);
    
            color = $(this).parent().prevAll(".product_color").val();
            size = $(this).next().val();
            stock = this.value;
    
            color_arr.push(color);
            size_arr.push(size);
            stock_arr.push(stock);
        }); // end each
        
        for(var i = 0; i < stock_arr.length; i++) {
            product_detail = {
                product_color : color_arr[i],
                product_size : size_arr[i],
                product_stock : stock_arr[i]
            };

            sendPro(product_detail);
        } // end for

    } else if($(".product_color").val() && !$(".product_size").val()) { // 색상
    	$(".product_stock").each(function() {
    		console.log($(this).prev().val());
    		console.log(this.value);
    		
    		color = $(this).prev().val();
    		stock = this.value;
    		
    		color_arr.push(color);
    		stock_arr.push(stock);
    	}); // end each
    	
    	for(var i = 0; i < stock_arr.length; i++) {
    		product_detail = {
    	                product_color : color_arr[i],
    	                product_stock : stock_arr[i]
    	            };

    	            sendPro(product_detail);
    	}
    } else if(!$(".product_color").val() && $(".product_size").val()) { // 사이즈
        $(".product_stock").each(function() {
            console.log($(this).prev().val());
            console.log(this.value);

            size = $(this).prev().val();
            stock = this.value;

            size_arr.push(size);
            stock_arr.push(stock);
        }); // end each

        for(var i = 0; i < stock_arr.length; i++) {
            product_detail = {
                product_size : size_arr[i],
                product_stock : stock_arr[i]
            };

            sendPro(product_detail);
        } // end for

    } // end if

} // end detailInfo() 

function sendPro(productDetail) {
    $.ajax({
        type : "post",
        url : "/admin/productInfo",
        data : JSON.stringify(productDetail),
        async : false,
        contentType : "application/json; charset=utf-8"
    });
} // sendPro

function regist() {
	
	if(!$('input[name=name]').val()) {
		alert('상품명을 입력해주세요.');
		$('input[name=name]').focus();
	} else if($('select[name=high_code]').val() == '카테고리를 선택해주세요') {
		alert('상위 카테고리를 선택해주세요.');
		$('select[name=high_code]').focus();
	} else if($('select[name=low_code]').val() == '상위 카테고리를 선택해주세요') {
		alert('하위 카테고리를 선택해주세요.');
		$('select[name=low_code]').focus();
	} else if(!$('input[name=price]').val()) {
		alert('가격을 입력해주세요.');
		$('input[name=price]').focus();
	} else if(checkNumber($('input[name=price]').val())) {
		alert('가격은 숫자만 입력 가능합니다.');
		$('input[name=price]').focus();
 	} else if(!$('.product_stock').val()) {
		alert('상품 옵션은 필수입니다.');
		return false;
	} else if(checkNumber($('.product_stock').val())) {
		alert('상품 재고는 숫자만 입력 가능합니다.');
		return false;
	} else if(!$('#thumbnail').val()) {
		alert('대표 이미지를 등록해주세요.');
		$('#thumbnail').focus();
	} else if(!$('#getImage').val()) {
		alert('상품 정보 이미지를 등록해주세요.');
		$('#thumbnail').focus();
	} else {
		// product detail 먼저 전달해서 List에 담아둔다
		detailInfo();
		
		// product 정보를 등록한다
		$("#registForm").submit();
	}
}

// 가격, 재고 유효성 검사
function checkNumber(data) {
	var pattern = /[^0-9]/;
		
	if(pattern.test(data)) {
		return true;
	} else {
		return false;
	}
}
