<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Reizen</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="./css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Reizen</span>
        <form method="post" action="" class="reis">
            <c:if test='${not empty message}'>
                <span class="login-error">${message}</span>
            </c:if>
            <label class="reis-label">Kaartnummer</label>
            <select class="reis-select" name="kaart">
                <c:forEach items="${kaartList}" var="kaart">
                    <option value="${kaart.kaartId}">${kaart.kaartNummer}</option>
                </c:forEach>
            </select>
            <select class="reis-select" name="station">
                <option value="6D36C50C-2810-44E1-9117-37432FA4D427">Veenendaal - De Klomp</option>
                <option value="02CA1105-67F5-418B-A2E2-FEE82C24905D">Centraal Station Arnhem</option>
            </select>
            <input class="btn" type="submit" value="in-/uitchecken" />
        </form>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>