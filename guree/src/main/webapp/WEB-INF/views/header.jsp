<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 5.
  Time: 오후 1:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<html>
<head>
    <title>Title</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>



    <style>
        @font-face {
            font-family: 'LINESeedKR-Bd';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        .article-t {
            font-family: 'LINESeedKR-Bd';
        }

        body {
            width: 100%;
            max-width: 100%;
            min-width: 1900px;
            overflow: scroll;
            margin: 0 auto;

        }
        .d-flex{
        margin: 1px;

        }

        .container {
            text-align: center;
        }

        #calendar {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 5px;
            margin: 20px auto;
            width: 80%;
        }

        .calendar-day {
            position: relative;
            border: 1px solid #ccc;
            padding: 14px;
            text-align: center;
            border-radius: 5px;
            cursor: pointer;
            background-color: #fff;
            transition: background-color 0.3s;
        }

        .calendar-day.attended {
            background-color: #90ee90;
        }

        .calendar-day:hover {
            background-color: #f0f0f0;
        }

        .calendar-day::before {
            content: attr(data-date);
            position: absolute;
            top: 5px;
            left: 5px;
            font-size: 0.8em;
            color: #666;
        }

    </style>

</head>
<body>
<header class="w-75 mt-3 mb-5 mx-auto">
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">
                <img src="/img/logo.png" style="width: 150px;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 article-t">
                    <li class="nav-item">
                        <a class="nav-link display-4" href="/board/marketList?pageNum=1">중고거래</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link display-4" href="/board/auctionList?pageNum=1">경매</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link display-4" href="#">핫딜</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link display-4" href="/notice/list">공지사항</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle display-4" role="button" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            고객지원
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">자주묻는질문</a></li>
                            <li><a class="dropdown-item" href="/report/list">문의하기</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                        </ul>
                    </li>
                </ul>
                <div class="d-flex">
                    <input id="header-keyWord" class="form-control me-2" type="search" placeholder="검색" aria-label="Search">
                    <button id="header-search" class="btn btn-primary" type="button"><i class="bi bi-search"></i></button>
                </div>
            </div>
        </div>
    </nav>
    <div class="d-flex justify-content-end">
        <div class="d-flex">
            <ul class="nav nav-pills">
                <li class="nav-item">
                    <sec:authorize access="isAnonymous()">
                        <a class="nav-link" href="/member/login">로그인</a>
                    </sec:authorize>


                </li>
                <li class="nav-item">
                    <sec:authorize access="isAnonymous()">
                        <a class="nav-link" href="/member/joindetail">회원가입</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link disabled" aria-disabled="true"><sec:authentication property="name"/>님</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="isAuthenticated()">
                        <button class="nav-link" onclick="btn_logout()">로그아웃</button>
                    </sec:authorize>
                </li>
                <li class="nav-item">

                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link" aria-current="page" href="/member/myPage">마이페이지</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">

                    <sec:authorize access="hasRole('admin')">
                        <a class="nav-link" aria-current="page" href="/member/admin">관리자페이지</a>
                    </sec:authorize>
                </li>
                <li class="nav-item dropdown">
                    <sec:authorize access="isAuthenticated()">

                        <a class="nav-link" aria-expanded="false" href="/member/attendance">출석체크</a>

                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link" href="/member/chat">채팅하기</a>
                    </sec:authorize>
                </li>
            </ul>
        </div>
    </div>

</header>
<script>
    $("#header-search").click(function () {
        let keyword = $("#header-keyWord").val();
        if (keyword === "") {
            alert("검색어를 입력하세요.");
            return;
        }
        location.href ="/board/allList?&keyWord="+keyword+"&pageNum=1";
    })

    $("#header-keyWord").keydown(function (e) {
        if (e.key === "Enter") { // Enter 키
            e.preventDefault(); // 기본 Enter 동작 방지
            $("#header-search").click();
        }
    });

    function btn_logout(){

      if(confirm("로그아웃 하시겠습니까?"))  {
            location.href="/member/logout";
        }

    }
</script>


</body>
</html>
