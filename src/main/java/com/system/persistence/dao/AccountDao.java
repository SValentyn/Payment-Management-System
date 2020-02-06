package com.system.persistence.dao;

import com.system.entity.Account;

import java.util.List;

/**
 * The AccountDao interface provides methods for retrieving data for Account entity
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
     * Removes account by account id
     */
    int delete(Integer id);

    /**
     * Retrieves account by account id
     */
    Account findAccountById(Integer accountId);

    /**
     * Returns all accounts by user id
     */
    List<Account> findAllAccountsByUserId(Integer userId);

}
