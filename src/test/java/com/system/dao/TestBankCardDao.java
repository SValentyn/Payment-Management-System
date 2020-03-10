package com.system.dao;

import com.system.entity.BankCard;
import com.system.persistence.dao.BankCardDao;
import com.system.persistence.dao.impl.BankCardDaoImpl;
import org.junit.BeforeClass;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestBankCardDao {

    private static BankCardDao bankCardDao = null;
    private static BankCard bankCard = null;

    @BeforeClass
    public static void setUp() {
        bankCardDao = mock(BankCardDaoImpl.class);
        bankCard = new BankCard();
        bankCard.setCardId(1);
        bankCard.setAccountId(1);
        bankCard.setNumber("5450655032805450");
        bankCard.setCVV("666");

        when(bankCardDao.create(bankCard)).thenReturn(bankCard.getCardId());
        when(bankCardDao.delete(bankCard.getCardId())).thenReturn(bankCard.getCardId());
        when(bankCardDao.findCardsByAccountId(bankCard.getAccountId())).thenReturn(Arrays.asList(bankCard));
        when(bankCardDao.findCardByCardNumber(bankCard.getNumber())).thenReturn(bankCard);
    }

    @Test
    public void testCreateCreditCard() {
        Integer expectedId = bankCard.getCardId();
        Integer cardId = bankCardDao.create(bankCard);
        assertNotNull(cardId);
        assertEquals(expectedId, cardId);
    }

    @Test
    public void testUpdateBankCard() {
        String beforeNumber = bankCard.getNumber();
        bankCard.setNumber("5450655032805451");
        bankCardDao.update(bankCard);
        String afterNumber = bankCard.getNumber();
        assertNotEquals(beforeNumber, afterNumber);
    }

    @Test
    public void testDeleteBankCard() {
        Integer expectedId = bankCard.getCardId();
        Integer cardId = bankCardDao.delete(bankCard.getCardId());
        assertNotNull(cardId);
        assertEquals(expectedId, cardId);
    }

    @Test
    public void testFindBankCardByCardNumber() {
        Integer expectedId = bankCard.getAccountId();
        BankCard creditCard_1 = bankCardDao.findCardByCardNumber(bankCard.getNumber());
        BankCard creditCard_2 = bankCardDao.findCardByCardNumber("5450655032800000"); // null
        assertEquals(expectedId, (Integer) creditCard_1.getAccountId());
        assertNull(creditCard_2);
    }

    @Test
    public void testFindCardsByAccountId() {
        List<BankCard> bankCards = bankCardDao.findCardsByAccountId(bankCard.getCardId());
        assertEquals(1, bankCards.size());
        assertEquals("666", bankCards.get(0).getCVV());
    }

}
