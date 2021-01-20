<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.placeOrder.title"/></title>
</head>
<body>
    <c:set var="currentPage" value="/jsp/customer/place_order.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>
    <br>
    <div class="table-responsive">
        <table class="table table-hover table-bordered">
            <tbody>
            <tr class="accordion-toggle collapsed text-left" data-toggle="collapse" href="#collapseOne">
                <td class="text-right"><fmt:message bundle="${loc}" key="page.placeOrder.totalPrice"/>:</td>
                <td class="text-left">${cartPrice}</td>
            </tr>
            <tr class="hide-table-padding">
                <td></td>
                <td>
                    <div id="collapseOne" class="collapse in p-3">
                        <div class="row">
                            <div class="col-1">#</div>
                            <div class="col-4"><fmt:message bundle="${loc}" key="page.placeOrder.name"/></div>
                            <div class="col-1"><fmt:message bundle="${loc}" key="page.placeOrder.quantity"/></div>
                            <div class="col-1"><fmt:message bundle="${loc}" key="page.placeOrder.price"/></div>
                        </div>
                        <c:forEach var="cart" items="${cart}" varStatus="status">
                        <div class="row">
                            <div class="col-1">${status.count}</div>
                            <div class="col-4">${cart.key.name}</div>
                            <div class="col-1">${cart.value}</div>
                            <div class="col-1">${cart.key.price*cart.value}</div>
                        </div>
                        </c:forEach>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="container text-center justify-content-center" style="margin-top: 10px">
        <div class="row justify-content-center">
            <div class="col">
                <form action="CafeServlet" method="post" >
                    <input type="hidden" name="service" value="PLACE_ORDER">

                        <legend><fmt:message bundle="${loc}" key="page.placeOrder.deliveryAddress"/></legend>
                        <div class="justify-content-center d-inline-block" style="margin: 0px 30px">
                            <c:forEach items="${addresses}" var="address" varStatus="status">
                                <div class="custom-control custom-radio d-inline-block h-100">
                                    <input type="radio" id="${status.count}" name="addressId" class="custom-control-input" value="${address.addressId}" required>
                                    <label class="custom-control-label" for="${status.count}">
                                        <h5><fmt:message bundle="${loc}" key="page.placeOrder.address"/> #${status.count}</h5>
                                        <address class="font-italic">
                                            <fmt:message bundle="${loc}" key="page.placeOrder.addressLine1"/>: ${address.addressLine1}<br>
                                            <fmt:message bundle="${loc}" key="page.placeOrder.addressLine2"/>: ${address.addressLine2}<br>
                                            <fmt:message bundle="${loc}" key="page.placeOrder.comment"/>: ${address.comment}
                                        </address>
                                    </label>
                                </div>
                            </c:forEach>
                            <div class="custom-control custom-radio d-inline-block h-100" style="margin: 0px 30px">
                                <input type="radio" id="customRadio" name="addressId" class="custom-control-input" value="newAddress" required>
                                <label class="custom-control-label" for="customRadio">
                                        <h5><fmt:message bundle="${loc}" key="page.placeOrder.newAddress"/></h5>
                                        <label for="addressLine1" class="font-italic"><fmt:message bundle="${loc}" key="page.placeOrder.addressLine1"/></label>
                                        <input type="text" id="addressLine1" name="addressLine1" placeholder="15 Zhenis str"><br>
                                        <label for="addressLine2" class="font-italic"><fmt:message bundle="${loc}" key="page.placeOrder.addressLine2"/></label>
                                        <input type="text" id="addressLine2" name="addressLine2" placeholder="block B, apt 133"><br>
                                        <label for="comment" class="font-italic"><fmt:message bundle="${loc}" key="page.placeOrder.comment"/></label>
                                        <input type="text" id="comment" name="comment" placeholder="домофон не работает">                                </label>
                            </div>
                        </div>

                    <br><br>

                        <legend><fmt:message bundle="${loc}" key="page.placeOrder.deliveryTime"/></legend>
                        <div class="row justify-content-center">
                            <div class="col-3">
                                <input type="time" class="form-control" name="deliveryTime" min="12:00"
                                       max="22:00" step="600" required>
                            </div>
                        </div>

                    <br><br>

                        <legend><fmt:message bundle="${loc}" key="page.placeOrder.paymentMethod"/></legend>
                        <div class="row justify-content-center">
                            <div class="col-5">
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadio3" name="paymentType" class="custom-control-input"
                                           value="card" required disabled>
                                    <label class="custom-control-label" for="customRadio3"><fmt:message bundle="${loc}" key="page.placeOrder.onlineCard"/></label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadio4" name="paymentType" class="custom-control-input"
                                           value="bitcoin" required disabled>
                                    <label class="custom-control-label" for="customRadio4"><fmt:message bundle="${loc}" key="page.placeOrder.bitcoin"/></label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadio5" name="paymentType" class="custom-control-input"
                                           value="cash" required>
                                    <label class="custom-control-label" for="customRadio5"><fmt:message bundle="${loc}" key="page.placeOrder.cash"/></label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadio6" name="paymentType" class="custom-control-input"
                                           value="card" required>
                                    <label class="custom-control-label" for="customRadio6"><fmt:message bundle="${loc}" key="page.placeOrder.deliveryCard"/></label>
                                </div>
                            </div>
                        </div>

                    <br><br>

                        <legend><fmt:message bundle="${loc}" key="page.placeOrder.commentSection"/></legend>
                        <div>
                            <textarea name="comments" id="comments" placeholder="<fmt:message bundle="${loc}" key="page.placeOrder.commentPrompt"/>" style="font-family:sans-serif;font-size:1.2em;"></textarea>
                        </div>

                    <br><hr style="border-color: #1e7e34">
                    <button type="submit" class="btn btn-outline-success my-2 my-sm-0"><fmt:message bundle="${loc}" key="page.placeOrder.submitOrder"/></button>
                </form>
            </div>
        </div>
    </div>

    <br>
    <br>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
