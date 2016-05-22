<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Persoonlijke gegevens wijzigen</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Persoonlijke gegevens wijzigen</span>
        <form class="kaart" method="post" action="">
            <ul class="kaart-list">
                <li class="kaart-item">
                    <label class="kaart-label">Naam</label>
                    <input class="kaart-input" type="text" name="naam" value="${naam}" />
                </li>
                <li class="kaart-item">
                    <label class="kaart-label">Postcode</label>
                    <input class="kaart-input" type="text" name="postcode" value="${postcode}"/>
                </li>
                <li class="kaart-item">
                    <label class="kaart-label">Huisnummer</label>
                    <input class="kaart-input" type="text" name="huisnummer" value="${huisnummer}" />
                </li>
                <li class="kaart-item">
                    <label class="kaart-label">Geboortedatum</label>
                    <input class="kaart-input" type="text" name="geboortedatum" value="${geboortedatum}" />
                </li>
                <li class="kaart-item">
                    <label class="kaart-label">Telefoonnummer</label>
                    <input class="kaart-input" type="text" name="telefoonnummer" value="${telefoonnummer}" />
                </li>
                <li class="kaart-item">
                    <label class="kaart-label">E-mailadres</label>
                    <input class="kaart-input" type="text" name="email" value="${email}" />
                </li>
                <li class="kaart-item">
                    <input class="btn" type="submit" value="Wijzigen" />
                </li>
            </ul>
        </form>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>