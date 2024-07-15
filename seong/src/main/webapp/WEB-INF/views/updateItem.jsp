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
    <link rel="stylesheet" href="/api/ckeditor5/style.css">
    <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/42.0.1/ckeditor5.css">
    <script>
        window.onload = function () {
            const enddate = "${inventory.h_p_enddateString}";

            const myInput = document.querySelector(".myInput");
            const fp = flatpickr(myInput, {
                enableTime: true,
                dateFormat: "Y-m-d H:i",
                "locale": "ko",
                defaultDate: enddate
            });
            fp.config.onChange.push(function (selectedDates, dateStr, fp) {
                const isoDatetime = new Date(dateStr).toISOString().slice(0, 16); // 초 단위는 생략
                document.getElementById('h_p_enddate').value = isoDatetime;
            })

            //저장된 카테고리 가져오기
            const savedCategory = '${inventory.h_p_category}';
            const selectCategory = document.querySelector('select[name=h_p_category]').options;
            for (let i = 0; i < selectCategory.length; i++) {
                if (selectCategory[i].value == savedCategory) selectCategory[i].selected = true;
            }

            const fileElem = document.getElementById('attachments')
            fileElem.addEventListener('change', imgCreate, false);

            function imgCreate() {
                const curFiles = fileElem.files;
                const preview = document.getElementById('preview');
                for (const file of curFiles) {
                    const img = URL.createObjectURL(file);
                    preview.src = img;
                    preview.style.width = '100%';
                }
            }

            //판매기간 체크
            if (enddate != '') {
                document.getElementById('radioDate1').checked = false;
                document.getElementById('radioDate2').checked = true;
            } else {
                document.getElementById('radioDate1').checked = true;
                document.getElementById('radioDate2').checked = false;
            }

            //구매제한 체크
            const buylevel = "${inventory.h_p_buylevel}";
            if (buylevel != 0) {
                document.getElementById('radioMem1').checked = false;
                document.getElementById('radioMem2').checked = true;
            } else {
                document.getElementById('radioMem1').checked = true;
                document.getElementById('radioMem2').checked = false;
            }

        }

        function upload(){
            document.getElementById('attachments').click()
        }
    </script>
</head>
<body>
<form action="/update_item" method="post" enctype="multipart/form-data">
    <div class="card mb-3 p-3 w-75 mx-auto">
        <div class="p-3">
            <div class="row row-cols-2">
                <div class="col-md-4">
                    <div class="text-center align-middle" onclick="upload()" style="cursor:pointer; border:1px black solid">
                        <img src="/upload/${inventory.ifList[0].h_p_sysFileName}" width="100%" id="preview"><br>
                        이미지 첨부
                        <input type="file" name="attachments" id="attachments" multiple accept="image/*" hidden="hidden"/>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="row row-cols-2 gy-3">
                        <div class="col-6">
                            <input type="hidden" name="h_p_num" value="${inventory.h_p_num}">
                            상품명
                            <input type="text" class="form-control" id="h_p_name" name="h_p_name" value="${inventory.h_p_name}">
                        </div>
                        <div class="col-6">
                            카테고리
                            <select id="h_p_category" name="h_p_category" class="form-select">
                                <option selected>카테고리 선택</option>
                                <c:forEach var="category" items="${cList}">
                                    <option value="${category.c_name}">${category.c_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-6">
                            가격
                            <input type="text" class="form-control" id="h_p_price" name="h_p_price" value="${inventory.h_p_price}">
                        </div>
                        <div class="col-6">
                            수량
                            <input type="text" class="form-control" id="h_p_quantity" name="h_p_quantity" value="${inventory.h_p_quantity}">
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
                                        <input type="text" name="h_p_enddate" id="h_p_enddate" value="${inventory.h_p_enddate}" hidden="hidden">
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
                                                    <input type="text" class="form-control" size="1em" id="h_p_buylevel" name="h_p_buylevel" value="${inventory.h_p_buylevel}">
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
                        <div class="main-container">
                            <div class="editor-container editor-container_classic-editor" id="editor-container">
                                <div class="editor-container__editor"><textarea id="h_p_desc" name="h_p_desc">${inventory.h_p_desc}</textarea></div>
                            </div>
                        </div>
                    </div>
                </div><!-- 상품정보 랩핑 끝-->
            </div><!-- 상품이미지/상품정보 좌우정렬 -->
        </div><!-- 전체 내용 랩핑 끝 -->
    </div><!-- 컨테이너 끝-->

    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <input type="submit" class="btn btn-primary" value="등록하기">
    </div>

    <script type="importmap">
        {
            "imports": {
                "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/42.0.1/ckeditor5.js",
                "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/42.0.1/"
            }
        }
    </script>
    <script type="module" src="/api/ckeditor5/main.js"></script>
</form>
</body>
</html>
