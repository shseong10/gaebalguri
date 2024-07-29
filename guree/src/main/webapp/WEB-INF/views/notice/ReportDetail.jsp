<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 18.
  Time: 오후 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
    <title>공지사항</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        body{
            font-family: 'MapleStory';
        }
        .action{
            text-align: center;
        }
        .notice{
            margin: auto;
        }
        h2{
            text-align: center;
        }
        img{
            width: 700px;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <div class="notice">
        <h2>공지사항</h2>
        <table class="table table-dark table-striped" style="width: 900px; margin: auto; text-align: center;">
            <tr>
                <td>작성자</td>
                <td colspan="3">${nDto.n_id}</td>
            </tr>
            <tr>
                <td>구분</td>
                <td colspan="3">${nDto.n_kind}</td>
            </tr>
            <tr>
                <td>제목</td>
                <td colspan="3">${nDto.n_title}</td>
            </tr>
            <tr>
                <td>조회수</td>
                <td colspan="3">${nDto.n_views}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="3">
                    <c:if test="${!empty nDto.nfList}">
                        <c:forEach var="files" items="${nDto.nfList}" varStatus="loop">
                            <img src="/upload/${files.nf_sysFileName}" class="${loop.index == 0 ? '' : 'img-none' }">
                            <br><br>
                        </c:forEach>
                    </c:if>
                    ${nDto.n_contents}</td>
            </tr>
        </table>
        <div class="action">
            <button onclick="location.href='/report/list'">목록으로</button>
            <button id="update-btn" onclick="location.href='/report/update?n_num=' + ${nDto.n_num}">수정</button>
        </div>
    </div>
</section>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    function upload(n_num){
        location.href = '/report/update?n_num=' + n_num;
    }
    $('.img-none').hide();

    const joinId = '${nDto.n_id}';
    const user = '<sec:authentication property="name" />';

    if(user === joinId){
        $('#update-btn').show();
    }else{
        $('#update-btn').hide();
    }
</script>
</body>
</html>
