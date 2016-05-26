package nl.infosupport.smartov.database;

import lombok.extern.log4j.Log4j;
import nl.infosupport.smartov.database.dao.SmartOVDao;
import nl.infosupport.smartov.database.model.*;

import javax.inject.Inject;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
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
        try {
            PreparedStatement ps = connection.prepareStatement(
                    "EXECUTE smartov.dbo.PROC_ADD_SALDO @accountid = ?, @saldo = ?;"
            );
            ps.setString(1, accountId.toString());
            ps.setBigDecimal(2, saldo);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getBigDecimal(1);
        } catch (SQLException e) {
            throw new SmartOVException(e);
        }
    }

    @Override
    public void setAutoRenewal(UUID acocuntId, String rekeningNummer, BigInteger from, BigInteger ammount) throws SmartOVException {

    }

    @Override
    public void disableAutoRenewal(UUID accountId) throws SmartOVException {

    }

    @Override
    public List<Kaart> getCardsByAccount(UUID accountId) throws SmartOVException {
        return null;
    }

    @Override
    public void bindCard(UUID cardId, UUID accountId) throws SmartOVException {

    }

    @Override
    public void unbindCard(UUID cardId) throws SmartOVException {

    }

    @Override
    public List<Reisproduct> getProducts(UUID cardId) throws SmartOVException {
        return null;
    }

    @Override
    public void moveProduct(UUID productId, UUID cardId) throws SmartOVException {

    }

    @Override
    public UUID createCard(UUID persoonId, String kaartnaam) throws SmartOVException {
        try {
            PreparedStatement ps = connection.prepareStatement(
                    "EXECUTE smartov.dbo.PROC_CREATE_CARD @kaartnummer = ?, @kaartnaam = ?, @persoonId = ?;"
            );
            ps.setString(1, new Random().ints(16, 0, 9).mapToObj(Integer::toString).collect(Collectors.joining()));
            ps.setString(2, kaartnaam);
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.YEAR, 2);
            //ps.setDate(3, new java.sql.Date(calendar.getTime().getTime()));
            ps.setString(3, persoonId.toString());
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

    @Override
    public BigInteger getCosts(UUID accountId, Date from, Date till) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public BigInteger getCostsForCard(UUID accountId, UUID cardId, Date from, Date till) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public List<Reis> getJourneys(UUID accountId, Date from, Date till) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public List<Kaart> getCardsByOwner(UUID cardOwner) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public BigInteger deductMoney(UUID accountId, BigInteger ammount) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public void requestNewCard(UUID cardId, Reden reason) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public void deleteCard(UUID cardId) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public void startTravel(UUID cardId, UUID stationId) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public void endTravel(UUID cardId, UUID stationId) throws SmartOVException {
        throw new RuntimeException("Method not implemented!");
    }

    @Override
    public Persoon getPerson(UUID personId) throws SmartOVException {
        try {
            PreparedStatement ps = connection.prepareStatement(
                    "EXECUTE smartov.dbo.PROC_GET_PERSON @PersoonID = ?;"
            );
            ps.setString(1, personId.toString());
            ResultSet rs = ps.executeQuery();
            rs.next();
            return new Persoon(personId, rs.getString("NAAM"), rs.getString("POSTCODE"), rs.getString("HUISNUMMER"),
                    rs.getDate("GEBOORTEDATUM"), rs.getString("TELEFOONNUMMER"), rs.getString("E_MAILADRES"));
        } catch (SQLException e) {
            throw new SmartOVException(e);
        }
    }

    @Override
    public UUID createAccount(UUID personId) {
        throw new RuntimeException("Method not implemented!");
    }
}
