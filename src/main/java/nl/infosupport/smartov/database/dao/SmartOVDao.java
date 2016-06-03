package nl.infosupport.smartov.database.dao;

import nl.infosupport.smartov.database.SmartOVException;
import nl.infosupport.smartov.database.model.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Provides easy access to the datastructure "SmartOV"
 */
public interface SmartOVDao extends CloseableDao {

    /**
     * Gets the saldo of a given account
     *
     * @param accountId the id of the account
     * @return the saldo of the account
     * @throws SmartOVException if the account doesnt exist
     */
    @ProcedureId(1)
    @ProcedureName("PROC_GET_SALDO")
    BigDecimal getSaldo(UUID accountId) throws SmartOVException;

    /**
     * Adds a given quantity to the saldo of an account
     *
     * @param accountId the account
     * @param saldo     the ammount to add
     * @return the new saldo
     * @throws SmartOVException if the account doesnt exist or if the total saldo exceeds 200
     */
    @ProcedureId(2)
    @ProcedureName("PROC_ADD_SALDO")
    BigDecimal addSaldo(UUID accountId, BigDecimal saldo) throws SmartOVException;

    /**
     * Enables auto-renewal for an account
     *
     * @param acocuntId      the account
     * @param rekeningNummer the bankaccount to widthdraw money from
     * @param from           the ammount of money that triggers the autorenewal
     * @param ammount        the ammount of money to add
     * @throws SmartOVException if the account doesnt exist, or already has auto-renewal enabled.
     */
    @ProcedureId(3)
    @ProcedureName("PROC_SET_AUTO_RENEWAL")
    void setAutoRenewal(UUID acocuntId, String rekeningNummer, BigInteger from, BigInteger ammount)
            throws SmartOVException;

    /**
     * Disables auto-renewal for an account
     *
     * @param accountId the account
     * @throws SmartOVException if the account doesn't exist or doesn't have auto-renewal enabled.
     */
    @ProcedureId(4)
    @ProcedureName("PROC_DISABLE_AUTO_RENEWAL")
    void disableAutoRenewal(UUID accountId) throws SmartOVException;

    /**
     * Gets all the cardIDs that are bound to an account
     *
     * @param accountId the account
     * @return a list of all bound cards
     * @throws SmartOVException if the account doesn't exist.
     */
    @ProcedureId(5)
    @ProcedureName("PROC_GET_CARDS_BY_ACCOUNT")
    List<UUID> getCardsByAccount(UUID accountId) throws SmartOVException;

    /**
     * Gets all the cards that are bound to an account
     *
     * @param accountId the account
     * @return a list of all bound cards
     * @throws SmartOVException if the account doesn't exist.
     */
    @ProcedureId(5)
    @ProcedureName("PROC_GET_CARDS_BY_ACCOUNT")
    List<Kaart> getCardsByAccountDetailed(UUID accountId) throws SmartOVException;

    /**
     * Binds a card to an account
     *
     * @param cardId    the card to bind
     * @param accountId the account to bind to
     * @throws SmartOVException if the card is already bound or doesn't exist.
     */
    @ProcedureId(6)
    @ProcedureName("PROC_BIND_CARD")
    void bindCard(UUID cardId, UUID accountId) throws SmartOVException;

    /**
     * Unbinds a card from an account
     *
     * @param cardId the card to unbind
     * @throws SmartOVException if card was not bound or card doesn't exist
     */
    @ProcedureId(7)
    @ProcedureName("PROC_UNBIND_CARD")
    void unbindCard(UUID cardId) throws SmartOVException;

    /**
     * Gets all the products on a card
     *
     * @param cardId the card to check for
     * @return all the kortingsreisproducts on the card
     * @throws SmartOVException if the card doesn't exist.
     */
    @ProcedureId(8)
    @ProcedureName("PROC_GET_PRODUCTS")
    List<ProductOpKaart> getProducts(UUID cardId) throws SmartOVException;

    /**
     * Moves a product to a different card
     *
     * @param productOpKaartId the productoncard id
     * @param cardId    the card target
     * @throws SmartOVException if the card or product doesn't exist, or if current card of the product is not bound to
     *                          the same account.
     */
    @ProcedureId(9)
    @ProcedureName("PROC_MOVE_PRODUCT")
    void moveProduct(UUID productOpKaartId, UUID cardId) throws SmartOVException;

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
     * @throws SmartOVException if any of the fields is empty or isnt conform with the constraints.
     *                          Or the given personid was not found.
     */
    @ProcedureId(10)
    @ProcedureName("PROC_UPDATE_PERSON")
    void updatePerson(UUID personId, String naam, String postcode, String huisnummer, Date geboortedatum,
                      String telefoonummer, String email) throws SmartOVException;

    /**
     * Gets the costs made on a specific account
     *
     * @param accountId the account
     * @param from      the from filter
     * @param till      the till filter
     * @return a list of costs made during a specific period with an account
     * @throws SmartOVException if the account doesn't exist
     * @deprecated the API for costs is not stable yet, this method will probably change
     */
    @ProcedureId(11)
    @ProcedureName("PROC_GET_COSTS")
    @Deprecated
    BigInteger getCosts(UUID accountId, Date from, Date till) throws SmartOVException;

    /**
     * Gets all the costs a specific card made for a specific account during a period
     *
     * @param accountId the account
     * @param cardId    the card
     * @param from      the from filter
     * @param till      the till filter
     * @return a list of costs
     * @throws SmartOVException if the card or account doesn't exist.
     * @deprecated the API for costs is not stable yet, this method will probably change
     */
    @ProcedureId(12)
    @ProcedureName("PROC_GET_COSTS_FOR_CARD")
    @Deprecated
    BigInteger getCostsForCard(UUID accountId, UUID cardId, Date from, Date till) throws SmartOVException;

    /**
     * Gets the journeys that were made with an account during a specific period
     *
     * @param accountId the account
     * @param from      the from filter
     * @param till      the till filter
     * @return a list of journeys
     * @throws SmartOVException if the account doesn't exist.
     * @deprecated the API for costs is not stable yet, this method will probably change
     */
    @ProcedureId(13)
    @ProcedureName("PROC_GET_JOURNEYS")
    @Deprecated
    List<Reis> getJourneys(UUID accountId, Date from, Date till) throws SmartOVException;

    /**
     * Gets all the cards by their owner
     *
     * @param cardOwner the owner
     * @return a list of all owned cards
     * @throws SmartOVException if the owner doesn't exist
     */
    @ProcedureId(14)
    @ProcedureName("PROC_GET_CARDS_BY_OWNER")
    List<UUID> getCardsByOwner(UUID cardOwner) throws SmartOVException;

    /**
     * Assigns a product to a card
     *
     * @param cardId    the card
     * @param productId the product
     * @throws SmartOVException throws an exception if the card or the product does not exist.
     *                          Or if the same product is already assigned and is still valid.
     */
    @ProcedureId(15)
    @ProcedureName("PROC_ASSIGN_PRODUCT_TO_CARD")
    void assignProductToCard(UUID cardId, UUID productId) throws SmartOVException;

    /**
     * Deducts the ammount of money from the account
     *
     * @param accountId the account
     * @param ammount   the ammount
     * @return the updated ammount of money on the account
     * @throws SmartOVException if the account doesnt exist or the account doesn't have enough balance.
     */
    @ProcedureId(16)
    @ProcedureName("PROC_DEDUCT_MONEY")
    BigDecimal deductMoney(UUID accountId, BigDecimal ammount) throws SmartOVException;

    /**
     * Requests a replacement card
     *
     * @param cardId the card id
     * @param reason the reason
     * @throws SmartOVException if the card doesn't exist or the reason isn't valid
     */
    @ProcedureId(17)
    @ProcedureName("PROC_REQUEST_NEW_CARD")
    void requestNewCard(UUID cardId, Reden reason) throws SmartOVException;

    /**
     * Deletes a card
     *
     * @param cardId the card id
     * @throws SmartOVException if the card doesn't exist
     */
    @ProcedureId(18)
    @ProcedureName("PROC_DELETE_CARD")
    void deleteCard(UUID cardId) throws SmartOVException;

    /**
     * Starts a journey with a card
     *
     * @param cardId    the card
     * @param stationId the station the journey starts
     * @throws SmartOVException if the card or station doesn't exist. Or if the ballance is not enough.
     */
    @ProcedureId(19)
    @ProcedureName("PROC_START_TRAVEL")
    void startTravel(UUID cardId, UUID stationId) throws SmartOVException;

    /**
     * Ends a journey with a card
     *
     * @param cardId    the cardid
     * @param stationId the station
     * @throws SmartOVException if the card or station doesn't exist.
     */
    @ProcedureId(20)
    @ProcedureName("PROC_END_TRAVEL")
    void endTravel(UUID cardId, UUID stationId) throws SmartOVException;

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
    @ProcedureId(21)
    @ProcedureName("PROC_CREATE_CARD")
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
    @ProcedureId(22)
    @ProcedureName("PROC_CREATE_PERSON")
    UUID createPerson(String naam, String postcode, String huisnummer, Date geboortedatum, String telefoonummer,
                      String email) throws SmartOVException;

    /**
     * Gets a person from the ID
     *
     * @param personId the id
     * @return the person
     */
    @ProcedureId(23)
    @ProcedureName("PROC_GET_PERSON")
    Persoon getPerson(UUID personId) throws SmartOVException;

    /**
     * Creates a new account
     *
     * @param personId the person who manages the account
     * @return the id of the new account
     * @throws SmartOVException if the person doesnt exist
     */
    @ProcedureId(24)
    @ProcedureName("PROC_CREATE_ACCOUNT")
    UUID createAccount(UUID personId) throws SmartOVException;

    /**
     * Creates a new kortingsreisproduct
     *
     * @param name      the name of the product
     * @param duration  the duration it lasts in days
     * @param reduction the percentage of price reduction
     * @return the id of the created product
     * @throws SmartOVException if the duration is negative or the reduction isnt between 0 and 100
     */
    @ProcedureId(25)
    @ProcedureName("PROC_CREATE_KORTINGSREISPRODUCT")
    UUID createKortingsreisproduct(String name, int duration, int reduction) throws SmartOVException;

    /**
     * Gets a card by its cardnumber
     *
     * @param cardnumber the cardnumber
     * @return the card
     * @throws SmartOVException if the card doesnt exist
     */
    @ProcedureId(26)
    @ProcedureName("PROC_GET_CARD_BY_CARDNUMBER")
    Kaart getCardByCardnumber(String cardnumber) throws SmartOVException;

    /**
     * Gets the accounts that a person is managing
     *
     * @param personId the person
     * @return a list of accounts
     * @throws SmartOVException if the person does not exist.
     */
    @ProcedureId(27)
    @ProcedureName("PROC_GET_ACCOUNTS_BY_PERSON")
    List<UUID> getAccountsByPerson(UUID personId) throws SmartOVException;

    /**
     * Gets all products that are available for adding to a card
     *
     * @param cardId the card
     * @return a list of all avialable products
     * @throws SmartOVException if the card does not exist.
     */
    @ProcedureId(31)
    @ProcedureName("PROC_GET_ALL_AVAILABLE_PRODUCTS")
    List<Reisproduct> getAllAvailableProducts(UUID cardId) throws SmartOVException;
}
