<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function openZipSearch() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("extraAddress").value = extraAddr;

							} else {
								document.getElementById("extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('zipcode').value = data.zonecode;
							document.getElementById("address1").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("address2").focus();
						}
					}).open();
		}
	</script>

	<%@ include file="../includes/sidebar.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {

			$(".check-all").click(function() {
				$(".check-order").prop("checked", this.checked);
			});

			// 삭제 버튼 클릭 시 체크 된 상품 삭제
			$(".btn-checked-delete").on("click", function() {
				if($(".check-order:checked").length == 0) {
					alert("선택하신 상품이 없습니다.");
					return;
				}
				// 체크 되지 않은 목록의 값을 저장하여 /user/order 재호출
				var reload_no = [];
				var reload_quantity = [];
				$(".check-order").each(function() {
					if (!this.checked) {
						reload_no.push(this.value);
						reload_quantity.push($("#quantity"+this.value).text());
					}
				});
				
				location.href = "/user/order?product_detail_no_list=" + reload_no + "&quantity_list=" + reload_quantity;
			});
			
			// 페이지 로딩 시 배송지 정보 회원정보와 동일로 초기화
			changeDvryInfo("member");
			
			$("input[name=select-addr]").on("change", function() {
				var checkedValue = $("input[name=select-addr]:checked").val();
				// 회원 정보와 동일 체크
				if(checkedValue == 'member') {
					changeDvryInfo(checkedValue);
				} else { // 새로운 배송지 체크
					changeDvryInfo(checkedValue);
				}
			}); // radio onchange

		}); // end document
		
		// 배송지 정보를 바꿔줌
		function changeDvryInfo(checkedValue) {
			switch (checkedValue) {
			case "member" :
				$("input[name=name]").val('<c:out value="${member.name}" />');
				$("input[name=zipcode]").val('<c:out value="${member.zipcode}" />');
				$("input[name=address1]").val('<c:out value="${member.address1}" />');
				$("input[name=address2]").val('<c:out value="${member.address2}" />');
				
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
			case "new" :  
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

		function changeEmail() {
			var select_email = $("#select_email").val();
			$("#email").val(select_email);
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
							<c:set var="product_color"
								value="${addedOrderInfo.product_color }" />
							<c:set var="product_size" value="${addedOrderInfo.product_size }" />
							<c:set var="price" value="${addedOrderInfo.price }" />
							<c:set var="quantity" value="${addedOrderInfo.quantity }" />
							<c:set var="discount" value="${member.level.discount }" />
							<c:set var="saving" value="${member.level.saving }" />
							<c:set var="product_discount"
								value="${(price / 100) * discount * quantity }" />
							<c:set var="product_saving"
								value="${(price / 100) * saving * quantity }" />
							<c:set var="order_price"
								value="${(price * quantity) - product_discount }" />
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
										[옵션: 
										<c:if test="${product_color ne null }">
											<c:out value="${product_color }" />
										</c:if> <c:if test="${product_size ne null }">
											<c:out value="${product_size }" />
										</c:if>
										]
									</span>
								</td>
								<!-- 판매가 -->
								<td><span class="prod-price"><fmt:formatNumber
											value="${price }" pattern="#,###" />원</span></td>
								<!-- 회원 할인 -->
								<td><span>-<fmt:formatNumber
											value="${product_discount }" pattern="#,###" /></span></td>
								<!-- 상품 수량 -->
								<td><span id="quantity${no }"><c:out value="${quantity }" /></span></td>
								<!-- 적립금 -->
								<td><fmt:formatNumber value="${product_saving }"
										pattern="#,###" /></td>
								<!-- 배송비 -->
								<td><span class="delevery-charge"> <c:if
											test="${total_product_price >= 50000 || total_product_price == 0 }">
	                    		무료
	                    		</c:if> <c:if
											test="${total_product_price < 50000 && total_product_price != 0 }">
	                    		3,000원
	                    		</c:if>
								</span></td>
								<!-- 주문금액 -->
								<td><span class="final-prod-price"><fmt:formatNumber
											value="${order_price }" pattern="#,###" />원</span></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" style="text-align: left;">[기본배송]</td>
							<td colspan="5" style="text-align: right;"><b>상품구매금액</b> <span
								class="total-prod-price" style="font-weight: bold;"> <fmt:formatNumber
										value="${total_product_price }" pattern="#,###" />
							</span> + 배송비 <span class="delivery-charge"> <c:if
										test="${total_product_price >= 50000 || total_product_price == 0 }">
			                    		무료
			                    	</c:if> <c:if
										test="${total_product_price < 50000 && total_product_price != 0 }">
			                    		3,000원
			                    	</c:if>
							</span> = 주문금액 : <span class="total-order-price"> <c:if
										test="${total_product_price >= 50000 || total_product_price == 0 }">
										<fmt:formatNumber value="${total_product_price }"
											pattern="#,###" />원
		                    	</c:if> <c:if
										test="${total_product_price < 50000 && total_product_price != 0 }">
										<fmt:formatNumber value="${total_product_price + 3000}"
											pattern="#,###" />원
		                    	</c:if>
							</span></td>
						</tr>
					</tfoot>
				</table>
				<!-- prod-order-list table -->

				<button type="button"
					class="btn btn-default btn-sm btn-checked-delete">선택상품삭제</button>
			</div>
		</div>

		<div class="row">
			<div class="col-md-10 col-md-offset-1"
				style="padding: 0; font-size: 12px;">
				<hr style="border: 0.5px solid black;">
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
							<input type="radio" id="member-address" name="select-addr" value="member" checked="checked" />회원 정보와 동일
							&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" id="new-address" name="select-addr" value="new" />새로운 배송지
						</td>
					</tr>
					<tr>
						<th>받으시는분 <img src="/images/ico_required.gif"></th>
						<td><input type="text" name="name"></td>
					</tr>
					<tr>
						<th>주소<img src="/images/ico_required.gif"></th>
						<td>
							<input type="text" id="zipcode" name="zipcode" placeholder="우편번호" style="width: 100px; margin-bottom: 5px;">
							<input type="button" onclick="openZipSearch()" value="우편번호 찾기"><br>
							<input type="text" id="address1" name="address1" placeholder="주소" style="width: 196px; margin-bottom: 5px;"><br>
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
						</select> - <input type="text" name="tel2" style="width: 100px;" /> - 
						<input type="text" name="tel3" style="width: 100px;" /></td>
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
						</select> - <input type="text" name="phone2" style="width: 100px;" /> - <input
							type="text" name="phone3" style="width: 100px;" /></td>
					</tr>
					<tr>
						<th>이메일 <img src="/images/ico_required.gif"></th>
						<td><input type="text" name="email1" /> @ <input type="text"
							id="email" name="email2" /> <select id="select_email"
							style="height: 23px;" onchange="changeEmail()">
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
						<td><textarea name="delivery-message"
								style="width: 700px; height: 70px;"></textarea></td>
					</tr>
				</table>
				<!-- member info table -->
			</div>
		</div>

		<div class="row" style="margin-bottom: 100px;">
			<div class="col-md-10 col-md-offset-1" style="padding: 0;"
				style="margin-bottom: 30px;">
				<p style="font-size: 12px; font-weight: bold;">결제 예정 금액</p>
				<table class="table table-bordered payment-schedule-table">
					<thead>
						<tr>
							<th>판매 가격</th>
							<th>총 할인 + 부가 결재 금액</th>
							<th>총 결제 예정 금액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								189,000원
							</td>
							<td>
								3,000원
							</td>
							<td style="color: #CE1F14;">192,000원</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="col-md-10 col-md-offset-1" style="padding: 0;">
				<table class="table table-bordered payment-schedule-table-2">
					<tr>
						<td>총 할인 금액</td>
						<td>0원</td>
					</tr>
					<tr>
						<td>총 부가 결재 금액</td>
						<td>0원</td>
					</tr>
					<tr>
						<td>적립금</td>
						<td>
							<ul>
								<li><input type="text" />원 (총 사용가능 적립금 : 1,000원)</li>
								<li>- 적립금은 최소 0 이상일 때 결제가 가능합니다.</li>
								<li>- 최대 사용금액은 제한이 없습니다.</li>
								<li>- 1회 구매시 적립금 최대 사용금액은 1,000입니다.</li>
								<li>- 적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면
									주문이 완료됩니다.</li>
							</ul>
						</td>
					</tr>
				</table>
			</div>

			<div class="col-md-10 col-md-offset-1" style="text-align: center;">
				<button type="button" class="btn btn-default"
					style="background-color: black; color: white;">결제하기</button>
			</div>
		</div>
		<!-- Order Form End -->

		<%@ include file="../includes/footer.jsp"%>

	</div>

</body>
</html>