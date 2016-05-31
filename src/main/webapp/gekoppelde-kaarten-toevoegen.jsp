<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Gekoppelde kaarten wijzigen</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Gekoppelde kaarten wijzigen</span>
        <form class="kaart" method="post" action="">
            <ul class="kaart-list">
                <li class="kaart-item">
                    <label class="kaart-label">Kaartnummer</label>
                    <input class="kaart-input" type="text" name="naam" value="${naam}" />
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