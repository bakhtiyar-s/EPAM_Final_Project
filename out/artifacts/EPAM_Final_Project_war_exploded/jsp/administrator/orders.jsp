<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>

<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.userOrder.title"/></title>
</head>
<body>
<c:import url="/jsp/service/header.jsp"/>
<c:set var="currentPage" scope="session" value="/jsp/admin/orders.jsp"/>


<div class="container text-center justify-content-center" style="margin-top: 50px">
    <div class="row">
        <div class="col">
            <c:if test="${empty orders}">
                <fmt:message bundle="${loc}" key="page.userOrder.noOrdersMsg"/>
            </c:if>
            <c:if test="${orderCancelled}">
                <span class="text-success"><fmt:message bundle="${loc}" key="page.userOrder.orderCancelledMsg"/></span>
                <c:remove var="orderCancelled"/>
            </c:if>
            <c:if test="${orderCompleted}">
                <span class="text-success"><fmt:message bundle="${loc}" key="page.userOrder.orderCompletedMsg"/></span>
                <c:remove var="orderCompleted"/>
            </c:if>
            <c:if test="${not empty orders}">
                <h2 class="text-center"><fmt:message bundle="${loc}" key="page.userOrder.title"/>
                </h2><br>
                <table class="table table-hover table-bordered">
                    <thead class="thead-light text-uppercase">
                    <tr>
                        <th scope="col"><fmt:message bundle="${loc}" key="page.userOrder.orderId"/></th>
                        <th scope="col"><fmt:message bundle="${loc}" key="page.userOrder.userId"/></th>
                        <th scope="col"><fmt:message bundle="${loc}" key="page.userOrder.orderDate"/></th>
                        <th scope="col"><fmt:message bundle="${loc}" key="page.userOrder.paymentType"/></th>
                        <th scope="col"><fmt:message bundle="${loc}" key="page.userOrder.orderPrice"/></th>
                        <th scope="col"><fmt:message bundle="${loc}" key="page.userOrder.orderStatus"/></th>
                    </tr>
                    </thead>
                    <tbody class="text-left">
                    <c:forEach var="order" items="${orders}" varStatus="status">
                        <tr>
                            <td class="text-center">
                                    ${order.orderId}<br>
                                <a class="btn btn-sm btn-outline-info my-2 my-sm-0"
                                   href="${root}/CafeServlet?service=ORDER_DETAILS&amp;orderId=${order.orderId}">
                                    <fmt:message bundle="${loc}" key="page.userOrder.orderDetails"/></a>
                            </td>
                            <td class="text-center">${order.userId}</td>
                            <td class="text-center"><fmt:parseDate value="${order.orderTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                <fmt:formatDate pattern="dd.MM.yyyy HH:mm" value="${ parsedDateTime }" /></td>
                            <td class="text-center">${order.paymentType}</td>
                            <td class="text-center">${order.totalPrice} <fmt:message bundle="${loc}" key="page.menu.tenge"/></td>
                            <td class="text-center">${order.orderStatus}
                                <c:if test="${order.orderStatus == 'PENDING'}">
                                    <form method="post" action="${root}/CafeServlet">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <button class="btn btn-sm btn-outline-danger my-2 my-sm-0" type="submit"
                                                formaction="${root}/CafeServlet?service=CANCEL_ORDER">
                                            <small><fmt:message bundle="${loc}" key="page.userOrder.orderCancel"/></small>
                                        </button>
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <button class="btn btn-sm btn-outline-success my-2 my-sm-0" type="submit"
                                                formaction="${root}/CafeServlet?service=COMPLETE_ORDER">
                                            <small><fmt:message bundle="${loc}" key="page.userOrder.orderComplete"/></small>
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</div>


<br>
<br>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>

