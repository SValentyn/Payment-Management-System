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
     * Removes letter by user id
     */
    int delete(Integer id);

    /**
     * Retrieves letters by user id
     */
    List<Letter> findLettersByUserId(Integer id);

    /**
     * Retrieves all letters
     */
    List<Letter> findAllLetters();

}
