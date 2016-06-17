<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Kosten</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="./css/style.css" />
</head>
<body>
<%@include file="header.jsp"%>
<%@include file="navigation.jsp"%>
<div class="main" role="main">
    <div class="container">
        <span class="main-title">Kosten</span>
        <span class="main-span">Totale kosten: € ${cost}</span>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>