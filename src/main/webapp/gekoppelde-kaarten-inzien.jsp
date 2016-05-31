<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Gekoppelde kaarten inzien</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Gekoppelde kaarten</span>
        <div class="overview">
            <div class="overview-head">
                <span class="overview-title">Kaartnummer</span>
                <span class="overview-title">Kaartnaam</span>
                <span class="overview-title">Vervaldatum</span>
                <span class="overview-title">Koppeldatum</span>
                <span class="overview-title">&nbsp;</span>
            </div>
            <c:forEach items="${kaart}" var="kaart">
                <div class="overview-item">
                    <span class="overview-label"><c:out value="${kaart.kaartNummer}"/></span>
                    <span class="overview-label"><c:out value="${kaart.kaartNaam}"/></span>
                    <span class="overview-label"><c:out value="${kaart.vervalDatum}"/></span>
                    <span class="overview-label"><c:out value="${kaart.koppelDatum}"/></span>
                    <span class="overview-label"><a href="verwijder-kaart?kaartId=${kaart.kaartId}">Verwijder</a></span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>