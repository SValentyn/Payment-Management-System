package com.system.service;

import com.system.entity.Letter;
import com.system.persistence.dao.LetterDao;
import com.system.persistence.factory.DaoFactory;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 * Provides service methods for LetterDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class LetterService {

    private static final Logger LOGGER = LogManager.getLogger(LetterService.class);

    private static LetterService instance = null;
    private final LetterDao letterDao = DaoFactory.createLetterDao();

    private LetterService() throws SQLException {
    }

    public static synchronized LetterService getInstance() throws SQLException {
        if (instance == null) {
            instance = new LetterService();
        }
        return instance;
    }

    /**
     * Adds new letter to the DB
     */
    public int addNewLetter(Integer userId, Integer typeQuestion, String description) {
        int status = 0;
        if (userId != null && typeQuestion != null) {
            Letter letter = new Letter();
            letter.setUserId(userId);
            letter.setTypeQuestion(typeQuestion);
            letter.setDescription(description);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            formatter.setTimeZone(TimeZone.getTimeZone("UTC"));
            letter.setDate(formatter.format(new Date()));
            letter.setIsProcessed(false);
            status = letterDao.create(letter);
        }
        return status;
    }

    /**
     * Checks if letter id not null and updates it
     */
    public int updateLetterByLetterId(Integer letterId) {
        int status = 0;
        if (letterId != null) {
            Letter letter = findLetterByLetterId(letterId);
            letter.setIsProcessed(true);
            status = letterDao.update(letter);
        }
        return status;
    }

    /**
     * Checks if letter id not null and deletes it
     */
    public void deleteLetterByLetterId(Integer letterId) {
        if (letterId != null) {
            letterDao.delete(letterId);
        }
    }

    /**
     * Finds all letter by letter id
     */
    public Letter findLetterByLetterId(Integer letterId) {
        return letterDao.findLetterByLetterId(letterId);
    }

    /**
     * Finds all letters by user id
     */
    public List<Letter> findLettersByUserId(Integer userId) {
        return letterDao.findLettersByUserId(userId);
    }

    /**
     * Finds all unprocessed letters
     */
    public List<Letter> findUnprocessedLetters() {
        List<Letter> letters = letterDao.findAllLetters();
        List<Letter> unprocessedLetters = new ArrayList<>();
        for (Letter letter : letters) {
            if (!letter.getIsProcessed()) {
                unprocessedLetters.add(letter);
            }
        }
        return unprocessedLetters;
    }

    /**
     * Finds all letters in the DB
     */
    public List<Letter> findAllLetters() {
        return letterDao.findAllLetters();
    }

    /**
     * Searches all letters by criteria
     */
    public List<Letter> searchByCriteria(String typeQuestion, String startDate, String finalDate) {
        return letterDao.searchByCriteria(typeQuestion, startDate, finalDate);
    }

    /**
     * Searches all letters by criteria without value of type question
     */
    public List<Letter> searchByCriteria(String startDate, String finalDate) {
        return letterDao.searchByCriteria(startDate, finalDate);
    }

}
