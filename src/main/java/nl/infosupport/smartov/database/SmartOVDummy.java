package nl.infosupport.smartov.database;

import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.Persoon;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

class SmartOVDummy implements SmartOVDao {

    public BigDecimal getSaldo(UUID accountId) throws SmartOVException {
        return new BigDecimal(10);
    }

    public BigDecimal addSaldo(UUID accountId, BigDecimal saldo) throws SmartOVException {
        return new BigDecimal(10).add(saldo);
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

    @Override
    public Persoon getPerson(UUID personId) throws SmartOVException {
        return null;
    }

    @Override
    public void close() {

    }
}
