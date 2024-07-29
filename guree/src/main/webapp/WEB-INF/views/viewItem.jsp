<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        //주문하기 버튼을 클릭하면 js로 hidden form을 만들어서 전송
        function view_order () {
            const qty = document.getElementById('view_qty')

            const formObj = document.createElement("form")
            const h_o_p_num = document.createElement("input");
            const h_o_sales_price = document.createElement("input");
            const h_o_qty = document.createElement("input");

            h_o_p_num.name = "h_o_p_num";
            h_o_sales_price.name = "h_o_sales_price";
            h_o_qty.name = "h_o_qty";

            h_o_p_num.value = ${inventory.h_p_num};
            h_o_sales_price.value = ${inventory.h_p_price};
            h_o_qty.value = qty.value;

            formObj.appendChild(h_o_p_num);
            formObj.appendChild(h_o_sales_price);
            formObj.appendChild(h_o_qty);

            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "/buy_item"
            formObj.submit();
        }

        function view_cart () {
            const qty = document.getElementById('view_qty')

            const formObj = document.createElement("form")
            const h_c_user_id = document.createElement("input");
            const h_c_p_num = document.createElement("input");
            const h_c_p_sales_price = document.createElement("input");
            const h_c_p_qty = document.createElement("input");

            h_c_p_num.name = "h_c_p_num";
            h_c_user_id.name = "h_c_user_id";
            h_c_p_sales_price.name = "h_c_p_sales_price";
            h_c_p_qty.name = "h_c_p_qty";

            h_c_p_num.value = ${inventory.h_p_num};
            h_c_user_id.value = "aaa"; //임시아이디
            h_c_p_sales_price.value = ${inventory.h_p_price};
            h_c_p_qty.value = qty.value;

            formObj.appendChild(h_c_p_num);
            formObj.appendChild(h_c_user_id);
            formObj.appendChild(h_c_p_sales_price);
            formObj.appendChild(h_c_p_qty);

            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "/take_item"
            formObj.submit();
        }

        window.onload = function () {
            //이미지 슬라이더
            //컨트롤러로 가져온 데이터 중 파일리스트로 배열 생성
            const curFiles = new Array();
            <c:forEach items="${inventory.ifList}" var="item">
                curFiles.push({filename : '${item.h_p_sysFileName}'});
            </c:forEach>

            //파일리스트 배열을 슬라이더 요소로 생성
            const carouselInner = document.getElementById('carousel-inner');

            for (const file of curFiles) {
                //슬라이더 div 생성
                const carouselItem = document.createElement('div');
                carouselItem.className = 'carousel-item';

                //슬라이더 이미지 생성
                const img = '/upload/' + file.filename;
                const carouselItemImg = document.createElement('img');
                carouselItemImg.className = 'd- block w-100'
                carouselItemImg.setAttribute('src', img);

                //생성된 슬라이더 div와 이미지를 문서 내에 추가
                carouselInner.appendChild(carouselItem);
                carouselItem.appendChild(carouselItemImg);
            }

            //추가된 슬라이더중 첫번째 슬라이더에만 클래스(.active)추가 - 부트스트랩 슬라이더 사용 조건
            document.querySelector('.carousel-item').classList.add('active');

        }
    </script>
    <style>
        .text-body-secondary img {
            max-width: 100% !important;
        }

        .carousel-control-btn {
            color: #ced4da;
            font-weight: bold;
            font-size: 2.5rem;
        }
    </style>
</head>
<body>
    <div class="card mb-3 w-75 mx-auto">
        <div class="row g-0">
            <div class="col-md-4 carousel slide" id="carousel">
                <div class="carousel-inner" id="carousel-inner">

                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">
                    <span class="carousel-control-btn" aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
                    <span class="visually-hidden">이전</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">
                    <span class="carousel-control-btn" aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                    <span class="visually-hidden">다음</span>
                </button>
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title">${inventory.h_p_name}</h5>
                    <p class="card-text">${inventory.h_p_price}원</p>
                    <p class="card-text"><small class="text-body-secondary">${inventory.h_p_desc}</small></p>
                    <p class="card-text"><small class="text-body-secondary">수량 선택: <input type="text" id="view_qty" name="view_qty" value="3">개</small></p>
                    <div class="d-grid gap-2 d-md-block mb-3">
                        <a href="javascript: view_cart();" class="btn btn-primary" role="button">장바구니</a>
                        <a href="javascript: view_order();" class="btn btn-primary" role="button">주문하기</a>
                    </div>
                    <a href="/update_item?h_p_num=${inventory.h_p_num}" class="btn btn-warning" role="button">수정</a>
                    <a href="/delete_item?h_p_num=${inventory.h_p_num}" class="btn btn-danger" role="button">삭제</a>
            </div>
            </div>
        </div>
    </div>
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <a href="/list" class="btn btn-primary" role="button">목록으로</a>
    </div>
</body>
</html>
