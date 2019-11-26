<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/orderCompletion.css">
</head>
<body>
	<%@ include file="../includes/sidebar.jsp"%>
	
	<script type="text/javascript">
	$(document).ready(function() {
		$('.order_code').text('${order.code}');
		
		var orderDetailList = JSON.parse('${orderDetailList}');
		
		// 총 상품금액
		var total_prod_price = 0;
		// 배송비
		var delivery_charge = ${order.delivery_charge};
		// 총 할인금액
		var total_discount = 0;
		// 사용한 적립금
		var used_point = ${order.used_point};
		// 총 결제금액
		var final_order_price = 0;
		
		var tbody = $('#order_prod_tbody');
		orderDetailList.forEach(function(orderDetail) {
			
			total_prod_price += orderDetail.product_price * orderDetail.quantity;
			total_discount += orderDetail.discount;
			
			// 색상과 사이즈가 존재하면 사이즈 앞에 / 붙임
			if(orderDetail.product_color) {
				if(orderDetail.product_size) 
					orderDetail.product_size = ' / ' + orderDetail.product_size;
				else
					orderDetail.product_size = '';
			} else {
				orderDetail.product_color = '';
			}
			
			var tr = '';
			tr += '<tr>';
			tr += '	<td>';
			tr += '		<img src="' + orderDetail.product_file_path + '" class="order_prod_img">';
			tr += '	</td>';
			tr += '	<td class="order_prod_info">';
			tr += '		<span class="order_prod_name">' + orderDetail.product_name + '</span><br><br>';
			tr += '		<span class="order_prod_option">';
			tr += '		[옵션: ' + orderDetail.product_color + orderDetail.product_size + ']';
			tr += '		</span>';
			tr += '	</td>';
			tr += '	<td>' + orderDetail.product_price.format() + '원</td>';
			tr += '	<td>' + orderDetail.discount.format() + '원</td>';
			tr += '	<td>' + orderDetail.quantity.format() + '</td>';
			tr += '	<td class="active">' + (orderDetail.product_price * orderDetail.quantity - orderDetail.discount).format() + '원</td>';
			tr += '</tr>';
			
			tbody.append(tr);
		});
		
		final_order_price = total_prod_price + delivery_charge - total_discount - used_point;
		
		$('.total_prod_price').text(total_prod_price.format() + '원');
		$('.delivery_charge').text('+ ' + delivery_charge.format() + '원');
		$('.total_discount').text('- ' + total_discount.format() + '원');
		$('.used_point').text('- ' + used_point.format() + '원');
		$('.final_order_price').text(final_order_price.format() + '원');
		
		switch('${order.pay_method}') {
			case 'card' : $('.pay_method').text('신용카드'); break;
			case 'trans' : $('.pay_method').text('계좌이체'); break;
			case 'vbank' : $('.pay_method').text('가상계좌(무통장)'); break;
			case 'phone' : $('.pay_method').text('핸드폰 결제]'); break;
			case 'payco' : $('.pay_method').text('페이코'); break;
			case 'point' : $('.pay_method').text('적립금 결제'); break;
		}
		
		$('.state').text('${order.state}');
		$('.order_date').text('${order.order_date}'.replace('T', ' '));
		
		$('.recipient_name').text('${order.recipient_name}');
		$('.recipient_tel').text('${order.recipient_tel}');
		$('.recipient_phone').text('${order.recipient_phone}');
		$('.recipient_email').text('${order.recipient_email}');
		
		var address1 = '${order.recipient_address1 }';
		var address2 = '${order.recipient_address2 }';
		$('.recipient_address').text(address1.concat(' ', address2));
		$('.message').text('${order.message}');
	
	}); // end document
	</script>

	<div class="container" style="margin-left: 22%;">
		
	    <!-- Order Completion Start -->
	    <div class="row">
	
	        <div class="col-md-10 col-md-offset-1 order_comple_lb">
	            <p>ORDER COMPLETION</p>
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 order_comple_header">
	            <p><span>주문이 정상적으로 완료</span>되었습니다.</p>
	            <p>주문번호 : <span class="order_code"></span></p>
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 order_comple_body">
	            <p class="body_name">> 주문 상품</p>
	            <table class="table order_prod_tbl">
	                <colgroup>
	                    <col style="width: 100px;"> <!-- 이미지 -->
	                    <col style="width: 250px;"> <!-- 상품 정보 -->
	                    <col style="width: 130px;"> <!-- 상품 금액 -->
	                    <col style="width: 130px;"> <!-- 할인 금액 -->
	                    <col style="width: 60px;"> <!-- 수량 -->
	                    <col style="width: 180px;"> <!-- 주문 금액 -->
	                </colgroup>
	                <thead>
	                    <tr class="active">
	                        <th>이미지</th>
	                        <th>상품 정보</th>
	                        <th>상품 금액</th>
	                        <th>할인 금액</th>
	                        <th>수량</th>
	                        <th>주문 금액</th>
	                    </tr>
	                </thead>
	                <tbody id="order_prod_tbody">
 	                </tbody>
	                <tfoot>
	                    <tr>
	                        <td colspan="4"></td>
	                        <td colspan="2" class="active">
	                            <ul>
	                                <li class="name_li">총 상품금액</li>
	                                <li class="value_li total_prod_price"></li>
	                                <li class="name_li">배송비</li>
	                                <li class="value_li delivery_charge"></li>
	                                <li class="name_li">할인금액</li>
	                                <li class="value_li total_discount"></li>
	                                <li class="name_li">사용 적립금</li>
	                                <li class="value_li used_point"></li>
	                                <li class="name_li">총 결제금액</li>
	                                <li class="value_li final_order_price"></li>
	                            </ul>
	                        </td>
	                    </tr>
	                </tfoot>
	            </table>
	
	            <p class="body_name">> 결제 정보</p>
	            <table class="table table-bordered payment_info_tbl">
	                <tr>
	                    <td class="active">결제 방법</td>
	                    <td class="pay_method"></td>
	                    <td class="active">총 결제 금액</td>
	                    <td class="final_order_price"></td>
	                </tr>
	                <tr>
	                    <td class="active">주문 상태</td>
	                    <td class="state"></td>
	                    <td class="active">주문 날짜</td>
	                    <td class="order_date"></td>
	                </tr>
	            </table>
	
	            <p class="body_name">> 배송지 정보</p>
	            <table class="table table-bordered delivery_info_tbl">
	                <tr>
	                    <td class="active">수령인</td>
	                    <td class="recipient_name"></td>
	                </tr>
	                <tr>
	                    <td class="active">일반 전화</td>
	                    <td class="recipient_tel"></td>
	                </tr>
	                <tr>
	                    <td class="active">휴대 전화</td>
	                    <td class="recipient_phone"></td>
	                </tr>
	                <tr>
	                    <td class="active">이메일</td>
	                    <td class="recipient_email"></td>
	                </tr>
	                <tr>
	                    <td class="active">배송지 주소</td>
	                    <td class="recipient_address"></td>
	                </tr>
	                <tr>
	                    <td class="active">배송 메세지</td>
	                    <td class="message"></td>
	                </tr>
	            </table>
	
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 order_comple_footer">
	            <button type="button" class="btn btn-default order_list_btn" onclick="location.href='/user/orderList'">주문내역확인</button>
	            <button type="button" class="btn btn-default" onclick="location.href='/index'">쇼핑계속</button>
	        </div>
	
	    </div>
	    <!-- Order Completion End -->
			
	
		<%@ include file="../includes/footer.jsp"%>

	</div>
	
</body>
</html>