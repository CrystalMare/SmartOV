package nl.infosupport.smartov.database;

import lombok.extern.log4j.Log4j;
import nl.infosupport.smartov.database.dao.SmartOVDao;

import javax.inject.Inject;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.UUID;
import java.util.stream.Collectors;

@Log4j
class SmartConnector extends SqlConnector implements SmartOVDao {

    @Inject
    SmartConnector(SqlDatasource connection) {
        super(connection.getConnection());
    }

    @Override
    public BigDecimal getSaldo(UUID accountId) throws SmartOVException {
        try {
            PreparedStatement ps = connection.prepareStatement(
                    "EXECUTE smartov.dbo.PROC_GET_SALDO @AccountID = ?;"
            );
            ps.setString(1, accountId.toString());
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getBigDecimal(1);
        } catch (SQLException e) {
            throw new SmartOVException(e);
        }
    }

    @Override
    public BigDecimal addSaldo(UUID accountId, BigDecimal saldo) throws SmartOVException {
        return null;
    }

    @Override
    public UUID createCard(UUID persoonId, String kaartnaam) throws SmartOVException {
        try {
            PreparedStatement ps = connection.prepareStatement(
                    "EXECUTE smartov.dbo.PROC_CREATE_CARD @kaartnummer = ?, @kaartnaam = ?, @vervaldatum = ?;"
            );
            ps.setString(1, new Random().ints(16, 0, 9).mapToObj(Integer::toString).collect(Collectors.joining()));
            ps.setString(2, kaartnaam);
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.YEAR, 2);
            ps.setDate(3, new java.sql.Date(calendar.getTime().getTime()));
            ResultSet rs = ps.executeQuery();
            rs.next();
            return UUID.fromString(rs.getString(1));
        } catch (SQLException e) {
            throw new SmartOVException(e);
        }
    }

    @Override
    public UUID createPerson(String naam, String postcode, String huisnummer, Date geboortedatum, String telefoonummer,
                             String email) throws SmartOVException {
        try {
            PreparedStatement ps = connection.prepareStatement(
                    "EXECUTE smartov.dbo.PROC_CREATE_PERSON @naam = ?, @postcode = ?, @huisnummer = ?, " +
                            "@geboortedatum = ?, @telefoonnummer = ?, @emailadres = ?;"
            );
            ps.setString(1, naam);
            ps.setString(2, postcode);
            ps.setString(3, huisnummer);
            ps.setDate(4, new java.sql.Date(geboortedatum.getTime()));
            ps.setString(5, telefoonummer);
            ps.setString(6, email);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return UUID.fromString(rs.getString(1));
        } catch (SQLException e) {
            throw new SmartOVException(e);
        }
    }

    @Override
    public void updatePerson(UUID personId, String naam, String postcode, String huisnummer, Date geboortedatum,
                             String telefoonummer, String email) throws SmartOVException {
        try {
            PreparedStatement ps = connection.prepareStatement(
                    "EXECUTE smartov.dbo.PROC_UPDATE_PERSON @naam = ?, @postcode = ?, @huisnummer = ?, " +
                            "@geboortedatum = ?, @telefoonnummer = ?, @emailadres = ?, @persoonid = ?;"
            );
            ps.setString(1, naam);
            ps.setString(2, postcode);
            ps.setString(3, huisnummer);
            ps.setDate(4, new java.sql.Date(geboortedatum.getTime()));
            ps.setString(5, telefoonummer);
            ps.setString(6, email);
            ps.setString(7, personId.toString());
            ps.execute();
        } catch (SQLException e) {
            throw new SmartOVException(e);
        }
    }
}
