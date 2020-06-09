package com.system.service;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.persistence.dao.AccountDao;
import com.system.persistence.factory.DaoFactory;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * Provides service methods for AccountDao. Layout between DAO and Command.
 *
 * @author Syniuk Valentyn
 */
public class AccountService {

    private static AccountService instance = null;
    private final AccountDao accountDao = DaoFactory.createAccountDao();

    private AccountService() {
    }

    public static synchronized AccountService getInstance() {
        if (instance == null) {
            instance = new AccountService();
        }
        return instance;
    }

    /**
     * Adds a new account
     */
    public int addNewAccount(Integer userId, String number, String currency) {
        int status = 0;
        if (userId != null && number != null && currency != null) {
            Account account = new Account();
            account.setUserId(userId);
            account.setNumber(number);
            account.setBalance(new BigDecimal("0.00"));
            account.setCurrency(currency);
            account.setIsBlocked(false);
            account.setIsDeleted(false);
            status = accountDao.create(account);
        }
        return status;
    }

    /**
     * Finds account by account id and blocks it
     */
    public int blockAccount(Integer accountId) {
        int status = 0;
        if (accountId != null) {
            Account account = accountDao.findAccountById(accountId);
            account.setIsBlocked(true);
            status = accountDao.update(account);
        }
        return status;
    }

    /**
     * Finds account by account id and unblock it
     */
    public int unblockAccount(Integer accountId) {
        int status = 0;
        if (accountId != null) {
            Account account = accountDao.findAccountById(accountId);
            account.setIsBlocked(false);
            status = accountDao.update(account);
        }
        return status;
    }

    /**
     * Deletes an account if the accountId is not NULL and if there are no funds left on it
     * In addition, detaches all attached cards to the account
     */
    public int deleteAccountByAccountId(Integer accountId) throws SQLException {
        int status = 0;

        if (accountId != null) {
            BigDecimal balance = AccountService.getInstance().findAccountByAccountId(accountId).getBalance();
            if (balance.compareTo(BigDecimal.ZERO) != 0) {
                return -1;
            }

            status = accountDao.delete(accountId);
            if (status != 0) {
                List<BankCard> cards = BankCardService.getInstance().findCardsByAccountId(accountId);
                for (BankCard card : cards) {
                    BankCardService.getInstance().deleteCardById(card.getCardId());
                }
            }
        }
        return status;
    }

    /**
     * Finds account by account id
     */
    public Account findAccountByAccountId(Integer accountId) {
        return accountDao.findAccountById(accountId);
    }

    /**
     * Finds account by account number
     */
    public Account findAccountByAccountNumber(String number) {
        return accountDao.findAccountByNumber(number);
    }

    /**
     * Finds account number by account id
     */
    public String findAccountNumberByAccountId(Integer accountId) {
        return findAccountByAccountId(accountId).getNumber();
    }

    /**
     * Finds all accounts by user id
     */
    public List<Account> findAllAccountsByUserId(Integer userId) {
        return accountDao.findAllAccountsByUserId(userId);
    }

    /**
     * Finds all accounts in the system
     */
    public List<Account> findAllAccounts() {
        return accountDao.findAllAccounts();
    }

    /**
     * Searches all accounts by criteria
     */
    public List<Account> searchByCriteria(String number, String min_value, String max_value, String currency) {
        return accountDao.searchByCriteria(number, min_value, max_value, currency);
    }

    /**
     * Searches all accounts by criteria
     */
    public List<Account> searchByCriteria(Integer userId, String number, String min_value, String max_value, String currency) {
        return accountDao.searchByCriteria(userId, number, min_value, max_value, currency);
    }

}
