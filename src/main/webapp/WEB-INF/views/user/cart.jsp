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
    <link rel="stylesheet" href="/css/cart.css">
</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

<script>
$(document).ready(function() {
	var noArr = [];
	var quantityArr = [];
	
	// 회원 등급 할인 (모든 상품의 할인을 더한 값)				
	var total_discount = 0;
	// 배송비
	var delivery_charge = 0;
	// 오리지널 주문 금액
	var origin_prod_price = 0;
	// 최종 주문 금액
	var total_prod_price = 0;
	
	<c:forEach items="${cartList}" var="cart">
		// cartLsit에 담겨있는 각각의 cart의 no와 quantity를 가져와서 배열에 저장한다
		noArr.push("${cart.product_detail_no}");
		quantityArr.push("${cart.quantity}");
		
		var discount = ${(cart.product_price / 100) * member.level.discount * cart.quantity};
		total_discount += discount;
		
		origin_prod_price += ${cart.product_price * cart.quantity };
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
	
	// 주문 버튼을 누르게 되면 저장되어있는 배열을 이용해 order를 호출한다
	// 상품 주문
	$(".all-prod-order").on("click", function() {
		if(noArr.length == 0) {
			alert("주문할 상품이 없습니다.");
			return;
		}
			
		location.href="/user/order?product_detail_no_list=" + noArr + "&quantity_list=" + quantityArr;
	});
	
}); 
</script>
<script type="text/javascript" src="/js/user/cart.js"></script>

<!-- CartForm Start -->
<div class="container" style="margin-left:22%;">

    <div class="row cartLabel-row">
        <div class="col-md-10 col-md-offset-1" style="margin-bottom: 40px;">
            <p>CART</p>
        </div>
        
		<%@ include file="benefitExplain.jsp" %>
		
    </div>
    
    <form id="cartForm">
    	<input type="hidden" name="no" />
    	<input type="hidden" name="quantity" />
    	<input type="hidden" name="noList" />
    	<input type="hidden" name="member_id" />
    </form>
  
    <ul class="nav nav-tabs col-md-10 col-md-offset-1">
        <li role="presentation" class="active"><a href="#"><small><strong>국내 배송 상품(<c:out value="${cartCount }" />)</strong></small></a></li>
    </ul>

    <div class="row cart-list" style="margin-bottom: 100px;">
        <div class="col-md-10 col-md-offset-1"><strong>일반 상품(<c:out value="${cartCount }" />)</strong></div>
        <div class="col-md-10 col-md-offset-1">
            <table class="table cart-table">
                <colgroup>
                    <col  style="width: auto;"> <!-- 체크박스 -->
                    <col  style="width: 80px;"> <!-- 이미지 -->
                    <col  style="width: 220px;"> <!-- 상품정보 -->
                    <col  style="width: 100px;"> <!-- 판매가 -->
                    <col  style="width: 140px;"> <!-- 회원 할인 -->
                    <col  style="width: 160px;"> <!-- 수량 -->
                    <col  style="width: 100px;"> <!-- 배송비 -->
                    <col  style="width: 100px;"> <!-- 주문금액 -->
                    <col  style="width: 100px;"> <!-- 주문관리 -->
                </colgroup>
                <thead>
                    <tr class="active">
                        <th><input type="checkbox" name="all" class="check-all" /></th>
                        <th>이미지</th>
                        <th>상품정보</th>
                        <th>판매가</th>
                        <th>회원 할인</th>
                        <th>수량</th>
                        <th>배송비</th>
                        <th>주문금액<br>(적립금)</th>	
                        <th>주문관리</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="cart" items="${cartList }">
                		<c:set var="price" value="${cart.product_price }" />
                   		<c:set var="discount" value="${member.level.discount }" />
                   		<c:set var="saving" value="${member.level.saving }" />
                   		<c:set var="quantity" value="${cart.quantity }" />
                    <tr>
                        <!-- 상품 체크 박스 -->
                        <td><input type="checkbox" name="check_cart" class="checkCart" value='<c:out value="${cart.no }" />' /></td>
                        <!-- 상품 이미지 -->
                        <td>
                        	<a href='/product/productInfo?code=<c:out value="${cart.product_code }" />'>
                        		<img src='<c:out value="${cart.product_file_path }" />' class="cart-img">
                        	</a>
                        </td>
                        <!-- 상품 정보 -->
                        <td class="prod-info">
                            <span class="prod-name">
                            	<a href='/product/productInfo?code=<c:out value="${cart.product_code }" />'>
                            		<c:out value="${cart.product_name }" />
                            	</a>
                            </span><br><br>
                            <span class="prod-option">
                            	[옵션:&nbsp;
                            	<!-- color가 있을 때 -->
                            	<c:if test="${cart.product_color ne null }"> 
                            		<!-- size가 있을 때 -->
                            		<c:if test="${cart.product_size ne null }"> 
                            			<c:out value="${cart.product_color }" /> /
                            			<c:out value="${cart.product_size }" />
                            		</c:if>
                            		<!-- size가 없을 때 -->
                            		<c:if test="${cart.product_size eq null }">
                            			<!-- size가 없는 상품은 color만 표시 -->
                            			<c:out value="${cart.product_color }" />
                            		</c:if>
                            	</c:if>	
                            	<!-- color가 없을 때 -->
                            	<c:if test="${cart.product_color eq null }">
                            		<c:out value="${cart.product_size }" />
                            	</c:if>
                            	]
                            </span>
                        </td>
                        <!-- 판매가 -->
                        <td>
                            <span class="prod-price">
                            	<fmt:formatNumber value="${cart.product_price }" pattern="#,###" />원
                            </span>
                        </td>
                        <!-- 회원 할인 -->
                        <td>
                        	<span class="prod-discount">
                        		- <fmt:formatNumber value="${(price / 100) * discount * quantity }" pattern="#,###" />원
                        	</span>
                        </td>
                        <!-- 상품 수량 -->
                        <td>
                            <input type="text" name="qty" class="qtyVal" value='<c:out value="${quantity }" />'>
                            <!-- + 와 - 태그를 붙이기 위해 개행하지 않음 -->
                            <p class="btn-inc"><a href="javascript:void(0)">&nbsp;+&nbsp;&nbsp;</a></p><p class="btn-dec"><a href="javascript:void(0)">&nbsp;-&nbsp;&nbsp;</a></p>
                            <!-- 수량을 제한하기 위해 해당 상품의 재고를 가져와서 저장한다 -->
                            <input type="hidden" name="stock" value='<c:out value="${cart.product_stock }" />'>
                            <!-- this를 인자로 보내서 형제 노드인 input 태그를 찾아 수량을 가져온다. -->
                            <button type="button" class="modifyQtyBtn" onclick="changeQuantity(${cart.no}, this)">수정</button>
                        </td>
                        <!-- 배송비 -->
                        <td>
                        	<span class="delivery_charge"></span>
                        </td>
                        <!-- 주문금액 -->
                        <td>
                        	<c:set var="final_prod_price" value="${(price * cart.quantity) - ((price / 100) * discount) * quantity }" />
                        	<span class="final-prod-price">
                        		<!-- (상품 가격 * 수량) - (할인가 * 수량) -->
 		                    	<fmt:formatNumber value="${final_prod_price }" pattern="#,###" />원	<br>
 		                    	<!-- 적립금 -->
 		                    	(<fmt:formatNumber value="${(price / 100) * saving * quantity}" pattern="#,###" />)
                        	</span>
                        </td>
                        <!-- 주문관리 -->
                        <td>
                            <button type="button" class="btn btn-default btn-sm" onclick="deleteCartList(${cart.no})">삭제하기</button>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="active">
                        <td colspan="5" style="text-align: left;">
                            [기본배송]
                        </td>
                        <td colspan="5" style="text-align: right;">
                            <b>상품구매금액</b><span class="total-prod-price"></span>
                             + 배송비 <span class="delivery_charge"></span>
                             = 합계 : <span class="total-order-price"></span>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        
        <div class="col-md-10 col-md-offset-1" style="margin-bottom: 30px;">
            할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.
        </div>

        <div class="col-md-10 col-md-offset-1" style="margin-bottom: 50px;">
            <div class="col-md-6">
                <button type="button" class="btn btn-default btn-sm btn-delete">선택상품삭제</button>
            </div>
            <div class="col-md-6" style="text-align: right;">
                <button type="button" class="btn btn-default btn-sm btn-delete-cart" onclick="deleteCartAll('${member.id}')">장바구니비우기</button>
            </div>
        </div>

        <div class="col-md-10 col-md-offset-1">
            <table class="table table-bordered order-info-table">
                <tr class="active">
                    <th>총 상품금액</th>
                    <th>총 배송비</th>
                    <th>결제 예정 금액</th>
                </tr>
                <tr>
                    <td class="total-prod-price"></td>
                    <td class="delivery_charge"></td>
                    <td class="total-order-price" style="color: #CE1F14;"></td>
                </tr>
            </table>
        </div>

        <div class="col-md-10 col-md-offset-1" style="text-align : center; margin-bottom: 80px;">
            <button type="button" class="btn btn-default btn-sm all-prod-order">상품주문</button>
            <button type="button" class="btn btn-default btn-sm" onclick="location.href='/index'">쇼핑계속</button>
        </div>

        <div class="col-md-10 col-md-offset-1">
            <table class="table table-bordered">
                <tr>
                    <th>이용안내</th>
                </tr>
                <tr>
                    <td>
                        <p>장바구니 이용안내</p>
                        <ul class="cart-use-guide">
                            <li>해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.</li>
                            <li>해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
                            <li>선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
                            <li>[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
                            <li>장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
                        </ul>
                        <p>무이자할부 이용안내</p>
                        <ul class="cart-use-guide">
                            <li>상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
                            <li>[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
                            <li>단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
                        </ul>
                    </td>
                </tr>
            </table>
        </div>
        
    </div>
    <!-- CartForm End -->
    
	<%@ include file="../includes/footer.jsp" %>
	
</div>

</body>
</html>