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
</head>
<body>
<form action="/update_item" method="post" enctype="multipart/form-data">
    <input type="file" name="attachments" id="attachments" multiple><br>
    <select id="p-category" name="h_p_category" class="form-select">
        <option selected disabled>카테고리 선택</option>
        <c:forEach var="category" items="${cList}">
            <option value="${category.c_name}">${category.c_name}</option>
        </c:forEach>
    </select>
    <input type="hidden" name="h_p_num" value="${inventory.h_p_num}">
    상품명 <input type="text" id="p-name" name="h_p_name" value="${inventory.h_p_name}"><br>
    가격 <input type="text" id="p-price" name="h_p_price" value="${inventory.h_p_price}"> 원<br>
    수량 <input type="text" id="p-inven" name="h_p_quantity" value="${inventory.h_p_quantity}"> 개<br>
    상품설명 <input type="text" id="p-desc" name="h_p_desc" value="${inventory.h_p_desc}"><br>
    <input type="submit">
</form>
</body>
</html>
