<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <c:set var="imgFolderLocation"  value="${initParam.imageLocation}"/>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.orderDetails.title"/></title>
    <style>
        body {
            font-family: 'Varela Round', sans-serif;
            font-size: 13px;
            background-image: url("/resources/images/backgroundImage.jpg");
            background-size: cover;
            background-position: center;
            position: relative;
        }
        .table-responsive {
            margin: 30px 0;
        }
        .table-wrapper {
            min-width: 1000px;
            background: #fff;
            padding: 20px 25px;
            border-radius: 3px;
            box-shadow: 0 1px 1px rgba(0,0,0,.05);
        }

        .table-title {
            color: #fff;
            background: #6ab446;
            padding: 16px 25px;
            margin: -20px -25px 10px;
            border-radius: 3px 3px 0 0;
        }
        .table-title h2 {
            margin: 5px 0 0;
            font-size: 24px;
        }

        table.table tr th, table.table tr td {
            border-color: #e9e9e9;
            padding: 12px 15px;
            vertical-align: middle;
        }
        table.table tr th:first-child {
            width: 60px;
        }
        table.table tr th:last-child {
            width: 80px;
        }
        table.table-striped tbody tr:nth-of-type(odd) {
            background-color: #fcfcfc;
        }
        table.table-striped.table-hover tbody tr:hover {
            background: #f5f5f5;
        }
        table.table th i {
            font-size: 13px;
            margin: 0 5px;
            cursor: pointer;
        }
        table.table td a {
            font-weight: bold;
            color: #566787;
            display: inline-block;
            text-decoration: none;
        }
        table.table td a:hover {
            color: #2196F3;
        }

        table.table td a.view i {
            font-size: 22px;
            margin: 2px 0 0 1px;
        }
        table.table {
            border-radius: 50%;
            vertical-align: middle;
            margin-right: 10px;
        }

        .text-center .btn {
            border:1px solid #6ab446;
            background:#6ab446;
            border-radius: 0;
            color:#fff;
        }
    </style>
</head>
<body>
    <c:set var="currentPage" value="/jsp/customer/order_details.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-4">
                            <h2><fmt:message bundle="${loc}" key="page.orderDetails.title"/></h2>
                        </div>
                    </div>
                </div>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th><fmt:message bundle="${loc}" key="page.orderDetails.image"/></th>
                        <th><fmt:message bundle="${loc}" key="page.orderDetails.name"/></th>
                        <th><fmt:message bundle="${loc}" key="page.orderDetails.price"/></th>
                        <th><fmt:message bundle="${loc}" key="page.orderDetails.quantity"/></th>
                        <th><fmt:message bundle="${loc}" key="page.orderDetails.extendedPrice"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orderDetails}" var="menuItem" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td><img src="${pageContext.request.contextPath}${imgFolderLocation}${menuItem.key.imageLocation}" alt="picture" width="200" height="150"></td>
                            <td>${menuItem.key.name}</td>
                            <td>${menuItem.key.price}</td>
                            <td>${menuItem.value}</td>
                            <td>${menuItem.value*menuItem.key.price}</td>
                            </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <br><br>
                <div class="text-center">
                    <c:if test="${userCategory eq 'registered_user'}">
                        <a class="btn btn-outline-secondary btn-lg" href="${root}/jsp/customer/order_history.jsp"><fmt:message bundle="${loc}" key="page.orderDetails.backToOrders"/></a>
                    </c:if>
                    <c:if test="${userCategory eq 'administrator'}">
                        <a class="btn btn-outline-secondary btn-lg" href="${root}/CafeServlet?service=SHOW_ALL_ORDERS"><fmt:message bundle="${loc}" key="page.orderDetails.backToOrders"/></a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
