<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Automatisch opwaarderen</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="./css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Automatisch opwaarderen</span>
        <form class="saldo" method="post" action="">
            <ul class="saldo-list">
                <li class="saldo-item">
                    <label class="saldo-label"><input class="saldo-input" type="radio" name="saldo" value="0" /> € 0,-</label>
                </li>
                <li class="saldo-item">
                    <label class="saldo-label"><input class="saldo-input" type="radio" name="saldo" value="10" /> € 10,-</label>
                </li>
                <li class="saldo-item">
                    <label class="saldo-label"><input class="saldo-input" type="radio" name="saldo" value="20" /> € 20,-</label>
                </li>
                <li class="saldo-item">
                    <label class="saldo-label"><input class="saldo-input" type="radio" name="saldo" value="50" /> € 50,-</label>
                </li>
                <li class="saldo-item">
                    <input class="btn" type="submit" value="Opwaarderen" />
                </li>
            </ul>
        </form>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>