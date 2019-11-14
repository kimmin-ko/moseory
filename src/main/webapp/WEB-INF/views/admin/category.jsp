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
    <link rel="stylesheet" href="/css/category.css">
</head>
<body>
    
<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%">

    <!-- Manage Start -->
    <div class="row category">

		 <!-- MANAGE-header Start -->
        <div class="col-md-10 col-md-offset-1 category-header text-center">
            <p>CATEGORY</p>
		</div>
		<!-- Manage-header End -->

		<!-- Manage-body Start -->
		<div class="col-md-6 col-md-offset-3 category-body">
			<table class="table table-striped">
				<thead>
			        <tr>
			          <th>상위 카테고리 목록</th>
			        </tr>
		    	</thead>
				<tbody> 
					<tr>
						<td>outer</td>
						<td><span class="glyphicon glyphicon-zoom-in" aria-hidden="true" ></span></td>
					</tr>
					<tr>
						<td>outer</td>
						<td><span class="glyphicon glyphicon-zoom-in" aria-hidden="true" ></span></td>
					</tr>
					<tr>
						<td>outer</td>
						<td><span class="glyphicon glyphicon-zoom-in" aria-hidden="true" ></span></td>
					</tr>
					<tr>
						<td>outer</td>
						<td><span class="glyphicon glyphicon-zoom-in" aria-hidden="true" ></span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- Manage-body End -->
    </div>  
    <!-- Manage End -->

	<%@ include file="../includes/footer.jsp" %>
	
</div>
</body>
</html>