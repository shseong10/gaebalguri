<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>

    <style>
        #login_logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 12% 0 0 0;

        }

        #login_login {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px;
            font-size: 45px;

        }

        #login_input {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px;
        }
        #login_finder {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px;
        }

        input {
            margin-bottom: 20px;
            height: 50px;
            width: 300px;
            border: none;
            border-bottom: 2px solid;
            outline: none;
        }

        input[placeholder] {
            font-size: 25px;
        }

        #id_save {
            height: 15px;
            width: 15px;
        }

        .button-center{
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 10px;

        }
        button{

            height: 50px;
            width: 300px;
        }

    </style>
    <script>
        const msg = '${msg}';
        if (msg !== '')
            alert(msg);
    </script>
</head>
<body>
<div id="login_logo">
    <a href="/"><img src="/img/logo.png" alt="logo" width="200"> </a>
</div>
<div id="login_login">
    LOGIN
</div>
<div id="login_input">
    <form action="/member/login" method="post">
        <input type="text" id="id" name="username" placeholder="ID"><br>
        <input type="password" id="pw" name="password" placeholder="PW"><br>
        <input type="checkbox" id="id_save"><span style="font-size: 15px">아이디 저장</span> <br>
       <div class="button-center"> <button type="submit" class="btn btn-primary" onclick="login()">로그인</button></div>

    </form>
   </div>
<div id="login_finder"><a href="/member/idFind">아이디찾기</a> / <a href="/member/pwFind">비번찾기</a> / <a href="/member/joindetail">회원가입</a></div>


<!-- csrf설정시, 비동기 통신은 https://determination.tistory.com/entry/스프링-시큐리티Spring-Security-CSRF-설정AJAX-POST-FORM -->
<!--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">-->
</form>

<script>
    $(document).ready(function() {
        // 페이지가 로드될 때 저장된 아이디를 로드합니다.
        let savedUsername = localStorage.getItem('savedUsername');
        if (savedUsername) {
            $('#id').val(savedUsername);
            $('#id_save').prop('checked', true);
        }
    });

    function login() {
        let username = $('#id').val();
        let rememberMe = $('#id_save').is(':checked');

        if (rememberMe) {
            // 아이디를 로컬 저장소에 저장합니다.
            localStorage.setItem('savedUsername', username);
        } else {
            // 로컬 저장소에서 아이디를 제거합니다.
            localStorage.removeItem('savedUsername');
        }

        // 여기에 로그인 요청을 서버로 보내는 코드를 추가합니다.
        // 예: $.post('/login', { username: username, password: password }, function(response) { ... });

        // alert('로그인 시도: ' + username);
    }
</script>
</body>
</html>