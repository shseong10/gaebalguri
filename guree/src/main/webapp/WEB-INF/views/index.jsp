<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>


</style>
<script>
    // const myCarouselElement = document.querySelector('#myCarousel')
    //
    // const carousel = new bootstrap.Carousel(myCarouselElement, {
    //     interval: 2000,
    //     touch: false
    // })

    const msg = '${msg}';
    if (msg !== '') {

        alert(msg);
    }
    // $(document).ready(function () {
    //     $("#login").click(function () {
    //         location.href = "/member/login";
    // });
    //
    // $('#logout').click(function () {
    //     const form = `
	// 		<form action="/member/logout" method="post">
	// 		</form>
	// 	`;
    //     $(form).appendTo($('body')).submit();
    // });
    // });
</script>

<body>

<header>
<jsp:include page="header.jsp"></jsp:include>
</header>

<nav>
    <jsp:include page="nav.jsp"></jsp:include>
    </nav>

<section>
    <jsp:include page="section.jsp"></jsp:include>
</section>

<footer>
    <jsp:include page="footer.jsp"></jsp:include>
</footer>




</body>
</html>