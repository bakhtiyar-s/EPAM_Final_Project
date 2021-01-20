<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.address.title"/></title>
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
            max-width: 400px;
            margin: auto;
            text-align: center;
            padding: 10px;
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
    <c:set var="currentPage" value="/jsp/customer/address.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

    <header class="justify-content-center page-header header container-fluid">
        <div class="overlay"></div>
        <br>
        <div class="d-inline-block">
            <c:forEach items="${addresses}" var="address" varStatus="status">
                <div class="card d-inline-block h-100" style="margin: 20px 40px">
                    <img src="${pageContext.request.contextPath}/resources/images/address.png" alt="image" style="width:100%">
                    <h5><fmt:message bundle="${loc}" key="page.address.address"/> #${status.count}</h5>
                    <address class="font-italic">
                        <fmt:message bundle="${loc}" key="page.address.addressLine1"/>: ${address.addressLine1}<br>
                        <fmt:message bundle="${loc}" key="page.address.addressLine2"/>: ${address.addressLine2}<br>
                        <fmt:message bundle="${loc}" key="page.address.comment"/>: ${address.comment}
                    </address>
                </div>
            </c:forEach>
            <div class="card d-inline-block h-200" style="margin: 20px 40px">
                <form action="CafeServlet" method="post">
                    <input type="hidden" name="service" value="ADD_NEW_ADDRESS">
                    <h5><fmt:message bundle="${loc}" key="page.address.newAddress"/></h5>

                    <label for="addressLine1" class="font-italic"><fmt:message bundle="${loc}" key="page.address.addressLine1"/></label>
                    <input type="text" id="addressLine1" name="addressLine1" placeholder="15 Zhenis str" required><br>

                    <label for="addressLine2" class="font-italic"><fmt:message bundle="${loc}" key="page.address.addressLine2"/></label>
                    <input type="text" id="addressLine2" name="addressLine2" placeholder="block B, apt 133" required><br>

                    <label for="comment" class="font-italic"><fmt:message bundle="${loc}" key="page.address.comment"/></label>
                    <input type="text" id="comment" name="comment" placeholder="домофон не работает">

                    <button type="submit"><fmt:message bundle="${loc}" key="page.address.save"/></button>
                </form>
            </div>
        </div>
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
