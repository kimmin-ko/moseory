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

<!-- CartForm Start -->
<div class="container" style="margin-left:22%;">

    <div class="row cartLabel-row">
        <div class="col-md-10 col-md-offset-1" style="margin-bottom: 40px;">
            <p>CART</p>
        </div>
        
		<%@ include file="benefitExplain.jsp" %>
		
    </div>
    
    <ul class="nav nav-tabs col-md-10 col-md-offset-1">
        <li role="presentation" class="active"><a href="#"><small><strong>국내 배송 상품(1)</strong></small></a></li>
        <li role="presentation"><a href="#"><small><strong>해외 배송 상품(0)</strong></small></a></li>
    </ul>

    <div class="row cart-list" style="margin-bottom: 100px;">
        <div class="col-md-10 col-md-offset-1"><strong>일반 상품(1)</strong></div>
        <div class="col-md-10 col-md-offset-1">
            <table class="table cart-table">
                <colgroup>
                    <col  style="width: auto;">
                    <col  style="width: auto;">
                    <col  style="width: 220px;">
                    <col  style="width: 100px;">
                    <col  style="width: 140px;">
                    <col  style="width: 100px;">
                    <col  style="width: 100px;">
                    <col  style="width: 100px;">
                    <col  style="width: 100px;">
                    <col  style="width: 100px;">
                </colgroup>
                <thead>
                    <tr class="active">
                        <th><input type="checkbox" name="all" class="check-all" /></th>
                        <th>이미지</th>
                        <th>상품정보</th>
                        <th>판매가</th>
                        <th>수량</th>
                        <th>적립금</th>
                        <th>배송구분</th>
                        <th>배송비</th>
                        <th>합계</th>
                        <th>선택</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <!-- 상품 체크 박스 -->
                        <td><input type="checkbox" name="cart-list-1" class="checkCart" /></td>
                        <!-- 상품 이미지 -->
                        <td><img src="/images/1.jpg" class="cart-img"></td>
                        <!-- 상품 정보 -->
                        <td class="prod-info">
                            <span class="prod-name">포니 헨리넥 셔츠</span><br><br>
                            <span class="prod-option">[옵션: 네이비]</span>
                        </td>
                        <!-- 상품 가격 -->
                        <td>
                            <span class="prod-price">37,000원</span>
                        </td>
                        <!-- 상품 수량 -->
                        <td>
                            <input type="number" min="1" max="99" step="1" value="1">
                            <button type="button" onclick="changeQuantity()">변경</button>
                        </td>
                        <!-- 적립금 -->
                        <td>-</td>
                        <!-- 배송구분 -->
                        <td>기본배송</td>
                        <!-- 배송비 -->
                        <td>3,000원</td>
                        <!-- 합계 -->
                        <td><span class="final-prod-price">37,000원</span></td>
                        <!-- 선택 -->
                        <td>
                            <button type="button" class="btn btn-default btn-sm" onclick="location.href='/user/order'">주문하기</button>
                            <button type="button" class="btn btn-default btn-sm">관심상품</button>
                            <button type="button" class="btn btn-default btn-sm">삭제하기</button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="cart-list-1" class="checkCart" /></td>
                        <td><img src="/images/8.jpg" class="cart-img"></td>
                        <td class="prod-info">
                            <span class="prod-name">레이널 레더 플립플랍</span><br><br>
                            <span class="prod-option">[옵션: 블랙/250]</span>
                        </td>
                        <td>
                            <span class="prod-price">76,000원</span>
                        </td>
                        <td>
                            <input type="number" min="1" max="99" step="1" value="2">
                            <button type="button" onclick="changeQuantity()">변경</button>
                        </td>
                        <td>-</td>
                        <td>기본배송</td>
                        <td>3,000원</td>
                        <td><span class="final-prod-price">152,000원</span></td>
                        <td>
                            <button type="button" class="btn btn-default btn-sm" onclick="location.href='/user/order'">주문하기</button>
                            <button type="button" class="btn btn-default btn-sm">관심상품</button>
                            <button type="button" class="btn btn-default btn-sm">삭제하기</button>
                        </td>
                    </tr>
    
                </tbody>
                <tfoot>
                    <tr class="active">
                        <td colspan="5" style="text-align: left;">
                            [기본배송]
                        </td>
                        <td colspan="5" style="text-align: right;">
                            <b>상품구매금액</b>
                            <span class="total-prod-price" style="font-weight: bold;">189,000</span>
                             + 배송비 
                             <span class="delivery-charge">3,000</span>
                              = 합계 : 
                            <span class="total-order-price">192,000원</span>
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
                <button type="button" class="btn btn-default btn-sm btn-delete-cart">장바구니비우기</button>
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
                    <td>189,000원</td>
                    <td>+3,000원</td>
                    <td style="color: #CE1F14;">=192,000원</td>
                </tr>
            </table>
        </div>

        <div class="col-md-10 col-md-offset-1" style="text-align : center; margin-bottom: 80px;">
            <button type="button" class="btn btn-default btn-sm" 
            	style="background-color: black; color: white;" onclick="location.href='/user/order'">전체상품주문</button>
            <button type="button" class="btn btn-default btn-sm" onclick="location.href='/user/order'">선택상품주문</button>
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

<script type="text/javascript">
$(document).ready(function() {
    
	// 최상위 체크박스 선택 시 전체 선택
    $(".check-all").click(function() {
        $(".checkCart").prop("checked", this.checked);
    });

});
</script>

</body>
</html>