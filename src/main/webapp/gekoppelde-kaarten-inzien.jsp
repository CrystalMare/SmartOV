<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
        <span class="main-title">Kaarten</span>
        <c:if test="${name == 'SALDOBEHEERDER'}">
            <a href="gekoppelde-kaarten-toevoegen" class="btn for-add">Kaart toevoegen</a>
        </c:if>
        <div class="overview">
            <div class="overview-head">
                <span class="overview-title">Kaartnummer</span>
                <span class="overview-title">Kaartnaam</span>
                <span class="overview-title">Vervaldatum</span>
                <span class="overview-title">Koppeldatum</span>
                <span class="overview-title">&nbsp;</span>
            </div>
            <c:forEach items="${kaartList}" var="kaart">
                <div class="overview-item">
                    <span class="overview-label"><a href="reisproduct-inzien?kaartId=${kaart.kaartId}"><c:out value="${kaart.kaartNummer}"/></a></span>
                    <span class="overview-label"><c:out value="${kaart.kaartNaam}"/></span>
                    <span class="overview-label">
                        <c:out value="${kaart.vervalDatum}"/>
                    </span>
                    <span class="overview-label">
                        <c:out value="${kaart.koppelDatum}"/>
                    </span>
                    <span class="overview-label">
                        <a href="verwijder-kaart?kaartId=${kaart.kaartId}">Verwijder</a>
                    </span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>