<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 24.
  Time: 오전 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8f6f1644b141b69c4253753e1f438f04&libraries=services"></script>
</head>

<style>
    .table{
        margin: auto;
        width: 800px;
    }
    #address{
        width: 500px;
    }
</style>
<body>

<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>

<section>
    <h2 style="text-align: center;">정보 수정</h2>
    <form action="/member/infoUpdate" method="post">
    <table class="table">
        <thead>
        </thead>
        <tbody>
        <tr>
            <th scope="row">아이디</th>
            <td style="width: 300px;"><input type="text" name="m_id" placeholder="ID" value="${mInfo.m_id}"></td>
            <th scope="row">이름</th>
            <td><input type="text" name="m_name" placeholder="NAME" value="${mInfo.m_name}"></td>
        </tr>
        <tr>
            <th scope="row">연락처</th>
            <td><input type="text" name="m_phone" placeholder="PHONE" value="${mInfo.m_phone}"></td>
            <th scope="row">법인번호</th>
            <td><input type="text" name="m_companyNum" placeholder="COMPANY-NUM" ${mInfo.m_companyNum}></td>
        </tr>
        <tr>
            <th scope="row">주소</th>
            <td colspan="3">
                <input type="text" id="address" name="m_addr" placeholder="ADDRESS" value="${mInfo.m_addr}">
                <input type="button" id="" onclick="execDaumPostcode()" value="주소 검색">
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <div id="map" style="width:600px;height:600px;margin-top:10px;display:none"></div>
            </td>
        </tr>
        </tbody>
        <tr>
            <td>
                <button class="btn btn-primary">수정하기</button>
            </td>
        </tr>
    </table>

    </form>
</section>

<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
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
