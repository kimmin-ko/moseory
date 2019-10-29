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
    <link rel="stylesheet" href="/css/noticeView.css">
</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%;">

    <!-- NoticeView Start -->
    <div class="row" style="margin-top: 70px; margin-bottom: 30px;">

        <div class="col-md-10 col-md-offset-1 noticeLabel-row" style="margin-bottom: 50px;">
            <table class="table table-bordered noticeView-table">
                <tr>
                    <td class="view_title">제목</td>
                    <td colspan="3">회원 등급제에 관하여 설명 드릴게요!</td>
                </tr>
                <tr>
                    <td class="view_title">작성자</td>
                    <td colspan="3">모서리</td>
                </tr>
                <tr>
                    <td class="view_title">작성일</td>
                    <td>2019-10-14 00:35:27</td>
                    <td class="view_title">조회수</td>
                    <td>5481</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <img src="/images/notice2.jpg">
                    </td>
                </tr>
            </table>

            <button type="button" class="btn btn-default btn-sm" 
                onclick="location.href='/notice/noticeList'">목록</button>
        </div>
        
        <div class="col-md-10 col-md-offset-1">
            <table class="table table-bordered noticeOtherView-table">
                <tr>
                    <td class="otherView_title"><img src="/images/otherView_pre.jpg">이전글</td>
                    <td><a href="#">온라인 쇼핑몰에서 옷 실패 없이 사는 방법!</a></td>
                </tr>
                <tr>
                    <td class="otherView_title"><img src="/images/otherView_next.jpg">다음글</td>
                    <td><a href="#">모서리를 오픈하며...</a></td>
                </tr>
            </table>
        </div>

    </div> <!-- row -->
    <!-- NoticeView End -->

	<%@ include file="../includes/footer.jsp" %>
	        
</div>

</body>
</html>