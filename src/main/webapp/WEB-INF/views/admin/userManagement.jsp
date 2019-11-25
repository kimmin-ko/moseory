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
    <link rel="stylesheet" href="/css/userManagement.css">
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

    <!-- UserManagement Start -->
    <div class="row userManagement">

		 <!-- UserManagement-header Start -->
        <div class="col-md-10 col-md-offset-1 userManagement-header text-center">
            <p>USER MANAGEMENT</p>
		</div>
		<!-- UserManagement-header End -->
		<div class="col-md-10 col-md-offset-1 userManagement-searchBox">
	        <h6>검색 옵션</h6>
			<div class="col-md-10 col-md-offset-1 userManagement-searchBar">
	            <table>
	            	<tr>
	            		<td><select name="searchType"  class="form-control">
	            			<option value="id">ID</option>
	            			<option value="name">Name</option>
	            		</select></td>
	            		<td style="padding-right:100px;"><input type="text" name="searchValue" class="form-control"></td>
	            		<td>
	            			<h6>LEVEL</h6> 
	            		</td>
	            		<td style="padding-left:10px;">
	            			<select name="gradeType"  class="form-control">
	            				<option value="all">전체</option>
		            			<option value="5">VVIP</option>
		            			<option value="4">VIP</option>
		            			<option value="3">GOLD</option>
		            			<option value="2">SILVER</option>
		            			<option value="1">BRONZE</option>
	            			</select>
	            		</td>
	            	</tr>
	            	<tr>
						<td><select name="commType"  class="form-control">
	            			<option value="phone">Phone</option>
	            			<option value="tel">Tel</option>
	            		</select></td>
	            		<td style="padding-right:100px;"><input type="text" name="searchValue" class="form-control"></td>
	            		<td>
	            			<h6>EMAIL</h6>
	            		</td>
	            		<td style="padding-left:10px;">
	            			<input type="text" name="email" class="form-control" value="">
	            		</td>
	            	</tr>
	            </table>
				<button type="button" class="btn btn-default btn-sm" style="float:right; margin-bottom:10px;"name="searchBtn">검색</button>
			</div>
		</div>
		<!-- UserManagement-body Start -->
		
		<form id="form" method="post" action="">		
			<div class="col-md-10 col-md-offset-1 userManagement-body">
				<table class="table table-responsive" id="cateTable">
					<colgroup>
						<col width="5%" />
						<col width="20%" />
						<col width="15%" />
						<col width="20%" />
						<col width="30%" />
						<col width="10%" />
					</colgroup>
					<thead>
				        <tr>
				          <th>No</th>
				          <th>ID</th>
				          <th>NAME</th>
				          <th>PHONE</th>
				          <th>EMAIL</th>
				          <th>GREDE</th>
				        </tr>
			    	</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>m3252</td>
							<td>문승찬</td>
							<td>010-4586-3362</td>
							<td>m3252@naver.com</td>
							<td>브론즈</td>
						</tr>
						<tr>
							<td>1</td>
							<td>m3252</td>
							<td>문승찬</td>
							<td>010-4586-3362</td>
							<td>m3252@naver.com</td>
							<td>브론즈</td>
						</tr>
						<tr>
							<td>1</td>
							<td>m3252</td>
							<td>문승찬</td>
							<td>010-4586-3362</td>
							<td>m3252@naver.com</td>
							<td>브론즈</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
		<!-- UserManagement-body End -->
    </div>  
    <!-- UserManagement End -->

	<%@ include file="../includes/footer.jsp" %>
	
</div>
</body>
<script>


</script>
</html>