package com.system.service;

import com.system.entity.Account;
import com.system.entity.Payment;
import org.junit.BeforeClass;
import org.junit.Test;

import java.math.BigDecimal;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestPaymentService {

    private static PaymentService paymentService = null;
    private static Payment payment = null;
    private static Account account_1 = null;
    private static Account account_2 = null;

    @BeforeClass
    public static void setUp() {
        paymentService = mock(PaymentService.class);

        payment = new Payment();
        payment.setPaymentId(1);
        payment.setAccountId(1);
        payment.setIsOutgoing(true);
        payment.setSenderNumber("00000000000000000000");
        payment.setSenderAmount(new BigDecimal("200.0"));
        payment.setSenderCurrency("MXN");
        payment.setRecipientNumber("11111000000000000000");
        payment.setRecipientAmount(new BigDecimal("245.46"));
        payment.setRecipientCurrency("UAH");
        payment.setExchangeRate(new BigDecimal("1.23"));
        payment.setNewBalance(new BigDecimal("9725.46"));
        payment.setAppointment("Thank you for dinner!");
        payment.setDate("26/03/2020, 00:43");
        payment.setCondition(true);

        account_1 = new Account();
        account_1.setAccountId(1);
        account_1.setUserId(1);
        account_1.setNumber("00000000000000000000");
        account_1.setBalance(new BigDecimal("100000.00"));
        account_1.setCurrency("MXN");
        account_1.setIsBlocked(false);
        account_1.setIsDeleted(false);

        account_2 = new Account();
        account_2.setAccountId(2);
        account_2.setUserId(2);
        account_2.setNumber("11111000000000000000");
        account_2.setBalance(new BigDecimal("50000.00"));
        account_1.setCurrency("UAH");
        account_2.setIsBlocked(false);
        account_2.setIsDeleted(false);

        when(paymentService.makePaymentOnAccount(payment.getAccountId(), payment.getSenderNumber(), payment.getSenderAmount(), payment.getExchangeRate(), payment.getAppointment())).thenReturn(payment.getPaymentId());
    }

    @Test
    public void testCreatePayment() {
        Integer paymentId = paymentService.makePaymentOnAccount(1, "00000000000000000000", new BigDecimal("200.0"), new BigDecimal("1.23"), "Thank you for dinner!");
        assertNotNull(paymentId);
        assertEquals(new Integer(1), paymentId);
    }

}
