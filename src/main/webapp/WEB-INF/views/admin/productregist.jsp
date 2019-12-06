<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/productRegist.css">
</head>
<body>

	<%@ include file="../includes/sidebar.jsp"%>

	
	<script>
		$(document).ready(function(){
			$('#high_code').change(function(){
				var high_code = $('#high_code').val();
				
					$.ajax({
				        type : "post",
				        url : "/admin/productcate",
				        data : JSON.stringify(high_code),
				        dataType: "json",
				        contentType : "application/json; charset=utf-8",
						success: function(data){
							console.log(data);
							if(data.length == 0){
								$('#lowCategory').children().remove();
								$('#lowCategory').append("<option>하위카테고리가 없습니다</option>");
							}else{
								$('#lowCategory').children().remove();
								 for(var i =0; i < data.length; i++){
									$('#lowCategory').append("<option>" + data[i].name + "</option>");
								} 
							}
						}
				    });
					
					
			});
		
			
			
		});
	</script>
	<script src="/js/product/productRegist.js"></script>
	<div class="container joinForm-container" style="margin-left: 22%">
	
		<!-- ProductRegist Start -->
		<div class="row prod_reg_label">
			<div class="col-md-10 col-md-offset-1">
				<p>PRODUCT REGIST</p>
			</div>
		</div>

		<div class="row">
			<div class="col-md-10 col-md-offset-1" style="padding: 0;">
				<div class="col-md-6" style="padding: 0;">
					<span style="font-weight: bold;">기본정보</span>
				</div>
				<div class="col-md-6" style="text-align: right; padding: 0;">
					<span><img src="/images/ico_required.gif"> 필수입력사항</span>
				</div>
			</div>
		</div>
		
		<div class="row prod_reg_body">
			<div class="col-md-10 col-md-offset-1" style="padding: 0;">
				<form id="registForm" action="/admin/productregist" method="post"
					enctype="multipart/form-data">
					<table class="table table-bordered">
						<tr>
							<th>상품명 <img src="/images/ico_required.gif"></th>
							<td><input type="text" name="name"></td>
						</tr>
						<tr>
							<th>상위 카테고리 <img src="/images/ico_required.gif"></th>
							<td>
								<select id = "high_code" name = "high_code">
									<option>카테고리를 선택해주세요</option>
									<c:forEach var = "highCates" items = "${highCates }">
										<option value = "${highCates.code }">${highCates.name }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>하위 카테고리 <img src="/images/ico_required.gif"></th>
								<td>
									<select id="lowCategory" name="str_low_code">
											<option class = "empty">상위 카테고리를 선택해주세요</option>
									</select>
								</td>
						</tr>
						<tr>
							<th>가격 <img src="/images/ico_required.gif"></th>
							<td><input type="text" name="price">원</td>
						</tr>
						<tr>
							<th>상품 옵션 <img src="/images/ico_required.gif"></th>
							<td>
								<div class="detailInfo">
									<input type="button" class="add_colorAndSize" value="색상&사이즈 추가">&nbsp;
									<input type="button" class="add_color" value="색상 추가">&nbsp;
									<input type="button" class="add_size" value="사이즈 추가"><br>
									<br>
								</div>
							</td>
						</tr>
						<tr>
							<th>코멘트</th>
							<td><textarea class="form-control" name="product_comment"
									cols="20" rows="10"></textarea> <script>
										// CKEDITOR.replace('product_comment');
									</script></td>
						</tr>
						<tr>
							<th>썸네일</th>
							<td>
								<input type="file" id="thumbnail" name="thumbnail">
							</td>
						</tr>
						<tr>
							<th>이미지</th>
							<td><input type="file" id="getImage" name="files" multiple>
								<div class="imageArea"></div></td>
						</tr>
					</table>
					<div class="regist_btn_area text-center">
						<button type="button" class="btn btn-primary btn-md" onclick="regist()" id = "formbtn">등록</button> 
						<button type="button" class="btn btn-default btn-md">취소</button>
					</div>

				</form>
			</div>
		</div>
		<!-- ProductRegist End -->

		<%@ include file="../includes/footer.jsp"%>

	</div>
	<!-- container end -->

</body>
</html>