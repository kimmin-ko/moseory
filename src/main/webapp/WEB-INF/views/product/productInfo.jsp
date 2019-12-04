<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
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
            <%-- <img class="prod-img" src="<c:out value='${product.file_path }' />"> --%>

            <ul class="prod-info-list">
                <li class="menu_info">INFO</li>
                <li class="menu_review">REVIEW(<c:out value="${reviewCount }" />)</li>
                <li class="menu_qna">Q&A(<c:out value="${qnaCount }" />)</li>
            </ul>
        </div>
        
        <div class="col-md-5" class="prod-detail-info">
            <div class="ft-size-12">
            	<c:out value="${product.name }" /><br>
            	<fmt:formatNumber value="${product.price }" pattern="#,###" />원
            </div>
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
            	var member_id = '${user.id}';
            </script>
            
            <script src="/js/product/productInfo.js"></script>
            
            <script type="text/javascript">
            	// session에 저장된 로그인한 사용자
            	var user = "${user}";
            	// 자주 쓰이는 상품 번호 전연변수로 선언
            	var product_code = "${product.code}";
            	// 총 주문 가격
            	var total_price = 0;
            	// 총 주문 수량 
				var total_quantity = new Number(0);
            	// 각 tr의 수량을 저장할 Map
            	var quantity_map = new Map();
            	// 상품 페이지에 뿌려줄 리뷰의 갯수 초기화
            	var limit = new Number(5);
            	// 상품 페이지에 뿌려줄 리뷰 정렬 초기화
            	var type = 'N';
            	
            	function order() {
            		// 로그인 정보가 없을 경우
            		if(user == null || user == '') {
            			alert("로그인 후 이용해주세요.");
            			return;
            		}
            		
            		// 선택한 옵션이 없을 경우
            		if(total_quantity == 0) {
            			alert("옵션을 선택해주세요.");
            			return;
            		}
            		
            		// 선택된 각 옵션의 수량을 담을 변수 선언
            		var quantityList = [];
            		for(var i=0; i<duplCheckArr.length; i++) {
            			// input의 id가 quantity pdNo인 텍스트의 값을 가져와서 배열에 담아준다
            			quantityList.push($("#quantity"+duplCheckArr[i]).val());
            		}
            		
            		// 선택된 옵션의 번호 배열을 넘겨준다
            		location.href="/user/order?product_detail_no_list=" + duplCheckArr + "&quantity_list=" + quantityList;
            		
            	} // end order
            	
            	function addToCart() {
            		var member_id = "${user.id}";
            		
            		// 로그인 정보가 없을 경우
            		if(user == null || user == '') {
            			alert("로그인 후 이용해주세요.");
            			return;
            		}
            		
            		// 선택한 옵션이 없을 경우
            		if(total_quantity == 0) {
            			alert("옵션을 선택해주세요.");
            			return;
            		}
            		
            		// 장바구니에 정상적인 추가 또는 중복 확인 결과를 담을 변수
            		var r = false;
            		for(var i = 0; i < duplCheckArr.length; i++) {
						var cart = {
								member_id : member_id,
								product_detail_no : duplCheckArr[i],
								quantity : $('#quantity' + duplCheckArr[i]).val()
						};
						
						productJs.addToCart(cart, function(result) {
							// 장바구니에 해당 상품이 정상적으로 INSERT 되었거나 존재 여부를 확인 했을 경우 true
							if (result == 'success' || result == 'duplication') {
								r = true;
							}
						}); // end ajax
					} // end for
					
					// confirm() 의 결과 값. OK = true, CANCEL = false
            		var cf = null;
					
            		// addToCart가 정상적으로 실행 되었을 경우
					if(r) {
						cf = confirm("장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?");
					} else {
						alert("오류가 발생하였습니다. 다시 시도해주세요.");
					}
            		
            		if(cf) { // OK 버튼을 눌렀을 경우 장바구니 페이지로 이동
            			location.href='/user/cart';
            		} else { // CANCEL 버튼을 눌럿을 경우 함수 종료
            			return;
            		}
            		
            	} // end addToCart

            	function getReviewList(product_code, type, limit) {
            		
            		var reviewUL = $(".reviewUL");
            		productJs.getReviewList(product_code, type, limit, function(reviewList) {
        				
        				var str = "";
        				
        				if(reviewList.length == 0 || reviewList == null) {
        					reviewUL.html("");
           					return;
        				}

        				for(var i = 0, len = reviewList.length || 0; i < len; i++) {
        					
        					if(reviewList[i].product_detail.product_color == null)
        						reviewList[i].product_detail.product_color = '';
        					else
        						reviewList[i].product_detail.product_color += '&nbsp';
        					
        					if(reviewList[i].product_detail.product_size == null)
        						reviewList[i].product_detail.product_size = '';
        					
        					var year = reviewList[i].reg_date.year;
        					var month = reviewList[i].reg_date.monthValue;
        					var day = reviewList[i].reg_date.dayOfMonth;
        					var reg_date = year + '-' + month + '-' + day;
        					
        					str += "<li data-no='" + reviewList[i].no + "'>";
        					str += "	<div class='col-md-10 col-md-offset-1 review-body'>";
        					str += "		<p>";
        					str += "			<span>[" + reviewList[i].member.level + "]</span>";
        					str += "			<span>" + reviewList[i].member.id + "</span><span style='color: #B5B7BA;'> | </span>";
        					str += "			<span class='review-date'>" + reg_date + "</span>";
        					str += "			<span style='color: #B5B7BA;'> | </span>";
        					str += "			<span class='review-grade'>평점&nbsp;" + reviewList[i].grade + "</span>";
        					str += "		</p>";
        					str += "		<hr style='border: 0.5px #7F858A solid;'>";
        					//str += "		<div class='col-md-1'><img src='" + reviewList[i].file_path + "'></div>";
        					str += "		<div class='col-md-11 review-body-prod-name'>";
        					str += "			${product.name }<br>";
        					str += "			[옵션 : " + reviewList[i].product_detail.product_color;
        					str += "			" + reviewList[i].product_detail.product_size + "]";
        					str += "		</div>";
        					str += "		<div class='col-md-12 review-title'>";
        					str += "			<p>" + reviewList[i].title + "</p>";
        					str += "		</div>";
        					str += "		<div class='col-md-12 review-content'>";
        					str += "			<p>";
        					str += "				" + reviewList[i].content;
        					str += "			</p>";
        					str += "		</div>";
        					str += "		<div class='col-md-12 review-like'>";
        					str += "			<button type='button' class='btn btn-warning' onclick='increaseRecommend(" + reviewList[i].no + ", this)'>";
        					str += "				LIKE (" + reviewList[i].recommend + ")";
        					str += "			</button>";
        					str += "		</div>";
        					str += "	</div>";
        					str += "</li>";
        				}
        				
        				reviewUL.html(str);
        				
        			}); // getReviewList (ajax)
        			
        			if("${reviewCount}" > limit) {
            			$(".more-review").html('<button class="btn btn-info" onclick="moreReview()">리뷰 더보기</button>');
            		} else {
            			$(".more-review").html('');
            		}
        			
            	} // getReviewList
            	
            	$(document).ready(function() {
            		//alert($('.main-container').scrollTop());
            		
            		/* $(window).scroll(function() {
            			alert($(this).scrollTop());
            		}); */
            		
            		$("#total-price").text(total_price.format() + '원');
            		$("#total-quantity").text(total_quantity + '개');
            		
            		getReviewList(product_code, type, limit);
            		
            		// 리뷰 순서 변경
            		$("#sortReview").on("click", "li", function() {
            			type = $(this).attr('value');
            			limit = new Number(5);
            			
            			getReviewList(product_code, type, limit);
            		}) // sortReview
            		
            		// li changeColor
                	$("#sortReview li").on("click", function() {
                		$("#sortReview li").removeClass();
                		$(this).addClass('on');
                	});
            		
            	}); // document
            	
            	function moreReview() {
            		limit += 5;
            		
            		getReviewList(product_code, type, limit);
            		
            	} // moreReview
        		
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
            			dataType : 'json',
            			success : function(result) {
            				for(var i = 0; i < result.length; i++) {
            					// 가져온 사이즈를 select-size의 option으로 추가
            					if(result[i].product_stock != 0) {
            						$("#select-size").append('<option>' + result[i].product_size + '</option>');
            					} else {
            						$("#select-size").append('<option>' + result[i].product_size + '(품절)</option>');
            					}
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
            		var originSize = $("#select-size option:selected").val();
            		var size = $("#select-size option:selected").val();
            		var price = "${product.price}".format();
            		
            		// 옵션 선택 = function 종료
            		if(color == '옵션 선택' || size == '옵션 선택') return;
            		// (품절)일 경우 알림창 띄워준 후 종료
            		if(String(color).includes('품절') || String(size).includes('품절')) {
            			alert("해당 상품은 품절되었습니다.");
            			$("#select-color").find("option:eq(0)").prop("selected", true);
            			$("#select-size").find("option:eq(0)").prop("selected", true);
            			return;
            		}
            		
            		if (color && size) { // 컬러 true && 사이즈 true
            			size = '/' + size;
            		} else if (color && !size) { // 컬러 true && 사이즈 false
            			size = '';
            			originSize = '';
            		} else if (!color && size) { // 컬러 false && 사이즈 true
            			color = '';
            		}
            		
            		// 중복체크 및 디테일 번호 저장
            		var pdNo = 0; 
            		productJs.getProductDetailNo(product_code, color, originSize, function(result) {
            			pdNo = result;
            		});
            		
            		var flag = duplCheckArr.includes(pdNo);
            		
            		if(flag) { // 중복일 경우
            			alert("이미 선택되어 있는 옵션입니다.");
            			$("#select-color").find("option:eq(0)").prop("selected", true);
            			$("#select-size").find("option:eq(0)").prop("selected", true);
            			return;
            		}
            		
            		duplCheckArr.push(pdNo);
            		
            		// tr 추가
            		$(".add-pro-table > tbody:last").append(''
            			+ '<tr>'
                        + 	'<td>'
                        + 		'<p class="add-pro-name">' + name + '</p>'
                        + 		'<p class="add-pro-option">- ' + color + size + '</p>'
                        + 	'</td>'
                        + 	'<td>'
                        + 		'<p class="add-pro-quantity">'
                        + 			'<input type="number" id="quantity' + pdNo + '" min="1" max="99" value="1" oninput="changeCount(this, \'' + pdNo + '\')">&nbsp'
                        + 			'<img src="http://img.echosting.cafe24.com/design/skin/default/product/btn_price_delete.gif"'
                        +					'onclick="removeOrderProd(\'' + color + '\', \'' + originSize + '\', this)">'
                        + 		'</p>'
                        + 	'</td>'
                        + 	'<td>'
                        + 		'<p class="add-pro-price">' + price + '원</p>'
                        + 	'</td>'
                        + '</tr>');
            		
            		quantity_map.set("quantity" + pdNo, 1);
            		
            		// 수량 합산
            		sumQuantity();
            	} // addOrderProd
            	
            	// 주문 개수 변경
            	function changeCount(countInput, pdNo) {
            		var count = $(countInput).val();
            		var price = "${product.price}";
            		var total = (price * count).format();
					
            		productJs.getProductStock(pdNo, function(stock) {
            			if(count > stock) {
	            			alert("재고가 부족합니다.");
	            			$(countInput).val(stock);
	            			count = stock;
            			}
            		});
            		
            		if(count === '0' || count === '') {
            			alert("최소 주문수량은 1개 입니다.");
            			$(countInput).val(1);
            			count = 1;
            		}
            		
            		var trNum = $(countInput).closest('tr').prevAll().length;
            		
            		$('.add-pro-table > tbody > tr:eq(' + trNum + ') > td:last').html('<p class="add-pro-price">' + total + '원</p>');
            		
            		// count가 string type이기 때문에 number type으로 변환
            		quantity_map.set($(countInput).attr('id'), Number(count));
            		
            		// 수량 합산
            		sumQuantity();
            	} // changeCount
            	
            	// 수량 합산
            	function sumQuantity() {
            		
            		// map의 값을 모두 더해주기 전에 0으로 초기화
            		total_quantity = Number(0);

					for(var value of quantity_map.values()) {
						total_quantity += value;
					}
					
					$("#total-quantity").text(total_quantity.format() + '개');
					$("#total-price").text(("${product.price}" * total_quantity).format() + '원');
					
            	} // sumQuantity
            	
            	// 주문 목록 삭제
            	function removeOrderProd(color, size, cancelBtn) {
            		var pdNo = 0;
            		
            		productJs.getProductDetailNo(product_code, color, size, function(result) {
            			pdNo = result;
            		});
            		
					// 삭제 input id
					var quantity_id = $(cancelBtn).prev().attr('id');
					// 수량에서 삭제한 input의 값을 제거
					quantity_map.delete(quantity_id);
					// 총 수량 다시 계산
					sumQuantity();

					// 취소 버튼과 가장 가까운 tr의 index를 찾는다
            		var trNum = $(cancelBtn).closest('tr').prevAll().length;
					
            		// 해당 index의 tr을 제거한다
            		$('.add-pro-table > tbody > tr:eq(' + trNum + ')').remove();
            		
            		// 중복 체크 배열에서 삭제한 옵션 제거
            		duplCheckArr = jQuery.grep(duplCheckArr, function(value) {
                        return value != pdNo;
                    });
            		
            	} // removeOrderProd
            	
            	// 추천 증가
            	function increaseRecommend(review_no, recommend_btn) {
					var userId = "${user.id}";
					
					if(user == null || user == '') {
						alert("로그인 후에 LIKE/CLEAR LIKE하실 수 있습니다.");
						return;
					}
            		
            		$.ajax({
            			type : 'post',
            			url : '/product/increaseRecommend/' + review_no + '/' + userId,
            			success : function(result) {
            				$(recommend_btn).text('LIKE (' + result + ')');
            			}
            		});
            		
            	} // increaseRecommend
            	
            	function addWishList() {
            		var member_id = "${user.id}";
            		
            		// 로그인되어있을 때
            		if(member_id) {
	            		productJs.addWishList(member_id, product_code, function(result) {
	            			if(result == 'success') {
		            			alert("관심상품이 등록되었습니다.");
	            			} else {
	            				alert("이미 등록되어 있습니다.");
	            			}
	            		});
            		} else {
            			alert('로그인 후 이용해주세요.');
            		}
            	} // addWishList
            	
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
		                <c:forEach var="productDetail" items="${productDetailList }">
		                	<c:choose>
		                		<c:when test="${productDetail.product_stock ne 0 }">
			                		<option><c:out value="${productDetail.product_color }" /></option>
		                		</c:when>
		                		<c:otherwise>
			                		<option><c:out value="${productDetail.product_color }" />(품절)</option>
		                		</c:otherwise>
		                	</c:choose>
		                </c:forEach>
		            </select>
	            </c:if>
            </c:if>
            <!-- 사이즈 -->
            <c:if test="${size != null }">
	            <select id="select-size" class="ft-size-12 prod-option form-control" onchange="addOrderProd()">
	                <option>옵션 선택</option>
	                <c:forEach var="productSize" items="${productSizeList }">
	                	<c:choose>
	                		<c:when test="${productSize.product_stock ne 0 }">
	                			<c:set var="productDetailNo" value="${productSize.no }" />
		                		<option><c:out value="${productSize.product_size }" /></option>
	                		</c:when>
	                		<c:otherwise>
		                		<option><c:out value="${productSize.product_size }" />(품절)</option>
	                		</c:otherwise>
	                	</c:choose>
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
                <button type="button" class="btn btn-default btn-lg btn-buy" onclick="order()">BUY NOW</button>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg" onclick="addToCart()">ADD TO CART</button>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg" onclick="addWishList()">WISH LIST</button>
            </div>
            
        </div>

    </div> <!-- row -->

    <div class="row info_row" style="margin-bottom: 150px;">
        <div class="col-md-10 col-md-offset-1">
            <img src="/images/detail-view_01.jpg">
        </div>
    </div> <!-- row -->

    <div class="row" style="margin-bottom: 150px;">

        <div class="col-md-10 col-md-offset-1 review-header"> <!-- review header -->
            <p>Review(<c:out value="${reviewCount }" />)</p>
            <ul id="sortReview">
                <li class="on" value="N">최신순</li>
                <li value="R">추천순</li>
                <li value="H">높은평점순</li>
                <li value="L">낮은평점순</li>
            </ul>
        </div> <!-- review header -->
       	
       	<!-- 리뷰 ul -->
       	<ul class="list-unstyled reviewUL">
        </ul>

		<!-- 더보기 버튼 -->
		<div class="col-md-10 col-md-offset-1 more-review">
			
		</div>

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
                        <td width="10%">조회수</td>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="qna" items="${qnaList }">
					<tr>
						<!-- NO -->
						<td><c:out value="${qna.no }" /></td>
						<!-- TITLE -->
						<td class="qna_title">
							<a class="title" href="${qna.secret }">
							<c:forEach begin="1" end="${qna.depth }" >
								<c:if test="${qna.depth > 0 }">
									&nbsp;&nbsp;
								</c:if>
							</c:forEach>
							<c:if test="${qna.depth > 0 }">
								<img src="/images/re.gif">
							</c:if>
							<c:if test="${qna.secret ne 1 }">
								<c:out value="${qna.title }" />&nbsp;
							</c:if>
							<c:if test="${qna.secret eq 1 }">
								비밀글입니다.
								<img class="secret_img" src="/images/secret.jpg">
							</c:if>
								<input type="hidden" name="writer" value="${qna.member_id }">
								<input type="hidden" name="no" value="${qna.no }">
							</a>
						</td>
						<!-- WRITER -->
						<td class="qna_writer"><c:out value="${fn:substring(qna.member_id, 0, 2).concat('*****') }" /></td>
						<!-- DATE -->
						<td><c:out value="${qna.reg_date }" /></td>
						<!-- HIT -->
						<td><c:out value="${qna.hit }" /></td>
					</tr>
				</c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="col-md-10 col-md-offset-1 reg_btn_area">
			<c:if test="${user ne null }">
				<button type="button" class="btn btn-default btn-sm qna_reg_btn">글쓰기</button>
			</c:if>
		</div>
		
		<!-- 페이징 처리 -->
		<div class="col-md-10 col-md-offset-1 pagination-div">
			<nav>
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">&laquo;</a></li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
						<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }">
							<a href="${num }">${num }</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next }">
						<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">&raquo;</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
		
		<form id="actionForm" action="/product/productInfo" method="get">
			<input type="hidden" name="code" value="${product.code }">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</form>

    </div> <!-- row -->

    <!-- Product Info Form End -->
	
	<%@ include file="../includes/footer.jsp" %>
        
</div> <!-- container -->

</body>
</html>