<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:import url="/jsp/service/head.jsp"/>

<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <title><fmt:message bundle="${loc}" key="page.editMenu.title"/></title>
</head>
<body>
    <c:set var="currentPage" value="/jsp/administrator/edit_menu_item.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>


    <div class="container text-center" style="margin-top: 30px">
        <div class="row">
            <div class="col">
            <span class="text-danger">
                <c:if test="${menuItemChanged}">
                    <span class="text-success"><fmt:message bundle="${loc}" key="page.editMenu.successMsg"/></span>
                    <br><br>
                    <c:remove var="menuItemChanged"/>
                </c:if>
                <a class="btn btn-outline-success" href="${root}/CafeServlet?service=SHOW_MENU"><fmt:message bundle="${loc}" key="page.editMenu.backToMenu"/></a>
            </div>
        </div>
        <br>
        <div class="row justify-content-md-center text-left">
            <div class="col-6">
                <form method="post" action="${root}/CafeServlet">
                    <input type="hidden" name="service" value="EDIT_MENU_ITEM">
                    <legend class="text-center"><fmt:message bundle="${loc}" key="page.editMenu.title"/></legend><br>
                    <div class="form-group row">
                        <label for="id" class="col col-form-label"><fmt:message bundle="${loc}" key="page.editMenu.id"/></label>
                        <div class="col">
                            <input type="text" class="form-control" id="id" placeholder="${menuItem.id}" disabled>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="type" class="col col-form-label"><fmt:message bundle="${loc}" key="page.editMenu.category"/></label>
                        <div class="col">
                            <input type="text" class="form-control" id="type" placeholder="${menuItem.category}" disabled>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="name" class="col col-form-label"><fmt:message bundle="${loc}" key="page.editMenu.name"/></label>
                        <div class="col">
                            <textarea type="text" class="form-control" id="name" name="name">${menuItem.name}</textarea>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="description" class="col col-form-label"><fmt:message bundle="${loc}" key="page.editMenu.description"/></label>
                        <div class="col">
                            <textarea id="description" class="form-control" id="description" rows="4" cols="50"
                                  name="description">${menuItem.description}</textarea>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="price" class="col col-form-label"><fmt:message bundle="${loc}" key="page.editMenu.price"/></label>
                        <div class="col">
                            <input required type="number" step="10" name="price" class="form-control"
                                   id="price" value="${menuItem.price}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="stopLoss" class="col col-form-label"><fmt:message bundle="${loc}" key="page.editMenu.outOfStock"/></label>
                        <div class="col">
                            <select id="stopLoss" class="form-control" required name="stopLoss">
                                <option selected>${menuItem.stoploss}</option>
                                <c:if test="${menuItem.stoploss}">
                                    <option value="false">false</option>
                                </c:if>
                                <c:if test="${!menuItem.stoploss}">
                                    <option value="true">true</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row text-center">

                        <div class="col">
                            <button class="btn btn-outline-success" type="submit"><fmt:message bundle="${loc}" key="page.editMenu.submit"/></button>
                        </div>
                    </div>
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
