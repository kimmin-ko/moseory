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
	
	<script src="/js/user/orderCompletion.js"></script>

	<div class="container" style="margin-left: 22%;">
		
	    <!-- Order Completion Start -->
	    <div class="row">
	
	        <div class="col-md-10 col-md-offset-1 order_comple_lb">
	            <p>ORDER COMPLETION</p>
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 order_comple_header">
	            <p><span>주문이 정상적으로 완료</span>되었습니다.</p>
	            <p>주문번호 : <span>10005465498498</span></p>
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
	                <tbody>
	                    <tr>
	                        <td>
	                            <img src="images/001.gif" class="order_prod_img">
	                        </td>
	                        <td class="order_prod_info">
	                            <span class="order_prod_name">퓨리 카라 티셔츠</span><br><br>
	                            <span class="order_prod_option">[옵션 : 블랙/XL]</span>
	                        </td>
	                        <td>21,000원</td>
	                        <td>1,000원</td>
	                        <td>1</td>
	                        <td class="active">20,000원</td>
	                    </tr>
	                </tbody>
	                <tfoot>
	                    <tr>
	                        <td colspan="4"></td>
	                        <td colspan="2" class="active">
	                            <ul>
	                                <li class="name_li">총 상품금액</li>
	                                <li class="value_li">21,000원</li>
	                                <li class="name_li">배송비</li>
	                                <li class="value_li">(+) 3,000원</li>
	                                <li class="name_li">할인금액</li>
	                                <li class="value_li">(-) 1,000원</li>
	                                <li class="name_li">총 결제금액</li>
	                                <li class="value_li">23,000원</li>
	                            </ul>
	                        </td>
	                    </tr>
	                </tfoot>
	            </table>
	
	            <p class="body_name">> 결제 정보</p>
	            <table class="table payment_info_tbl">
	                <tr>
	                    <td class="active">결제 방법</td>
	                    <td>카드 결제</td>
	                    <td class="active">총 결제 금액</td>
	                    <td>23,000원</td>
	                </tr>
	                <tr>
	                    <td class="active">결제 상태</td>
	                    <td>입금 요청</td>
	                    <td></td>
	                    <td></td>
	                </tr>
	            </table>
	
	            <p class="body_name">> 배송지 정보</p>
	            <table class="table delivery_info_tbl">
	                <tr>
	                    <td class="active delivery_name">수령인</td>
	                    <td>김민</td>
	                    <td class="active order_mem_info">주문자 정보</td>
	                </tr>
	                <tr>
	                    <td class="active delivery_name">일반 전화</td>
	                    <td>032-684-4188</td>
	                    <td rowspan="4" class="active">
	                        <ul class="order_mem_info_ul">
	                            <li>김민</li>
	                            <li>010-3728-9670</li>
	                            <li>min22@naver.com</li>
	                        </ul>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="active delivery_name">휴대 전화</td>
	                    <td>010-5486-8755</td>
	                </tr>
	                <tr>
	                    <td class="active delivery_name">배송지 주소</td>
	                    <td>경기도 부천시</td>
	                </tr>
	                <tr>
	                    <td class="active delivery_name">배송 메세지</td>
	                    <td>부재 시 전화주세요.</td>
	                </tr>
	            </table>
	
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 order_comple_footer">
	            <button type="button" class="btn btn-default order_list_btn">주문내역확인</button>
	            <button type="button" class="btn btn-default">쇼핑계속하기</button>
	        </div>
	
	    </div>
	    <!-- Order Completion End -->
			
	
		<%@ include file="../includes/footer.jsp"%>

	</div>
	
</body>
</html>