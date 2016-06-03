<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Reisproducten van kaarten</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<div class="main" role="main">
    <div class="container">
        <div class="main-item">
            <span class="main-title">Reisproducten van kaarten</span>
            <a href="reisproduct-toevoegen" class="btn for-add">Reisproduct toevoegen</a>
            <div class="overview">
                <div class="overview-head">
                    <span class="overview-title">Naam</span>
                    <span class="overview-title">Geldigheid</span>
                    <span class="overview-title">&nbsp;</span>
                    <span class="overview-title">&nbsp;</span>
                    <span class="overview-title">&nbsp;</span>
                </div>
                <c:forEach items="${reisproduct}" var="reisproduct">
                    <div class="overview-item">
                        <span class="overview-label"><c:out value="${reisproduct.reisproduct.naam}"/></span>
                        <span class="overview-label"><c:out value="${reisproduct.reisproduct.geldigheid}"/></span>
                        <span class="overview-label">&nbsp;</span>
                        <span class="overview-label"><a href="reisproduct-wijzigen?productOpKaartId=${reisproduct.productOpKaartId}">Verplaats</a></span>
                        <span class="overview-label">&nbsp;</span>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>