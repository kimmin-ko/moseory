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
<link rel="stylesheet" href="/css/orderManageList.css">
<!-- Bootstrap Datepicker CSS -->
<link rel="stylesheet" href="/css/bootstrap-datepicker3.standalone.min.css">
</head>
<body>

	<%@ include file="../includes/sidebar.jsp"%>

	<!-- Bootstrap Datepicker JS -->
	<script src="/js/bootstrap-datepicker.min.js"></script>
	<!-- KO Datepicker JS -->
	<script src="/js/bootstrap-datepicker.ko.min.js"></script>
	
	<div class="container" style="margin-left: 22%;">
	
	    <!-- Order List Start -->
        <div class="row">
	        <div class="col-md-10 col-md-offset-1 order_list_lb">
	            <p>ORDER MANAGE LIST</p>
	        </div>
	
	        <div class="col-md-10 col-md-offset-1 order_list_cri">
	        	<form method="get" action="orderManageList">
	        		<div class="col-md-12 order_list_cri">
		        		<div class="col-md-4 order_list_cri">
		        			<span class="span_name">기간</span>
		        			<input type="text" class="hasDatepicker form-control" id="startDate" name="startDate"
				            autocomplete="false" placeholder="-">
				            -
				            <input type="text" class="hasDatepicker form-control" id="endDate" name="endDate"
				            autocomplete="false" placeholder="-">
		        		</div>
		        		<div class="col-md-4 order_list_cri">
		        			<span class="span_name">이메일</span>
		            		<input type="text" name="searchEmail" class="form-control search_email" value="${searchEmail }">
		        		</div>
		        		<div class="col-md-4 order_list_cri">
		        			<span class="span_name">주문 번호</span>
		        			<input type="text" name="orderValue" value="${orderValue }" class="form-control search_order">
		        		</div>
		        	</div>
	        		<div class="col-md-12 order_list_cri">
	        			<div class="col-md-4 order_list_cri">
		        			<select name="searchType" id="searchType"  class="form-control search_type" >
		            			<option value="id">ID</option>
		            			<option value="name">Name</option>
		            		</select>
	            			<input type="text" name="searchValue" value="${searchValue}" class="form-control search_keyword" >
		            	</div>
		            	<div class="col-md-4 order_list_cri">
		            		<select name="commType" id="commType" class="form-control search_type">
		            			<option value="phone" <c:if test="${commType == 'phone'}">selected</c:if> >Phone</option>
		            			<option value="tel" <c:if test="${commType == 'tel'}">selected</c:if>>Tel</option>
		            		</select>
		            		<input type="text" name="commValue"  value="${commValue }" class="form-control search_keyword">
		            	</div>
		            	<div class="col-md-4 order_list_cri">
		            		<span class="span_name">주문 상태</span>
		        			<select class="form-control search_type" id="selectState" name="state">
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
		            	</div>
	        		</div>
	            	<button type="submit" class="btn btn-default btn-sm" style="float:right; margin-bottom:10px;"name="searchBtn">검색</button>
	        	</form>
	        </div>
	        <div class="col-md-10 col-md-offset-1 m-order_list">
	            <table class="table order_list_tbl">
	                <colgroup>
	                    <col width="5%" />
	                    <col width="15%" />
	                    <col width="15%" />
	                    <col width="15%" />
	                    <col width="20%" />
	                    <col width="15%" />
	                    <col width="15%" />
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>No</th>
				          	<th>주문일자</th>
				          	<th>주문번호</th>
				          	<th>구매 ID</th>
				          	<th>상품정보</th>
				          	<th>주문금액(수량)</th>
				          	<th colspan="2">주문상태</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach var="model" items="${orderList}" varStatus="status">
							<tr onclick="javascript:ref('${model.CODE}', '${model.PRODUCT_DETAIL_NO}', '${model.PRODUCT_COLOR}');">
								<td>${model.RNUM}</td>
								<td>
									<fmt:formatDate value="${model.ORDER_DATE}" pattern="YYYY-MM-dd"/>
								</td>
								<td>${model.CODE}</td>
								<td>
									${model.MEMBER_ID}<br/>
									(${model.RECIPIENT_NAME})<br/>
									${model.RECIPIENT_PHONE}	
								</td>
								<td>
									<span class="prod_name">${model.NAME}</span><br><br>
	                            	<span class="prod_option">
	                            		[옵션:
		                            	<c:if test="${model.PRODUCT_COLOR ne null }"> 
		                            		<c:if test="${model.PRODUCT_SIZE ne null }"> 
		                            			<c:out value="${model.PRODUCT_COLOR }" /> /
		                            			<c:out value="${model.PRODUCT_SIZE }" />
		                            		</c:if>
		                            		<c:if test="${model.PRODUCT_SIZE eq null }">
		                            			<c:out value="${model.PRODUCT_COLOR }" />
		                            		</c:if>
		                            	</c:if>	
		                            	<c:if test="${model.PRODUCT_COLOR eq null }">
		                            		<c:out value="${model.PRODUCT_SIZE }" />
		                            	</c:if>
			                             ]
	                            	</span>
								</td>
								<td>
									<span class="order_amount"><fmt:formatNumber value="${model.AMOUNT}" />원</span><br>
	                            	<span class="order_quantity"><fmt:formatNumber value="${model.QUANTITY}" />개</span>
								</td>
								<td>
									<span class="order_state"><c:out value="${model.STATE}" /></span>
								</td>
								
							</tr>
						</c:forEach>
	                </tbody>
	            </table>
	            <!-- paging Start -->
				<div class="col-md-10 col-md-offset-1 pagination-div" style="margin-bottom: 30px;">
					<nav>
						<ul class="pagination">
							<c:if test="${paging.curBlock ne 1 }">
								<li class ="button_first"><a href="${pageContext.request.contextPath }/admin/orderManageList?curPage=${paging.startPage }">처음</a></li>
							</c:if>
							<c:if test="${paging.curPage ne 1 }">
								<li class ="button_previous"><a href="${pageContext.request.contextPath }/admin/orderManageList?curPage=${paging.prevPage }">이전</a></li>
							</c:if>
							<c:forEach var = "pageNumber" begin = "${paging.startPage }" end = "${paging.endPage }">
								<c:choose>
									<c:when test="${pageNumber eq paging.curPage }">
										<li class ="paginate_button active"><span>${pageNumber }</span></li>
									</c:when>
									<c:otherwise>
										<li class ="paginate_button"><a href = "${pageContext.request.contextPath }/admin/orderManageList?curPage=${pageNumber}&searchType=${searchType}&keyword=${keyword}">${pageNumber }</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test = "${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">	
								<li class ="button_next"><a href="${pageContext.request.contextPath }/admin/orderManageList?curPage=${paging.nextPage }">다음</a></li>
							</c:if>
							<c:if test = "${paging.curBlock ne paging.blockCnt && paging.blockCnt > 0 }">
								<li class ="button_end"><a href="${pageContext.request.contextPath }/admin/orderManageList?curPage=${paging.endPage }">끝</a></li>
							</c:if>
						</ul>
					</nav>
				</div>
				<!-- paging End -->
	        </div>
	
	    </div>
		<!-- Order List End -->
	
		<%@ include file="../includes/footer.jsp"%>

	</div>
</body>
<script>
$(function() {
	$('.hasDatepicker').datepicker({
		format : "yyyy-mm-dd", // 데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
		autoclose : true, // 사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
		templates : {
			leftArrow : '&laquo;',
			rightArrow : '&raquo;'
		}, // 다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징
		todayHighlight : true, // 오늘 날짜에 하이라이팅 기능 기본값 :false
		weekStart : 1,// 달력 시작 요일 선택하는 것 기본값은 0인 일요일
		language : "ko" // 달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
	});
}); // end datepicker

//String -> Date
function convertStringToDate(str) {
	var str = str.split('-');
	return new Date(str[0], str[1], str[2]);
} // end convertStringToDate

function ref(code,productDetailNo,color){
	if(color == null || color == ""){
		document.location.href="/admin/getOrderDetail?orderCode="+code+"&productDetailNo="+productDetailNo;
	}else{
		document.location.href="/admin/getOrderDetail?orderCode="+code+"&productDetailNo="+productDetailNo+"&productColor="+color;
	}
}

$(document).ready(function(){
	$('#startDate').on("change", function() {
		// Date Type으로 변환
		var startDate = convertStringToDate($(this).val());
		var endDate = convertStringToDate($('#endDate').val());

		if (startDate.getTime() > endDate.getTime()) {
			$('#endDate').val($(this).val());
		}

	}); // end startDate onchange

	$('#endDate').on("change", function() {
		// Date Type으로 변환
		var startDate = convertStringToDate($('#startDate').val());
		var endDate = convertStringToDate($(this).val());

		if (startDate.getTime() > endDate.getTime()) {
			$('#startDate').val($(this).val());
		}
	}); // end endDate onchange
})


</script>
</html>