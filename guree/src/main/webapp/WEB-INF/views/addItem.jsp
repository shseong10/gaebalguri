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
        const dataTransfer = new DataTransfer();

        window.onload = function () {
            //달력에서 판매기간 선택
            const myInput = document.querySelector(".myInput");
            const fp = flatpickr(myInput, {
                enableTime: true,
                dateFormat: "Y-m-d H:i",
                "locale": "ko"
            });
            //달력에서 선택한 날짜를 전송 필드에 주입
            fp.config.onChange.push(function (selectedDates, dateStr, fp) {
                const date = new Date(dateStr);
                const isoDateTime = new Date(date.getTime() - (date.getTimezoneOffset() * 60000)).toISOString().slice(0, 16);

                document.getElementById('h_p_enddate').value = isoDateTime;
            })

            //파일 첨부 미리보기
            const fileElem = document.getElementById('attachments');
            const previewSub = document.getElementById('preview_sub');
            const previewMain = document.getElementById('preview_main');
            fileElem.addEventListener('change', imgCreate, false);

            function imgCreate() {
                const curFiles = fileElem.files;

                for (const file of curFiles) {
                    const img = URL.createObjectURL(file); //현재 페이지에서만 유효한 이미지 url 생성
                    const previewSubImg = document.createElement('img'); //위 url을 가지고 이미지 요소 생성
                    previewSubImg.setAttribute('src', img);
                    previewSubImg.setAttribute('alt', file.name);
                    previewSubImg.classList.add('w-25');
                    previewSubImg.classList.add('pre-sub');
                    previewSubImg.style.cursor = 'pointer';
                    previewSub.appendChild(previewSubImg); //생성한 이미지 요소를 문서에 추가

                    previewMain.style.backgroundImage = 'url('+ img +')';

                    previewSubImg.addEventListener('click', removePreSub, false);

                    //업로드중인 파일을 dataTransfer에 추가
                    //dataTransfer를 사용해야 POST로 보내기 전에 파일을 추가/삭제할 수 있음
                    //dataTransfer 생성은 가장 먼저(필드변수)
                    dataTransfer.items.add(file)
                }
                fileElem.files = dataTransfer.files;
            }
        }

        function removePreSub() {
            const fileElem = document.getElementById('attachments'); //페이지에서 업로드중인 파일을 배열에 저장

            console.log('dataTransfer 추가 완료')
            console.log(dataTransfer.files)

            const fileName = this.alt; //선택한 이미지의 파일명을 변수에 저장
            const preSubAll = document.querySelectorAll('.pre-sub'); //문서 내 썸네일 요소를 배열에 저장

            //선택한 이미지가 업로드 목록 중 몇 번째 파일인지 검사
            let preSubIdx;
            for (let i = 0; i < preSubAll.length; i++) {
                if (preSubAll[i].alt == fileName) preSubIdx = i; //만일 i번째 파일이 파일명과 일치한다면 선택한 이미지는 i번
            }

            console.log(preSubIdx + '번째 파일 ' + fileName + '를 삭제')

            //dataTransfer에서 선택한 이미지의 순서에 해당하는 파일을 삭제
            dataTransfer.items.remove(preSubIdx);
            console.log('dataTransfer 삭제 완료')
            console.log(dataTransfer.files)

            fileElem.files = dataTransfer.files;

            //선택한 이미지를 화면에서 삭제
            this.remove();
        }

        //파일 첨부 필드 대신 이미지를 클릭하면 파일 첨부 필드가 클릭되도록 함
        function upload(){
            document.getElementById('attachments').click()
        }

    </script>
    <style>
        #preview_main {
            background-image: url("https://icons.getbootstrap.com/assets/icons/images.svg");
            background-repeat: no-repeat;
            background-position: center;
            background-size: 50%;

            cursor:pointer;
            border:1px black solid;
            min-height: 80%;

            text-align: center;
        }

        #preview_main img {
            width: 100%;
        }
    </style>
</head>
<body>
<form action="/add_item" method="post" enctype="multipart/form-data">
    <div class="card mb-3 p-3 w-75 mx-auto">
        <div class="p-3">
            <div class="row row-cols-2">
                <div class="col-md-4">
                    <div class="text-center align-middle h-100">
                        <div onclick="upload()" id="preview_main">
                            &nbsp;
                        </div>
                        <div id="preview_sub" class="row row-cols-4">
                        </div>
                    </div>
                    <input type="file" name="attachments" id="attachments" multiple accept="image/*" hidden="hidden"/>
                </div>
                <div class="col-md-8">
                    <div class="row row-cols-2 gy-3">
                        <div class="col-6">
                            상품명
                            <input type="text" class="form-control" id="p-name" name="h_p_name" value="선풍기">
                        </div>
                        <div class="col-6">
                            카테고리
                            <select id="p-category" name="h_p_category" class="form-select">
                                <option selected>카테고리 선택</option>
                                <c:forEach var="category" items="${cList}">
                                    <option value="${category.c_name}">${category.c_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-6">
                            가격
                            <input type="text" class="form-control" id="p-price" name="h_p_price" value="30000">
                        </div>
                        <div class="col-6">
                            수량
                            <input type="text" class="form-control" id="p-inven" name="h_p_quantity" value="10">
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
                                                    <input type="text" class="form-control" size="1em" id="h_p_buylevel" name="h_p_buylevel" value="0">
                                                </div>
                                                <div class="col-auto">
                                                    부터
                                                </div>
                                            </div>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <label for="formGroupExampleInput" class="form-label">상품설명</label>
                        <div class="main-container">
                            <div class="editor-container editor-container_classic-editor" id="editor-container">
                                <div class="editor-container__editor"><textarea id="h_p_desc" name="h_p_desc"></textarea></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

