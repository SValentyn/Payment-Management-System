package com.system.dao;

import com.system.entity.CreditCard;
import com.system.persistence.dao.CreditCardDao;
import com.system.persistence.dao.impl.CreditCardDaoImpl;
import org.junit.BeforeClass;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestCreditCardDao {

    private static CreditCardDao creditCardDao = null;
    private static CreditCard creditCard = null;

    @BeforeClass
    public static void setUp() {
        creditCardDao = mock(CreditCardDaoImpl.class);
        creditCard = new CreditCard();
        creditCard.setCardId(1);
        creditCard.setAccountId(1);
        creditCard.setNumber("5450655032805450");
        creditCard.setCVV("666");

        when(creditCardDao.create(creditCard)).thenReturn(creditCard.getCardId());
        when(creditCardDao.delete(creditCard.getCardId())).thenReturn(creditCard.getCardId());
        when(creditCardDao.findCardsByAccountId(creditCard.getAccountId())).thenReturn(Arrays.asList(creditCard));
        when(creditCardDao.findCardByCardNumber(creditCard.getNumber())).thenReturn(creditCard);
    }

    @Test
    public void testCreateCreditCard() {
        Integer expectedId = creditCard.getCardId();
        Integer cardId = creditCardDao.create(creditCard);
        assertNotNull(cardId);
        assertEquals(expectedId, cardId);
    }

    @Test
    public void testUpdateCreditCard() {
        String beforeCreditNumber = creditCard.getNumber();
        creditCard.setNumber("5450655032805451");
        creditCardDao.update(creditCard);
        String afterCreditNumber = creditCard.getNumber();
        assertNotEquals(beforeCreditNumber, afterCreditNumber);
    }

    @Test
    public void testDeleteCreditCard() {
        Integer expectedId = creditCard.getCardId();
        Integer cardId = creditCardDao.delete(creditCard.getCardId());
        assertNotNull(cardId);
        assertEquals(expectedId, cardId);
    }

    @Test
    public void testFindCreditCardByCardNumber() {
        Integer expectedId = creditCard.getAccountId();
        CreditCard creditCard_1 = creditCardDao.findCardByCardNumber(creditCard.getNumber());
        CreditCard creditCard_2 = creditCardDao.findCardByCardNumber("5450655032800000"); // null
        assertEquals(expectedId, (Integer) creditCard_1.getAccountId());
        assertNull(creditCard_2);
    }

    @Test
    public void testFindCardsByAccountId() {
        List<CreditCard> creditCards = creditCardDao.findCardsByAccountId(creditCard.getCardId());
        assertEquals(1, creditCards.size());
        assertEquals("666", creditCards.get(0).getCVV());
    }

}
