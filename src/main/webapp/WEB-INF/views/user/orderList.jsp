<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
 response.setHeader("Cache-Control","no-cache"); 
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/orderList.css">
<!-- Bootstrap Datepicker CSS -->
<link rel="stylesheet" href="/css/bootstrap-datepicker3.standalone.min.css">
</head>
<body>

	<%@ include file="../includes/sidebar.jsp"%>

	<!-- Bootstrap Datepicker JS -->
	<script src="/js/bootstrap-datepicker.min.js"></script>
	<!-- KO Datepicker JS -->
	<script src="/js/bootstrap-datepicker.ko.min.js"></script>
	
	<script src="/js/user/orderList.js"></script>
	
	<div class="container" style="margin-left: 22%;">
	
	    <!-- Order List Start -->
        <div class="row">
	        <div class="col-md-10 col-md-offset-1 order_list_lb">
	            <p>ORDER LIST</p>
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 order_list_cri">
	            <div class="btn-group btn-group-sm">
	                <button type="button" class="btn btn-default" onclick="setPeriod('today')">오늘</button>
	                <button type="button" class="btn btn-default" onclick="setPeriod('1week')">1주일</button>
	                <button type="button" class="btn btn-default" onclick="setPeriod('1month')">1개월</button>
	                <button type="button" class="btn btn-default" onclick="setPeriod('3month')">3개월</button>
	                <button type="button" class="btn btn-default" onclick="setPeriod('all')">전체 시기</button>
	            </div>
	
	            <input type="text" class="hasDatepicker form-control" id="startDate" name="startDate"
	            autocomplete="false" placeholder="-">
	            -
	            <input type="text" class="hasDatepicker form-control" id="endDate" name="endDate"
	            autocomplete="false" placeholder="-">
	
	            <select class="form-control" id="selectState" name="state">
	                <option>전체 상태</option>
	                <option>입금 확인</option>
	                <option>배송 준비 중</option>
	                <option>발송 완료</option>
	                <option>배송 완료</option>
	                <option>구매 확정</option>
	                <option>교환 요청</option>
	                <option>교환 처리 중</option>
	                <option>교환 완료</option>
	                <option>환불 요청</option>
	                <option>환불 처리 중</option>
	                <option>환불 완료</option> 
	            </select>
	
	            <button class="btn btn-default btn-sm getOrderList">조회</button>
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 m-order_list">
	            <table class="table order_list_tbl">
	                <colgroup>
	                    <col style="width: 80px;"/> <!-- 이미지 -->
	                    <col style="width: 250px;"/> <!-- 상품정보 -->
	                    <col style="width: 100px;"/> <!-- 주문일자 -->
	                    <col style="width: 170px;"/> <!-- 주문 번호 -->
	                    <col style="width: 150px;"/> <!-- 주문금액 -->
	                    <col style="width: 130px;"/> <!-- 주문상태 -->
	                </colgroup>
	                <thead>
	                    <tr>
	                        <td>이미지</td>
	                        <td>상품정보</td>
	                        <td>주문일자</td>
	                        <td>주문번호</td>
	                        <td>주문금액(수량)</td>
	                        <td colspan="2">주문 상태</td>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach var="order" items="${orderList }" varStatus="idx">
	                    <tr>
	                        <td>
	                            <img class="prod_file_path" src='<c:out value="${order.file_path }" />'>
	                        </td>
	                        <td class="prod_info">
	                            <span class="prod_name"><c:out value="${order.name }" /></span><br><br>
	                            <span class="prod_option">
	                            [옵션:
                            	<c:if test="${order.product_color ne null }"> 
                            		<c:if test="${order.product_size ne null }"> 
                            			<c:out value="${order.product_color }" /> /
                            			<c:out value="${order.product_size }" />
                            		</c:if>
                            		<c:if test="${order.product_size eq null }">
                            			<c:out value="${order.product_color }" />
                            		</c:if>
                            	</c:if>	
                            	<c:if test="${order.product_color eq null }">
                            		<c:out value="${order.product_size }" />
                            	</c:if>
	                             ]
	                            </span>
	                        </td>
	                        <td>
	                            <span class="order_date"><c:out value="${order.order_date }" /></span>
	                        </td>
	                        <td>
	                            <span class="order_code"><c:out value="${order.code }" /></span>
	                        </td>
	                        <td>
	                            <span class="order_amount"><fmt:formatNumber value="${order.amount }" />원</span><br>
	                            <span class="order_quantity"><fmt:formatNumber value="${order.quantity }" />개</span>
	                        </td>
	                        <td>
	                            <span class="order_state"><c:out value="${order.state }" /></span>
	                        </td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${order.state == '입금 확인' || order.state == '배송 준비 중' }">
	                        			<button class="btn btn-default btn-sm" onclick="orderCancel('${order.code}')">주문 취소</button>
	                        		</c:when>
	                        		<c:when test="${order.state == '배송 완료' }">
	                        			<button class="btn btn-default btn-sm" 
	                        				onclick="showExchangeModal('${order.code }', '${order.product_detail_no }')">교환 요청</button>
			                            <button class="btn btn-default btn-sm" 
			                            	onclick="changeOrderState('${order.code}', '${order.product_detail_no }', 'return')">반품 요청</button>
			                            <button class="btn btn-default btn-sm" 
			                            	onclick="orderConfirm('${order.code}', '${order.product_detail_no }', '${order.point }', '${order.amount }')">구매 확정</button>
	                        		</c:when>
	                        		<c:when test="${order.state == '구매 확정' }">
			                            <button class="btn btn-default btn-sm">리뷰 작성</button>
	                        		</c:when>
	                        		<c:otherwise>
	                        		</c:otherwise>
	                        	</c:choose>
	                        </td>
	                    </tr>
	                	</c:forEach>
	                </tbody>
	            </table>
	            
	            <!-- 교환 요청 모달 -->
	            <div class="modal fade exchange-modal-sm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false">
	            	<div class="modal-dialog modal-sm">
	            		<div class="modal-content">
	            			<div class="modal-header">
	            				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="clearSelectOption()">
	            					<span aria-hidden="true">&times;</span>
	            				</button>
	            				<p>옵션 교환</p>
	            			</div>
	            			<div class="modal-body">
	            				<div class="row">
		            				<div class="col-md-4">
		            					<img class="modal_prod_img" id="modal_prod_img">
		            				</div>
		            				<div class="col-md-8">
		            					<p class="modal_prod_name"></p>
		            					<p class="modal_prod_option"></p>
		            					<p class="modal_prod_quantity"></p>
		            				</div>
		            				
		            				<div class="col-md-12 modal_change_order">
		            					<p>교환 주문</p>
		            				</div>
		            				
		            				<div class="col-md-12 modal_color_size">
		            				</div>
		            				
		            				<div class="col-md-12">
		            					<p style="font-size: 11px; color: gray;">- 동일 상품, 옵션 교환 외 환불 후 재주문하세요.</p>
		            				</div>
	            				</div>
	            			</div>
	            			<div class="modal-footer">
	            				<div class="row">
	            					<div class="col-md-12">
	            						<button type="button" class="btn btn-detault exchangeReqBtn">교환 요청</button>
	            					</div>
	            				</div>
	            			</div>
	            		</div>
	            	</div>
	            </div>
	
	            <div class="col-md-10 col-md-offset-1 l_pagination">
	                <nav>
	                    <ul class="pagination pagination-sm">
	                        <li>
	                            <a href="#" aria-label="Previous">
	                                <span aria-hidden="true">&laquo;</span>
	                            </a>
	                        </li>
	                        <li class="active"><a href="#">1</a></li>
	                        <li><a href="#">2</a></li>
	                        <li><a href="#">3</a></li>
	                        <li><a href="#">4</a></li>
	                        <li><a href="#">5</a></li>
	                        <li>
	                            <a href="#" aria-label="Next">
	                                <span aria-hidden="true">&raquo;</span>
	                            </a>
	                        </li>
	                    </ul>
	                </nav>
	            </div>
	        </div>
	
	    </div>
		<!-- Order List End -->
	
		<%@ include file="../includes/footer.jsp"%>

	</div>
	
</body>
</html>