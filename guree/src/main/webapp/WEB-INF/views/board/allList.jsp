<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 17.
  Time: 오후 4:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<style>


    .fileWide {
        display: flex;
        justify-content: center;
        overflow: hidden;
        width: 245px;
        height: 245px;

    }

    .fileWide img {
        width: 100%;
        height: 100%;
    }


</style>
<script>
    $(() => {
        const msg = '${msg}'
        if (msg)

            alert('${msg}')
    })
</script>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>

<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <h1>검색결과</h1>
</div>
<div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
    <c:forEach var="item" items="${bList}">
        <div class="col">
            <div class="card mb-3">
                <div class="row g-0">
                    <div class="col-md-4">
                        <div class="fileWide">

                            <c:forEach var="file" items="${item.bfList}" varStatus="loop">
                                <c:if test="${file.bf_sysFileName eq ''}">
                                    <img src="/upload/프사없음.jfif" class="img-fluid rounded-start" alt="...">
                                </c:if>
                                <c:if test="${!empty file.bf_sysFileName}">
                                    <div>
                                        <img src="/upload/${file.bf_sysFileName}"
                                             class="img-fluid rounded-start ${loop.index == 0 ? '' : 'img-none' }"
                                             alt="...">
                                    </div>
                                </c:if>
                            </c:forEach>

                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card-body">
                            <h5 class="card-title">
                                <c:if test="${item.sb_saleKind == 2}">
                                   <div>중고거래</div>
                                    <a href="/board/marketDetail?sb_num=${item.sb_num}" class="stretched-link">${item.sb_title}</a>
                                </c:if>
                                <c:if test="${item.sb_saleKind == 1}">
                                    <div>경매</div>
                                <a href="/board/auctionDetail?sb_num=${item.sb_num}" class="stretched-link">${item.sb_title}</a>
                                </c:if>


                            </h5>
                            <p class="card-text">분류:${item.sb_category}</p>
                            <p class="card-text">가격:${item.sb_price}</p>
                            <p class="card-text">시작가:${item.sb_startPrice}</p>
                            <p class="card-text">현재가:${item.sb_nowPrice}</p>
                            <p class="card-text">조회수:${item.sb_view}</p>

                            <p class="card-text"><small class="text-body-secondary">${item.sb_contents}</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<div class="pagination justify-content-center mt-4">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <!-- Previous button -->
            <li class="page-item <c:if test='${startPage == 1}'> disabled </c:if>'">
                <a class="page-link" href="?pageNum=${startPage - pageCount}" aria-label="Previous">
                    이전
                </a>
            </li>
            <!-- Page numbers -->
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li class="page-item<c:if test='${currentPage == i}'> active </c:if>'" aria-current="page">
                    <a class="page-link" href="?pageNum=${i}">${i}</a>
                </li>
            </c:forEach>
            <!-- Next button -->
            <li class="page-item <c:if test='${endPage == totalPages}'> disabled </c:if>'">
                <a class="page-link" href="?pageNum=${endPage + 1}" aria-label="Next">
                    다음
                </a>
            </li>
        </ul>
    </nav>
</div>


<script>
    $(document).ready(function () {
        ($('.img-none')).hide();


    });
</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>