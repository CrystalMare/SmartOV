package nl.infosupport.smartov.database;

import lombok.extern.log4j.Log4j;
import nl.infosupport.smartov.database.dao.SmartOVDao;

import javax.inject.Inject;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.UUID;

@Log4j
class SmartOVConnector extends SqlConnector implements SmartOVDao {

    @Inject
    SmartOVConnector(SqlDatasource connection) {
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
        return null;
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
    }
}
