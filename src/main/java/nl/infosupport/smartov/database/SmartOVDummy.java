package nl.infosupport.smartov.database;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

public class SmartOVDummy implements SmartOVDao {
    public BigDecimal getSaldo(UUID accountId) throws SmartOVException {
        return new BigDecimal(10);
    }

    public void addSaldo(UUID accountId, BigDecimal saldo) throws SmartOVException {

    }

    public UUID createCard(UUID persoonId, String kaartnaam) throws SmartOVException {
        return UUID.randomUUID();
    }

    public UUID createPerson(String naam, String postcode, String huisnummer, Date geboortedatum, String telefoonummer,
                             String email) throws SmartOVException {
        return UUID.randomUUID();
    }

    public void updatePerson(UUID personId, String naam, String postcode, String huisnummer, Date geboortedatum,
                             String telefoonummer, String email) throws SmartOVException {

    }
}
