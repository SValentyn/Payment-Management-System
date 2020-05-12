package com.system.persistence.dao.impl;

import com.system.entity.Letter;
import com.system.persistence.dao.LetterDao;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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
    private static final String FIND_ALL_LETTERS = "SELECT * FROM letters ORDER BY date ASC";
    private static final String SEARCH_BY_CRITERIA = "SELECT * FROM letters WHERE is_processed = 0 AND typeQuestion LIKE ? AND date BETWEEN STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s)') ORDER BY date ASC;";
    private static final String SEARCH_BY_CRITERIA_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP = "SELECT * FROM letters WHERE is_processed = 0 AND typeQuestion LIKE ? AND date BETWEEN STR_TO_DATE(?, '%d/%m/%Y') AND CURRENT_TIMESTAMP() ORDER BY date ASC;";
    private static final String SEARCH_BY_CRITERIA_WITHOUT_TYPE_QUESTION = "SELECT * FROM letters WHERE is_processed = 0 AND date BETWEEN STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s)') ORDER BY date ASC;";
    private static final String SEARCH_BY_CRITERIA_WITHOUT_TYPE_QUESTION_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP = "SELECT * FROM letters WHERE is_processed = 0 AND date BETWEEN STR_TO_DATE(?, '%d/%m/%Y') AND CURRENT_TIMESTAMP() ORDER BY date ASC;";

    private static LetterDaoImpl instance = null;
    private final QueryExecutor executor = QueryExecutor.getInstance();

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
        entity.setDescription(StringEscapeUtils.escapeJava(entity.getDescription()));

        Object[] args = {
                entity.getUserId(),
                entity.getTypeQuestion(),
                entity.getDescription(),
                entity.getDate(),
                entity.getIsProcessed()
        };
        return executor.executeStatement(CREATE_LETTER, args);
    }

    @Override
    public int update(Letter entity) {
        Object[] args = {
                entity.getIsProcessed(),
                entity.getLetterId()
        };
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

    @Override
    public List<Letter> searchByCriteria(String typeQuestion, String startDate, String finalDate) {
        List<Letter> letters = new ArrayList<>();
        try {
            if (startDate.equals("")) {
                startDate = "01/01/2020 00:00:00";
            }

            ResultSet rs;
            if (finalDate.equals("")) {
                rs = executor.getResultSet(SEARCH_BY_CRITERIA_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP, typeQuestion, startDate);
            } else {
                finalDate += "23:59:59";
                rs = executor.getResultSet(SEARCH_BY_CRITERIA, typeQuestion, startDate, finalDate);
            }

            while (rs.next()) {
                letters.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return letters;
    }

    @Override
    public List<Letter> searchByCriteria(String startDate, String finalDate) {
        List<Letter> letters = new ArrayList<>();
        try {
            if (startDate.equals("")) {
                startDate = "01/01/2020 00:00:00";
            }

            ResultSet rs;
            if (finalDate.equals("")) {
                rs = executor.getResultSet(SEARCH_BY_CRITERIA_WITHOUT_TYPE_QUESTION_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP, startDate);
            } else {
                finalDate += "23:59:59";
                rs = executor.getResultSet(SEARCH_BY_CRITERIA_WITHOUT_TYPE_QUESTION, startDate, finalDate);
            }

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
            letter.setTypeQuestion(rs.getInt("typeQuestion"));
            letter.setDescription(StringEscapeUtils.unescapeJava(rs.getString("description")));
            Timestamp timestamp = rs.getTimestamp("date");
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
            letter.setDate(formatter.format(timestamp));
            letter.setIsProcessed(rs.getBoolean("is_processed"));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return letter;
    }

}
