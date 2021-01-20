<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.title.login"/></title>
    <style>
        form {
            border: 3px solid #f1f1f1;
        }

        input[type=email], input[type=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            opacity: 0.8;
        }

        .container {
            padding: 16px;
        }
        @media screen and (max-width: 300px) {
            span.password {
                display: block;
                float: none;
            }
    </style>
</head>
<body>
    <c:set var="currentPage" value="/jsp/guest/login.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

<form action="CafeServlet" method="post">

    <input type="hidden" id="serviceId" name="service" value="LOGIN">
    <div class="container">
        <h1><fmt:message bundle="${loc}" key="page.login.login"/></h1>
        <c:if test="${loginFailed}">
            <p class="text-danger"><fmt:message bundle="${loc}" key="page.login.badLoginData"/></p>
        </c:if>
        <c:if test="${registrationSuccess}">
            <p class="alert-success"><fmt:message bundle="${loc}" key="page.reg.registrationSuccess"/></p>
            <c:remove var="registrationSuccess"/>
        </c:if>
        <p><fmt:message bundle="${loc}" key="page.login.prompt"/></p>
        <hr>
        <label for="email"><b><fmt:message bundle="${loc}" key="page.login.email"/></b></label>
        <input type="email" placeholder="user@company.com" name="email" id="email" required>

        <label for="password"><b><fmt:message bundle="${loc}" key="page.login.password"/></b></label>
        <input type="password" placeholder="<fmt:message bundle="${loc}" key="page.login.enterPassword"/>" name="password" id="password" required>

        <button type="submit"><fmt:message bundle="${loc}" key="page.login.buttonLogin"/></button>
    </div>
</form>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
