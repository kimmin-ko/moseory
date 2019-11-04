<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/joinForm.css">
<!-- 
1. 색상을 하나 선택하면
2. 체크박스로 사이즈 다중 선택
3. 체크가 되면 박스 옆에 text생기면서 재고 입력
4. 색상 추가 버튼
-->  

</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

<!-- <script type="text/javascript" src="/ckeditor/ckeditor/ckeditor.js"></script> -->
<!-- <script>
	var uploadFile = HttpContext.Current.Request.Files;
	
	var currentUploadFile = uploadFile[0];
	if (currentUploadFile != null && currentUploadFile.ContentLength > 0){
		var uploadFileName = Path.GetFileName(currentUploadFile.FileName);
	 
		 var baseDomainAddress = "toughman.pe.kr";
		 var fileUploadFolder = "d:\\www\editor_upload\\";
		 var fileUploadFolderWebPath = baseDomainAddress + "/editor_upload" ;
		 
		 if (Directory.Exists(fileUploadFolder) == false){
		 	Directory.CreateDirectory(fileUploadFolder);
		 }
	 
		 var fileUploadAllowExtension = "jpg,png,jpeg";
		 
		 var uniqueFileNameFullPath = GetUniqueFileName(fileUploadFolder, uploadFileName);
		 
		 var fileExtension = uniqueFileNameFullPath.Substring(uniqueFileNameFullPath.LastIndexOf(".") + 1).ToLower();
		 
		 var allowFileExtension = fileUploadAllowExtension.Split(',');
		 
	 	if (allowFileExtension.Contains(fileExtension) == true){
			currentUploadFile.SaveAs(uniqueFileNameFullPath);
			var webPath = fileUploadFolderWebPath + Path.GetFileName(uniqueFileNameFullPath);
			
			Response.Write("<script type='text/javascript'>\nwindow.parent.CKEDITOR.tools.callFunction(1, '" + webPath + "', '');\n</script>");
		}
		else {
			Response.Write("<script type='text/javascript'>\nalert('허용되지 않은 파일 유형입니다.');\n</script>");
		 }
	}
</script> -->
<script>
	
	function highCategory(e){
		var outer = ["자켓","수트","코트","점퍼/짚업"];
		var top = ["긴팔","가디건","니트","반팔","조끼"];
		var shirts = ["베이직","체크/패턴","스트라이프"];
		var bottom = ["슬랙스","데님","면바지","반바지"];
		var bag = ["가방"];
		var shoes = ["신발"];
		var acc = ["악세사리"];

		var target = document.getElementById("lowCategory");
		if(e.value == "1") var d = outer;
		else if(e.value == "2") var d = top;
		else if(e.value == "3") var d = shirts;
		else if(e.value == "4") var d = bottom;
		else if(e.value == "5") var d = bag;
		else if(e.value == "6") var d = shoes;
		else if(e.value == "7") var d = acc;
		
		target.options.length = 0;
		
		for(x in d){
			var opt = document.createElement("option");
			opt.value = e.value + x;	
			opt.innerHTML = d[x];
			target.appendChild(opt);
		}
	}
	
</script>
<script>
/* $(document).ready(function(){ 
    $('.addStock').hide();
    var check = $(".size1").prop("checked");
    $(".size").change(function(){
	    var numberOfChecked1 = $('input:checkbox:checked').length;
	    console.log(numberOfChecked1);
        if($(this).is(":checked")){
            console.log("트루,,,");
            $('.addStock').show();
        }else{
            console.log("거짓,,,");
            $('.addStock').hide();
        }
        $('input[name="product_stock"]').each(function(i) {
        	
        	console.log($(this).val());
		});
    });
}); */
	var productDetail = null;
	
	function regist() {
		
		detailInfo();
		
		$("#registForm").submit();
		
	}
	
	function detailInfo() {
		
	
		var colorArray = [];
		var sizeArray = [];
		var stockArray = [];
		var numberOfChecked = $('input:checkbox:checked').length;

		for(var i = 0; i < numberOfChecked; i++) {
			$('select[name="product_color"]').each(function(i){
				colorArray.push($(this).val());
			});
		}
		$('input[name="product_size"]:checked').each(function(i){
			sizeArray.push($(this).val());
		});
		
		
		$('input[name="product_stock"]').each(function(i) {
			
			if($(this).val() != ""){
				stockArray.push($(this).val());
			}
		});

		var stockLength = stockArray.length;
		var sizeLength = sizeArray.length;
		
		if(stockLength != sizeLength){
			alert("사이즈와 수량을 확인해주세요");
		}
		
		
		console.log(colorArray);
		console.log(sizeArray);
		console.log(stockArray);
		
		
		for(var i = 0; i < numberOfChecked; i++) {
			productDetail = {
				product_color : colorArray[i],
				product_size : sizeArray[i],
				product_stock : stockArray[i]
			}
			sendDetail.sendPro(productDetail);
		}

	}
	
	
	var sendDetail = (function() {
		
		function sendPro(productDetail) {
	
			$.ajax({
				type : "post",
				url : "/admin/productInfo",
				data : JSON.stringify(productDetail),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(result){
					console.log(result);
				}
			});
	
		} // sendPro
		
		return {sendPro : sendPro};
	})();
</script>

<div class="container joinForm-container" style="margin-left:22%">

    <!-- Join Form Start -->
    <div class="row joinLabel-row" style="margin-top: 80px;">
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

    <div class="row" style="margin-bottom: 50px;">
        <div class="col-md-10 col-md-offset-1" style="padding: 0;">
       		<form id="registForm" action = "productregist" method = "post">
	        <input type = "hidden" name = "file_path" value = "this is null">
	        <input type = "hidden" name = "file_name" value = "this is null">
	            <table class="table table-bordered">
	                <tr>
	                    <th>상품명 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="name"></td>
	                </tr>
	                <tr>
	                    <th>상위 카테고리 <img src="/images/ico_required.gif"></th>
	                    <td>
	                        <select onchange= "highCategory(this)" name = "high_code">
	                        	<option>카테고리를 선택해주세요</option>
	                            <option value = "1">아우터(OUTER)</option>
	                            <option value = "2">탑(TOP)</option>
	                            <option value = "3">셔츠(SHIRTS)</option>
								<option value = "4">하의(BOTTOM)</option>
								<option value = "5">가방(BAG)</option>
	                            <option value = "6">신발(SHOES)</option>
	                            <option value = "7">악세사리(ACC)</option>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>하위 카테고리 <img src="/images/ico_required.gif"></th>
	                    <td>
	                        <select id = "lowCategory" name = "low_code">
	                            <option>상위 카테고리를 선택해주세요</option>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>가격 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="price">원</td>
	                </tr>
	                <!-- <tr>
	                    <th>총 수량 <img src="/images/ico_required.gif"></th>
	                    <td><input type="text" name="quantity"> </td>
	                </tr> -->
	                <tr>
	                	<th>상품정보 <img src="/images/ico_required.gif"></th>
	                	<td>
	                		<div class = "detailInfo">
		                		<div class = "addColor">
			                		<select name = "product_color">
	                					<option value = "화이트">WHITE</option>
	                					<option value = "블랙">BALCK</option>
	                					<option value = "레드">RED</option>
	                					<option value = "그레이">GRAY</option>
	                				</select>
		                		</div>
								<div class = "addSize">
					                <input type="checkbox" class ="size" name="product_size" value="xs">XS
    					            <input type = "text" name = "product_stock" class= "product_stock">개<br>
					                <!-- <div class = "addStock">
					                </div> -->
					                <input type="checkbox" class ="size" name="product_size" value="s">S
					                <input type = "text" name = "product_stock" class= "product_stock">개<br>
					                
					                <input type="checkbox" class ="size" name="product_size" value="m" id = "sizeArea">M
					                <input type = "text" name = "product_stock" class= "product_stock">개<br>
					                <input type="checkbox" class ="size" name="product_size" value="l">L
					                <input type = "text" name = "product_stock" class= "product_stock">개<br>
					                <input type="checkbox" class ="size" name="product_size" value="xl">XL
					                <input type = "text" name = "product_stock" class= "product_stock">개<br>
					            
					            </div>	       
							</div>      		
  	              			<button type = "button">추가</button>
	                	</td>
	                </tr>
	                <!-- 
	                	1. 색상을 하나 선택하면
	                	2. 체크박스로 사이즈 다중 선택
	                	3. 체크가 되면 박스 옆에 text생기면서 재고 입력
	                	4. 색상 추가 버튼
	                 -->
	                <tr>
	                	<th>코멘트</th>
	                	<td>
							<textarea class = "form-control" name = "product_comment" id = "product_comment" cols="20" rows="15"></textarea>	                	
							<script> 
								// CKEDITOR.replace('product_comment');
							</script>
	                	</td>
	                </tr>
	            
	            </table>
	            <div class = "regist_btn_area text-center">
					<input type = "button" value = "등록" class = "btn btn-primary btn-md" onclick="regist()">
					<input type = "button"  value = "취소" class ="btn btn-default btn-md">
				</div>
				
			</form>
        </div>
    </div>

    <%@ include file="../includes/footer.jsp" %>

</div> <!-- container end -->
 

</body>
</html>