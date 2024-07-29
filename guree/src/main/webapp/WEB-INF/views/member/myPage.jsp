<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 8.
  Time: 오전 8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>

        .profile-picture {
            width: 200px;
            height: 200px;
            border: 2px solid violet;
            padding: 5px;
            border-radius: 20px;
            margin: 0px 20px 0 20px;

        }

        .info-title {
            margin: 0 0 20px 0;
        }


        img {
            max-width: 100%;

            max-height: 100%;

        }

        .profile-update {
            display: flex;
            justify-content: center;
            margin: 10px;
        }

        .profile-info {
            font-size: 25px;
            font-weight: 600;
            margin: 10px 0 0 0;
        }

        .profile-info-all {
            margin: 0 0 0 20px;

        }

        .font-right {
            display: flex;
            justify-content: left;
        }
        .profile-btn{
            display: flex;
            justify-content: center;
            align-content: center;
            margin: 20px 0 0 0;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>

</header>

<div class="container-lg">
    <div class="font-right">
        <h2 class="article-t">마이페이지</h2>
    </div>
    <div class="row" style="margin-top:50px;">

        <div class="col-sm-4">
            <div class="info-title">
                <h1>Profile</h1>
            </div>
            <div class="rounded float-start">
                <!-- Button trigger modal -->
                <div class="container-sm profile-picture" data-bs-toggle="modal" data-bs-target="#profile-up">
                    <c:if test="${empty profile.pf_oriFileName}">
                        <img src="/upload/프사없음.jfif" width="200px">
                    </c:if>
                    <c:if test="${!empty profile.pf_oriFileName}">
                        <img src="/upload/${profile.pf_sysFileName}" width="200px">
                    </c:if>
                </div>

            </div>

            <div class="profile-info">NAME</div>
            <div>${profile.m_name}</div>
            <div class="profile-info">LEVEL</div>
            <div>${profile.p_level}</div>
            <div class="profile-info">TOTAL POINT</div>
            <div>${profile.m_sumPoint}P</div>

        </div>
        <div class="col-sm-1">
            <div class="d-flex" style="height: 100%;">
                <div class="vr"></div>
            </div>
        </div>
        <div class="col">
            <div class="info-title">
                <h1 style="display: inline;">Management</h1>
                <div class="float-end">
                    <a class="btn btn-primary" href="/member/infoUpdate">정보수정</a>
                </div>
            </div>
            <div class="profile-info-all">
                <div class="profile-info">계좌</div>
                <div>5484686484646</div>
                <div class="profile-info">주소지</div>
                <div>${profile.m_addr}</div>
            </div>
            <div class="profile-info">
                <ul class="nav nav-pills">
                    <li class="nav-item">
                        <a class="nav-link" href="/board/auctionRegister">판매하기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="">완료내역</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="">리뷰관리</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/member/myTrade">나의거래</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/member/myCart">관심상품</a>
                    </li>
                </ul>
            </div>


        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="profile-up" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">프로필 등록</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="profile-update">
                    <form action="/member/profileUpdate" method="post" enctype="multipart/form-data">
                        <input type="text" class="upload-name" value="파일선택" readonly>
                        <label for="attachment" class="btn btn-primary">프로필 사진찾기</label>
                        <input type="file" id="attachment" name="attachment" hidden="hidden">

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" onclick="basicProfile()">기본 프로필</button>
                            <button type="submit" class="btn btn-primary">등록</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $('#attachment').on('change', function () {
        console.log($('#attachment'))
        let files = document.getElementById('attachment').files
        console.log(files)

        let fileName = ''

        if (files.length == 1) {
            fileName = files[0].name;
        } else {
            fileName = "파일 선택";
        }
        $(".upload-name").val(fileName);
    })
    function basicProfile() {
        location.href="/member/profileDelete"
    }


</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
