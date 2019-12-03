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
<link rel="stylesheet" href="/css/order.css">
</head>
<body>
	<!-- 아임포트 API -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<!-- 다음 주소 API -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/address/daum_address.js"></script>

	<%@ include file="../includes/sidebar.jsp"%>
	
	<script src="/js/user/order.js"></script>
	<script type="text/javascript">
	$(document).ready(
			function() {
				// 아임포트 window.IMP 초기화
				var IMP = window.IMP;
				IMP.init('imp30264444'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
				// 결제 수단 기본 card
				var pay_method = 'card';
				// 주문 상품명
				var name = '';
				// 주문 금액
				var amount = 10;
				// 구매자 이메일
				var buyer_email = '${member.email}';
				// 구매자 이름
				var buyer_name = '${member.name}';
				// 구매자 전화번호 (핸드폰 번호 불러옴)
				var buyer_tel = '${member.phone}';
				// 구매자 주소
				var buyer_addr = '${member.address1}';
				// 구매자 우편번호
				var buyer_postcode = '${member.zipcode}';
				
				// 결제하기 버튼
				$(".btn_payment").on("click", function() {
					var name = $("input[name=name]").val();
					
					var zipcode = $("input[name=zipcode]").val();
					var address1 = $("input[name=address1]").val();
					var address2 = $("input[name=address2]").val();
					
					var tel = '';
					var tel1 = $("input[name=tel2]").val();
					var tel2 = $("input[name=tel3]").val();
					
					var phone = '';
					var phone1 = $("input[name=phone2]").val();
					var phone2 = $("input[name=phone3]").val();
					
					var email = '';
					var email1 = $("input[name=email1]").val();
					var email2 = $("input[name=email2]").val();
					
					var message = $("textarea[name=delivery_message]").val();
					
					var used_point = $("input[name=point]").val();
					
					if(!name) { // 수령인 비어있을 경우
						alert("수령인 항목은 필수 입력값 입니다.");
						$("input[name=name]").focus();
						return;
					} else if(checkRecipient(name)) { // 수령자명 유효성 검사
						alert("수령자명은 한글과 영문만 입력할 수 있습니다.");
						$("input[name=name]").focus();
						return;
					} else if(!zipcode || !address1 || !address2) { // 주소가 비어있을 경우
						alert("주소 항목은 필수 입력값 입니다.");
						$("input[name=address2]").focus();
						return;
					} else if(checkTel(tel1, tel2)) { // 일반전화 유효성 검사 
						alert("일반전화 항목 입력값이 잘못되었습니다.");
						$("input[name=tel1]").focus();
						return;
					} else if(!phone1 || !phone2) { // 휴대전화가 비어있을 경우
						alert("휴대전화 항목은 필수 입력값 입니다.");
						$("input[name=phone2]").focus();
						return;
					} else if(checkTel(phone1, phone2)) { // 휴대전화 유효성 검사
						alert("휴대전화 항목 입력값이 잘못되었습니다.");
						$("input[name=phone2]").focus();
						return;
					} else if(!email1 || !email2) { // 이메일이 비어있을 경우
						alert("이메일 항목은 필수 입력값 입니다.");
						$("input[name=email1]").focus();
						return;
					} else if(checkEmail(email1, email2)) { // 이메일 유효성 검사
						alert("이메일 항목 입력값이 잘못되었습니다.");
						$("input[name=email1]").focus();
						return;
					} else if(!$("#pay_agreement").is(":checked")) {
						alert("구매진행 항목에 동의는 필수 입력값 입니다.");
						$("#pay_agreement").focus();
						return;
					} else if(tel1 || tel2) {
						tel = $("select[name=tel1]").val() + '-' + tel1 + '-' + tel2;
					}
					
					phone = $("select[name=phone1]").val() + '-' + phone1 + '-' + phone2;
					email = email1 + '@' + email2;
					
					var order_vo = {
							member_id : '${member.id}',
							delivery_charge : delivery_charge,
							recipient_name : name,
							recipient_zipcode : zipcode,
							recipient_address1 : address1,
							recipient_address2 : address2,
							recipient_tel : tel,
							recipient_phone : phone,
							recipient_email : email,
							message : message,
							pay_method : pay_method,
							used_point : used_point
					};
					
					// 최종 주문 금액이 0원인 경우
					if(amount == 0) {
						var c = confirm("결제 금액이 0원입니다. 결제 하시겠습니까?");
						
						if(c) {
							// 주문 완료 시 실행
							order_vo.pay_method = 'point';
							
							// 디테일 먼저 저장
							details_list.forEach(function(details) {
								addOrderDetail(details);
							});
							
							addOrder(order_vo);	
							return;
						} else {
							return;
						}
					}
					
					IMP.request_pay({
					    pg : 'html5_inicis', // version 1.1.0부터 지원.
					    pay_method : pay_method, // 결제 수단
					    merchant_uid : 'merchant_' + new Date().getTime(),
					    name : name, // 주문 상품 이름
					    amount : amount, // 주문 금액
					    buyer_email : buyer_email, // 구매자 이메일
					    buyer_name : buyer_name, // 구매자 이름
					    buyer_tel : buyer_tel, // 구매자 전화번호
					    buyer_addr : buyer_addr, // 구매자 주소
					    buyer_postcode : buyer_postcode // 구매자 우편번호
					}, function(rsp) {
					    if ( rsp.success ) {
					        var msg = '결제가 완료되었습니다.';
							
					     	// 디테일 먼저 저장
							details_list.forEach(function(details) {
								addOrderDetail(details);
							});
					     
							// 주문 완료 처리
							addOrder(order_vo);
					    } else {
					        var msg = '결제에 실패하였습니다.\n';
					        msg += rsp.error_msg;
					    }
					    alert(msg);
					}); // end request_pay
					
				}); // end payment_btn onclick
				
				function addOrderDetail(details) {
					$.ajax({
						type : 'post',
						url : '/user/addDetailsList',
						data : JSON.stringify(details),
						contentType : 'application/json; charset=utf-8',
						async : false
					});
				}
				
				// 주문 완료 시 실행 함수
				function addOrder(order_vo) {
					var form = $('<form></form>');
					form.attr('method', 'post');
					form.attr('action', '/user/addOrder');
					form.appendTo('body');
					
					var member_id = $('<input type="hidden" name="member_id" value="' + order_vo.member_id + '">');
					var delivery_charge = $('<input type="hidden" name="delivery_charge" value="' + order_vo.delivery_charge + '">');
					var recipient_name = $('<input type="hidden" name="recipient_name" value="' + order_vo.recipient_name + '">');
					var recipient_zipcode = $('<input type="hidden" name="recipient_zipcode" value="' + order_vo.recipient_zipcode + '">');
					var recipient_address1 = $('<input type="hidden" name="recipient_address1" value="' + order_vo.recipient_address1 + '">');
					var recipient_address2 = $('<input type="hidden" name="recipient_address2" value="' + order_vo.recipient_address2 + '">');
					var recipient_tel = $('<input type="hidden" name="recipient_tel" value="' + order_vo.recipient_tel + '">');
					var recipient_phone = $('<input type="hidden" name="recipient_phone" value="' + order_vo.recipient_phone + '">');
					var recipient_email = $('<input type="hidden" name="recipient_email" value="' + order_vo.recipient_email + '">');
					var message = $('<input type="hidden" name="message" value="' + order_vo.message + '">');
					var pay_method = $('<input type="hidden" name="pay_method" value="' + order_vo.pay_method + '">');
					var used_point = $('<input type="hidden" name="used_point" value="' + order_vo.used_point + '">');
					
					form.append(member_id);
					form.append(delivery_charge);
					form.append(recipient_name);
					form.append(recipient_zipcode);
					form.append(recipient_address1);
					form.append(recipient_address2);
					form.append(recipient_tel);
					form.append(recipient_phone);
					form.append(recipient_email);
					form.append(message);
					form.append(pay_method);
					form.append(used_point);
					
					form.submit();
				}
				
				// 페이지 로드 시 결제 수단 설명 출력 
				$("input[name=pay_method]").each(function() {
					if($(this).is(":checked")) {						
						changePaymentMethod($(this).val());
					}
				}); 
				
				// 결제 수단 선택 시
				$("input[name=pay_method]").on("change", function() {
					changePaymentMethod($(this).val());
					
					// 결제 수단을 선택한 값으로 변경
					pay_method = $(this).val();
				}); // end pay_method onchange
				
				
				// 회원이 보유중인 적립금
				var member_point = ${member.point};
				// 회원 등급 할인 (모든 상품의 할인을 더한 값)				
				var total_discount = 0;
				// 회원 등급 적립 ( 모든 상품의 적립금을 더한 값)
				var total_saving = 0;
				// 할인 합계
				var sum_discount = 0;
				// 배송비
				var delivery_charge = 0;
				// 오리지널 주문 금액
				var origin_prod_price = 0;
				// 최종 주문 금액
				var total_prod_price = 0;
				
				// 주문 등록에 필요한 정보 (List<Map<String, Integer>> details_list)
				var details_list = [];
				
				
				// 모든 상품의 할인금액을 더해줌
				<c:forEach var="addedOrderInfo" items="${addedOrderInfoList }">
					// 해당 상품의 할인금액
					var discount = ${(addedOrderInfo.price / 100) * member.level.discount * addedOrderInfo.quantity};
					// 모든 상품의 총 할인금액
					total_discount += discount;
					
					// 해당 상품의 적립금
					var saving = ${(addedOrderInfo.price / 100) * member.level.saving * addedOrderInfo.quantity};
					// 모든 상품의 총 적립금
					total_saving += saving;
					
					origin_prod_price += ${addedOrderInfo.price * addedOrderInfo.quantity};
					
					var product_code = ${addedOrderInfo.code};
					var product_detail_no = ${addedOrderInfo.product_detail_no};
					var quantity = ${addedOrderInfo.quantity};
					var price = ${addedOrderInfo.price};
					var amount_d = price - discount;
					
					// 주문 등록에 필요한 주문 상품의 정보
					var details = {
							product_code : product_code,
							product_detail_no : product_detail_no,
							quantity : quantity,
							amount : amount_d,
							discount : discount,
							point : saving
					};
					
					details_list.push(details);
						
					// 결제 정보 저장
					name = '${addedOrderInfo.name}';
				</c:forEach>
				
				total_prod_price = origin_prod_price - total_discount;
				
				$(".total-prod-price").html("<strong>" + total_prod_price.format() + "원</strong>");
				
				// 배송비
				if(origin_prod_price >= 50000 || origin_prod_price == 0) {
					$(".delivery_charge").text("무료");
					$(".total-order-price").text(total_prod_price.format());
					$(".total-order-price").text((total_prod_price).format() + "원");
				} else if(origin_prod_price < 50000 && origin_prod_price != 0) {
					$(".delivery_charge").text("3,000원");
					delivery_charge = 3000;
					$(".total-order-price").text((total_prod_price + delivery_charge).format() + "원");
				}
				
				// 최종 결제 금액 (total_discount와 delivery_charge보다 뒤에 선언)
				var final_order_price = origin_prod_price + delivery_charge - total_discount;
				
				// 결제 페이지로 넘겨줄 금액 초기화
				amount = final_order_price;
				
				// 회원 등급 할인, 합계 할인 초기화
				$(".total_discount, .sum_discount").text('-' + total_discount.format());
				// 총 적립금 초기화
				$(".total_saving").text(total_saving.format());
				// 최종 결제 금액 초기화
				$(".final_order_price").text(final_order_price.format());
				
				// 회원 레벨
				$(".member_lev_grade").text("${member.level.level}");
				$(".member_lev").text("${member.level}");
				
				// 보유중인 포인트
				$(".member_point").text("${member.point}".format());
				
				// 보유 적립금 변경시
				$(".input_point").on("input change paste keyup", function() {
					var point = Number($(this).val());
					
					// 보유중인 적립금을 초과하여 입력 시 0으로
					if(point > member_point) {
						alert("보유하신 적립금을 초과하였습니다.");
						$(this).val(0);
						point = 0;
					}

					// 최종 결제 금액을 초과하여 입력 시 맥시멈 값으로
					if(point > final_order_price) {
						$(this).val(final_order_price);
						point = final_order_price;
					}
					
					// 합계 할인
					sum_discount = total_discount + point;
					var input_final_order_price = origin_prod_price + delivery_charge - sum_discount;
					
					if(point == 0) $(".use_point").text('0');
					else $(".use_point").text('-' + point.format());
					
					$(".sum_discount").text('-' + sum_discount.format());
					$(".final_order_price").text(input_final_order_price.format());
					
					// 최종 결제 금액 (상용시 해제)
					amount = input_final_order_price;
				});
				
				// 최대 사용 체크
				$(".maximum_point").on("change", function() {
					if($(this).is(":checked")) {
						$(".input_point").val("${member.point}");
						$(".input_point").trigger("input");
					} else {
						$(".input_point").val(0);
						$(".input_point").trigger("input");
					}
				});
				
				// 최상위 체크박스 클릭 시 모든 CheckBox Checked
				$(".check-all").click(function() {
					$(".check-order").prop("checked", this.checked);
				});

				// 삭제 버튼 클릭 시 체크 된 상품 삭제
				$(".btn-checked-delete").on(
						"click",
						function() {
							if ($(".check-order:checked").length == 0) {
								alert("선택하신 상품이 없습니다.");
								return;
							}
							// 체크 되지 않은 목록의 값을 저장하여 /user/order 재호출
							var reload_no = [];
							var reload_quantity = [];
							$(".check-order").each(
									function() {
										if (!this.checked) {
											reload_no.push(this.value);
											reload_quantity.push($("#quantity" + this.value).text());
										}
									});

							location.href = "/user/order?product_detail_no_list=" + reload_no + "&quantity_list=" + reload_quantity;
						});

				// 페이지 로딩 시 배송지 정보 회원정보와 동일로 초기화
				changeDvryInfo("member");

				$("input[name=select-addr]").on("change", function() {
					var checkedValue = $("input[name=select-addr]:checked").val();
					// 회원 정보와 동일 체크
					if (checkedValue == 'member') {
						changeDvryInfo(checkedValue);
					} else { // 새로운 배송지 체크
						changeDvryInfo(checkedValue);
					}
				}); // radio onchange

			}); // end document
	
	function changeDvryInfo(checkedValue) {
		switch (checkedValue) {
		case "member":
			$("input[name=name]").val('${member.name}');
			$("input[name=zipcode]").val('${member.zipcode}');
			$("input[name=address1]").val('${member.address1}');
			$("input[name=address2]").val('${member.address2}');

			var tel = "${member.tel}".split('-');
			$("select[name=tel1]").val(tel[0]);
			$("input[name=tel2]").val(tel[1]);
			$("input[name=tel3]").val(tel[2]);

			var phone = "${member.phone}".split('-');
			$("select[name=phone1]").val(phone[0]);
			$("input[name=phone2]").val(phone[1]);
			$("input[name=phone3]").val(phone[2]);

			var email = "${member.email}".split('@');
			$("input[name=email1]").val(email[0]);
			$("input[name=email2]").val(email[1]);

			break;
		case "new":
			$("input[name=name]").val('');
			$("input[name=zipcode]").val('');
			$("input[name=address1]").val('');
			$("input[name=address2]").val('');

			$("select[name=tel1] option:eq(0)").prop("selected", true);
			$("input[name=tel2]").val('');
			$("input[name=tel3]").val('');

			$("select[name=phone1] option:eq(0)").prop("selected", true);
			$("input[name=phone2]").val('');
			$("input[name=phone3]").val('');

			$("input[name=email1]").val('');
			$("input[name=email2]").val('');

			break;
		}
	}
	</script>

	<div class="container" style="margin-left: 22%;">

		<!-- Order Form Start -->
		<div class="row">
			<div class="col-md-10 col-md-offset-1 orderLabel-row">
				<p>ORDER</p>
			</div>

			<%@ include file="benefitExplain.jsp"%>

		</div>

		<div class="row">
			<div class="col-md-10 col-md-offset-1" style="margin-bottom: 50px;">
				<!-- prod-order-list table -->
				<table class="table table-striped prod-order-list-table">
					<colgroup>
						<col style="width: 20px;">
						<col style="width: 100px;">
						<col style="width: 180px;">
						<col style="width: 70px;">
						<col style="width: 70px;">
						<col style="width: 40px;">
						<col style="width: 70px;">
						<col style="width: 60px;">
						<col style="width: 70px;">
					</colgroup>
					<thead>
						<tr>
							<th colspan="9">상품 주문 내역</th>
						</tr>
						<tr>
							<td><input type="checkbox" class="check-all"></td>
							<td>이미지</td>
							<td>상품 정보</td>
							<td>판매가</td>
							<td>회원 할인</td>
							<td>수량</td>
							<td>적립금</td>
							<td>배송비</td>
							<td>주문금액</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="addedOrderInfo" items="${addedOrderInfoList }">
							<c:set var="no" value="${addedOrderInfo.product_detail_no }" />
							<c:set var="code" value="${addedOrderInfo.code }" />
							<c:set var="file_path" value="${addedOrderInfo.file_path }" />
							<c:set var="name" value="${addedOrderInfo.name }" />
							<c:set var="product_color" value="${addedOrderInfo.product_color }" />
							<c:set var="product_size" value="${addedOrderInfo.product_size }" />
							<c:set var="price" value="${addedOrderInfo.price }" />
							<c:set var="quantity" value="${addedOrderInfo.quantity }" />
							<c:set var="discount" value="${member.level.discount }" />
							<c:set var="saving" value="${member.level.saving }" />
							<c:set var="product_discount" value="${(price / 100) * discount * quantity }" />
							<c:set var="product_saving" value="${(price / 100) * saving * quantity }" />
							<c:set var="order_price" value="${(price * quantity) - product_discount }" />
							<tr> 
								<!-- 상품 체크 박스 -->
								<td><input type="checkbox" class="check-order"
									value='<c:out value="${no }" />'></td>
								<!-- 상품 이미지 -->
								<td><a href="/product/productInfo?code=${code }"> <img
										class="order-img" src='<c:out value="${file_path }" />'></a>
								</td>
								<!-- 상품 정보 -->
								<td class="prod-info">
									<span class="prod-name"> <a href="/product/productInfo?code=${code }"> <c:out value="${name }" /></a>
									</span><br> <br> <span class="prod-option">
										[옵션:&nbsp;
		                            	<!-- color가 있을 때 -->
		                            	<c:if test="${product_color ne null }"> 
		                            		<!-- size가 있을 때 -->
		                            		<c:if test="${product_size ne null }"> 
		                            			<c:out value="${product_color }" /> /
		                            			<c:out value="${product_size }" />
		                            		</c:if>
		                            		<!-- size가 없을 때 -->
		                            		<c:if test="${product_size eq null }">
		                            			<!-- size가 없는 상품은 color만 표시 -->
		                            			<c:out value="${product_color }" />
		                            		</c:if>
		                            	</c:if>	
		                            	<!-- color가 없을 때 -->
		                            	<c:if test="${product_color eq null }">
		                            		<c:out value="${product_size }" />
		                            	</c:if>
		                            	]
									</span>
								</td>
								<!-- 판매가 -->
								<td><span class="prod-price"><fmt:formatNumber
											value="${price }" pattern="#,###" />원</span></td>
								<!-- 회원 할인 중 -->
								<td><span class="prod_discount">-<fmt:formatNumber value="${product_discount }" pattern="#,###" /></span></td>
								<!-- 상품 수량 -->
								<td><span id="quantity${no }"><c:out value="${quantity }" /></span></td>
								<!-- 적립금 -->
								<td><fmt:formatNumber value="${product_saving }"
										pattern="#,###" /></td>
								<!-- 배송비 -->
								<td><span class="delivery_charge"></span></td>
								<!-- 주문금액 -->
								<td><span class="final-prod-price"><fmt:formatNumber value="${order_price }" pattern="#,###" />원</span></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" style="text-align: left;">[기본배송]</td>
							<td colspan="5" style="text-align: right;">
								<b>상품구매금액</b>
								<span class="total-prod-price" style="font-weight: bold;"></span>
								 + 배송비
								<span class="delivery_charge"></span>
								 = 주문금액 : 
								<span class="total-order-price">
								</span>
							</td>
						</tr>
					</tfoot>
				</table>
				<!-- prod-order-list table -->

				<button type="button" class="btn btn-default btn-sm btn-checked-delete">선택상품삭제</button>
			</div>
		</div>

		<div class="row">
			<div class="col-md-10 col-md-offset-1"
				style="padding: 0; font-size: 12px;">
				<hr style="border: 0.3px solid #717171;">
				<div class="col-md-6" style="padding: 0;">
					<span style="font-weight: bold;">배송정보</span>
				</div>
				<div class="col-md-6" style="text-align: right; padding: 0;">
					<span><img src="/images/ico_required.gif"> 필수입력사항</span>
				</div>
			</div>
		</div>

		<div class="row" style="margin-bottom: 50px;">
			<div class="col-md-10 col-md-offset-1" style="padding: 0;">
				<!-- member info table -->
				<table class="table table-bordered order-info-table">
					<tr>
						<th>배송지 선택</th>
						<td>
							<input type="radio" id="member-address" name="select-addr" value="member" checked="checked" />
							<label for="member-address">회원 정보와 동일</label>
							&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" id="new-address" name="select-addr" value="new" />
							<label for="new-address">새로운 배송지</label>
						</td>
					</tr>
					<tr>
						<th>수령인 / 배송지명 <img src="/images/ico_required.gif"></th>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<th>주소<img src="/images/ico_required.gif"></th>
						<td>
							<input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly="readonly">
							<input type="button" onclick="openZipSearch()" value="우편번호 찾기"><br>
							<input type="text" id="address1" name="address1" placeholder="주소" readonly="readonly"><br>
							<input type="text" id="address2" name="address2" placeholder="상세주소">
							<input type="text" id="extraAddress" placeholder="참고항목">
						</td>
					</tr>
					<tr>
						<th>일반전화</th>
						<td><select name="tel1" style="width: 70px; height: 23px;">
								<option value="02">02</option>
								<option value="031">031</option>
								<option value="032">032</option>
								<option value="033">033</option>
								<option value="041">041</option>
								<option value="042">042</option>
								<option value="043">043</option>
								<option value="044">044</option>
						</select> - <input type="text" name="tel2" maxlength="4" style="width: 100px;" /> - 
						<input type="text" name="tel3" maxlength="4" style="width: 100px;" /></td>
					</tr>
					<tr>
						<th>휴대전화 <img src="/images/ico_required.gif"></th>
						<td><select name="phone1" style="width: 70px; height: 23px;">
								<option>010</option>
								<option>011</option>
								<option>016</option>
								<option>017</option>
								<option>018</option>
								<option>019</option>
						</select> - <input type="text" name="phone2" maxlength="4" style="width: 100px;" /> - <input
							type="text" name="phone3" maxlength="4" style="width: 100px;" /></td>
					</tr>
					<tr>
						<th>이메일 <img src="/images/ico_required.gif"></th>
						<td><input type="text" name="email1" /> @ 
						<input type="text" id="email" name="email2" /> 
						<select id="select_email" style="height: 23px;" onchange="changeEmail()">
								<option value="">-- 이메일 선택 --</option>
								<option>naver.com</option>
								<option>daum.net</option>
								<option>nate.com</option>
								<option>gmail.com</option>
								<option>hotmail.com</option>
								<option>yahoo.com</option>
						</select></td>
					</tr>
					<tr>
						<th>배송메세지</th>
						<td><textarea name="delivery_message"	
								style="width: 700px; height: 70px;"></textarea></td>
					</tr>
				</table>
				<!-- member info table -->
			</div>
		</div>

		<div class="row" style="margin-bottom: 100px;">
			
	        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
	            <p id="final-order-title">최종 결제 금액</p>
	        </div>
	        <div class="col-md-10 col-md-offset-1" style="padding: 0; margin-bottom: 50px;">
	            <!-- left -->
	            <div class="col-md-9 cell_info">
	                <ul>
	                    <li>회원 등급 할인</li>
	                    <li>
	                        <strong><span class="total_discount"></span>원</strong>
	                        <span class="add-explan">(LV.
	                        <span class="member_lev_grade"></span>&nbsp;
	                        <span class="member_lev"></span> 등급)</span>
	                    </li>
	                </ul>
	                <ul>
	                    <li>보유 적립금 사용</li>
	                    <li>
	                        <input type="text" class="input_point" name="point" value="0">원&nbsp;
	                        <input type="checkbox" class="maximum_point" id="maximum_point">
	                        <label for="maximum_point"><strong>최대 사용</strong></label>
	                        (사용 가능 적립금 <span class="member_point"></span>원)
	                    </li>
	                </ul>
	                <ul>
	                    <li>할인 합계</li>
	                    <li><span class="add-explan">모든 할인 내역을 합산한 금액입니다.</span></li>
	                </ul>
	                <ul>
	                    <li>배송비</li>
	                    <li><span class="delivery_charge"></span> 
	                    <span class="add-explan">(50,000원 이상 구매시 무료)</span></li>
	                </ul>
	            </div>
	            <!-- right -->
	            <div class="col-md-3 cell_info_right">
	                <ul>
	                    <li>회원 등급 할인</li>
	                    <li><span class="total_discount">0</span>원</li>
	                </ul>
	                <ul>
	                    <li>보유 적립금 사용</li>
	                    <li><span class="use_point">0</span>원</li>
	                </ul>
	                <ul>
	                    <li>할인 합계</li>
	                    <li><span class="sum_discount">0</span>원</li>
	                </ul>
	                <ul>
	                    <li>배송비</li>
	                    <li><span class="delivery_charge"></span></li>
	                </ul>
	                <ul>
	                    <li>총 적립금</li>
	                    <li><span class="total_saving"></span>원</li>
	                </ul>
	                <ul>
	                    <li>최종 결제 금액</li>
	                    <li><span class="final_order_price"></span>원</li>
	                </ul>
	            </div>
	
	        </div>

	        <div class="col-md-10 col-md-offset-1" style="padding: 0;" style="margin-bottom: 30px;">
	            <p style="font-size: 12px; font-weight: bold;">결제 정보 / 주문자 동의</p>
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 payment_info" style="text-align: center;">
	            <ul>
	                <li>결제 수단</li> <!-- 햐 -->
	                <li><input type="radio" id="card" name="pay_method" value="card" checked="checked"><label for="card">신용카드</label></li>
	                <li><input type="radio" id="trans" name="pay_method" value="trans"><label for="trans">계좌이체</label></li>
	                <li><input type="radio" id="vbank" name="pay_method" value="vbank"><label for="vbank">가상계좌(무통장입금)</label></li>
	                <li><input type="radio" id="phone" name="pay_method" value="phone"><label for="phone">휴대폰결제</label></li>
	                <li><input type="radio" id="payco" name="pay_method" value="payco"><label for="payco">페이코</label></li>
	            </ul>
	            <ul>
	                <li>결제 안내</li>
	                <li class="li_payment_guide"><span class="payment_guide"></span></li>
	            </ul>
	            <ul>
	                <li>주문자 동의</li>
	                <li>
	                    <input type="checkbox" id="pay_agreement">
	                    <strong><label for="pay_agreement">위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에 동의합니다.(필수)</label></strong>
	                </li>
	            </ul>
	            <button type="button" class="btn btn-default btn_payment">결제하기</button>
	        </div>
		</div>
		<!-- Order Form End -->

		<%@ include file="../includes/footer.jsp"%>

	</div>

</body>
</html>