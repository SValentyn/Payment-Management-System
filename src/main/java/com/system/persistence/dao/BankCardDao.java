package com.system.persistence.dao;

import com.system.entity.BankCard;

import java.util.List;

/**
 * The BankCardDao interface provides methods for retrieving data for BankCard entity
 *
 * @author Syniuk Valentyn
 */
public interface BankCardDao {

    /**
     * Inserts new entity into database
     */
    int create(BankCard entity);

    /**
     * Updates bank card status
     */
    int update(BankCard entity);

    /**
     * Removes bank card by card id
     */
    int delete(Integer id);

    /**
     * Retrieves a bank card entity by its id
     */
    BankCard findCardByCardId(Integer cardId);

    /**
     * Retrieves a bank card entity by its number
     */
    BankCard findCardByCardNumber(String number);

    /**
     * Retrieves bank cards by accountId
     */
    List<BankCard> findCardsByAccountId(Integer accountId);

    /**
     * Retrieves bank cards by userId
     */
    List<BankCard> findCardsByUserId(Integer userId);

    /**
     * Retrieves all bank cards
     */
    List<BankCard> findAllCards();

}
