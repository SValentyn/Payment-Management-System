package com.system.persistence.dao.impl;

import com.system.entity.CreditCard;
import com.system.persistence.dao.CreditCardDao;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from CreditCardDao interface
 *
 * @author Syniuk Valentyn
 */
public class CreditCardDaoImpl implements CreditCardDao {

    private static final Logger LOGGER = LogManager.getLogger(CreditCardDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_CARD = "INSERT INTO credit_cards(account_id, number, cvv, validity, is_active) VALUES(?, ?, ?, ?, ?)";
    private static final String UPDATE_CARD = "UPDATE credit_cards SET is_active = ? WHERE card_id = ?";
    private static final String DELETE_CARD = "DELETE FROM credit_cards WHERE card_id = ?";
    private static final String FIND_CARD_BY_USER_ID = "SELECT * FROM credit_cards WHERE card_id = ?";
    private static final String FIND_CARD_BY_NUMBER = "SELECT * FROM credit_cards WHERE number = ?";
    private static final String FIND_CARDS_BY_ACCOUNT_ID = "SELECT * FROM credit_cards WHERE account_id = ?";
    private static final String FIND_ALL_CARDS = "SELECT * FROM credit_cards";

    private static CreditCardDaoImpl instance = null;
    private QueryExecutor executor = QueryExecutor.getInstance();

    private CreditCardDaoImpl() throws SQLException {
    }

    public static synchronized CreditCardDaoImpl getInstance() throws SQLException {
        if (instance == null) {
            instance = new CreditCardDaoImpl();
        }
        return instance;
    }

    @Override
    public int create(CreditCard entity) {
        Object[] args = {entity.getAccountId(), entity.getNumber(), entity.getCVV(), entity.getValidity(), entity.getIsActive()};
        return executor.executeStatement(CREATE_CARD, args);
    }

    @Override
    public int update(CreditCard entity) {
        return executor.executeStatement(UPDATE_CARD, entity.getIsActive(), entity.getCardId());
    }

    @Override
    public int delete(Integer cardId) {
        return executor.executeStatement(DELETE_CARD, cardId);
    }


    @Override
    public CreditCard findCardByCardId(Integer cardId) {
        CreditCard creditCard = null;
        try {
            ResultSet rs = executor.getResultSet(FIND_CARD_BY_USER_ID, cardId);
            if (rs.next()) {
                creditCard = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return creditCard;
    }

    @Override
    public CreditCard findCreditCardByCardNumber(String number) {
        CreditCard creditCard = null;
        try {
            ResultSet rs = executor.getResultSet(FIND_CARD_BY_NUMBER, number);
            if (rs.next()) {
                creditCard = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return creditCard;
    }

    @Override
    public List<CreditCard> findCardsByAccountId(Integer accountId) {
        List<CreditCard> creditCards = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_CARDS_BY_ACCOUNT_ID, accountId);
            while (rs.next()) {
                creditCards.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return creditCards;
    }

    @Override
    public List<CreditCard> findAllCards() {
        List<CreditCard> creditCards = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_ALL_CARDS);
            while (rs.next()) {
                creditCards.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return creditCards;
    }

    /**
     * Creates entity from result set
     */
    private CreditCard createEntity(ResultSet rs) {
        CreditCard creditCard = new CreditCard();
        try {
            creditCard.setAccountId(rs.getInt("account_id"));
            creditCard.setCardId(rs.getInt("card_id"));
            creditCard.setNumber(rs.getString("number"));
            creditCard.setCVV(rs.getString("cvv"));
            creditCard.setValidity(rs.getString("validity"));
            creditCard.setIsActive(rs.getBoolean("is_active"));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return creditCard;
    }

}
