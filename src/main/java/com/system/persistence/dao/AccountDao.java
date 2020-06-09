package com.system.persistence.dao;

import com.system.entity.Account;

import java.util.List;

/**
 * The interface provides methods for retrieving data for an Account entity
 *
 * @author Syniuk Valentyn
 */
public interface AccountDao {

    /**
     * Inserts new entity into database
     */
    int create(Account entity);

    /**
     * Updates existing account
     */
    int update(Account entity);

    /**
     * It does not delete the account, but makes it completely inaccessible
     */
    int delete(Integer id);

    /**
     * Retrieves account by account id
     */
    Account findAccountById(Integer accountId);

    /**
     * Retrieves account by number account
     */
    Account findAccountByNumber(String number);

    /**
     * Returns all accounts by user id
     */
    List<Account> findAllAccountsByUserId(Integer userId);

    /**
     * Returns all accounts in the system
     */
    List<Account> findAllAccounts();

    /**
     * Searches all accounts by criteria
     */
    List<Account> searchByCriteria(Integer userId, String number, String min_value, String max_value, String currency);

    /**
     * Searches all accounts by criteria without value of userId
     */
    List<Account> searchByCriteria(String number, String min_value, String max_value, String currency);

}
