package com.system.service;

import com.system.entity.Account;
import org.junit.BeforeClass;
import org.junit.Test;

import java.math.BigDecimal;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestAccountService {

    private static AccountService accountService = null;
    private static Account account = null;
    private static Double funds = null;

    @BeforeClass
    public static void setUp() {
        accountService = mock(AccountService.class);
        account = new Account();
        account.setAccountId(1);
        account.setUserId(1);
        account.setNumber("11110000111100001111");
        account.setBalance(1_000d);
        account.setIsBlocked(false);
        funds = 500d;

        when(accountService.addFunds(account.getAccountId(), funds)).thenReturn(account.getAccountId());
        when(accountService.blockAccount(account.getAccountId())).thenReturn(account.getAccountId());
        when(accountService.unblockAccount(account.getAccountId())).thenReturn(account.getAccountId());
    }

    @Test
    public void testBlockAccount() {
        Integer accountId = accountService.blockAccount(1);
        assertEquals(account.getAccountId(), accountId);
    }

    @Test
    public void testUnblockAccount() {
        Integer accountId = accountService.unblockAccount(1);
        assertEquals(account.getAccountId(), accountId);
    }

    @Test
    public void testAddFunds() {
        Integer accountId = accountService.addFunds(account.getAccountId(), funds);
        assertNotNull(accountId);
        assertEquals(accountId, account.getAccountId());
    }
}
