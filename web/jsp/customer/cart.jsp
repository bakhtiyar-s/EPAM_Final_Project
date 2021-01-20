<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.cart.title"/></title>
</head>
<body>
    <c:set var="currentPage" value="/jsp/customer/cart.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>

    <div class="container text-center justify-content-center" style="margin-top: 20px">
        <c:if test="${empty cart}">
            <p><fmt:message bundle="${loc}" key="page.cart.cartIsEmpty"/></p>
            <a class="btn btn-outline-info my-2 my-sm-0" href="${root}/CafeServlet?service=SHOW_MENU"><fmt:message bundle="${loc}" key="button.ourMenu"/></a>
            </c:if>
        <c:if test="${not empty cart}">
            <div class="row">
                <div class="col">
                    <br>
                    <h5><fmt:message bundle="${loc}" key="page.cart.shoppingCart"/></h5><br>
                    <table class="table table-hover table-bordered">
                        <thead class="thead-light text-uppercase">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message bundle="${loc}" key="page.cart.name"/></th>
                            <th scope="col"><fmt:message bundle="${loc}" key="page.cart.quantity"/></th>
                            <th scope="col"><fmt:message bundle="${loc}" key="page.cart.extendedPrice"/></th>
                            <th scope="col"><fmt:message bundle="${loc}" key="page.cart.remove"/></th>
                        </tr>
                        </thead>
                        <tbody class="text-left">
                        <c:forEach var="cart" items="${cart}" varStatus="status">
                            <tr>
                                <td scope="row">${status.count}</td>
                                <td>${cart.key.name}</td>
                                <td class="text-right">${cart.value}</td>
                                <td class="text-right">${cart.key.price*cart.value}</td>
                                <td>
                                    <form name="removeDishFromCartForm" method="post" action="${root}/CafeServlet">
                                        <div class="form-row justify-content-center">
                                            <input type="hidden" name="service" value="REMOVE_FROM_CART">
                                            <input type="hidden" name="menuItemId" value="${cart.key.id}">
                                            <button class="btn btn-outline-warning my-2 my-sm-0" type="submit"><fmt:message bundle="${loc}" key="page.cart.remove"/></button>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr class="text-right">
                            <th scope="row" colspan="3"><fmt:message bundle="${loc}" key="page.cart.totalPrice"/>:</th>
                            <th colspan="2" class="text-center">${cartPrice}</th>
                        </tr>
                        </tfoot>
                    </table>
                    <br>
                    <form name="placeOrderForm" method="get" action="${root}/controller">
                        <input type="hidden" name="service" value="SHOW_PLACE_ORDER_PAGE"/>
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><fmt:message bundle="${loc}" key="page.cart.placeOrder"/></button>
                    </form>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
