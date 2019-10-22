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
    <link rel="stylesheet" href="/css/sidebar.css">
    <link rel="stylesheet" href="/css/footer.css">
    <link rel="stylesheet" href="/css/productInfoForm.css">
</head>
<body>

<%@ include file="../includes/sidebar.jsp" %>

<div class="container" style="margin-left:22%;">

    <!-- Product Info Form Start -->
    <div class="row" style="margin-top: 60px; margin-bottom: 150px;">

        <div class="col-md-7 product_image">
            <img class="prod-img" src="/images/1.jpg">

            <ul class="prod-info-list">
                <li>DETAIL</li>
                <li>INFO</li>
                <li>REVIEW(0)</li>
                <li>Q&A(0)</li>
            </ul>
        </div>
            
        <div class="col-md-5" class="prod-detail-info">
            <div class="ft-size-12">포니 헨리넥 셔츠<br>37,000원</div>
            <br>
            <div class="info-title">COMMENT</div>
            <p class="ft-size-12">
                적당한 두께감으로 4계절 내내 입을수 있는 셔츠입니다^^! 여름에 입기에 너무 두껍지 않고 딱 적당한 두께라 팔 걷고 슬랙스, 데님이랑 매칭하기 좋은 상품입니다. 가을에는 아우터와 함께 매치하기 이쁜 상품으로 포인트 주기 딱 좋은 제품 아닌가 싶습니다!
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

            <span class="ft-size-12">컬러</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <select class="ft-size-12 prod-option">
                <option>-[필수] 옵션을 선택해 주세요.</option>
                <option>---------------</option>
                <option>네이비</option>
                <option>베이지</option>
            </select>

            <p class="ft-size-12">(최소주문수량 1개 이상)</p>

            <hr style="border: 0.5px solid #B5B5B5">

            <p>TOTAL : <span class="prod-price">0원</span>(<span class="prod-quantity">0개</span>)</p>
            
            <hr style="border: 0.5px solid #DFDFDF">

            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg btn-buy">BUY NOW</button>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg">ADD TO CART</button>
            </div>
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-lg">WISH LIST</button>
            </div>

        </div>

    </div> <!-- row -->

    <div class="row" style="margin-bottom: 150px;">
        <div class="col-md-10 col-md-offset-1">
            <img src="/images/detail-view_01.jpg">
        </div>
    </div> <!-- row -->

    <div class="row" style="margin-bottom: 150px;">

        <div class="col-md-10 col-md-offset-1 review-header"> <!-- review header -->
            <p>Review(250)</p>
            <ul>
                <li>최신순</li>
                <li>댓글순</li>
                <li>추천순</li>
                <li>높은평점순</li>
                <li>낮은평점순</li>
            </ul>
        </div> <!-- review header -->
       
        <div class="col-md-10 col-md-offset-1 review-body">  <!-- review body start -->
            <p>
                <span>[BRONZE]</span>
                <span>min00</span><span style="color: #B5B7BA;"> | </span>
                <span class="review-date">2019.10.13 18:08</span><span style="color: #B5B7BA;"> | </span>
                <span class="review-grade">4.5</span>
            </p>

            <hr style="border: 0.5px #7F858A solid;">

            <div class="col-md-1"><img src="/images/1.jpg"></div>
            <div class="col-md-11 review-body-prod-name">
                포니 헨리넥 셔츠<br>
                [옵션 : 베이지]
            </div>

            <div class="col-md-12 review-title">
                <p>최고예요</p>
            </div>

            <div class="col-md-12 review-content">
                <p>
                    감사원은 원장을 포함한 5인 이상 11인 이하의 감사위원으로 구성한다. 
                    군인은 현역을 면한 후가 아니면 국무위원으로 임명될 수 없다. 
                    비상계엄하의 군사재판은 군인·군무원의 범죄나 군사에 관한 간첩죄의 경우와 초병·초소·유독음식물공급·포로에 관한 죄중 법률이 정한 경우에 한하여 단심으로 할 수 있다. 
                    다만, 사형을 선고한 경우에는 그러하지 아니하다.
                </p>
            </div>

            <div class="col-md-12 review-like">
                <button type="button" class="btn btn-warning">리뷰 추천 !!</button>
            </div>

            <div class="col-md-12 review-reply form-inline">
                <input type="text" class="form-control" style="width: 85%" />
                <button class="btn btn-default">댓글 작성</span></button>
            </div>

        </div> <!-- review body end -->

        <div class="col-md-10 col-md-offset-1 review-body">  <!-- review body start -->
            <p>
                <span>[BRONZE]</span>
                <span>min00</span><span style="color: #B5B7BA;"> | </span>
                <span class="review-date">2019.10.13 18:08</span><span style="color: #B5B7BA;"> | </span>
                <span class="review-grade">4.5</span>
            </p>

            <hr style="border: 0.5px #7F858A solid;">

            <div class="col-md-1"><img src="/images/1.jpg"></div>
            <div class="col-md-11 review-body-prod-name">
                포니 헨리넥 셔츠<br>
                [옵션 : 베이지]
            </div>

            <div class="col-md-12 review-title">
                <p>최고예요</p>
            </div>

            <div class="col-md-12 review-content">
                <p>
                    감사원은 원장을 포함한 5인 이상 11인 이하의 감사위원으로 구성한다. 
                    군인은 현역을 면한 후가 아니면 국무위원으로 임명될 수 없다. 
                    비상계엄하의 군사재판은 군인·군무원의 범죄나 군사에 관한 간첩죄의 경우와 초병·초소·유독음식물공급·포로에 관한 죄중 법률이 정한 경우에 한하여 단심으로 할 수 있다. 
                    다만, 사형을 선고한 경우에는 그러하지 아니하다.
                </p>
            </div>

            <div class="col-md-12 review-like">
                <button type="button" class="btn btn-warning">리뷰 추천 !!</button>
            </div>

            <div class="col-md-12 review-reply form-inline">
                <input type="text" class="form-control" style="width: 85%" />
                <button class="btn btn-default">댓글 작성</span></button>
            </div>

        </div> <!-- review body end -->

        <div class="col-md-10 col-md-offset-1 qna-header"> <!-- Q&A header -->
            <p>Q & A(96)</p>
        </div> <!-- Q&A header -->

        <div class="col-md-10 col-md-offset-1 qna-body">
            <table class="table">
                <thead>
                    <tr>
                        <td>번호</td>
                        <td>카테고리</td>
                        <td>제목</td>
                        <td>작성자</td>
                        <td>작성일</td>
                        <td>조회</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <!-- 번호 -->
                        <td>2</td>
                        <!-- 카테고리 -->
                        <td></td>
                        <!-- 제목 -->
                        <td>상품문의 할게요</td>
                        <!-- 작성자 -->
                        <td>김****</td>
                        <!-- 작성일 -->
                        <td>2019-10-14</td>
                        <!-- 조회 -->
                        <td>5</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td></td>
                        <td>상품문의 할게요!!</td>
                        <td>문****</td>
                        <td>2019-09-29</td>
                        <td>7</td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div> <!-- row -->

    <!-- Product Info Form End -->
	
	<%@ include file="../includes/footer.jsp" %>
        
</div> <!-- container -->

</body>
</html>