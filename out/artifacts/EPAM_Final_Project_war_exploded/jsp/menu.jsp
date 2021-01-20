<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>

<c:import url="/jsp/service/head.jsp"/>


<html>
<head>
    <fmt:setLocale value="${lang}" scope="session"/>
    <fmt:setBundle basename="locale" var="loc"/>
    <fmt:message bundle="${loc}" key="page.menu.starters" var="startersTitle"/>
    <fmt:message bundle="${loc}" key="page.menu.hotmeals" var="hotmealsTitle"/>
    <fmt:message bundle="${loc}" key="page.menu.soups" var="soupsTitle"/>
    <fmt:message bundle="${loc}" key="page.menu.desserts" var="dessertsTitle"/>
    <fmt:message bundle="${loc}" key="page.menu.drinks" var="drinksTitle"/>
    <fmt:message bundle="${loc}" key="page.menu.btnAddToCart" var="btnAddToCart"/>
    <fmt:message bundle="${loc}" key="page.menu.msgQuantity" var="msgQuantity"/>
    <fmt:message bundle="${loc}" key="page.menu.tenge" var="tg"/>
    <fmt:message bundle="${loc}" key="page.menu.outOfStock" var="outOfStock"/>
    <fmt:message bundle="${loc}" key="page.menu.edit" var="edit"/>
    <c:set var="imgFolderLocation"  value="${initParam.imageLocation}"/>

    <title><fmt:message bundle="${loc}" key="page.title.menu"/></title>
    <style>
        html {
            scroll-behavior: smooth !important;
        }

        #navbar_top{
            z-index: 10;
            background:#6ab446;
        }
        .wrapper{
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-auto-rows: 500px;
            grid-gap: 30px;
        }
        .block{
            background-color: lightseagreen;
        }
        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            max-width: 300px;
            margin: auto;
            text-align: center;
            font-family: arial;
        }
        .card:hover {
            box-shadow: 0 8px 12px 0 rgba(0,0,0,0.6)
        }

        .price {
            color: grey;
            font-size: 22px;
            margin: 5px;
        }

        .card button {
            display: inline-block;
            border: none;
            outline: 0;
            padding: 5px;
            color: white;
            background-color: #000;
            text-align: center;
            cursor: pointer;
            width: 180px;
            height: 40px;
            margin: 5px;
            font-size: 18px;
        }

        .card button:hover {
            opacity: 0.7;
        }

        .form-inline {
            margin: 5px auto;
            display: block;
        }

        .quantity {
            width: 80px;
            height: 40px;
            margin: 5px;
        }

        .description {
            height: 100px;
        }

        .itemName {
            text-align: center;
            height: 50px;
            padding: 5px 5px 5px 5px;
        }
    </style>
</head>
<body>
    <c:set var="currentPage" value="/jsp/menu.jsp" scope="session"/>
    <jsp:include page="/jsp/service/header.jsp"/>
    <nav id="navbar_top" class="sticky-top navbar navbar-expand-lg navbar-dark border-top">
        <div class="container">
            <a class="navbar-brand" href="#starters">${startersTitle}</a>
            <a class="navbar-brand" href="#hotmeals">${hotmealsTitle}</a>
            <a class="navbar-brand" href="#soups">${soupsTitle}</a>
            <a class="navbar-brand" href="#desserts">${dessertsTitle}</a>
            <a class="navbar-brand" href="#drinks">${drinksTitle}</a>
        </div>
    </nav>
    <div id="starters"></div>
    <br><br><br>
    <h1 style="margin-left: 50px">${startersTitle}</h1>
    <div class="wrapper starter container">
        <c:forEach items="${starters}" var="starter">
            <div class="block col-sm card">
                <img src="${pageContext.request.contextPath}${imgFolderLocation}${starter.imageLocation}" alt="picture" style="width:100%">
                <h5 class="itemName">${starter.name}</h5>
                <p class="price">${starter.price} ${tg}</p>
                <p class="description">${starter.description}</p>
                <c:if test="${isLogin==true}">
                    <c:if test="${userCategory eq 'registered_user'}">
                        <c:if test="${starter.stoploss eq false}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="ADD_TO_CART">
                            <input type="hidden" name="menuItemId" value="${starter.id}">
                            <input class="quantity" max="10" min="1" type="number" placeholder="${msgQuantity}" name="quantity" required>
                            <button type="submit">${btnAddToCart}</button>
                        </form>
                        </c:if>
                        <c:if test="${starter.stoploss eq true}"><button type="submit" disabled>${outOfStock}</button></c:if>
                    </c:if>
                    <c:if test="${userCategory eq 'administrator'}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="EDIT_MENU_ITEM_PAGE">
                            <input type="hidden" name="menuItemId" value="${starter.id}">
                            <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">${edit}</button>
                        </form>
                    </c:if>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <div id="hotmeals"></div>
    <br><br><br>
    <h1 style="margin-left: 50px">${hotmealsTitle}</h1>
    <div class="wrapper hotmeal container">
        <c:forEach items="${hotMeals}" var="hotMeal">
            <div class="block col-sm card">
                <img src="${pageContext.request.contextPath}${imgFolderLocation}${hotMeal.imageLocation}" alt="picture" style="width:100%">
                <h5 class="itemName">${hotMeal.name}</h5>
                <p class="price">${hotMeal.price} ${tg}</p>
                <p class="description">${hotMeal.description}</p>
                <c:if test="${isLogin==true}">
                    <c:if test="${userCategory eq 'registered_user'}">
                        <c:if test="${hotMeal.stoploss eq false}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="ADD_TO_CART">
                            <input type="hidden" name="menuItemId" value="${hotMeal.id}">
                            <input class="quantity" max="10" min="1" type="number" placeholder="${msgQuantity}" name="quantity" required>
                            <button type="submit">${btnAddToCart}</button>
                        </form>
                        </c:if>
                        <c:if test="${hotMeal.stoploss eq true}"><button type="submit" disabled>${outOfStock}</button></c:if>
                    </c:if>
                    <c:if test="${userCategory eq 'administrator'}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="EDIT_MENU_ITEM_PAGE">
                            <input type="hidden" name="menuItemId" value="${hotMeal.id}">
                            <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">${edit}</button>
                        </form>
                    </c:if>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <div id="soups"></div>
    <br><br><br>
    <h1 style="margin-left: 50px">${soupsTitle}</h1>
    <div class="wrapper hotmeal container">
        <c:forEach items="${soups}" var="soup">
            <div class="block col-sm card">
                <img src="${pageContext.request.contextPath}${imgFolderLocation}${soup.imageLocation}" alt="picture" style="width:100%">
                <h5 class="itemName">${soup.name}</h5>
                <p class="price">${soup.price} ${tg}</p>
                <p class="description">${soup.description}</p>
                <c:if test="${isLogin==true}">
                    <c:if test="${userCategory eq 'registered_user'}">
                        <c:if test="${soup.stoploss eq false}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="ADD_TO_CART">
                            <input type="hidden" name="menuItemId" value="${soup.id}">
                            <input class="quantity" max="10" min="1" type="number" placeholder="${msgQuantity}" name="quantity" required>
                            <button type="submit">${btnAddToCart}</button>
                        </form>
                        </c:if>
                        <c:if test="${soup.stoploss eq true}"><button type="submit" disabled>${outOfStock}</button></c:if>
                    </c:if>
                    <c:if test="${userCategory eq 'administrator'}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="EDIT_MENU_ITEM_PAGE">
                            <input type="hidden" name="menuItemId" value="${soup.id}">
                            <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">${edit}</button>
                        </form>
                    </c:if>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <div id="desserts"></div>
    <br><br><br>
    <h1 style="margin-left: 50px">${dessertsTitle}</h1>
    <div class="wrapper hotmeal container">
        <c:forEach items="${desserts}" var="dessert">
            <div class="block col-sm card">
                <img src="${pageContext.request.contextPath}${imgFolderLocation}${dessert.imageLocation}" alt="picture" style="width:100%">
                <h5 class="itemName">${dessert.name}</h5>
                <p class="price">${dessert.price} ${tg}</p>
                <p class="description">${dessert.description}</p>
                <c:if test="${isLogin==true}">
                    <c:if test="${userCategory eq 'registered_user'}">
                        <c:if test="${dessert.stoploss eq false}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="ADD_TO_CART">
                            <input type="hidden" name="menuItemId" value="${dessert.id}">
                            <input class="quantity" max="10" min="1" type="number" placeholder="${msgQuantity}" name="quantity" required>
                            <button type="submit">${btnAddToCart}</button>
                        </form>
                        </c:if>
                        <c:if test="${dessert.stoploss eq true}"><button type="submit" disabled>${outOfStock}</button></c:if>
                    </c:if>
                    <c:if test="${userCategory eq 'administrator'}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="EDIT_MENU_ITEM_PAGE">
                            <input type="hidden" name="menuItemId" value="${dessert.id}">
                            <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">${edit}</button>
                        </form>
                    </c:if>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <div id="drinks"></div>
    <br><br><br>
    <h1 style="margin-left: 50px">${drinksTitle}</h1>
    <div class="wrapper hotmeal container">
        <c:forEach items="${drinks}" var="drink">
            <div class="block col-sm card">
                <img src="${pageContext.request.contextPath}${imgFolderLocation}${drink.imageLocation}" alt="picture" style="width:100%">
                <h5 class="itemName">${drink.name}</h5>
                <p class="price">${drink.price} ${tg}</p>
                <p class="description">${drink.description}</p>
                <c:if test="${isLogin==true}">
                    <c:if test="${userCategory eq 'registered_user'}">
                        <c:if test="${drink.stoploss eq false}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="ADD_TO_CART">
                            <input type="hidden" name="menuItemId" value="${drink.id}">
                            <input class="quantity" max="10" min="1" type="number" placeholder="${msgQuantity}" name="quantity" required>
                            <button type="submit">${btnAddToCart}</button>
                        </form>
                        </c:if>
                        <c:if test="${drink.stoploss eq true}"><button type="submit" disabled>${outOfStock}</button></c:if>
                    </c:if>
                    <c:if test="${userCategory eq 'administrator'}">
                        <form class="form-inline" method="post" action="CafeServlet">
                            <input type="hidden" name="service" value="EDIT_MENU_ITEM_PAGE">
                            <input type="hidden" name="menuItemId" value="${drink.id}">
                            <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">${edit}</button>
                        </form>
                    </c:if>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <br>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
</body>
</html>
