package com.system.persistence.dao.impl;

import com.system.entity.Letter;
import com.system.persistence.dao.LetterDao;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from LetterDao interface
 *
 * @author Syniuk Valentyn
 */
public class LetterDaoImpl implements LetterDao {

    private static final Logger LOGGER = LogManager.getLogger(CreditCardDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_LETTER = "INSERT INTO letters(user_id, typeQuestion, description, date) VALUES(?, ?, ?, ?)";
    private static final String DELETE_LETTER = "DELETE FROM letters WHERE user_id = ?";
    private static final String FIND_LETTERS_BY_USER_ID = "SELECT * FROM letters WHERE user_id = ?";
    private static final String FIND_ALL_LETTERS = "SELECT * FROM letters";

    private static LetterDaoImpl instance = null;
    private QueryExecutor executor = QueryExecutor.getInstance();

    private LetterDaoImpl() throws SQLException {
    }

    public static synchronized LetterDaoImpl getInstance() throws SQLException {
        if (instance == null) {
            instance = new LetterDaoImpl();
        }
        return instance;
    }

    @Override
    public int create(Letter entity) {
        Object[] args = {entity.getUserId(), entity.getTypeQuestion(), entity.getDescription(), entity.getDate()};
        return executor.executeStatement(CREATE_LETTER, args);
    }

    @Override
    public int delete(Integer userId) {
        return executor.executeStatement(DELETE_LETTER, userId);
    }

    @Override
    public List<Letter> findLettersByUserId(Integer userId) {
        List<Letter> letters = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_LETTERS_BY_USER_ID, userId);
            while (rs.next()) {
                letters.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return letters;
    }

    @Override
    public List<Letter> findAllLetters() {
        List<Letter> letters = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_ALL_LETTERS);
            while (rs.next()) {
                letters.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return letters;
    }

    /**
     * Creates entity from result set
     */
    private Letter createEntity(ResultSet rs) {
        Letter letter = new Letter();
        try {
            letter.setUserId(rs.getInt("user_id"));
            letter.setTypeQuestion(rs.getString("typeQuestion"));
            letter.setDescription(rs.getString("description"));
            letter.setDate(rs.getString("date"));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return letter;
    }

}
