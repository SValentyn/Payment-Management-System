package com.system.dao;

import com.system.entity.Account;
import com.system.persistence.dao.AccountDao;
import com.system.persistence.dao.impl.AccountDaoImpl;
import org.junit.BeforeClass;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestAccountDao {

    private static AccountDao accountDao = null;
    private static Account account = null;

    @BeforeClass
    public static void setUp() {
        accountDao = mock(AccountDaoImpl.class);
        account = new Account();
        account.setAccountId(1);
        account.setUserId(1);
        account.setNumber("11110000111100001111");
        account.setBalance(1_000_000d);

        when(accountDao.create(account)).thenReturn(account.getAccountId());
        when(accountDao.update(account)).thenReturn(account.getAccountId());
        when(accountDao.findAccountById(account.getAccountId())).thenReturn(account);
        when(accountDao.findAllAccountsByUserId(account.getUserId())).thenReturn(Arrays.asList(account));
    }

    @Test
    public void testCreateAccount() {
        Integer accountId = accountDao.create(account);
        assertNotNull(accountId);
        assertEquals(new Integer(1), accountId);
    }

    @Test
    public void testUpdateAccount() {
        Integer accountId = accountDao.update(account);
        assertNotNull(accountId);
        assertEquals(new Integer(1), accountId);
    }

    @Test
    public void testFindAccountById() {
        Account account1 = accountDao.findAccountById(account.getAccountId());
        Account account2 = accountDao.findAccountById(3);
        assertNull(account2);
        assertEquals(new BigDecimal(1_000_000), account1.getBalance());
    }

    @Test
    public void testFindAllAccountsOfUser() {
        List<Account> accounts = accountDao.findAllAccountsByUserId(1);
        assertEquals(1, accounts.size());
        assertEquals("11110000111100001111", accounts.get(0).getNumber());
    }
}
