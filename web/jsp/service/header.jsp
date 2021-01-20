<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="root" value="${pageContext.request.contextPath}" scope="session"/>


<head>
    <style>
        .navbar {
            background:#6ab446;
        }
        .nav-link,
        .navbar-brand {
            color: #fff;
            cursor: pointer;
        }
        .nav-link {
            margin-center: 1em !important;
        }
        .nav-link:hover {
            color: #000;
        }
        .navbar-collapse {
            justify-content: flex-end;
        }
        .dropdown-menu {
            z-index: 999;
        }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

</head>

<body>
<fmt:setLocale value="${lang}" scope="session"/>
<fmt:setBundle basename="locale" var="loc"/>


<nav class="navbar navbar-expand-md">
    <a class="navbar-brand" href="#">Logo</a>
    <button class="navbar-toggler navbar-dark" type="button" data-toggle="collapse" data-target="#main-navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="main-navigation">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="${root}/jsp/main.jsp"><fmt:message bundle="${loc}" key="button.Main"/></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${root}/CafeServlet?service=SHOW_MENU"><fmt:message bundle="${loc}" key="button.ourMenu"/></a>
            </li>
            <c:if test="${isLogin!=true}">
            <li class="nav-item">
                <a class="nav-link" href="${root}/jsp/guest/registration.jsp"><fmt:message bundle="${loc}" key="button.registration"/></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${root}/jsp/guest/login.jsp"><fmt:message bundle="${loc}" key="button.login"/></a>
            </li>
            </c:if>
            <c:if test="${isLogin eq true}">
                <c:if test="${userCategory eq 'registered_user'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${root}/CafeServlet?service=SHOW_CART"><fmt:message bundle="${loc}" key="button.cart"/></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle font-weight-bold" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                ${user.firstName}
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="${root}/jsp/customer/profile.jsp"><fmt:message bundle="${loc}" key="button.profile"/></a>
                            <a class="dropdown-item" href="${root}/CafeServlet?service=SHOW_ORDERS"><fmt:message bundle="${loc}" key="button.orders"/></a>
                            <a class="dropdown-item" href="${root}/jsp/customer/address.jsp"><fmt:message bundle="${loc}" key="button.addresses"/></a>
                        </div>
                    </li>

                </c:if>
                <c:if test="${userCategory eq 'administrator'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${root}/CafeServlet?service=SHOW_ALL_ORDERS"><fmt:message bundle="${loc}" key="button.userOrders"/></a>
                    </li>
<%--                    <li class="nav-item">--%>
<%--                        <a class="nav-link" href="${root}/CafeServlet?service=SHOW_ORDERS"><fmt:message bundle="${loc}" key="button.addMenuItem"/></a>--%>
<%--                    </li>--%>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="${root}/CafeServlet?service=LOGOUT"><fmt:message bundle="${loc}" key="button.logOut"/></a>
                </li>
            </c:if>
            <div class="border rounded mr-auto" >
            <li class="nav-item">
                    <a class="text-white" href="${root}/CafeServlet?service=CHANGE_LOCALE&amp;language=en"><fmt:message bundle="${loc}" key="button.eng"/></a>
            </li>
            <li class="nav-item">
                    <a class="text-white" href="${root}/CafeServlet?service=CHANGE_LOCALE&amp;language=ru"><fmt:message bundle="${loc}" key="button.ru"/></a>
            </li>
            </div>
        </ul>
    </div>
</nav>
</body>
