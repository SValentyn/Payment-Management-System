package com.system.persistence.dao.impl;

import com.system.entity.Letter;
import com.system.persistence.dao.LetterDao;
import org.apache.commons.lang.StringEscapeUtils;
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

    private static final Logger LOGGER = LogManager.getLogger(LetterDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_LETTER = "INSERT INTO letters(user_id, typeQuestion, description, date, is_processed) VALUES(?, ?, ?, ?, ?)";
    private static final String UPDATE_LETTER = "UPDATE letters SET is_processed = ? WHERE letter_id = ?";
    private static final String DELETE_LETTER = "DELETE FROM letters WHERE letter_id = ?";
    private static final String FIND_LETTER_BY_LETTER_ID = "SELECT * FROM letters WHERE letter_id = ?";
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
        entity.setTypeQuestion(StringEscapeUtils.escapeJava(entity.getTypeQuestion()));
        entity.setDescription(StringEscapeUtils.escapeJava(entity.getDescription()));
        Object[] args = {entity.getUserId(), entity.getTypeQuestion(), entity.getDescription(), entity.getDate(), entity.getIsProcessed()};
        return executor.executeStatement(CREATE_LETTER, args);
    }

    @Override
    public int update(Letter entity) {
        Object[] args = {entity.getIsProcessed(), entity.getLetterId()};
        return executor.executeStatement(UPDATE_LETTER, args);
    }

    @Override
    public int delete(Integer id) {
        return executor.executeStatement(DELETE_LETTER, id);
    }

    @Override
    public Letter findLetterByLetterId(Integer letterId) {
        Letter letter = new Letter();
        try {
            ResultSet rs = executor.getResultSet(FIND_LETTER_BY_LETTER_ID, letterId);
            while (rs.next()) {
                letter = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return letter;
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
            letter.setLetterId(rs.getInt("letter_id"));
            letter.setUserId(rs.getInt("user_id"));
            letter.setTypeQuestion(StringEscapeUtils.unescapeJava(rs.getString("typeQuestion")));
            letter.setDescription(StringEscapeUtils.unescapeJava(rs.getString("description")));
            letter.setDate(rs.getString("date"));
            letter.setIsProcessed(rs.getBoolean("is_processed"));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return letter;
    }

}
