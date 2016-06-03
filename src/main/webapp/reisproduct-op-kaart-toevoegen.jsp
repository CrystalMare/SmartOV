<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Reisproduct op kaart toevoegen</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="./css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Reisproduct toevoegen</span>
        <form class="kaart" method="post" action="">
            <c:if test='${not empty errorMessage}'>
                <span class="login-error">${errorMessage}</span>
            </c:if>
            <ul class="kaart-list">
                <li class="kaart-item">
                    <label class="kaart-label">Kaartnummer</label>
                    <input class="kaart-input" type="text" name="kaartnummer" />
                </li>
                <li class="kaart-item">
                    <label class="kaart-label">Reisproduct</label>
                    <select name="reisproduct">
                        <c:forEach items="${reisproduct}" var="reisproduct">
                            <option value="${reisproduct.reisproductId}">${reisproduct.naam}</option>
                        </c:forEach>
                    </select>
                </li>
                <li class="kaart-item">
                    <input class="btn" type="submit" value="Toevoegen" />
                </li>
            </ul>
        </form>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>