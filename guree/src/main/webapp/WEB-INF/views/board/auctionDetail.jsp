<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 8.
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

</head>
<style>

    .carousel-item{

        margin: auto;
        width: auto; /* 너비를 자동으로 조정하여 가로 세로 비율 유지 */
        height: auto; /* 높이를 자동으로 조정하여 가로 세로 비율 유지 */


    }
    .carousel-inner{
        display: flex;
        align-items: center;
        justify-content: center;
    }
    #product-detail {
        width: 450px;
        height: 500px;
    }
    .allDiv-box{
        height: 600px;

    }

    .carousel-item img {
        max-height: 500px; /* 높이를 자동으로 조정하여 가로 세로 비율 유지 */

    }
    .carousel-control-prev-icon{
        background-color: #cccccc;
    }
    .carousel-control-next-icon{
        background-color: #cccccc;
    }


</style>
<script>

    $(() => {
        const msg = '${successMsg}'
        if (msg)

            alert('${successMsg}')


    })


    function userbtnclic() {
        if (joinId === user) {
            alert("판매자는 경매에 참여할 수 없습니다.")

        } else {
            $('.bid_form').submit();
        }
    }




</script>
<script>
    $(() => {
    const msg = '${msg}';
    if (msg !== '') {

        alert(msg);
    }
    })
</script>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<div class="card mb-3 w-75 mx-auto allDiv-box">
    <div class="row g-5">
        <div class="col-md-4">
            <div class="fileWide">
                <div id="carouselExample" class="carousel slide">
                    <div class="carousel-inner">
                        <c:forEach var="img" items="${file}" varStatus="loop">
                            <c:if test="${empty img.bf_sysFileName}">
                                <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                                <img src="/upload/프사없음.jfif" class="img-fluid rounded-start" alt="...">
                                </div>
                            </c:if>
                            <c:if test="${!empty img.bf_sysFileName}">
                                <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                                    <img src="/upload/${img.bf_sysFileName}" class="img-fluid rounded-start" alt="...">
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-body">
                <p class="card-text">상품설명</p>
                <p class="card-text" id="product-detail"><small class="text-body-secondary">${bDto.sb_contents}</small>
                </p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-body">
                <h5 class="card-title">상품명 : ${bDto.sb_title}</h5>
                <hr>
                <p class="card-text">즉시구매가 : ${bDto.sb_price}</p>
                <p class="card-text">시작가 : ${bDto.sb_startPrice}</p>
                <p class="card-text">현재가 : ${bDto.sb_nowPrice}</p>
                <p class="card-text">최소입찰가 : ${bDto.sb_bid}</p>
                <p class="card-text">경매시작일 : ${bDto.sb_date}</p>
                <p class="card-text">경매종료일 : ${bDto.sb_timer}</p>
                <p>판매자 : ${bDto.sb_id}</p>
                <p>현재 입찰 예정자 : ${bDto.a_joinId}</p>

                <div id="timer"></div>
                <form action="/board/attend" method="post" class="bid_form">
                    <div class="d-grid gap-2 d-md-block mb-3">
                        <a href="/board/myAuctionCart?sb_num=${bDto.sb_num}" class="btn btn-primary" role="button">장바구니</a>
                        <input type="hidden" name="sb_num" value="${bDto.sb_num}">
                        <input type="hidden" name="sb_nowPrice" value="${bDto.sb_nowPrice}">
                        <input type="hidden" name="sb_bid" value="${bDto.sb_bid}">

                        <input type="button" class="btn btn-primary" onclick="userbtnclic()" value="입찰하기">
                    </div>
                </form>
                <form action="#">
                    <input type="hidden" name="h_o_p_num" value="${bDto.sb_num}">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#now-buy">즉시구매</button>
                    <input type="button" id="reset-button" class="btn btn-primary" value="삭제하기" onclick="deleteBtn()">

                </form>
            </div>
        </div>
    </div>
</div>

<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <a href="/board/auctionList" class="btn btn-primary" role="button">목록으로</a>
</div>

<%--즉시구매--%>
<!-- Modal -->
<div class="modal fade" id="now-buy" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/board/buyNowGo">
                    <button class="btn btn-primary">
                        QR코드로 구매하기
                    </button>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>



<script>
    const joinId = '${bDto.sb_id}';
    const user = '<sec:authentication property="name"/>'



    if (user === joinId) {
        $('#reset-button').show();
    } else
    {
        $('#reset-button').hide();
    }



    function deleteBtn() {
        location.href = "/board/auctionDelete?sb_num="+${bDto.sb_num}
    }



</script>
<sec:authorize access="hasRole('admin')">
    <script>
        $('#reset-button').show();
    </script>
</sec:authorize>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
