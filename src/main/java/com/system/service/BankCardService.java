package com.system.service;

import com.system.entity.BankCard;
import com.system.persistence.dao.BankCardDao;
import com.system.persistence.factory.DaoFactory;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Provides service methods for BankCardDao. Layout between DAO and Command.
 *
 * @author Syniuk Valentyn
 */
public class BankCardService {

    private static final Logger LOGGER = LogManager.getLogger(BankCardService.class);

    private static BankCardService instance = null;
    private final BankCardDao bankCardDao = DaoFactory.createBankCardDao();

    private BankCardService() {
    }

    public static synchronized BankCardService getInstance() {
        if (instance == null) {
            instance = new BankCardService();
        }
        return instance;
    }

    /**
     * Adds new bank card to the account
     */
    public int addNewBankCard(Integer accountId, String number, String CVV, String month, String year) {
        int status = 0;
        if (accountId != null && number != null && CVV != null && month != null && year != null) {
            SimpleDateFormat formatter = new SimpleDateFormat("MM/yyyy");
            Date date = null;

            try {
                date = formatter.parse(month + "/" + year);
            } catch (ParseException e) {
                LOGGER.error("ParseException: " + e.getMessage());
            }

            BankCard card = new BankCard();
            card.setAccountId(accountId);
            card.setNumber(number);
            card.setCVV(CVV);
            card.setValidity(formatter.format(date));
            card.setIsActive(true);
            status = bankCardDao.create(card);
        }
        return status;
    }

    /**
     * Blocks bank card by cardId
     */
    public int blockBankCard(Integer cardId) {
        int status = 0;
        if (cardId != null) {
            BankCard card = bankCardDao.findCardByCardId(cardId);
            card.setIsActive(false);
            status = bankCardDao.update(card);
        }
        return status;
    }

    /**
     * Unblocks bank card by cardId
     */
    public int unblockBankCard(Integer cardId) {
        int status = 0;
        if (cardId != null) {
            BankCard card = bankCardDao.findCardByCardId(cardId);
            card.setIsActive(true);
            status = bankCardDao.update(card);
        }
        return status;
    }

    /**
     * Checks if cardId not null and deletes it
     */
    public int deleteCardById(Integer cardId) {
        int status = 0;
        if (cardId != null) {
            status = bankCardDao.delete(cardId);
        }
        return status;
    }

    /**
     * Checks if card number not null and deletes it
     */
    public int deleteCardByCardNumber(String number) {
        int status = 0;
        if (number != null) {
            BankCard card = findCardByCardNumber(number);
            status = bankCardDao.delete(card.getCardId());
        }
        return status;
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
    public List<BankCard> findCardsByAccountId(Integer accountId) {
        return bankCardDao.findCardsByAccountId(accountId);
    }

    /**
     * Finds all bank cards by user id
     */
    public List<BankCard> findCardsByUserId(Integer userId) {
        return bankCardDao.findCardsByUserId(userId);
    }

    /**
     * Finds all bank cards in the system
     */
    public List<BankCard> findAllCards() {
        return bankCardDao.findAllCards();
    }

}
