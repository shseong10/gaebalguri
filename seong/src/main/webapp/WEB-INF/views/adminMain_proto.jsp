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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
    <script>
        function modalView(e){
            let objNum = parseInt(e.name); //클릭한 대상의 id값(=상품번호)을 가져와서 저장

            let httpRequest;
            httpRequest = new XMLHttpRequest();
            httpRequest.onreadystatechange = () => {
                if (httpRequest.readyState === XMLHttpRequest.DONE) {
                    if (httpRequest.status === 200) {
                        console.log('새로운 모달창 열기')
                        console.log(httpRequest.response)
                    }
                }
            }
            httpRequest.open('GET', '/admin/quickview?h_p_num='+objNum , true);
            httpRequest.send();
        }

        function quickUpdate(){
            httpRequest.open('POST', '/admin/quickupdate', true);
            httpRequest.responseType = 'json';
            httpRequest.setRequestHeader('Content-Type', 'application/json');
            httpRequest.send(JSON.stringify(reqJson));
        }
    </script>
</head>
<body>
    <div class="card mb-3 w-75 mx-auto">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">상품명</th>
                    <th scope="col"></th>
                    <th scope="col">카테고리</th>
                    <th scope="col">판매가격</th>
                    <th scope="col">재고수량</th>
                    <th scope="col">판매기간</th>
                    <th scope="col">구매제한</th>
                    <th scope="col">누적판매량</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${iList}">
                    <tr>
                        <th scope="row">${item.h_p_num}</th>
                        <td>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#modal_container" onclick="modalView(this)" name="${item.h_p_num}" id="${item.h_p_num}_name">${item.h_p_name}</a>
                        </td>
                        <td>
                            <a href="/list/detail?h_p_num=${item.h_p_num}" target="_blank"><i class="bi bi-plus-square-fill"></i></a>
                        </td>
                        <td id="${item.h_p_num}_category">
                            ${item.h_p_category}
                        </td>
                        <td id="${item.h_p_num}_price">
                            ${item.h_p_price}
                        </td>
                        <td id="${item.h_p_num}_quantity">
                            ${item.h_p_quantity}
                        </td>
                        <td id="${item.h_p_num}_enddate">
                            ${item.h_p_enddateString}
                        </td>
                        <td id="${item.h_p_num}_buylevel">
                            ${item.h_p_buylevel}
                        </td>
                        <td>
                            누적판매량
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <a href="/list/add_item" class="btn btn-primary" role="button">상품 등록 페이지를 열기</a>
        <a href="/list" class="btn btn-primary" role="button">판매 페이지로 돌아가기</a>
    </div>
    <!-- Modal -->
    <div class="modal fade modal-xl" id="modal_container" tabindex="-1" aria-labelledby="modal_containerLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modal_containerLabel"></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="p-3">
                        <div class="row row-cols-2">
                            <div class="col-md-4">
                                상품 이미지
                                <img src="#" class="img-fluid rounded-start" alt="..." id="h_p_img">
                                <input type="file" class="form-control" name="attachments" id="attachments" multiple>
                            </div>
                            <div class="col-md-8">
                                <div class="row row-cols-2 gy-3">
                                    <div class="col-6">
                                        <input type="hidden" id="h_p_num" name="h_p_num" value="${quickView.h_p_num}">
                                        상품명
                                        <input type="text" class="form-control" id="h_p_name" name="h_p_name" value="${quickView.h_p_name}">
                                    </div>
                                    <div class="col-6">
                                        카테고리
                                        <select id="h_p_category" name="h_p_category" class="form-select">
                                            <option>카테고리 선택</option>
                                            <c:forEach var="category" items="${cList}">
                                                <option value="${category.c_name}">${category.c_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-6">
                                        가격
                                        <input type="text" class="form-control" id="h_p_price" name="h_p_price" value="${quickView.h_p_price}">
                                    </div>
                                    <div class="col-6">
                                        수량
                                        <input type="text" class="form-control" id="h_p_quantity" name="h_p_quantity" value="${quickView.h_p_quantity}">
                                    </div>
                                    <div class="col-6">
                                        <div class="row row-cols-2 g-2">
                                            <div class="col-3">
                                                판매기간
                                            </div>
                                            <div class="col-9">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="radioDate" id="radioDate1" value="option1" checked>
                                                    <label class="form-check-label" for="radioDate1">
                                                        지정안함
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="radioDate" id="radioDate2" value="option2">
                                                    <label class="form-check-label" for="radioDate2">
                                                        지정일까지
                                                    </label>
                                                    <input type="datetime-local" class="form-control myInput mt-1" placeholder="날짜를 선택하세요." readonly="readonly">
                                                    <input type="text" name="h_p_enddate" id="h_p_enddate" hidden="hidden">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="row row-cols-2 g-2">
                                            <div class="col-3">
                                                구매제한
                                            </div>
                                            <div class="col-9">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="radioMem" id="radioMem1" value="option1" checked>
                                                    <label class="form-check-label" for="radioMem1">
                                                        모든 회원
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="radioMem" id="radioMem2" value="option2">
                                                    <label class="form-check-label" for="radioMem2">
                                                        <div class="row">
                                                            <div class="col-auto">
                                                                구매 가능 레벨
                                                            </div>
                                                            <div class="col-auto p-0">
                                                                <input type="text" class="form-control" size="1em" id="h_p_buylevel" name="h_p_buylevel" value="${quickView.h_p_buylevel}">
                                                            </div>
                                                            <div class="col-auto">
                                                                부터
                                                            </div>
                                                        </div>
                                                    </label>
                                                </div>
                                            </div><!-- 구매제한 내용 오른쪽-->
                                        </div><!-- 구매제한 내용 좌우정렬 -->
                                    </div><!-- 구매제한 랩핑 끝-->
                                </div><!-- 상품정보 input 좌우정렬 -->
                                <div>
                                    <label for="formGroupExampleInput" class="form-label">상품설명</label>
                                    <textarea class="form-control" id="h_p_desc" name="h_p_desc" style="height: 10rem">${quickView.h_p_desc}</textarea>
                                </div>
                            </div><!-- 상품정보 랩핑 끝-->
                        </div><!-- 상품이미지/상품정보 좌우정렬 -->
                    </div><!-- 전체 내용 랩핑 끝 -->
                </div>
                <div class="modal-footer d-flex">
                    <button type="button" class="btn btn-danger me-auto" data-bs-dismiss="modal">상품 삭제</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" onclick="quickUpdate()" data-bs-dismiss="modal">변경사항 저장</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
