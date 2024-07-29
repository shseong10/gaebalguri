<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 3.
  Time: 오후 3:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8f6f1644b141b69c4253753e1f438f04&libraries=services"></script>
</head>
<style>
    #join_logo {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 5% 0 0 0;

    }

    #join_join {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 30px;
        font-size: 45px;

    }

    #join_input {
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
        margin-top: 10px;
        height: 50px;
        width: 300px;
        border: none;
        border-bottom: 2px solid;
        outline: none;
    }

    input[placeholder] {
        font-size: 25px;
    }




    button {
        margin-top: 20px;
        height: 50px;
        width: 300px;
    }

</style>
<body>
<div id="join_logo">
    <a href="/"><img src="/img/logo.png" alt="logo" width="200"> </a>
</div>
<div id="join_input">

    <form action="/member/join" method="post" id="join-form">
        <div id="join_join">JOIN</div>
        <div><input type="text" name="m_id" id="id" placeholder="id "></div>
        <div><span></span></div>
        <div><input type="password" name="m_pw" id="pw" placeholder="pw "></div>
        <div><span></span></div>
        <div><input type="password" name="re_m_pw" id="re_pw" placeholder="Re-pw"></div>
        <div><span></span></div>
        <div><input type="text" name="m_name" id="name" placeholder="name"></div>
        <div><input type="text" name="m_phone" id="phone" placeholder="phone"></div>
        <div>
            <input type="text" id="address" placeholder="주소"><br>
            <input type="button" onclick="execDaumPostcode()" value="주소 검색"><br>
            <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
        </div>
        <div><input type="text" name="m_companyNum" id="companyNum" placeholder="company number"></div>
        <button type="button" onclick="join()" class="btn btn-primary">회원가입</button>
        <div><span></span></div>
    </form>
</div>
<script>


    const idj = /^(?=.*[a-z])(?=.*\d)[a-z\d]{4,16}$/
    const id = $('#id');
    let idCheck = false;



    console.log(idj.test(id.val()));
    id.on('input', function () {
        if (idj.test(id.val())) {
            $('span').eq(0).html('사용 가능한 아이디입니다.').css({
                'color': 'green', 'font-size': '12px'
            })
        } else {
            $('span').eq(0).html('4~16 영문 숫자').css({
                'color': 'red', 'font-size': '12px'
            })
        }
        $.ajax({
            method : 'get',
            url : '/member/idCheck',
            data : {"m_id": $('#id').val()}
        }).done((resp)=>{
            console.log(resp)
            if(resp){
                $('span').eq(0).html('중복되는 아이디 입니다.').css({
                    'color': 'red', 'font-size': '12px'
                })

            }else {
                idCheck = true;
            }


        }).fail((err)=> {
            console.log(err)
        })

    });
    const pwj = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,16}$/
    const pw = $('#pw');
    console.log(pwj.test(pw.val()));
    pw.on('input', function () {
        if (pwj.test(pw.val())) {
            $('span').eq(1).html('사용 가능한 비밀번호입니다.').css({
                'color': 'green', 'font-size': '12px'
            })
        } else {
            $('span').eq(1).html('8~16 영문 대소문자 숫자 특수문자 각 1개 필수').css({
                'color': 'red', 'font-size': '12px'
            })
        }
    });
    $('#re_pw').on('input', function () {
        if ($('#re_pw').val() == pw.val()) {
            $('span').eq(2).html('비밀번호가 일치합니다.').css({
                'color': 'green', 'font-size': '12px'
            })
        } else {
            $('span').eq(2).html('비밀번호가 같지 않습니다.').css({
                'color': 'red', 'font-size': '12px'
            })
        }
    });

    function join() {
        if (pwj.test(pw.val()) && idj.test(id.val()) && $('#re_pw').val() === pw.val() && idCheck
            && $('#name').val()!=="" && $('#addr').val()!=="" && $('#phone').val()!=="") {
             $('#join-form').submit();
        } else {
            $('span').eq(3).html('올바르지 않은 양식입니다.').css({
                'color': 'red', 'font-size': '12px'
            })
        }
    }


</script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
</body>
</html>
