<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.userProfile.title"/></title>
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
            background: rgba(0, 0, 0, 0.4);
        }

        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            max-width: 300px;
            margin: auto;
            text-align: center;
        }

        button {
            border: none;
            outline: 0;
            display: inline-block;
            padding: 8px;
            color: white;
            background-color: #6ab446;
            text-align: center;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
        }

        button:hover, a:hover {
            opacity: 0.7;
        }

    </style>
</head>
<body>
    <c:set var="currentPage" value="/jsp/customer/profile.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

    <header class="page-header header container-fluid">
        <div class="overlay"></div>
        <br>

        <div class="card">
            <img src="/resources/images/profilePhoto.jpg" style="width:100%">
            <h3>${user.firstName} ${user.lastName}</h3>
            <p>+7 ${user.phoneNumber}</p>
            <p>${user.email}</p>
            <p><button type="button" data-toggle="collapse" data-target="#collapse" aria-expanded="false" aria-controls="collapse">
                <fmt:message bundle="${loc}" key="page.userProfile.changePassword"/></button>
            </p>
            <c:if test="${passwordChanged}">
                <p class="alert-success"><fmt:message bundle="${loc}" key="page.userProfile.passwordChangeMsg"/></p>
                <br>
                <c:remove var="passwordChanged"/>
            </c:if>
            <c:if test="${passwordsDoNotMatch}">
                <p class="alert-danger"><fmt:message bundle="${loc}" key="page.userProfile.passwordsDoNotMatch"/></p>
                <br>
                <c:remove var="passwordsDoNotMatch"/>
            </c:if>
            <div class="collapse" id="collapse">
                    <form action="CafeServlet" method="post">
                        <input type="hidden" id="serviceId" name="service" value="CHANGE_PASSWORD">
                        <label for="currentPassword"><b><fmt:message bundle="${loc}" key="page.userProfile.currentPassword"/></b></label>
                        <input type="password" placeholder="<fmt:message bundle="${loc}" key="page.userProfile.enterCurrentPassword"/>" name="currentPassword" id="currentPassword" required>

                        <label for="newPassword"><b><fmt:message bundle="${loc}" key="page.userProfile.newPassword"/></b></label>
                        <input type="password" placeholder="<fmt:message bundle="${loc}" key="page.userProfile.enterNewPassword"/>" name="newPassword" id="newPassword" required>

                        <label for="repeatPassword"><b><fmt:message bundle="${loc}" key="page.userProfile.repeatPassword"/></b></label>
                        <input type="password" placeholder="<fmt:message bundle="${loc}" key="page.userProfile.repeatNewPassword"/>" name="repeatPassword" id="repeatPassword" required>
                        <br><br>
                        <button type="submit" class="registerbtn"><fmt:message bundle="${loc}" key="page.userProfile.changeBtn"/></button>
                    </form>
            </div>
        </div>
        <br>
    </header>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function(){
            $('.header').height($(window).height());
        })
    </script>
</body>
</html>
