<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 16.
  Time: 오후 3:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

</style>

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
                <p class="card-text">분류 : ${bDto.sb_category}</p>
                <p class="card-text">가격 : ${bDto.sb_price}</p>
                <p class="card-text">지역 : ${bDto.sb_local}</p>
                <p class="card-text">날짜 : ${bDto.sb_date}</p>
                <p>판매자 : ${bDto.sb_id}</p>
                <div id="timer"></div>
                <form action="/board/attend" method="post" class="bid_form">
                    <div class="d-grid gap-2 d-md-block mb-3">
                        <a href="/board/mySalesCart?sb_num=${bDto.sb_num}" class="btn btn-primary" role="button">장바구니</a>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#now-buy">구매신청</button>
                        <input type="hidden" name="sb_num" value="${bDto.sb_num}">
                    </div>
                </form>
                <form action="#">
                    <input type="hidden" name="h_o_p_num" value="${bDto.sb_num}">

                    <input type="button" id="reset-button" class="btn btn-primary" value="삭제하기" onclick="deleteBtn()">

                </form>
            </div>
        </div>
    </div>
</div>

<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <a href="/board/marketList" class="btn btn-primary" role="button">목록으로</a>
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
    const user = '<sec:authentication property="name"/>';

    if (user === joinId) {
        $('#reset-button').show();
    } else {
        $('#reset-button').hide();
    }

    function deleteBtn() {
        location.href = "/board/marketDelete?sb_num="+${bDto.sb_num}
    }


</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
