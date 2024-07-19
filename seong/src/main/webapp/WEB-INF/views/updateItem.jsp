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

            //파일 첨부 미리보기
            const fileElem = document.getElementById('attachments');
            const previewSub = document.getElementById('preview_sub');
            const previewMain = document.getElementById('preview_main');
            fileElem.addEventListener('change', imgCreate, false);

            //저장된 이미지 불러오기
            //DTO로 가져온 데이터로 배열 생성(원본파일명, 시스템파일명 조합)
            const savedImgList = new Array();
            <c:forEach items="${inventory.ifList}" var="item">
            savedImgList.push({oriFileName: '${item.h_p_oriFileName}', sysFileName: '${item.h_p_sysFileName}'});
            </c:forEach>
            //이미지 객체를 만들어서 문서 내에 추가
            if (savedImgList.length > 0) {
                for (let i = 0; i < savedImgList.length; i++) {
                    const savedImg = document.createElement('img');
                    savedImg.setAttribute('src', '/upload/' + savedImgList[i].sysFileName);
                    savedImg.setAttribute('alt', savedImgList[i].oriFileName);
                    savedImg.classList.add('w-25');
                    savedImg.classList.add('pre-sub-ori');
                    savedImg.style.cursor = 'pointer';
                    previewSub.appendChild(savedImg);

                    savedImg.addEventListener('click', removePreSubOri, false);
                }
            }


            //파일업로드 내용이 바뀌면 다음 메소드를 실행
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

                    previewMain.style.backgroundImage = 'url(' + img + ')';

                    previewSubImg.addEventListener('click', removePreSub, false);

                    //업로드중인 파일을 dataTransfer에 추가
                    //dataTransfer를 사용해야 POST로 보내기 전에 파일을 추가/삭제할 수 있음
                    //dataTransfer 생성은 가장 먼저(필드변수)
                    dataTransfer.items.add(file)
                }
                fileElem.files = dataTransfer.files;
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

        function removePreSub() {
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

        function removePreSubOri() {
            const fileName = this.alt; //선택한 이미지의 파일명을 변수에 저장

            console.log('기존 파일 ' + fileName + '를 삭제')

            const deleteFile = document.createElement('input');
            deleteFile.setAttribute('type', 'hidden');
            deleteFile.setAttribute('name', 'deleteFile');
            deleteFile.setAttribute('id', fileName);
            deleteFile.setAttribute('value', fileName);
            document.getElementById('preview_sub').appendChild(deleteFile);

            //선택한 이미지를 화면에서 삭제
            this.remove();
        }

        function upload() {
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
<form action="/update_item" method="post" enctype="multipart/form-data">
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
