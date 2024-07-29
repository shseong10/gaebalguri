<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 5.
  Time: 오후 1:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<html>
<head>
    <title>Title</title>
</head>
<style>
    body {
        width: 100%;
        max-width: 100%;
        min-width: 1900px;

        overflow: scroll;
        margin: 0 auto;

    }

</style>
<body>
<section class="w-75 mx-auto mb-5">
    <h1 class="article-t">추천상품</h1>
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <c:forEach var="item" items="${items}">
            <div class="col">
                <div class="card h-100">

                    <c:set var="firstFile" value="${null}"/>
                    <c:forEach var="file" items="${files}">
                        <c:if test="${item.sb_num == file.bf_sb_num && empty firstFile}">
                            <c:set var="firstFile" value="${file}"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${not empty firstFile}">
                        <img src="/upload/${firstFile.bf_sysFileName}" class="card-img-top" alt="...">
                    </c:if>

                    <c:if test="${item.sb_saleKind == 1}">
                        <div class="card-body">
                            <div>경매</div>
                            <a href="/board/auctionDetail?sb_num=${item.sb_num}" class="stretched-link"><h5
                                    class="card-title">상품명 : ${item.sb_title}</h5>
                                <p class="card-text">가격 :${item.sb_price} </p></a>
                        </div>
                        <div class="card-footer">
                            <small class="text-body-secondary">${item.sb_local}</small>
                        </div>
                    </c:if>
                    <c:if test="${item.sb_saleKind == 2}">
                        <div class="card-body">
                            <div>중고상품</div>
                            <a href="/board/marketDetail?sb_num=${item.sb_num}" class="stretched-link"><h5
                                    class="card-title">상품명 : ${item.sb_title}</h5>
                                <p class="card-text">가격 :${item.sb_price} </p></a>
                        </div>
                        <div class="card-footer">
                            <small class="text-body-secondary">${item.sb_local}</small>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
        <%--            <div class="col">--%>
        <%--                <div class="card h-100">--%>
        <%--                    <img src="/img/product_sample_02.png" class="card-img-top" alt="...">--%>
        <%--                    <div class="card-body">--%>
        <%--                        <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>--%>
        <%--                            <p class="card-text">가격</p></a>--%>
        <%--                    </div>--%>
        <%--                    <div class="card-footer">--%>
        <%--                        <small class="text-body-secondary">인천광역시 미추홀구</small>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--            <div class="col">--%>
        <%--                <div class="card h-100">--%>
        <%--                    <img src="/img/product_sample_03.png" class="card-img-top" alt="...">--%>
        <%--                    <div class="card-body">--%>
        <%--                        <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>--%>
        <%--                            <p class="card-text">가격</p></a>--%>
        <%--                    </div>--%>
        <%--                    <div class="card-footer">--%>
        <%--                        <small class="text-body-secondary">인천광역시 미추홀구</small>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--            <div class="col">--%>
        <%--                <div class="card h-100">--%>
        <%--                    <img src="/img/product_sample_04.png" class="card-img-top" alt="...">--%>
        <%--                    <div class="card-body">--%>
        <%--                        <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>--%>
        <%--                            <p class="card-text">가격</p></a>--%>
        <%--                    </div>--%>
        <%--                    <div class="card-footer">--%>
        <%--                        <small class="text-body-secondary">인천광역시 미추홀구</small>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>

    </div>
</section>

</body>
</html>
