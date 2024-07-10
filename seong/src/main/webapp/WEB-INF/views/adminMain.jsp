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
        function modalView(e){
            let objNum = parseInt(e.name); //클릭한 대상의 id값(=상품번호)을 가져와서 저장
            const json = ${json}; //controller에서 model addAttribute로 가져온 json타입 리스트를 변수에 저장
            const result = json.find(({h_p_num}) => h_p_num === objNum); //json변수에서 h_p_num이 objNum값과 같은 요소를 검색

            console.log("새로운 모달창 열기");
            console.log(result);
            const view_num = result.h_p_num;
            const view_category = result.h_p_category;
            const view_name = result.h_p_name;
            const view_price = result.h_p_price;
            const view_quantity = result.h_p_quantity;
            const view_desc = result.h_p_desc;

            const modalViewTitle = document.getElementById('modal_containerLabel');
            const modalViewNum = document.getElementById('h_p_num');
            const modalViewCategory = document.getElementById('h_p_category');
            const modalViewh_p_name = document.getElementById('h_p_name');
            const modalViewPrice = document.getElementById('h_p_price');
            const modalViewQty = document.getElementById('h_p_quantity');
            const modalViewDesc = document.getElementById('h_p_desc');

            modalViewTitle.textContent = view_name;
            modalViewNum.setAttribute('value', view_num);
            modalViewCategory.setAttribute('value', view_category);
            modalViewh_p_name.setAttribute('value', view_name);
            modalViewPrice.setAttribute('value', view_price);
            modalViewQty.setAttribute('value', view_quantity);
            modalViewDesc.setAttribute('value', view_desc);
            modalViewDesc.textContent = view_desc;

            const modalViewImgFilename = result.ifList[0].h_p_sysFileName;
            const modalViewImg = document.getElementById('h_p_img');
            modalViewImg.setAttribute('src', '/upload/' + modalViewImgFilename);
        }

        function quickUpdate(){
            const UpdateNum = document.getElementById('h_p_num');
            const UpdateCategory = document.getElementById('h_p_category');
            const Updateh_p_name = document.getElementById('h_p_name');
            const UpdatePrice = document.getElementById('h_p_price');
            const UpdateQty = document.getElementById('h_p_quantity');
            const UpdateDesc = document.getElementById('h_p_desc');

            let inputNum = UpdateNum.value;
            let inputCategory = UpdateCategory.value;
            let inputName = Updateh_p_name.value;
            let inputPrice = UpdatePrice.value;
            let inputQty = UpdateQty.value;
            let inputDesc = UpdateDesc.value;

            //json형식으로 변경
            let reqJson = new Object();
            reqJson.h_p_num = inputNum;
            reqJson.h_p_category = inputCategory;
            reqJson.h_p_name = inputName;
            reqJson.h_p_price = inputPrice;
            reqJson.h_p_quantity = inputQty;
            reqJson.h_p_desc = inputDesc;

            let httpRequest;
            httpRequest = new XMLHttpRequest();
            httpRequest.onreadystatechange = () => {
                if (httpRequest.readyState === XMLHttpRequest.DONE) {
                    if (httpRequest.status === 200) {
                        let update_result = httpRequest.response.iList;
                        console.log('모달창 내용 업데이트')
                        console.log(update_result);

                        const h_p_category = update_result.h_p_category;
                        const h_p_name = update_result.h_p_name;
                        const h_p_price = update_result.h_p_price;
                        const h_p_quantity = update_result.h_p_quantity;
                        // const h_p_desc = update_result.h_p_desc;

                        const listName = document.getElementById(inputNum+'_name');
                        const listCategory = document.getElementById(inputNum+'_category');
                        const listPrice = document.getElementById(inputNum+'_price');
                        const listQuantity = document.getElementById(inputNum+'_quantity');
                        listName.textContent = h_p_name;
                        listCategory.textContent = h_p_category;
                        listPrice.textContent = h_p_price;
                        listQuantity.textContent = h_p_quantity;
                    }
                }
            }
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
                        <td>
                            판매기간
                        </td>
                        <td>
                            구매제한
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
        <a href="/add_item" class="btn btn-primary" role="button">상품 등록 페이지를 열기</a>
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
                    <div class="row g-0">
                            <div class="col-md-4">
                                <img src="#" class="img-fluid rounded-start" alt="..." id="h_p_img">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body" style="padding-left: 1.5rem">
                                    <form id="quick_update">
                                    <input type="hidden" id="h_p_num" value="h_p_num">
                                    <input type="hidden" id="h_p_category" value="h_p_category">
                                    <p class="card-text text-body-secondary">상품명 <input type="text" class="form-control" id="h_p_name" name="h_p_name" value="상품명"></p>
                                    <p class="card-text text-body-secondary">가격 <input type="text" class="form-control" id="h_p_price" name="h_p_price" value="가격"></p>
                                    <p class="card-text text-body-secondary">재고 <input type="text" class="form-control" id="h_p_quantity" name="h_p_quantity" value="재고"></p>
                                    <p class="card-text text-body-secondary">설명 <textarea class="form-control" id="h_p_desc" name="h_p_desc" style="height: 10rem"></textarea></p>
                                    </form>
                                </div>
                            </div>
                    </div>
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
