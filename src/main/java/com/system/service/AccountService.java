package com.system.service;

import com.system.entity.Account;
import com.system.entity.CreditCard;
import com.system.persistence.dao.AccountDao;
import com.system.persistence.dao.CreditCardDao;
import com.system.persistence.factory.DaoFactory;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * Provides service methods for AccountDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class AccountService {

    private static final Logger LOGGER = LogManager.getLogger(AccountService.class);
    private static AccountService instance = null;
    private AccountDao accountDao = DaoFactory.createAccountDao();
    private CreditCardDao creditCardDao = DaoFactory.createCreditCardDao();

    private AccountService() throws SQLException {
    }

    public static synchronized AccountService getInstance() throws SQLException {
        if (instance == null) {
            instance = new AccountService();
        }
        return instance;
    }

    /**
     * Creates new account
     */
    public void createAccount(Integer userId, String number, BigDecimal balance) {
        if (number != null && userId != null && balance != null) {
            Account account = new Account();
            account.setUserId(userId);
            account.setNumber(number);
            account.setBalance(balance);
            account.setIsBlocked(false);
        }
    }

    /**
     * Finds account by id and blocks it. Blocks all credit cards that belong to this account
     */
    public int blockAccount(Integer accountId) {
        int status = 0;
        if (accountId != null) {
            Account account = accountDao.findAccountById(accountId);
            List<CreditCard> creditCards = creditCardDao.findCardsByAccountId(accountId);
            for (CreditCard creditCard : creditCards) {
                creditCard.setIsActive(false);
                creditCardDao.update(creditCard);
            }
            account.setIsBlocked(true);
            status = accountDao.update(account);
        }
        return status;
    }

    /**
     * Finds account by id and unblock it
     */
    public int unblockAccount(Integer accountId) {
        int status = 0;
        if (accountId != null) {
            Account account = accountDao.findAccountById(accountId);
            List<CreditCard> creditCards = creditCardDao.findCardsByAccountId(accountId);
            for (CreditCard creditCard : creditCards) {
                creditCard.setIsActive(true);
                creditCardDao.update(creditCard);
            }
            account.setIsBlocked(false);
            status = accountDao.update(account);
        }
        return status;
    }

    /**
     * Checks if account isn't blocked and adds funds
     */
    public int addFunds(Integer accountId, BigDecimal funds) {
        int status = 0;
        if (accountId != null) {
            Account account = accountDao.findAccountById(accountId);
            if (!account.getIsBlocked()) { // account isn't blocked
                account.setBalance(account.getBalance().add(funds));
                status = accountDao.update(account);
            } else
                LOGGER.info("Attempt to add funds to a blocked account!");
        }
        return status;
    }

    /**
     * Finds all accounts by userId
     */
    public List<Account> findAllAccountsByUserId(Integer userId) {
        return accountDao.findAllAccountsByUserId(userId);
    }

}
