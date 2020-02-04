package com.system.service;

import com.system.entity.Letter;
import com.system.persistence.dao.LetterDao;
import com.system.persistence.dao.impl.CreditCardDaoImpl;
import com.system.persistence.factory.DaoFactory;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Provides service methods for LetterDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class LetterService {

    private static final Logger LOGGER = LogManager.getLogger(CreditCardDaoImpl.class);

    private static LetterService instance = null;
    private LetterDao letterDao = DaoFactory.createLetterDao();

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
    public int addNewLetter(Integer userId, String typeQuestion, String description) {
        int status = 0;
        if (userId != null && typeQuestion != null && description != null) {
            Letter letter = new Letter();
            letter.setUserId(userId);
            letter.setTypeQuestion(typeQuestion);
            letter.setDescription(description);
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            letter.setDate(formatter.format(new Date()));
            status = letterDao.create(letter);
        }
        return status;
    }

    /**
     * Checks if user id not null and deletes it
     */
    public void deleteLetterByUserId(Integer userId) {
        if (userId != null) {
            letterDao.delete(userId);
        }
    }

    /**
     * Finds all letters by user id
     */
    public List<Letter> findLettersByUserId(Integer userId) {
        return letterDao.findLettersByUserId(userId);
    }

    /**
     * Finds all letters in the DB
     */
    public List<Letter> findAllLetters() {
        return letterDao.findAllLetters();
    }

}
