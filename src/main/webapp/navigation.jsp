<nav class="nav">
    <div class="container">
        <ul class="nav-list">
            <c:if test="${empty name}">
                <li class="nav-item"><a href="kaart-kopen" class="nav-link">Kaart kopen</a></li>
            </c:if>
            <c:if test="${name == 'KAARTHOUDER'}">
                <li class="nav-item"><a href="persoonlijke-gegevens-wijzigen" class="nav-link">Persoonlijke gegevens wijzigen</a></li>
                <li class="nav-item"><a href="gekoppelde-kaarten" class="nav-link">Gekoppelde kaarten</a></li>
                <li class="nav-item"><a href="reizen" class="nav-link">Reizen</a></li>
            </c:if>
            <c:if test="${name == 'SALDOBEHEERDER'}">
                <li class="nav-item"><a href="saldo-opwaarderen" class="nav-link">Saldo opwaarderen</a></li>
                <li class="nav-item"><a href="persoonlijke-gegevens-wijzigen" class="nav-link">Persoonlijke gegevens wijzigen</a></li>
                <li class="nav-item"><a href="gekoppelde-kaarten" class="nav-link">Gekoppelde kaarten</a></li>
                <li class="nav-item"><a href="kostenoverzicht" class="nav-link">Kosten</a></li>
            </c:if>
        </ul>
    </div>
</nav>
