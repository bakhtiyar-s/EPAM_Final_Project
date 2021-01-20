<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.title.main"/></title>
    <style>
        .header {
            background-image: url("/resources/images/backgroundImage.jpg");
            background-size: cover;
            background-position: center;
            position: relative;
        }
        .overlay {
            position: absolute;
            min-height: 100%;
            min-width: 100%;
            left: 0;
            top: 0;
            background: rgba(0, 0, 0, 0.6);
        }
        .description {
            left: 50%;
            position: absolute;
            top: 45%;
            transform: translate(-50%, -55%);
            text-align: center;
        }
        .description h1 {
            color: #6ab446;
        }
        .description p {
            color: #fff;
            font-size: 1.3rem;
            line-height: 1.5;
        }
        .description button {
            border:1px solid #6ab446;
            background:#6ab446;
            border-radius: 0;
            color:#fff;
        }
        .description button:hover {
            border:1px solid #fff;
            background:#fff;
            color:#000;
        }
    </style>
</head>
<body>

    <jsp:include page="/jsp/service/header.jsp"/>
    <c:set var="currentPage" value="/jsp/main.jsp" scope="session"/>

    <header class="page-header header container-fluid">
        <div class="overlay"></div>

        <div class="description">
            <h1 class=""><fmt:message bundle="${loc}" key="page.main.welcome"/></h1>
            <p><fmt:message bundle="${loc}" key="page.main.text"/>
            </p>
            <form method="post" action="${root}/CafeServlet">
                <input type="hidden" name="service" value="SHOW_MENU">
                <button class="btn btn-outline-secondary btn-lg"><fmt:message bundle="${loc}" key="page.main.showMenu"/></button>
            </form>
        </div>

    </header>
    <jsp:include page="/jsp/service/footer.jsp"/>
    <script>
        $(document).ready(function(){
            $('.header').height($(window).height());
        })
    </script>
</body>
</html>
