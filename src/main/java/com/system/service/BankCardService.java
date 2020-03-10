package com.system.service;

import com.system.entity.BankCard;
import com.system.persistence.dao.BankCardDao;
import com.system.persistence.factory.DaoFactory;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Provides service methods for BankCardDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class BankCardService {

    private static final Logger LOGGER = LogManager.getLogger(BankCardService.class);

    private static BankCardService instance = null;
    private BankCardDao bankCardDao = DaoFactory.createBankCardDao();

    private BankCardService() throws SQLException {
    }

    public static synchronized BankCardService getInstance() throws SQLException {
        if (instance == null) {
            instance = new BankCardService();
        }
        return instance;
    }

    /**
     * Adds new card to the user account
     */
    public int addNewCard(String accountId, String number, String CVV, String month, String year) {
        int status = 0;
        if (accountId != null && number != null && CVV != null && month != null && year != null) {
            SimpleDateFormat formatter = new SimpleDateFormat("MM/yyyy");
            Date date = null;

            try {
                date = formatter.parse(month + "/" + year);
            } catch (ParseException e) {
                LOGGER.error("ParseException: " + e.getMessage());
            }

            BankCard bankCard = new BankCard();
            bankCard.setAccountId(Integer.parseInt(accountId));
            bankCard.setNumber(number);
            bankCard.setCVV(CVV);
            bankCard.setValidity(formatter.format(date));
            bankCard.setIsActive(true);
            status = bankCardDao.create(bankCard);
        }
        return status;
    }

    /**
     * Blocks bank card by number
     */
    public void blockBankCard(String number) {
        if (number != null) {
            BankCard bankCard = bankCardDao.findCardByCardNumber(number);
            bankCard.setIsActive(false);
            bankCardDao.update(bankCard);
        }
    }

    /**
     * Unblocks bank card by number
     */
    public void unblockBankCard(String number) {
        if (number != null) {
            BankCard creditCard = bankCardDao.findCardByCardNumber(number);
            creditCard.setIsActive(true);
            bankCardDao.update(creditCard);
        }
    }

    /**
     * Checks if cardId not null and deletes it
     */
    public void deleteCardById(Integer cardId) {
        if (cardId != null) {
            bankCardDao.delete(cardId);
        }
    }

    /**
     * Checks if card number not null and deletes it
     */
    public void deleteCardByNumber(String number) {
        if (number != null) {
            BankCard card = findCardByCardNumber(number);
            bankCardDao.delete(card.getCardId());
        }
    }

    /**
     * Finds bank card by card id
     */
    public BankCard findCardByCardId(Integer cardId) {
        return bankCardDao.findCardByCardId(cardId);
    }

    /**
     * Finds all bank card by card number
     */
    public BankCard findCardByCardNumber(String number) {
        return bankCardDao.findCardByCardNumber(number);
    }

    /**
     * Finds all bank cards by account id
     */
    public List<BankCard> findAllCardsByAccountId(Integer accountId) {
        return bankCardDao.findCardsByAccountId(accountId);
    }

    /**
     * Finds all bank cards in the DB
     */
    public List<BankCard> findAllCards() {
        return bankCardDao.findAllCards();
    }

}
