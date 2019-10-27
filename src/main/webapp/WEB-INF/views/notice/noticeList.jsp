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
    <link rel="stylesheet" href="/css/notice.css">
</head>
<body>

<script type="text/javascript">
    $(document).ready(function() {
    
        $(".check-all").click(function() {
            $(".check-order").prop("checked", this.checked);
        });
    });
    
    function changeEmail() {
        var select_email = $("#select_email").val();
        $("#email").val(select_email);
    }
</script>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%;">

    <!-- Notice Start -->
    <div class="row">
        <div class="col-md-10 col-md-offset-1 noticeLabel-row">
            <p>NOTICE</p>
        </div>
    </div> <!-- row -->

    <div class="row" style="margin-bottom: 150px;">
        <div class="col-md-10 col-md-offset-1">
            <table class="table notice-board">
                <thead>
                    <tr>
                        <td>NO</td>
                        <td>TITLE</td>
                        <td>NAME</td>
                        <td>DATE</td>
                        <td>HIT</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <!-- NO -->
                        <td>2</td>
                        <!-- TITLE -->
                        <td><a href="/notice/noticeView">회원 등급제에 관하여 설명 드릴게요!</a></td>
                        <!-- NAME -->
                        <td>모서리</td>
                        <!-- DATE -->
                        <td>2019-10-14 12:52:29</td>
                        <!-- HIT -->
                        <td>5589</td>
                    </tr>
                    <tr>
                        <!-- NO -->
                        <td>1</td>
                        <!-- TITLE -->
                        <td><a href="/notice/noticeView">모서리를 오픈하며...</a></td>
                        <!-- NAME -->
                        <td>모서리</td>
                        <!-- DATE -->
                        <td>2019-10-14 12:50:29</td>
                        <!-- HIT -->
                        <td>7798</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="col-md-10 col-md-offset-1 pagination-div" style="margin-bottom: 30px;">
            <nav>
                <ul class="pagination">
                    <li>
                    <a href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                    </li>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li>
                    <a href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                    </li>
                </ul>
            </nav>
        </div>

        <div class="col-md-10 col-md-offset-1">
            <span class="form-inline search-area">
                                   검색어
                <select class="form-control" style="width: 130px">
                    <option value="subject">제목</option>
                    <option value="content">내용</option>
                    <option value="subject_Content">제목 + 내용</option>
                </select>
                <div class="form-group">
                    <input type="text" class="form-control" style="width: 180px;" />
                    <button class="btn btn-default"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                </div>  
            </span>
        </div>

    </div> <!-- row -->
    <!-- Notice End -->

	<%@ include file="../includes/footer.jsp" %>
	        
</div>

</body>
</html>