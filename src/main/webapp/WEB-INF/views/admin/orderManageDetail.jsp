<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/orderManageDetail.css">
<script type="text/javascript">
	var message = "${msg}";
	if(message != ""){
		alert(message);
	}
</script>

</head>
<body>

<!-- Daum 우편번호 찾기 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/address/daum_address.js"></script>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container modifyForm-container" style="margin-left:22%">

    <div class="row modifyLabel-row" style="margin-top: 80px;">
        <div class="col-md-10 col-md-offset-1 orderManageDetail">
            <p>ORDER MANAGE DETAIL</p>
        </div>
    </div>

	<div class="row" style="margin-bottom: 30px;">
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
	      
	        <h6>주문 상태 변경</h6>
	        	<c:if test="${orderInfo.STATE eq '입금 확인'  or orderInfo.STATE eq '배송 준비 중' or orderInfo.STATE eq '발송 완료' or orderInfo.STATE eq '배송 완료'}">
	        		<div class="alert alert-success" role="alert">
	        			<select class="form-control" id="selectState" name="state" >
			                <option value="배송 준비 중" <c:out value="${orderInfo.STATE eq '배송 준비 중' ? 'selected' : '' }" />>배송 준비 중</option>
			                <option value="발송 완료"   <c:out value="${orderInfo.STATE eq '발송 완료' ? 'selected' : '' }" />>발송 완료</option>
			                <option value="배송 완료"   <c:out value="${orderInfo.STATE eq '배송 완료' ? 'selected' : '' }" />>배송 완료</option>
			                <option value="구매 확정"   <c:out value="${orderInfo.STATE eq '구매 확정' ? 'selected' : '' }" />>구매 확정</option>
			                <option value="교환 요청"   <c:out value="${orderInfo.STATE eq '교환 요청' ? 'selected' : '' }" />>교환 요청</option>
			            </select>
			        </div>
	        	</c:if>	
        		<c:if test="${orderInfo.STATE eq '교환 요청'  or orderInfo.STATE eq '교환 처리 중' or orderInfo.STATE eq '교환 완료'}">
        			<div class="alert alert-info" role="alert">
	        			<select class="form-control" id="selectState" name="state" >
			                <option value="교환 처리 중" <c:out value="${orderInfo.STATE eq '교환 처리 중' ? 'selected' : '' }" />>교환 처리 중</option>
			                <option value="교환 완료"   <c:out value="${orderInfo.STATE eq '교환 완료' ? 'selected' : '' }" />>교환 완료</option>
			                <option value="환불 요청"   <c:out value="${orderInfo.STATE eq '환불 요청' ? 'selected' : '' }" />>환불 요청</option>
			            </select>
			        </div>
        		</c:if>
        		<c:if test="${orderInfo.STATE eq '환불 요청'}">
        			<div class="alert alert-warning" role="alert">
	        			<select class="form-control" id="selectState" name="state" >
			       			<option value="교환 요청"   <c:out value="${orderInfo.STATE eq '교환 요청' ? 'selected' : '' }" />>교환 요청</option>
			                <option value="환불 처리 중" <c:out value="${orderInfo.STATE eq '환불 처리 중' ? 'selected' : '' }" />>환불 처리 중</option>
			                <option value="환불 완료"   <c:out value="${orderInfo.STATE eq '환불 완료' ? 'selected' : '' }" />>환불 완료</option>
		          		</select>
			        </div> 
        		</c:if>
	    </div>
	</div>
	
	
    <div class="row">
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
            <div class="col-md-6" style="padding: 0;">
                <h6>주문 정보</h6>
            </div>
            <table class="table table-bordered">
                <tr>
                    <th>주문 일자</th>
                    <td>
                    	<fmt:formatDate value="${orderInfo.ORDER_DATE}" pattern="YYYY-MM-dd hh:mm"/>
                    </td>
                    <th>구매 ID</th>
                    <td>
                    	${orderInfo.MEMBER_ID}
                    </td>
                </tr>
                <tr>
                    <th>주문 번호</th>
                    <td>${orderInfo.CODE}</td>
                    <th>상품 이름</th>
                    <td>${orderInfo.NAME}</td>
                </tr>
                <tr>
                    <th>주문 금액</th>
                    <td>${orderInfo.AMOUNT} 원</td>
                   	<th>사용 포인트</th>
                   	<td>
	                   	
	                   	<c:if test="${empty orderInfo.USED_POINT || USED_POINT == '' }">
	                   		0 p
	                   	</c:if>
	                   	<c:if test="${!empty orderInfo.USED_POINT && USED_POINT != '' }">
	                   		${orderInfo.USED_POINT} p
	                   	</c:if> 
                   	</td>
                </tr>
                <tr>
                    <th>결제  종류</th>
                    <td>${orderInfo.PAY_METHOD}</td>
                   	<th>수량</th>
                   	<td>${orderInfo.QUANTITY} </td>
                </tr>
                <tr>
                	<th>색상</th>
                   	<td>${orderInfo.PRODUCT_COLOR}</td>
                   	<th>사이즈</th>
                   	<td>
                   		<c:if test="${empty orderInfo.PRODUCT_SIZE }">
                   			FREE SIZE
                   		</c:if>
                   		<c:if test="${!empty orderInfo.PRODUCT_SIZE }">
                   			${orderInfo.PRODUCT_SIZE}
                   		</c:if>
                   	</td>
                </tr>
        	</table>
        </div>
    </div>
	
    <div class="row" style="margin-bottom: 30px;">
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
	        <div class="col-md-6" style="padding: 0;">
	        	<h6>배송 정보</h6>
	        </div>
            <table class="table table-bordered">
                <tr>
                    <th>수취인 이름</th>
                    <td>
                    	<input type="text" class="form-control" name="recipient_name" value="${orderInfo.RECIPIENT_NAME}"/>
                    </td>
                    <th>수취인 우편번호</th>
                	<td>
                		<input type="text"  class="form-control" style="width:65%;float:left" name="zipcode" id="zipcode" value="${orderInfo.RECIPIENT_ZIPCODE}" readonly="readonly"/>
                		<input type="button" class="btn btn-default btn-sm" style="float:right" onclick="openZipSearch()" value="우편번호 찾기" />
                	</td>
                </tr>
                <tr>
                    <th>수취인 전화</th>
                    <td>
                    	<input type="text" class="form-control" name="recipient_tel" value="${orderInfo.RECIPIENT_TEL}"/>
                    </td>
                	<th>수취인 주소</th>
                	<td>
                		<input type="text" class="form-control" style="width:65%;float:left" name="address1" id="address1" value="${orderInfo.RECIPIENT_ADDRESS1}" readonly="readonly"/>
                		<input type="text" class="form-control" style="width:30%;float:right" id="extraAddress" placeholder="참고항목" readonly="readonly" />
                	</td>
                </tr>
                <tr>
                	<th>수취인 핸드폰</th>
                    <td>
                    	<input type="text" class="form-control" name="recipient_phone" value="${orderInfo.RECIPIENT_PHONE}"/>
                    </td>
                	<th>수취인 상세주소</th>
                	<td>
						<input type="text" class="form-control" name="address2" id="address2" value="${orderInfo.RECIPIENT_ADDRESS2}"/>
					</td>
                </tr>
                <tr>
                	<th>수취인 이메일</th>
                    <td>
                    	<input type="text" class="form-control" name="recipient_email" value="${orderInfo.RECIPIENT_EMAIL}"/>
                    </td>
                	<th>배송 메세지</th>
                	<td>
                		<input type="text" class="form-control" name="recipient_message" value="${orderInfo.RECIPIENT_MESSAGE}"/>
					</td>
                </tr>
            </table>
        </div>
    </div> 
	<form action="orderManageDetailProc" method="post" id="modifyForm">
    </form>

	<div class="row" style="margin-bottom: 200px;">
        <div class="col-md-10 col-md-offset-1" style="text-align: center;">
			<button type="submit" class="btn btn-default btn-sm" id="submitBtn"
				style="background-color: #404549; color: white;">주문상태 변경</button>
			<button type="button" class="btn btn-default btn-sm" onclick="location.href='/admin/orderManageList'">취소</button>
		</div>
	</div>
    <!-- Modify Form End -->

    <%@ include file="../includes/footer.jsp" %>

</div> <!-- container end -->

</body>
</html>