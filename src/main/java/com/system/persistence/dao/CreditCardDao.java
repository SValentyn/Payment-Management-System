package com.system.persistence.dao;

import com.system.entity.CreditCard;

import java.util.List;

/**
 * The CreditCardDao interface provides methods for retrieving data for CreditCard entity
 *
 * @author Syniuk Valentyn
 */
public interface CreditCardDao {

    /**
     * Inserts new entity into database
     */
    int create(CreditCard entity);

    /**
     * Updates credit card status
     */
    int update(CreditCard entity);

    /**
     * Removes credit card by id
     */
    int delete(Integer id);

    /**
     * Retrieves a credit card entity by its number
     */
    CreditCard findCreditCardByCardNumber(String number);

    /**
     * Retrieves credit cards by accountId
     */
    List<CreditCard> findCardsByAccountId(Integer id);
}
