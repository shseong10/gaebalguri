<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 12.
  Time: 오전 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <style>
    .goingTop {
      width: 20px;
      height: 20px;
      padding: 20px;
      background: #986eaf;
      font-weight: bold;
      border-radius: 50%;
      color: #444;
      text-decoration: none;
      position: fixed;
      bottom: 100px;
      right: 120px;

      display: flex; /* Flexbox로 변경 */
      justify-content: center; /* 가로 중앙 정렬 */
      align-items: center; /* 세로 중앙 정렬 */
    }
    .goingTop:hover{
      text-decoration:none;
    }  .goingTop {
         width: 20px;
         height: 20px;
         padding: 20px;
         background: #986eaf;
         font-weight: bold;
         border-radius: 50%;
         color: #444;
         text-decoration: none;
         position: fixed;
         bottom: 100px;
         right: 120px;

         display: flex; /* Flexbox로 변경 */
         justify-content: center; /* 가로 중앙 정렬 */
         align-items: center; /* 세로 중앙 정렬 */
       }
    .goingTop:hover{
      text-decoration:none;
    }

    .footer-logo {
      width: 5%;
      margin-left: -90%;
      margin-bottom: 20px; /* 하단 여백 유지 */
    }
    .footer-info {
      color: GrayText;
      font-size: small;
      text-align: left;
      margin-right: auto;
      width: 30%;
      height: 2%;
    }

    footer {
      display: flex;
      flex-direction: column;
      min-height: 1vh;
      background-color: whitesmoke;
      background-size: cover;
      background-position: center;
      color: black;
      padding: 4px 0;
      margin-top: 200px;

      text-align: center;

    }

    .footer-content {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
      margin-bottom: 20px;
    }

    .footer-content>div {
      flex: 1;
      min-width: 200px;
      margin: 10px 0;
    }

    .footer-content h3 {
      margin-bottom: 10px;
      font-size: 1.2em;
      text-transform: uppercase;
    }

    .footer-content p,
    .footer-content a {
      margin: 5px 0;
      color: GrayText;
      text-decoration: none;
    }
    .copyright {
      margin-top: 20px;
      font-size: 0.9em;
    }
  </style>
</head>

<body>
<div class="inner">
  <div class="footer-content">
    <div class="Terms">
      <h3><a href="...">이용약관</a></h3>
    </div>
    <div class="hours">
      <h3><a href="...">개인정보처리방침</a></h3>
    </div>
    <div class="hours">
      <h3><a href="...">분쟁처리절차</a></h3>
    </div>
    <div class="address">
      <h3><a href="...">청소년보호정책</a></h3>
    </div>
    <div class="careers">
      <h3><a href="...">게시글 수집 및 이용 안내</a></h3>
    </div>
  </div>
  <img src="/img/logo.png" alt="로고" class="footer-logo"/>
  <div class="footer-info">
    <ul>
      <li>(주)더보라 사업자 정보</li>
      <li>(주)더보라</li>
      <li>대표자 : 개발구리의 개구리선생</li>
      <li>주소 : 인천광역시 미추홀구 학익동 인천일보아카데미</li>
      <li>대표번호 : 010-9292-9292</li>
      <li>메일 :Guree@guriguri.co.kr</li>
    </ul>
  </div>
  <p class="copyright">
    &copy; <span class="this-year"></span> THE BORA Company. All Rights Reserved.
  </p>
  <div class="goingTop" onclick="window.scrollTo(0,0);">UP</div>
</div>

</body>




</html>