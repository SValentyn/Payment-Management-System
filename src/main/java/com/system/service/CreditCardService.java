package com.system.service;

import com.system.entity.CreditCard;
import com.system.persistence.dao.CreditCardDao;
import com.system.persistence.dao.impl.CreditCardDaoImpl;
import com.system.persistence.factory.DaoFactory;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Provides service methods for CreditCardDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class CreditCardService {

    private static final Logger LOGGER = LogManager.getLogger(CreditCardDaoImpl.class);

    private static CreditCardService instance = null;
    private CreditCardDao creditCardDao = DaoFactory.createCreditCardDao();

    private CreditCardService() throws SQLException {
    }

    public static synchronized CreditCardService getInstance() throws SQLException {
        if (instance == null) {
            instance = new CreditCardService();
        }
        return instance;
    }

    /**
     * Adds new card to the user account
     */
    public int addNewCard(String accountId, String number, String CVV, String month, String year) {
        int status = 0;
        if (accountId != null && number != null && CVV != null && month != null && year != null) {
            if (creditCardDao.findCreditCardByCardNumber(number) != null) {
                LOGGER.info("Trying to add an existing card!");
            } else {
                SimpleDateFormat formatter = new SimpleDateFormat("MM/yyyy");
                Date date = null;

                try {
                    date = formatter.parse(month + "/" + year);
                } catch (ParseException e) {
                    LOGGER.error("ParseException: " + e.getMessage());
                }

                CreditCard creditCard = new CreditCard();
                creditCard.setAccountId(Integer.parseInt(accountId));
                creditCard.setNumber(number);
                creditCard.setCVV(CVV);
                creditCard.setValidity(formatter.format(date));
                creditCard.setIsActive(true);
                status = creditCardDao.create(creditCard);
            }
        }
        return status;
    }

    /**
     * Checks if cardId not null and deletes it
     */
    public void deleteCardById(Integer cardId) {
        if (cardId != null) {
            creditCardDao.delete(cardId);
        }
    }

    /**
     * Checks if card number not null and deletes it
     */
    public void deleteCardByNumber(String number) {
        if (number != null) {
            CreditCard card = findCardByCardNumber(number);
            creditCardDao.delete(card.getCardId());
        }
    }

    /**
     * Blocks credit card by number
     */
    public void blockCreditCard(String number) {
        if (number != null) {
            CreditCard creditCard = creditCardDao.findCreditCardByCardNumber(number);
            creditCard.setIsActive(false);
            creditCardDao.update(creditCard);
        }
    }

    /**
     * Unblocks credit card by number
     */
    public void unblockCreditCard(String number) {
        if (number != null) {
            CreditCard creditCard = creditCardDao.findCreditCardByCardNumber(number);
            creditCard.setIsActive(true);
            creditCardDao.update(creditCard);
        }
    }

    /**
     * Finds credit card by card id
     */
    public CreditCard findCardByCardId(Integer cardId) {
        return creditCardDao.findCardByCardId(cardId);
    }

    /**
     * Finds all credit card by card number
     */
    public CreditCard findCardByCardNumber(String number) {
        return creditCardDao.findCreditCardByCardNumber(number);
    }

    /**
     * Finds all credit cards by account id
     */
    public List<CreditCard> findCardsByAccountId(Integer accountId) {
        return creditCardDao.findCardsByAccountId(accountId);
    }

    /**
     * Finds all credit cards in the DB
     */
    public List<CreditCard> findAllCards() {
        return creditCardDao.findAllCards();
    }

}
