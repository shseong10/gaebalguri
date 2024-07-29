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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

    #id-finder {
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



    .button-center {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 20px;

    }

    button {

        height: 50px;
        width: 300px;
        margin: 5px;
    }

</style>


<body>


<div id="logo">
    <a href="/"><img src="/img/logo.png" alt="logo" width="200"> </a>
</div>
<div id="id-finder">
    ID 찾기
</div>

<div class="info-input"><input type="text" name="m_name" id="name" placeholder="name"></div>
<div class="info-input"><input type="text" name="m_phone" id="phone" placeholder="phone"></div>
<div id="id" class="info-input" hidden="hidden">아이디</div>


<div class="button-center"><button type="button" class="btn btn-primary" onclick="idFinder()">찾기</button> </div>

<div class="info-input"><a href="/member/pwFind"> 비밀번호 찾기</a>/<a href="/member/joindetail">회원가입</a> </div>


<script>
    function idFinder() {
        let name = document.getElementById("name");
        let phone = document.getElementById("phone");
        console.log(name.value);
        console.log(phone.value);

        if (name.value == "" || phone.value == "") {
            alert("이름 또는 전화번호를 적어주세요")


        } else {
            $.ajax({
                method: 'post',
                url: '/member/idFind',
                data: {"m_name": name.value, "m_phone": phone.value},

            }).done((resp) => {

                $('#id').html("ID : " + resp).removeAttr("hidden");
                console.log(resp)
            }).fail(function (err) {
                console.log(err)
            })
        }
    }
</script>
</body>
</html>
