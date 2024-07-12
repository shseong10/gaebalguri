<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-07-11
  Time: 오후 3:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="card mb-3 p-3 w-75 mx-auto">
    <div class="p-3">
        <div class="row row-cols-2">
            <div class="col-md-4">
                상품 이미지
                <input type="file" class="form-control" name="attachments" id="attachments" multiple>
            </div>
            <div class="col-md-8">
                <div class="row row-cols-2 gy-3">
                    <div class="col-6">
                        상품명
                        <input type="text" class="form-control" id="p-name" name="h_p_name" value="${inventory.h_p_name}">
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
                        <input type="text" class="form-control" id="p-price" name="h_p_price" value="${inventory.h_p_price}">
                    </div>
                    <div class="col-6">
                        수량
                        <input type="text" class="form-control" id="p-inven" name="h_p_quantity" value="${inventory.h_p_quantity}">
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
                                    <input type="text" id="h_p_enddate" value="#">
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
                                                <input type="text" class="form-control" size="1em" id="inputUserLevel">
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
                    <textarea class="form-control" id="h_p_desc" name="h_p_desc" style="height: 10rem" value="${inventory.h_p_desc}">${inventory.h_p_desc}</textarea>
                </div>
            </div><!-- 상품정보 랩핑 끝-->
        </div><!-- 상품이미지/상품정보 좌우정렬 -->
    </div><!-- 전체 내용 랩핑 끝 -->
</div><!-- 컨테이너 끝-->
</body>
</html>
