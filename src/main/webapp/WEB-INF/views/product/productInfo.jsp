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
    <link rel="stylesheet" href="/css/productInfoForm.css">
</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%;">

    <!-- Product Info Form Start -->
    <div class="row" style="margin-top: 60px; margin-bottom: 150px;">

        <div class="col-md-7 product_image">
            <img class="prod-img" src="<c:out value='${product.file_path }' />">

            <ul class="prod-info-list">
                <li>DETAIL</li>
                <li>INFO</li>
                <li>REVIEW(<c:out value="${reviewCount }" />)</li>
                <li>Q&A(<c:out value="${qnaCount }" />)</li>
            </ul>
        </div>
        
            
        <div class="col-md-5" class="prod-detail-info">
            <div class="ft-size-12"><c:out value="${product.name }" /><br><c:out value="${product.price }" />원</div>
            <br>
            <div class="info-title">COMMENT</div>
            <p class="ft-size-12">
                <c:out value="${product.product_comment }" />
            </p>
            <br>
            <div class="info-title">DETAIL</div>
                <p class="info-content">
                    ·소재 : 코튼<br>
                    ·컬러 : 베이지,네이비<br>
                    ·모델 사이즈 : 177cm, 62kg 100(L) / 28~29(M) 착용<br>
                    ·신축성 : 중간 / 두께 : 중간 / 비침 : 없음<br>
                    ·세탁 및 관리법 : 하단 소재 세탁 방법 참고
                </p>

            <hr style="border: 0.5px solid #DFDFDF">
            
            <script type="text/javascript">
            	// 총 주문 가격
            	var total_price = 0;
            	// 총 주문 수량 
				var total_quantity = new Number(0);
            	// 각 tr의 수량을 저장할 Map
            	var quantity_map = new Map();
            	// 각 tr의 id를 지정해주기 위한 index 0으로 초기화
            	var idx = 0;
            	
            	$(document).ready(function() {
            		$("#total-price").text(total_price + '원');
            		$("#total-quantity").text(total_quantity + '개');
            	});
            	
            	// 색상 선택 시 해당 색상의 사이즈를 조회
            	function getSize() {
            		// 현재 select-size의 option 삭제
            		$("#select-size option").remove();
            		$("#select-size").append('<option>옵션 선택</option>');
            		
            		// 해당 상품 코드
            		var code = ${product.code};
            		// 선택된 색상
            		var color = $("#select-color option:selected").val();
            		
            		// code와 color를 이용해서 size를 가져옴
            		$.ajax({
            			type : 'get',
            			url : '/product/getSize/' + code + '/' + color,
            			success : function(result) {
            				for(var i = 0; i < result.length; i++) {
            					// 가져온 사이즈를 select-size의 option으로 추가
            					$("#select-size").append('<option>'+result[i]+'</option>');
            				}	
            			}
            		});
            	} // getSize
            	
            	// 옵션 중복 체크
				var duplCheckArr = [];
            	// 색상 또는 사이즈 선택 시 주문 목록에 추가
            	function addOrderProd() {
            		var name = "${product.name}";
            		var color = $("#select-color option:selected").val();
            		var size = $("#select-size option:selected").val();
            		var price = "${product.price}";
            		
            		// 옵션 선택 = function 종료
            		if(color == '옵션 선택' || size == '옵션 선택') return;
            		
            		if (color && size) { // 컬러 true && size true
            			size = '/' + size;
            		} else if (color && !size) {
            			size = '';
            		} else if (!color && size) { // 컬러 false && size true
            			color = '';
            		}
            		
            		// 중복체크
            		var check = color + size;
            		var flag = duplCheckArr.includes(check);
            		
            		if(flag) { // 중복일 경우
            			alert("이미 선택되어 있는 옵션입니다.");
            			$("#select-size").find("option:eq(0)").prop("selected", true);
            			return;
            		}
            		
            		duplCheckArr.push(check);
            		
            		// tr 추가
            		$(".add-pro-table > tbody:last").append(''
            			+ '<tr>'
                        + 	'<td>'
                        + 		'<p class="add-pro-name">' + name + '</p>'
                        + 		'<p class="add-pro-option">- ' + color + size + '</p>'
                        + 	'</td>'
                        + 	'<td>'
                        + 		'<p class="add-pro-quantity">'
                        + 			'<input type="number" id="quantity' + idx + '" min="1" max="99" value="1" oninput="changeCount(this)">&nbsp'
                        + 			'<img src="http://img.echosting.cafe24.com/design/skin/default/product/btn_price_delete.gif"'
                        +					'onclick="removeOrderProd(\'' + color + '\', \'' + size + '\', this)">'
                        + 		'</p>'
                        + 	'</td>'
                        + 	'<td>'
                        + 		'<p class="add-pro-price">' + price + '원</p>'
                        + 	'</td>'
                        + '</tr>');
            		
            		quantity_map.set("quantity" + idx, 1);
            		
            		// 수량 합산
            		sumQuantity();
            		
            		idx++;
            	} // addOrderProd
            	
            	// 주문 개수 변경
            	function changeCount(countInput) {
            		var count = $(countInput).val();
            		var price = "${product.price}";

            		if(count === '0' || count === '') {
            			alert("최소 주문수량은 1개 입니다.");
            			$(countInput).val(1);
            			return;
            		}
            		
            		var trNum = $(countInput).closest('tr').prevAll().length;
            		
            		$('.add-pro-table > tbody > tr:eq(' + trNum + ') > td:last').html('<p class="add-pro-price">' + (price * count) + '원</p>');
            		
            		// count가 string type이기 때문에 number type으로 변환
            		quantity_map.set($(countInput).attr('id'), new Number(count));
            		
            		// 수량 합산
            		sumQuantity();
            		
            		console.log("total_quantity : " + total_quantity);
            	} // changeCount
            	
            	// 수량 합산
            	function sumQuantity() {
            		
            		// map의 값을 모두 더해주기 전에 0으로 초기화
            		total_quantity = new Number(0);

					for(var value of quantity_map.values()) {
						total_quantity += value;
					}
					
					$("#total-quantity").text(total_quantity + '개');
					$("#total-price").text((${product.price} * total_quantity) + '원');
					
            	} // sumQuantity
            	
            	// 주문 목록 삭제
            	function removeOrderProd(color, size, cancelBtn) {
            		var check = color + size;
            		
            		// 취소 버튼과 가장 가까운 tr의 index를 찾는다
            		var trNum = $(cancelBtn).closest('tr').prevAll().length;
            		
					// 삭제 input id
					var quantity_id = $(cancelBtn).prev().attr('id');
					// 수량에서 삭제한 input의 값을 제거
					quantity_map.delete(quantity_id);
					// 총 수량 다시 계산
					sumQuantity();

            		// 해당 index의 tr을 제거한다
            		$('.add-pro-table > tbody > tr:eq(' + trNum + ')').remove();
            		
            		// 중복 체크 배열에서 삭제한 옵션 제거
            		duplCheckArr = jQuery.grep(duplCheckArr, function(value) {
                        return value != check;
                    });
            		
            	} // removeOrderProd
            	
            	// 추천 증가
            	function increaseRecommend(review_no, recommend_btn) {
            		
            		$.ajax({
            			type : 'post',
            			url : '/product/increaseRecommend/' + review_no,
            			success : function(result) {
            				$(recommend_btn).text('LIKE (' + result + ')');
            			}
            		});
            		
            	} // upRecommend
            	
	            </script>
            <!-- 컬러 -->
            <c:if test="${color != null }">
            	<c:if test="${size != null }"> <!-- 사이즈가 있으면 사이즈 조회 -->
	            	<select id="select-color" class="ft-size-12 prod-option form-control" onchange="getSize()">
		            	<option>옵션 선택</option>
		                <c:forEach var="productColor" items="${productColorList }">
		                	<option><c:out value="${productColor }" /></option>
		                </c:forEach>
		            </select>
	            </c:if>
	            <c:if test="${size == null }"> <!-- 사이즈가 없으면 주문목록 추가 -->
	            	<select id="select-color" class="ft-size-12 prod-option form-control" onchange="addOrderProd()">
		            	<option>옵션 선택</option>
		                <c:forEach var="productColor" items="${productColorList }" varStatus="status">
		                	<option><c:out value="${productColor }" /></option>
		                </c:forEach>
		            </select>
	            </c:if>
            </c:if>
            <!-- 사이즈 -->
            <c:if test="${size != null }">
	            <select id="select-size" class="ft-size-12 prod-option form-control" onchange="addOrderProd()">
	                <option>옵션 선택</option>
	                <c:forEach var="productSize" items="${productSizeList }">
	                	<option><c:out value="${productSize }" /></option>
	                </c:forEach>
	            </select>
            </c:if>

            <p class="ft-size-12">(최소주문수량 1개 이상)</p>
	
			<!-- 주문 목록 추가할 테이블 -->
           	<table class="table table-condensed add-pro-table">
                <tbody></tbody>
            </table>
			
			<!-- 토탈 주문 가격과 개수 -->
            <p>
	            TOTAL : <span id="total-price"></span>
	            (<span id="total-quantity"></span>)	
	        </p>
            
            <hr style="border: 0.5px solid #DFDFDF">
			
			<!-- 구매, 장바구니 추가, 관심 상품 추가 버튼 -->
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg btn-buy">BUY NOW</button>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg" onclick="addProductToCart()">ADD TO CART</button>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg">WISH LIST</button>
            </div>
            
        </div>

    </div> <!-- row -->

    <div class="row" style="margin-bottom: 150px;">
        <div class="col-md-10 col-md-offset-1">
            <img src="/images/detail-view_01.jpg">
        </div>
    </div> <!-- row -->

    <div class="row" style="margin-bottom: 150px;">

        <div class="col-md-10 col-md-offset-1 review-header"> <!-- review header -->
            <p>Review(<c:out value="${reviewCount }" />)</p>
            <ul>
                <li>최신순</li>
                <li>댓글순</li>
                <li>추천순</li>
                <li>높은평점순</li>
                <li>낮은평점순</li>
            </ul>
        </div> <!-- review header -->
       
       	<c:forEach var="review" items="${reviewList }">
	        <div class="col-md-10 col-md-offset-1 review-body">  <!-- review body start -->
	            <p>
	                <span>[<c:out value="${review.member.level }" />]</span>
	                <span>${review.member.id }</span><span style="color: #B5B7BA;"> | </span>
	                <span class="review-date"><c:out value="${review.reg_date }" /></span>
	                <span style="color: #B5B7BA;"> | </span>
	                <span class="review-grade"><c:out value="${review.grade }" /></span>
	            </p>
	
	            <hr style="border: 0.5px #7F858A solid;">
	
	            <div class="col-md-1"><img src='<c:out value="${review.file_path }" />'></div>
	            <div class="col-md-11 review-body-prod-name">
	                ${product.name }<br>
	                [옵션 : <c:out value="${review.product_detail.product_color }" />&nbsp;
	                		<c:out value="${review.product_detail.product_size }" />]
	            </div>
	
	            <div class="col-md-12 review-title">
	                <p><c:out value="${review.title }" /></p>
	            </div>
	
	            <div class="col-md-12 review-content">
	                <p>
	                	<c:out value="${review.content }" />   
	                </p>
	            </div>
	
	            <div class="col-md-12 review-like">
	                <button type="button" class="btn btn-warning" onclick="increaseRecommend(${review.no}, this)">
	                	LIKE (<c:out value="${review.recommend }" />)
	                </button>
	            </div>
			</div> <!-- review body end -->
        </c:forEach>

        <div class="col-md-10 col-md-offset-1 qna-header"> <!-- Q&A header -->
            <p>Q & A(<c:out value="${qnaCount }" />)</p>
        </div> <!-- Q&A header -->

        <div class="col-md-10 col-md-offset-1 qna-body">
            <table class="table">
                <thead>
                    <tr>
                        <td width="10%">번호</td>
                        <td width="40%">제목</td>
                        <td width="20%">작성자</td>
                        <td width="20%">작성일</td>
                        <td width="10%">조회</td>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="qna" items="${qnaList }">
                    <tr>
                        <td><c:out value="${qna.no}" /></td>
                        <td><c:out value="${qna.title}" /></td>
                        <td><c:out value="${qna.member.name}" /></td>
                        <td><c:out value="${qna.reg_date}" /></td>
                        <td><c:out value="${qna.hit}" /></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div> <!-- row -->

    <!-- Product Info Form End -->
	
	<%@ include file="../includes/footer.jsp" %>
        
</div> <!-- container -->

</body>
</html>