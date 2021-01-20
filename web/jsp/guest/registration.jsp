<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.title.reg"/></title>
    <style>
        * {box-sizing: border-box}

        .container {
            padding: 16px;
        }

        input[type=text], input[type=password], input[type=tel], input[type=email]   {
            width: 100%;
            padding: 15px;
            margin: 5px 0 22px 0;
            display: inline-block;
            border: none;
            background: #f1f1f1;
        }

        input[type=text]:focus, input[type=password]:focus, input[type=tel]:focus, input[type=email]:focus {
            background-color: #ddd;
            outline: none;
        }

        hr {
            border: 1px solid #f1f1f1;
            margin-bottom: 25px;
        }

        .registerbtn {
            background-color: #4CAF50;
            color: white;
            padding: 16px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            opacity: 0.9;
        }

        .registerbtn:hover {
            opacity:1;
        }

        a {
            color: dodgerblue;
        }

        .signin {
            background-color: #f1f1f1;
            text-align: center;
        }
    </style>
</head>
<body>

    <c:set var="currentPage" value="/jsp/guest/registration.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

<form action="CafeServlet" method="post">

    <input type="hidden" id="serviceId" name="service" value="REGISTER_CLIENT">
    <div class="container">
        <h1><fmt:message bundle="${loc}" key="page.reg"/></h1>
        <p><fmt:message bundle="${loc}" key="page.reg.prompt"/></p>
        <c:if test="${passwordsDoNotMatch}">
            <p class="alert-danger"><fmt:message bundle="${loc}" key="page.reg.passwordsDoNotMatch"/></p>
            <br>
            <c:remove var="passwordsDoNotMatch"/>
        </c:if>
        <hr>
        <label for="first_name"><b><fmt:message bundle="${loc}" key="page.reg.firstName"/></b></label>
        <input type="text" pattern="[A-Z]{1}[a-z]{1,19}|[А-ЯЁ]{1}[а-яё]{1,19}" placeholder="<fmt:message bundle="${loc}" key="page.reg.firstName"/>" name="first_name" id="first_name" required>

        <label for="last_name"><b><fmt:message bundle="${loc}" key="page.reg.lastName"/></b></label>
        <input type="text" pattern="[A-Z]{1}[a-z]{1,19}|[А-ЯЁ]{1}[а-яё]{1,19}" placeholder="<fmt:message bundle="${loc}" key="page.reg.lastName"/>" name="last_name" id="last_name" required>

        <label for="phoneNumber"><b><fmt:message bundle="${loc}" key="page.reg.phone"/></b></label>
        <input type="tel" pattern="(?:\(\d{3}\)|\d{3})[- ]?\d{3}[- ]?\d{4}" placeholder="(XXX)XXX-XXXX" name="phoneNumber" id="phoneNumber" required>

        <label for="email"><b><fmt:message bundle="${loc}" key="page.reg.email"/></b></label>
        <input type="email" placeholder="<fmt:message bundle="${loc}" key="page.reg.enterEmail"/>" name="email" id="email" required>

        <label for="password"><b><fmt:message bundle="${loc}" key="page.reg.Password"/></b></label>
        <input type="password" placeholder="<fmt:message bundle="${loc}" key="page.reg.enterPassword"/>" name="password" id="password" required>

        <label for="psw-repeat"><b><fmt:message bundle="${loc}" key="page.reg.RepeatPassword"/></b></label>
        <input type="password" placeholder="<fmt:message bundle="${loc}" key="page.reg.RepeatPassword"/>" name="psw-repeat" id="psw-repeat" required>
        <hr>

        <p><fmt:message bundle="${loc}" key="page.reg.terms"/></p>
        <button type="submit" class="registerbtn"><fmt:message bundle="${loc}" key="page.reg.buttReg"/></button>
    </div>

    <div class="container signin">
        <p><fmt:message bundle="${loc}" key="page.reg.alreadyHaveAccount"/> <a href="${root}/jsp/guest/login.jsp"><fmt:message bundle="${loc}" key="page.reg.signIn"/></a>.</p>
    </div>

</form>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>