<%--
  Created by IntelliJ IDEA.
  User: Bakhtiyar_2
  Date: 22.12.2020
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<style>
    .page-footer {
        background-color: #222;
        color: #ccc;
        padding: 60px 0 30px;
    }
    .footer-copyright {
        color: #666;
        padding: 40px 0;
    }
</style>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${lang}" scope="session"/>
<fmt:setBundle basename="locale" var="loc"/>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<footer class="page-footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-8 col-sm-12">
                <h6 class="text-uppercase font-weight-bold"><fmt:message bundle="${loc}" key="page.main.additionalInfoTitle"/></h6>
                <p><fmt:message bundle="${loc}" key="page.main.additionalInfoMsg1"/></p>
                <p><fmt:message bundle="${loc}" key="page.main.additionalInfoMsg2"/></p>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-12">
                <h6 class="text-uppercase font-weight-bold"><fmt:message bundle="${loc}" key="page.main.contactTitle"/></h6>
                <p><fmt:message bundle="${loc}" key="page.main.contactAddress"/>
                    <br/>info@onlinecafe.com
                    <br/>+7 777 123 43 43
                    <br/>+7 7172 555 444</p>
            </div>
        </div>
    </div>
        <div class="footer-copyright text-center">© 2021 <fmt:message bundle="${loc}" key="page.main.copyright"/></div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>


