package com.system.persistence.dao.impl;

import com.system.entity.Account;
import com.system.persistence.dao.AccountDao;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from AccountDao interface
 *
 * @author Syniuk Valentyn
 */
public class AccountDaoImpl implements AccountDao {

    private static final Logger LOGGER = LogManager.getLogger(AccountDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_ACCOUNT = "INSERT INTO accounts(user_id, number, balance, currency, is_blocked, is_deleted) VALUES(?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_ACCOUNT = "UPDATE accounts SET balance = ?, is_blocked = ? WHERE account_id = ?";
    private static final String DELETE_ACCOUNT = "UPDATE accounts SET is_blocked = 1, is_deleted = 1 WHERE account_id = ?";
    private static final String FIND_ACCOUNT_BY_ID = "SELECT * FROM accounts WHERE account_id = ? AND is_deleted = 0";
    private static final String FIND_ACCOUNT_BY_NUMBER = "SELECT * FROM accounts WHERE number = ? AND is_deleted = 0";
    private static final String FIND_ALL_ACCOUNTS_BY_USER_ID = "SELECT * FROM accounts WHERE user_id = ? AND is_deleted = 0";
    private static final String FIND_ALL_ACCOUNTS = "SELECT * FROM accounts WHERE is_deleted = 0";
    private static final String SEARCH_BY_CRITERIA = "SELECT * FROM accounts WHERE user_id = ? AND is_deleted = 0 AND number LIKE CONCAT(?, '%') AND balance >= ? AND balance <= ? AND currency LIKE ? ORDER BY account_id DESC";

    private static AccountDaoImpl instance = null;
    private final QueryExecutor executor = QueryExecutor.getInstance();

    private AccountDaoImpl() throws SQLException {
    }

    public static synchronized AccountDaoImpl getInstance() throws SQLException {
        if (instance == null) {
            instance = new AccountDaoImpl();
        }
        return instance;
    }

    public int create(Account entity) {
        Object[] args = {
                entity.getUserId(),
                entity.getNumber(),
                entity.getBalance(),
                entity.getCurrency(),
                entity.getIsBlocked(),
                entity.getIsDeleted()
        };
        return executor.executeStatement(CREATE_ACCOUNT, args);
    }

    @Override
    public int update(Account entity) {
        Object[] args = {
                entity.getBalance(),
                entity.getIsBlocked(),
                entity.getAccountId()
        };
        return executor.executeStatement(UPDATE_ACCOUNT, args);
    }

    @Override
    public int delete(Integer id) {
        return executor.executeStatement(DELETE_ACCOUNT, id);
    }

    @Override
    public Account findAccountById(Integer accountId) {
        Account account = null;
        try {
            ResultSet rs = executor.getResultSet(FIND_ACCOUNT_BY_ID, accountId);
            if (rs.next()) {
                account = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return account;
    }

    @Override
    public Account findAccountByNumber(String number) {
        Account account = null;
        try {
            ResultSet rs = executor.getResultSet(FIND_ACCOUNT_BY_NUMBER, number);
            if (rs.next()) {
                account = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return account;
    }

    @Override
    public List<Account> findAllAccountsByUserId(Integer userId) {
        List<Account> accounts = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_ALL_ACCOUNTS_BY_USER_ID, userId);
            while (rs.next()) {
                accounts.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return accounts;
    }

    @Override
    public List<Account> findAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_ALL_ACCOUNTS);
            while (rs.next()) {
                accounts.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return accounts;
    }

    @Override
    public List<Account> searchByCriteria(Integer userId, String number, String min_value, String max_value, String currency) {
        List<Account> accounts = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(SEARCH_BY_CRITERIA, userId, number, min_value, max_value, currency);
            while (rs.next()) {
                accounts.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return accounts;
    }

    /**
     * Creates entity from result set
     */
    private Account createEntity(ResultSet rs) {
        Account account = new Account();
        try {
            account.setUserId(rs.getInt("user_id"));
            account.setAccountId(rs.getInt("account_id"));
            account.setNumber(rs.getString("number"));
            account.setBalance(rs.getBigDecimal("balance"));
            account.setCurrency(rs.getString("currency"));
            account.setIsBlocked(rs.getBoolean("is_blocked"));
            account.setIsDeleted(rs.getBoolean("is_deleted"));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return account;
    }

}
