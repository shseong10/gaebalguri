<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 5.
  Time: 오후 1:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    body{
        width: 100%;
        max-width: 100%;
        min-width: 1900px;

        overflow: scroll;
        margin: 0 auto;

    }

</style>
<body>
<nav class="w-75 mx-auto mb-5">
    <h1 class="article-t">광고상품</h1>
    <div class="row row-cols-1 row-cols-md-3 g-3">
        <div class="col">
            <div class="card h-100">
                <img src="/img/product_sample_01.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>
                        <p class="card-text">가격</p></a>
                </div>
                <div class="card-footer">
                    <small class="text-body-secondary">인천광역시 미추홀구</small>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <img src="/img/product_sample_02.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>
                        <p class="card-text">가격</p></a>
                </div>
                <div class="card-footer">
                    <small class="text-body-secondary">인천광역시 미추홀구</small>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <img src="/img/product_sample_03.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>
                        <p class="card-text">가격</p></a>
                </div>
                <div class="card-footer">
                    <small class="text-body-secondary">인천광역시 미추홀구</small>
                </div>
            </div>
        </div>
    </div>
</nav>
</body>
</html>
