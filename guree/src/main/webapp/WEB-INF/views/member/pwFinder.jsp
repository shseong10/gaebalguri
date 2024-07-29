<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 4.
  Time: 오후 3:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
</head>
<style>

    #logo {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 12% 0 0 0;

    }

    .pw-finder {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 30px;
        font-size: 45px;

    }

    .info-input {
        display: flex;
        align-items: center;
        justify-content: center;

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
    .login_finder {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 30px;
    }



    .button-center {
        display: flex;
        align-items: center;
        justify-content: center;
        /*margin-top: 10px;*/

    }

    button {

        height: 50px;
        width: 300px;
        /*margin: 5px;*/
    }


</style>



<body>

<div id="logo">
    <a href="/"><img src="/img/logo.png" alt="logo" width="200"> </a>
</div>
<div>
    <div class="finder">
        <div class="pw-finder">
            PW 찾기
        </div>
        <div class="info-input"><input type="text" name="m_id" id="id" placeholder="id"></div>
        <div class="info-input"><input type="text" name="m_name" id="name" placeholder="name"></div>
        <div class="info-input"><input type="text" name="m_phone" id="phone" placeholder="phone"></div>
        <div class="button-center"><button class="btn btn-primary" type="button" onclick="pwFinder()">찾기</button></div>
        <div class="login_finder"><a href="/member/idFind">아이디찾기</a>/<a href="/member/login">로그인</a>/<a href="/member/joindetail">회원가입</a></div>
    </div>
    <div class="pw" hidden="hidden">
        <div class="pw-finder">
            PW 변경
        </div>
        <form action="/member/pwChange" method="post">
            <div class="info-input"><input type="text" name="m_id" placeholder="id"></div>
            <div class="info-input"><input type="password" name="m_pw" id="pw" placeholder="new pw"></div>
            <div class="info-input"><input type="password" name="m_pw" id="re-pw" placeholder="re-pw"></div>
            <div class="info-input"><span class="pw-confirm"></span> </div>
            <div class="button-center"><button class="btn btn-primary">변경</button></div>
            <div class="login_finder"><a href="/member/login">로그인</a>/<a href="/member/joindetail">회원가입</a></div>
        </form>
    </div>


</div>
<script>
    $('#re-pw').on('input',()=>{
        if($('#re-pw').val()!==$('#pw').val()){
            $('.pw-confirm').html("일치하지 않습니다.").css({'font-size':'12px', 'color':'red'})
        }else{
            $('.pw-confirm').html("일치합니다.").css({'font-size':'12px', 'color':'green'})
        }
    })

    function pwFinder() {
        let name = document.getElementById("name");
        let phone = document.getElementById("phone");


        if (name.value == "" || phone.value == "" || $('#id').val() == "") {
            alert("아이디, 이름 또는 전화번호를 적어주세요")


        } else {
            $.ajax({
                method: 'post',
                url: '/member/pwFind',
                data: {"m_id": $('#id').val(), "m_name": name.value, "m_phone": phone.value},

            }).done((resp) => {
                    if (resp) {
                    $('.pw').removeAttr("hidden");
                    console.log(resp)
                    $('.finder').hide();

                }
            }).fail(function (err) {
                console.log(err)
            })

        }


    }
</script>
</body>
</html>
