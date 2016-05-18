package nl.infosupport.smartov.database;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

/**
 * Provides easy access to the datastructure "SmartOV"
 */
public interface SmartOVDao {

    /**
     * Gets the saldo of a given account
     *
     * @param accountId the id of the account
     * @return the saldo of the account
     * @throws SmartOVException if the account doesnt exist
     */
    BigDecimal getSaldo(UUID accountId) throws SmartOVException;

    /**
     * Adds a given quantity to the saldo of an account
     *
     * @param accountId the account
     * @param saldo     the ammount to add
     * @return the new saldo
     * @throws SmartOVException if the account doesnt exist or if the total saldo exceeds 200
     */
    BigDecimal addSaldo(UUID accountId, BigDecimal saldo) throws SmartOVException;

    /**
     * <p>
     * Creates a new personal card
     * </p>
     * <b>Note:</b> if the age of the persoxn is 65 or over, a '65+ reisproduct' will be added to the card.
     *
     * @param persoonId the id of the cardholder (owner)
     * @param kaartnaam the name of the card
     * @return the id of the card that was created
     * @throws SmartOVException if the name is null or exceeds 26 characters or if no person with the personid was found
     */
    UUID createCard(UUID persoonId, String kaartnaam) throws SmartOVException;

    /**
     * Creates a new person
     *
     * @param naam          the name of the person, max 26
     * @param postcode      the zipcode, max 10 characters
     * @param huisnummer    the number of the house, max 10 characters
     * @param geboortedatum the date of birth, at least 5 years old
     * @param telefoonummer the phonenumber, max 15 characters (E.164)
     * @param email         the mailaddress, max 255 characters
     * @return the id of the person created
     * @throws SmartOVException if any of the fields is empty or isnt conform with the constraints set on the fields.
     */
    UUID createPerson(String naam, String postcode, String huisnummer, Date geboortedatum, String telefoonummer,
                      String email) throws SmartOVException;

    /**
     * Updates a person
     *
     * @param personId      the id of the person
     * @param naam          the name of the person, max 26
     * @param postcode      the zipcode, max 10 characters
     * @param huisnummer    the number of the house, max 10 characters
     * @param geboortedatum the date of birth, at least 5 years old
     * @param telefoonummer the phonenumber, max 15 characters (E.164)
     * @param email         the mailaddress, max 255 characters
     * @throws SmartOVException if any of the fields is empty or isnt conform with the constraints. O
     *                          Or the given personid was not found.
     */
    void updatePerson(UUID personId, String naam, String postcode, String huisnummer, Date geboortedatum,
                      String telefoonummer, String email) throws SmartOVException;


}
