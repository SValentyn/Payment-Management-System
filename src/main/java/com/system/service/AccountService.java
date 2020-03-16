package com.system.service;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.persistence.dao.AccountDao;
import com.system.persistence.dao.BankCardDao;
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
    private BankCardDao bankCardDao = DaoFactory.createBankCardDao();

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
    public int createAccount(Integer userId, String number, String currency) {
        int status = 0;
        if (userId != null && number != null) {
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
     * Finds account by id and blocks it
     * Blocks all bank cards that belong to this account
     */
    public int blockAccount(Integer accountId) {
        int status = 0;
        if (accountId != null) {
            Account account = accountDao.findAccountById(accountId);
            List<BankCard> bankCards = bankCardDao.findCardsByAccountId(accountId);
            for (BankCard bankCard : bankCards) {
                bankCard.setIsActive(false);
                bankCardDao.update(bankCard);
            }
            account.setIsBlocked(true);
            status = accountDao.update(account);
        }
        return status;
    }

    /**
     * Finds account by id and unblock it
     * Unlocks all bank cards that belong to this account
     */
    public int unblockAccount(Integer accountId) {
        int status = 0;
        if (accountId != null) {
            Account account = accountDao.findAccountById(accountId);
            List<BankCard> bankCards = bankCardDao.findCardsByAccountId(accountId);
            for (BankCard bankCard : bankCards) {
                bankCard.setIsActive(true);
                bankCardDao.update(bankCard);
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
            } else {
                LOGGER.info("Attempt to add funds to a blocked account!");
            }
        }
        return status;
    }

    /**
     * Checks if account id not null and deletes it
     */
    public void deleteAccountByAccountId(Integer accountId) {
        if (accountId != null) {
            accountDao.delete(accountId);
        }
    }

    /**
     * Finds account by accountId
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
     * Finds account number by accountId
     */
    public String findAccountNumberByAccountId(Integer accountId) {
        return findAccountByAccountId(accountId).getNumber();
    }

    /**
     * Finds all accounts by userId
     */
    public List<Account> findAllAccountsByUserId(Integer userId) {
        return accountDao.findAllAccountsByUserId(userId);
    }

    /**
     * Finds all accounts in the DB
     */
    public List<Account> findAllAccounts() {
        return accountDao.findAllAccounts();
    }

}
