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
    <link rel="stylesheet" href="/css/category.css">
</head>
<script type="text/javascript">
var message = "${msg}";
if(message != ""){
	alert(message);
}
</script>
<body>
    
<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%">

    <!-- Category Start -->
    <div class="row category">

		 <!-- Category-header Start -->
        <div class="col-md-10 col-md-offset-1 category-header text-center">
            <p>HIGH CATEGORY</p>
		</div>
		<!-- Category-header End -->

		<!-- Category-body Start -->
		
		<form id="form" method="post" action="saveParentsCategory">		
			<div class="col-md-6 col-md-offset-3 category-body">
				<table class="table table-striped" id="cateTable">
					<colgroup>
						<col width="10%" />
						<col width="15%" />
						<col width="35%" />
						<col width="35%" />
					</colgroup>
					<thead>
				        <tr>
				          <th><label>
				          		<input type="checkbox" name="row-idx-all" id="row-idx-all" />
				          	</label></th>
				          <th>Code</th>
				          <th>Name</th>
				          <th>explanation</th>
				        </tr>
			    	</thead>
					<tbody>
						<c:forEach var="model" items="${parentCategoryList}" varStatus="status">
							<tr>
								<td><label><input type="checkbox"  name="row-idx" value="${model.code}" style="top: 9px;" /></label></td>
								<td><input type="text" class="form-control" name="code" value="${model.code}"></td>
								<td><input type="text" class="form-control" name="name" value="${model.name}"></td>
								<td><input type="text" class="form-control" name="kname" value="${model.kname}"></td>
								<td><span class="glyphicon glyphicon-zoom-in" aria-hidden="true" style="top: 9px;"></span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
		<!-- Category-body End -->
			<div class="col-md-10 col-md-offset-1" style="text-align : center; margin-bottom: 80px;">
				<button type="button" class="btn btn-default btn-sm" 
	            	style="background-color: black; color: white;" name="deleteBtn">선택 목록 삭제</button>
	            <button type="submit" class="btn btn-default btn-sm" name="addBtn">추가</button>
	            <button type="button" class="btn btn-default btn-sm" name="saveBtn">저장</button>
	        </div>
    </div>  
    <!-- Category End -->

	<%@ include file="../includes/footer.jsp" %>
	
</div>
</body>
<script>
function EventFunction(){
	
	//체크박스 전체 선택
	$("input[name=row-idx-all]").click(function(){
		var check = $(this).is(":checked");
		var tr = $(this).parents("thead").siblings("tbody").find("tr");
		if(check){
			for(var i=0; i < tr.length; i++){
				$("td",tr.eq(i)).eq(0).find("input[type=checkbox]").prop("checked",true);
			}
		}else{
			for(var i=0; i < tr.length; i++){
				$("td",tr.eq(i)).eq(0).find("input[type=checkbox]").prop("checked",false);
			}
		}		
	});
	
	//추가하기 버튼 클릭
	$("button[name='addBtn']").click(function(){
		var LastTr = $("#cateTable > tbody:last-child");
		var addHTML = "";
		addHTML += "<tr>";
		addHTML += 	  "<td><label><input type='checkbox'  name='row-idx' value='' style='top: 9px;' /></label></td>";
		addHTML += 	  "<td><input type='text' class='form-control' name='code' value=''></td>";
		addHTML += 	  "<td><input type='text' class='form-control' name='name' value=''></td>";
		addHTML += 	  "<td><input type='text' class='form-control' name='kname' value=''></td>";
		addHTML += "</tr>";
		LastTr.append(addHTML);
	});	
	
	//삭제하기 버튼 클릭
	$("button[name='deleteBtn']").click(function(){
		
		var _d = new Array();
		var deleteTrs = 0;
		
		$('input:checkbox[name="row-idx"]').each(function(index, item){
			if(this.checked){
				if($(this).val() != "" && $(this).val() != null){
					_d.push($(this).val());
				}
				$(this).parents("tr").remove();
				deleteTrs ++;
			}
		});
		
		if(_d.length == 0 && deleteTrs == 0){
			alert("선택된 카테고리가 없습니다.");
			return false;
		}else if(_d.length == 0 && deleteTrs > 0){
			return false;
		}
		
		if(confirm("카테고리 삭제 시 관련 상품도 삭제가 됩니다. 정말 삭제하시겠습니까?")){
			$.ajax({
				url : "/admin/deleteParentsCategory",
				method : "post",
				traditional : true,
				data : {"codes" : _d},
				success : function(result){
					if(result > 0){
						alert("삭제되었습니다.");						
					}else{
						alert("시스템 에러");
					}
					document.location.reload();
				}
			});
		}
		$("input[name=row-idx-all]").prop("checked",false);
	});
	
	//저장버튼 클릭시
	$("button[name='saveBtn']").click(function(){
		var form = $("#form");
		form.submit();
	});
}

$(document).ready(function(){
	EventFunction();
})


</script>
</html>