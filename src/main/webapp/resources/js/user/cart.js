$(document).ready(function() {
	// 총 주문 가격
	var total_prod_price = new Number(0);

	// 최상위 체크박스 선택 시 전체 선택
	$(".check-all").click(function() {
		$(".checkCart").prop("checked", this.checked);
	});

	// + 버튼을 누르면 수량을 1 증가시킨다.
	$(".btn-inc").on("click", function() {
		var incQty = Number($(this).prev().val()) + 1;

		$(this).prev().val(incQty);
	});

	// - 버튼을 누르면 수량을 1 감소시킨다.
	$(".btn-dec").on("click", function() {
		var decQty = Number($(this).prevAll("input[name=qty]").val()) - 1;
		if (decQty < 1) {
			alert("최소 주문 수량은 1개 입니다.");
			decQty = 1;
		}
		$(this).prev().prev().val(decQty);
	});
	
	// 선택한 상품을 삭제
	$(".btn-delete").on("click", function() {
		
		var noList = [];
		
		$("input:checkbox[name=check_cart]").each(function() {
			if(this.checked) {
				noList.push(this.value);
			} // end if
		}); // end check box each
		
		var c = confirm("선택한 상품을 삭제하시겠습니까?");
		
		if (c) {
			$("input[name=noList]").val(noList);
			$("#cartForm").attr({
				method : 'post',
				action : '/user/deleteCartList'
			}).submit();
		} else {
			return;
		} // end if
		
	}); // end delete function
	
}); // end document ready

function changeQuantity(no, modifyBtn) {

	// 수량을 변경할 상품의 cart.no, cart.quantity를 form의 input에 값을 넣어준다.
	var quantity = $(modifyBtn).prevAll("input[name=qty]").val();

	$("input[name=no]").val(no);
	$("input[name=quantity]").val(quantity);

	$("#cartForm").attr({
		method : 'post',
		action : '/user/modifyCartQuantity'
	}).submit();
}

function deleteCartList(no) {

	var c = confirm("상품을 삭제하시겠습니까?");

	if (c) {
		$("input[name=no]").val(no);
		$("#cartForm").attr({
			method : 'post',
			action : '/user/deleteCartOne'
		}).submit();
	} else {
		return;
	}

} // end deleteCartList

function deleteCartAll(member_id) {
	
	var c = confirm("장바구니를 비우시겠습니까?");
	
	if(c) {
		$("input[name=member_id]").val(member_id);
		$("#cartForm").attr({
			method : 'post',
			action : '/user/deleteCartAll'
		}).submit();
	}
} // end deleteCartAll


















