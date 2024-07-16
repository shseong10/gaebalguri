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
        function modalView(e){
            let objNum = parseInt(e.name); //클릭한 대상의 id값(=상품번호)을 가져와서 저장

            let httpRequest;
            httpRequest = new XMLHttpRequest();
            httpRequest.onreadystatechange = () => {
                if (httpRequest.readyState === XMLHttpRequest.DONE) {
                    if (httpRequest.status === 200) {
                        console.log('새로운 모달창 열기')

                        const result = JSON.parse(httpRequest.responseText);

                        const modalViewTitle = document.getElementById('modal_containerLabel');
                        const modalViewNum = document.getElementById('h_p_num');
                        const modalViewh_p_name = document.getElementById('h_p_name');
                        const modalViewPrice = document.getElementById('h_p_price');
                        const modalViewEnddate = document.getElementById('h_p_enddate');
                        const modalViewBuylevel = document.getElementById('h_p_buylevel');
                        const modalViewQty = document.getElementById('h_p_quantity');
                        const modalViewDesc = document.getElementById('h_p_desc_hidden');


                        modalViewTitle.textContent = result[0].h_p_name;
                        modalViewNum.setAttribute('value', result[0].h_p_num);
                        modalViewh_p_name.setAttribute('value', result[0].h_p_name);
                        modalViewPrice.setAttribute('value', result[0].h_p_price);
                        modalViewEnddate.setAttribute('value', result[0].h_p_enddate);
                        modalViewBuylevel.setAttribute('value', result[0].h_p_buylevel);
                        modalViewQty.setAttribute('value', result[0].h_p_quantity);
                        modalViewDesc.innerHTML = result[0].h_p_desc;

                        //비동기 데이터가 전부 로드되면 숨겨진 div에 클릭이벤트를 실행해서 api를 건드리게함(ㅠㅠ)
                        modalViewDesc.click();

                        //저장된 이미지 가져오기
                        const modalViewImgFilename = result[0].ifList[0].h_p_sysFileName;
                        const modalViewImg = document.getElementById('h_p_img');
                        modalViewImg.setAttribute('src', '/upload/' + modalViewImgFilename);

                        //저장된 카테고리 가져오기
                        const savedCategory = result[0].h_p_category
                        const modalViewCategory = document.querySelector('select[name=h_p_category]').options;
                        for (let i = 0; i < modalViewCategory.length; i++) {
                            if (modalViewCategory[i].value == savedCategory) modalViewCategory[i].selected = true;
                        }

                        //캘린더 출력 + 저장된 날짜 가져오기
                        const myInput = document.querySelector(".myInput");
                        const fp = flatpickr(myInput, {
                            enableTime: true,
                            dateFormat: "Y-m-d H:i",
                            "locale": "ko",
                            defaultDate: result[0].h_p_enddateString
                        });
                        fp.config.onChange.push(function (selectedDates, dateStr, fp) {
                            const date = new Date(dateStr);
                            const isoDateTime = new Date(date.getTime() - (date.getTimezoneOffset() * 60000)).toISOString().slice(0, 16);

                            document.getElementById('h_p_enddate').value = isoDateTime;
                        })

                        //판매기간 체크
                        if (result[0].h_p_enddate != '') {
                            document.getElementById('radioDate1').checked = false;
                            document.getElementById('radioDate2').checked = true;
                        } else {
                            document.getElementById('radioDate1').checked = true;
                            document.getElementById('radioDate2').checked = false;
                        }

                        //구매제한 체크
                        const buylevel = result[0].h_p_buylevel;
                        if (buylevel != 0) {
                            document.getElementById('radioMem1').checked = false;
                            document.getElementById('radioMem2').checked = true;
                        } else {
                            document.getElementById('radioMem1').checked = true;
                            document.getElementById('radioMem2').checked = false;
                        }

                    }
                }
            }
            httpRequest.open('GET', '/admin/quickview?h_p_num='+objNum , true);
            httpRequest.send();
        }//modalView(e) end

        function quickUpdate(){
            const UpdateNum = document.getElementById('h_p_num');
            const UpdateCategory = document.getElementById('h_p_category');
            const Updateh_p_name = document.getElementById('h_p_name');
            const UpdatePrice = document.getElementById('h_p_price');
            const UpdateEnddate = document.getElementById('h_p_enddate');
            const UpdateBuylevel = document.getElementById('h_p_buylevel');
            const UpdateQty = document.getElementById('h_p_quantity');
            const UpdateDesc = document.getElementById('h_p_desc');

            let inputNum = UpdateNum.value;
            let inputCategory = UpdateCategory.value;
            let inputName = Updateh_p_name.value;
            let inputPrice = UpdatePrice.value;
            let inputEnddate = UpdateEnddate.value;
            let inputBuylevel = UpdateBuylevel.value;
            let inputQty = UpdateQty.value;
            let inputDesc = UpdateDesc.value;

            //json형식으로 변경
            let reqJson = new Object();
            reqJson.h_p_num = inputNum;
            reqJson.h_p_category = inputCategory;
            reqJson.h_p_name = inputName;
            reqJson.h_p_price = inputPrice;
            if (inputEnddate != "null") reqJson.h_p_enddate = inputEnddate;
            reqJson.h_p_buylevel = inputBuylevel;
            reqJson.h_p_quantity = inputQty;
            reqJson.h_p_desc = inputDesc;
            console.log(reqJson)

            let httpRequest;
            httpRequest = new XMLHttpRequest();
            httpRequest.onreadystatechange = () => {
                if (httpRequest.readyState === XMLHttpRequest.DONE) {
                    if (httpRequest.status === 200) {
                        let update_result = httpRequest.response.iList;
                        console.log('모달창 내용 업데이트')
                        console.log(update_result);

                        if (update_result.h_p_enddate != null) {
                            const enddate = new Date(update_result.h_p_enddate)

                            const yyyy = enddate.getFullYear()
                            const mm = enddate.getMonth() + 1 // getMonth() is zero-based
                            const dd = enddate.getDate()
                            const hh = enddate.getHours()
                            const ii = enddate.getMinutes()

                            const h_p_enddate = yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + ii
                            const listEnddate = document.getElementById(inputNum+'_enddate');
                            listEnddate.textContent = h_p_enddate;
                        }

                        const h_p_category = update_result.h_p_category;
                        const h_p_name = update_result.h_p_name;
                        const h_p_price = update_result.h_p_price;
                        const h_p_quantity = update_result.h_p_quantity;
                        const h_p_buylevel = update_result.h_p_buylevel;

                        const listName = document.getElementById(inputNum+'_name');
                        const listCategory = document.getElementById(inputNum+'_category');
                        const listPrice = document.getElementById(inputNum+'_price');
                        const listQuantity = document.getElementById(inputNum+'_quantity');
                        const listBuylevel = document.getElementById(inputNum+'_buylevel');
                        listName.textContent = h_p_name;
                        listCategory.textContent = h_p_category;
                        listPrice.textContent = h_p_price;
                        listQuantity.textContent = h_p_quantity;
                        listBuylevel.textContent = h_p_buylevel;
                    }
                }
            }
            httpRequest.open('POST', '/admin/quickupdate', true);
            httpRequest.responseType = 'json';
            httpRequest.setRequestHeader('Content-Type', 'application/json');
            httpRequest.send(JSON.stringify(reqJson));
        }

        //검색
        function search() {
            let keyword = document.getElementById('keyword').value;
            if (keyword === '') {
                alert('검색어를 입력하세요.')
                return;
            }
            location.href = '/admin/main?keyword='+keyword+'&pageNum=1'
        }

    </script>
</head>
<body>
<div class="w-75 mt-5 mx-auto">
    <div class="d-flex mb-2">
        <div class="p-2"><a href="/admin/main"><img src="/upload/logo.png" width="25%"></a></div>
        <div class="d-flex ms-auto h-75">
            <input type="text" id="keyword" class="form-control me-2" placeholder="검색하기" style="width: 10rem;">
            <button type="button" id="search" onclick="search()" class="btn btn-primary"><i class="bi bi-search"></i></button>
        </div>
    </div>
    <div class="card mb-3">
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
    <div class="d-grid gap-2 mb-3 mx-auto">
        <div class="paging">${paging}</div>
        <a href="/list/add_item" class="btn btn-primary" role="button">상품 등록 페이지를 열기</a>
        <a href="/list" class="btn btn-primary" role="button">판매 페이지로 돌아가기</a>
    </div>
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
                                    <input type="hidden" id="h_p_num" name="h_p_num" value="#">
                                    상품명
                                    <input type="text" class="form-control" id="h_p_name" name="h_p_name">
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
                                    <input type="text" class="form-control" id="h_p_price" name="h_p_price">
                                </div>
                                <div class="col-6">
                                    수량
                                    <input type="text" class="form-control" id="h_p_quantity" name="h_p_quantity">
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
                                <label class="form-label">상품설명</label>
                                <div class="main-container">
                                    <div class="editor-container editor-container_classic-editor" id="editor-container">
                                        <div class="editor-container__editor">
                                            <textarea id="h_p_desc" name="h_p_desc"></textarea>
                                            <div id="h_p_desc_hidden" style="display: none">desc</div>
                                        </div>
                                    </div>
                                </div>
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
    <script type="importmap">
        {
            "imports": {
                "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/42.0.1/ckeditor5.js",
                "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/42.0.1/"
            }
        }
    </script>
    <script type="module" src="/api/ckeditor5/main.js"></script>
</div>
</body>
</html>
