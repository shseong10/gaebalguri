<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 18.
  Time: 오후 3:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>공지사항 작성</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous">
    </script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
    <style>
        body {
            font-family: "MapleStory";
        }
        .write {
            width: 800px;
            margin: auto;
            text-align: center;
        }
        #n_contents {
            width: 300px;
            height: 250px;
        }
        .op{
            text-align: center;
        }
        .button{
            text-align: right;
        }
    </style>
    <script>
        if('${msg}'!==''){
            alert('${msg}');
        }
    </script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <div class="write">
        <form action="/report/write" method="post" enctype="multipart/form-data">
            <h2 class="op">신고/문의하기</h2>
            <table class="table table-dark table-striped" style="width: 800px; margin: auto; text-align: center">
                <tr>
                    <td>
                        <input type="hidden" name="n_id" value="${userId}" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <select name="n_kind" id="kind">
                            <option value="신고">신고</option>
                            <option value="문의">문의</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="text" name="n_title" placeholder="제목" required />
                    </td>
                </tr>
                <tr>
                    <td><textarea name="n_contents" id="n_contents" placeholder="내용을 적어주세요" style="width: 600px"></textarea></td>
                </tr>
                <tr>
                    <td>
                        <input type="file" name="attachments" id="attachments" multiple />
                    </td>
                </tr>
            </table>
            <div class="button">
                <input type="submit" value="작성">
            </div>
        </form>
    </div>
</section>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    $('#upload').on('change', function (){
        let files = document.getElementById('upload').files;
        console.log(files);
        let fileName = '';
        if(files.length > 1){
            fileName = files[0].name + ' 외 ' + (files.length-1) + '개';
        }else if(files.length === 1){
            fileName = files[0].name;
        }else{
            fileName = "파일 선택";
        }
        $(".upload-name").val(fileName);
    })
</script>
</body>
</html>
