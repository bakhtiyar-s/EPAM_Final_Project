<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.confirmedOrder.title"/></title>
    <style>
        body {
            color: #566787;
            background: #f5f5f5;
            font-family: 'Varela Round', sans-serif;
            font-size: 13px;
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
            color: #2196F3;
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
        td {
            width:16%;
        }
        .text-center button {
            border:1px solid #6ab446;
            background:#6ab446;
            border-radius: 0;
            color:#fff;
        }
    </style>
    <script>
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</head>
<body>
    <c:set var="currentPage" value="/jsp/customer/confirmed_order.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

    <c:if test="${orderConfirmed}">
        <br>
        <br>
        <h4 class="text-success text-center"><fmt:message bundle="${loc}" key="page.confirmedOrder.confirmMsg"/></h4><br>
        <br>
        <c:remove var="orderConfirmed"/>
    </c:if>
    <c:if test="${orderCancelled}">
        <br>
        <br>
        <h4 class="text-success text-center"><fmt:message bundle="${loc}" key="page.confirmedOrder.cancelMsg"/></h4><br>
        <br>
        <c:remove var="orderCancelled"/>
    </c:if>
    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-4">
                            <h2><fmt:message bundle="${loc}" key="page.confirmedOrder.currentOrder"/></h2>
                        </div>
                    </div>
                </div>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th><fmt:message bundle="${loc}" key="page.confirmedOrder.orderDate"/></th>
                        <th><fmt:message bundle="${loc}" key="page.confirmedOrder.deliveryTime"/></th>
                        <th><fmt:message bundle="${loc}" key="page.confirmedOrder.status"/></th>
                        <th><fmt:message bundle="${loc}" key="page.confirmedOrder.totalPrice"/></th>
                        <th><fmt:message bundle="${loc}" key="page.confirmedOrder.paymentType"/></th>
                        <c:if test="${not orderCancelled}">
                            <th><fmt:message bundle="${loc}" key="page.confirmedOrder.cancel"/></th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <fmt:parseDate value="${lastOrder.orderTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                <fmt:formatDate pattern="dd.MM.yyyy HH:mm" value="${ parsedDateTime }" />
                            </td>
                            <td>${lastOrder.deliverByTime}</td>
                            <td><span class="status text-success">&bull;</span>${lastOrder.orderStatus}</td>
                            <td>${lastOrder.totalPrice}</td>
                            <td>${lastOrder.paymentType}</td>
                            <c:if test="${not orderCancelled}">
                                <td>
                                    <form method="post" action="${root}/CafeServlet">
                                        <div class="form-row justify-content-left">
                                            <input type="hidden" name="service" value="CANCEL_ORDER">
                                            <input type="hidden" name="orderId" value="${lastOrder.orderId}">
                                            <button class="btn btn-outline-warning my-2 my-sm-0" type="submit"><fmt:message bundle="${loc}" key="page.confirmedOrder.cancelOrder"/></button>
                                        </div>
                                    </form>
                                </td>
                            </c:if>
                        </tr>
                    </tbody>
                </table>
                <br><br>
                <div class="text-center">
                    <form method="post" action="${root}/CafeServlet">
                        <input type="hidden" name="service" value="SHOW_ORDERS">
                        <button class="btn btn-outline-secondary btn-lg"><fmt:message bundle="${loc}" key="page.confirmedOrder.myOrders"/></button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
