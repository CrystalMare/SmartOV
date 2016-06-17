<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Reishistorie</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="./css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Reishistorie</span>
        <div class="overview">
            <div class="overview-head">
                <span class="overview-title">Naam</span>
                <span class="overview-title">Prijs</span>
                <span class="overview-title">Incheckdatum</span>
                <span class="overview-title">Uitcheckdatum</span>
                <span class="overview-title">Eindpunt</span>
            </div>
            <c:forEach items="${reisFromList}" var="reisFromList">
                <div class="overview-item">
                    <span class="overview-label"><c:out value="${reisFromList.naam}"/></span>
                    <span class="overview-label"><c:out value="${reisFromList.prijs}"/></span>
                    <span class="overview-label"><c:out value="${reisFromList.incheckDatum}"/></span>
                    <span class="overview-label"><c:out value="${reisFromList.uitcheckDatum}"/></span>
                    <span class="overview-label"><c:out value=""/></span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>