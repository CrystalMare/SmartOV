<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartOV | Login</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>
    <%@include file="header.jsp"%>
    <%@include file="navigation.jsp"%>
    <div class="main" role="main">
        <div class="container">
            <div class="main-item">
                <form class="login" method="post" action="/">
                    <c:if test='${not empty errorMessage}'>
                        <span class="login-error">${errorMessage}</span>
                    </c:if>
                    <fieldset>Login</fieldset>
                    <ul class="login-list">
                        <li class="login-item">
                            <label class="login-label">Naam</label>
                        </li>
                        <li class="login-item">
                            <select class="login-select" name="name">
                                <option value="KAARTHOUDER">Kaarthouder</option>
                                <option value="SALDOBEHEERDER">Saldobeheerder</option>
                            </select>
                        </li>
                        <li class="login-item">
                            <input class="btn" type="submit" value="Login" />
                        </li>
                    </ul>
                </form>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>