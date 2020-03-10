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
        payment.setRecipientNumber("5450655032805450");
        payment.setSum(new BigDecimal("1000.00"));
        payment.setAppointment("Thank you for dinner!");

        account_1 = new Account();
        account_1.setAccountId(1);
        account_1.setUserId(1);
        account_1.setNumber("11110000111100001111");
        account_1.setBalance(new BigDecimal("100000.00"));
        account_1.setIsBlocked(false);

        account_2 = new Account();
        account_2.setAccountId(2);
        account_2.setUserId(2);
        account_2.setNumber("22220000222200002222");
        account_2.setBalance(new BigDecimal("50000.00"));
        account_2.setIsBlocked(false);

        when(paymentService.makePaymentOnAccount(payment.getAccountId(), payment.getRecipientNumber(), new BigDecimal("1000.00"), payment.getAppointment()))
                .thenReturn(payment.getPaymentId());
    }

    @Test
    public void testCreatePayment() {
        Integer paymentId = paymentService.makePaymentOnAccount(1, "5450655032805450", new BigDecimal("1000.00"), "Thank you for dinner!");
        assertNotNull(paymentId);
        assertEquals(new Integer(1), paymentId);
    }

}
