<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.orderHistory.title"/></title>
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
        table.table td a.view {
            width: 30px;
            height: 30px;
            color: #6ab446;
            border: 2px solid;
            border-radius: 30px;
            text-align: center;
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
        .status {
            font-size: 30px;
            margin: 2px 2px 0 0;
            display: inline-block;
            vertical-align: middle;
            line-height: 10px;
        }
        .text-success {
            color: #10c469;
        }
    </style>
    <script>
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</head>
<body>
    <c:set var="currentPage" value="/jsp/customer/order_history.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-4">
                            <h2><fmt:message bundle="${loc}" key="page.orderHistory.orders"/></h2>
                        </div>
                    </div>
                </div>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th><fmt:message bundle="${loc}" key="page.orderHistory.orderDate"/></th>
                        <th><fmt:message bundle="${loc}" key="page.orderHistory.status"/></th>
                        <th><fmt:message bundle="${loc}" key="page.orderHistory.totalPrice"/></th>
                        <th><fmt:message bundle="${loc}" key="page.orderHistory.details"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orderHistory}" var="order" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td>
                            <fmt:parseDate value="${order.orderTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                            <fmt:formatDate pattern="dd.MM.yyyy HH:mm" value="${ parsedDateTime }" />
                        </td>
                        <td><span class="status text-success">&bull;</span>${order.orderStatus}</td>
                        <td>${order.totalPrice}</td>
                        <td><a href="${root}/CafeServlet?service=ORDER_DETAILS&amp;orderId=${order.orderId}" class="view" title="View Details" data-toggle="tooltip">></a></td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
