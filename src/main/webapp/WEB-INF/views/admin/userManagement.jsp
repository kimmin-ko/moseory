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
	        <form method="get" action="userManagement">
				<div class="col-md-10 col-md-offset-1 userManagement-searchBar">
		            <table>
		            	<tr>
		            		<td><select name="searchType"  class="form-control">
		            			<option value="id">ID</option>
		            			<option value="name">Name</option>
		            		</select></td>
		            		<td style="padding-right:100px;"><input type="text" name="searchValue" value="${searchValue}" class="form-control"></td>
		            		<td>
		            			<h6>LEVEL</h6> 
		            		</td>
		            		<td style="padding-left:10px;">
		            			<select name="levelType"  class="form-control">
		            				<option value="all">전체</option>
			            			<option value="5" <c:if test="${levelType == '5'}">selected</c:if> >VVIP</option>
			            			<option value="4" <c:if test="${levelType == '4'}">selected</c:if> >VIP</option>
			            			<option value="3" <c:if test="${levelType == '3'}">selected</c:if> >GOLD</option>
			            			<option value="2" <c:if test="${levelType == '2'}">selected</c:if> >SILVER</option>
			            			<option value="1" <c:if test="${levelType == '1'}">selected</c:if> >BRONZE</option>
		            			</select>
		            		</td>
		            	</tr>
		            	<tr>
							<td><select name="commType"  class="form-control">
		            			<option value="phone" <c:if test="${commType == 'phone'}">selected</c:if> >Phone</option>
		            			<option value="tel" <c:if test="${commType == 'tel'}">selected</c:if>>Tel</option>
		            		</select></td>
		            		<td style="padding-right:100px;"><input type="text" name="commValue" value="${commValue }" class="form-control"></td>
		            		<td>
		            			<h6>EMAIL</h6>
		            		</td>
		            		<td style="padding-left:10px;">
		            			<input type="text" name="searchEmail" class="form-control" value="${searchEmail }">
		            		</td>
		            	</tr>
		            </table>
					<button type="submit" class="btn btn-default btn-sm" style="float:right; margin-bottom:10px;"name="searchBtn">검색</button>
				</div>
	        </form>
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
						<c:forEach var="model" items="${userList}" varStatus="status">
							<tr onclick="javascript:ref('${model.id}');">
								<td>${model.rnum}</td>
								<td>${model.id}</td>
								<td>${model.name}</td>
								<td>${model.phone}</td>
								<td>${model.email}</td>
								<td>${model.level}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
		<!-- UserManagement-body End -->
		<!-- paging Start -->
		<div class="col-md-10 col-md-offset-1 pagination-div" style="margin-bottom: 30px;">
			<nav>
				<ul class="pagination">
					<c:if test="${paging.curBlock ne 1 }">
						<li class ="button_first"><a href="${pageContext.request.contextPath }/admin/userManagement?curPage=${paging.startPage }">처음</a></li>
					</c:if>
					<c:if test="${paging.curPage ne 1 }">
						<li class ="button_previous"><a href="${pageContext.request.contextPath }/admin/userManagement?curPage=${paging.prevPage }">이전</a></li>
					</c:if>
					<c:forEach var = "pageNumber" begin = "${paging.startPage }" end = "${paging.endPage }">
						<c:choose>
							<c:when test="${pageNumber eq paging.curPage }">
								<li class ="paginate_button active"><span>${pageNumber }</span></li>
							</c:when>
							<c:otherwise>
								<li class ="paginate_button"><a href = "${pageContext.request.contextPath }/admin/userManagement?curPage=${pageNumber}&searchType=${searchType}&keyword=${keyword}">${pageNumber }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test = "${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">	
						<li class ="button_next"><a href="${pageContext.request.contextPath }/admin/userManagement?curPage=${paging.nextPage }">다음</a></li>
					</c:if>
					<c:if test = "${paging.curBlock ne paging.blockCnt && paging.blockCnt > 0 }">
						<li class ="button_end"><a href="${pageContext.request.contextPath }/admin/userManagement?curPage=${paging.endPage }">끝</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
		<!-- paging End -->
    </div>  
    <!-- UserManagement End -->

	<%@ include file="../includes/footer.jsp" %>
	
</div>
</body>
<script>
function ref(userId){
	document.location.href="/admin/getUserDetail?id="+userId;
}

$(document).ready(function(){

})
</script>
</html>