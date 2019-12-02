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
<link rel="stylesheet" href="/css/qnaGet.css">
</head>
<body>

	<%@ include file="../includes/sidebar.jsp"%>
	
	<div class="container" style="margin-left: 22%;">
	
	    <!-- NoticeView Start -->
	    <div class="row" style="margin-top: 70px; margin-bottom: 30px;">
	
	        <div class="col-md-10 col-md-offset-1 noticeLabel-row" style="margin-bottom: 50px;">
	            <table class="table table-bordered noticeView-table">
	                <tr>
	                    <td class="tbl_header">제목</td>
	                    <td colspan="3"></td>
	                </tr>
	                <tr>
	                    <td class="tbl_header">작성자</td>
	                    <td colspan="3"></td>
	                </tr>
	                <tr>
	                    <td class="tbl_header">작성일</td>
	                    <td></td>
	                    <td class="tbl_header">조회수</td>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td colspan="4">
	                        <img src="images/notice2.jpg">
	                    </td>
	                </tr>
	            </table>
	
	            <button type="button" class="btn btn-default btn-sm" 
	                onclick="location.href='notice.html'">목록</button>
	        </div>
	        
	        <div class="col-md-10 col-md-offset-1">
	            <table class="table table-bordered noticeOtherView-table">
	                <tr>
	                    <td class="otherView_title"><img src="images/otherView_pre.jpg">이전글</td>
	                    <td>온라인 쇼핑몰에서 옷 실패 없이 사는 방법!</td>
	                </tr>
	                <tr>
	                    <td class="otherView_title"><img src="images/otherView_next.jpg">다음글</td>
	                    <td>모서리를 오픈하며...</td>
	                </tr>
	            </table>
	        </div>
	
	    </div>
	    <!-- NoticeView End -->
		
		<%@ include file="../includes/footer.jsp" %>
	
	</div>

</body>
</html>