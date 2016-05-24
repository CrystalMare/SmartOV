<header class="hdr">
    <div class="container">
        <a class="logo" href="/">SmartOV</a>
        <c:if test='${not empty name}'>
        <div class="user">
            <span class="user-span">${name}</span>
            <a class="user-logout" href="/logout">Log out</a>
        </div>
        </c:if>
    </div>
</header>