package com.system.persistence.dao;

import com.system.entity.Letter;

import java.util.List;

/**
 * The LetterDao interface provides methods for retrieving letter for Letter entity
 *
 * @author Syniuk Valentyn
 */
public interface LetterDao {

    /**
     * Inserts new entity into database
     */
    int create(Letter entity);

    /**
     * Updates letter status
     */
    int update(Letter entity);

    /**
     * Removes letter by letter id
     */
    int delete(Integer id);

    /**
     * Retrieves letter by letter id
     */
    Letter findLetterByLetterId(Integer letterId);

    /**
     * Retrieves letters by user id
     */
    List<Letter> findLettersByUserId(Integer userId);

    /**
     * Retrieves all letters
     */
    List<Letter> findAllLetters();

    /**
     * Searches all letters by criteria
     */
    List<Letter> searchByCriteria(String typeQuestion, String startDate, String finalDate);

    /**
     * Searches all letters by criteria without value of type question
     */
    List<Letter> searchByCriteria(String startDate, String finalDate);

}
