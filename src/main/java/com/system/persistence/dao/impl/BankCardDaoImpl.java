package com.system.persistence.dao.impl;

import com.system.entity.BankCard;
import com.system.persistence.dao.BankCardDao;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from BankCardDao interface
 *
 * @author Syniuk Valentyn
 */
public class BankCardDaoImpl implements BankCardDao {

    private static final Logger LOGGER = LogManager.getLogger(BankCardDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_CARD = "INSERT INTO bank_cards(account_id, number, cvv, validity, is_active) VALUES(?, ?, ?, ?, ?)";
    private static final String UPDATE_CARD = "UPDATE bank_cards SET is_active = ? WHERE card_id = ?";
    private static final String DELETE_CARD = "DELETE FROM bank_cards WHERE card_id = ?";
    private static final String FIND_CARD_BY_CARD_ID = "SELECT * FROM bank_cards WHERE card_id = ?";
    private static final String FIND_CARD_BY_NUMBER = "SELECT * FROM bank_cards WHERE number = ?";
    private static final String FIND_CARDS_BY_ACCOUNT_ID = "SELECT * FROM bank_cards WHERE account_id = ?";
    private static final String FIND_CARDS_BY_USER_ID = "SELECT bank_cards.* FROM bank_cards INNER JOIN accounts ON bank_cards.account_id = accounts.account_id WHERE accounts.user_id = ?";
    private static final String FIND_ALL_CARDS = "SELECT * FROM bank_cards";

    private static BankCardDaoImpl instance = null;
    private final QueryExecutor executor = QueryExecutor.getInstance();

    private BankCardDaoImpl() throws SQLException {
    }

    public static synchronized BankCardDaoImpl getInstance() throws SQLException {
        if (instance == null) {
            instance = new BankCardDaoImpl();
        }
        return instance;
    }

    @Override
    public int create(BankCard entity) {
        Object[] args = {
                entity.getAccountId(),
                entity.getNumber(),
                entity.getCVV(),
                entity.getValidity(),
                entity.getIsActive()
        };
        return executor.executeStatement(CREATE_CARD, args);
    }

    @Override
    public int update(BankCard entity) {
        Object[] args = {
                entity.getIsActive(),
                entity.getCardId()
        };
        return executor.executeStatement(UPDATE_CARD, args);
    }

    @Override
    public int delete(Integer id) {
        return executor.executeStatement(DELETE_CARD, id);
    }

    @Override
    public BankCard findCardByCardId(Integer cardId) {
        BankCard creditCard = null;
        try {
            ResultSet rs = executor.getResultSet(FIND_CARD_BY_CARD_ID, cardId);
            if (rs.next()) {
                creditCard = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return creditCard;
    }

    @Override
    public BankCard findCardByCardNumber(String number) {
        BankCard creditCard = null;
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
    public List<BankCard> findCardsByAccountId(Integer accountId) {
        List<BankCard> creditCards = new ArrayList<>();
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
    public List<BankCard> findCardsByUserId(Integer userId) {
        List<BankCard> creditCards = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_CARDS_BY_USER_ID, userId);
            while (rs.next()) {
                creditCards.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return creditCards;
    }

    @Override
    public List<BankCard> findAllCards() {
        List<BankCard> creditCards = new ArrayList<>();
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
    private BankCard createEntity(ResultSet rs) {
        BankCard creditCard = new BankCard();
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
