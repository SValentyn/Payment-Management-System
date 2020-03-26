package com.system.dao;

import com.system.entity.Payment;
import com.system.persistence.dao.PaymentDao;
import com.system.persistence.dao.impl.PaymentDaoImpl;
import org.junit.BeforeClass;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestPaymentDao {

    private static PaymentDao paymentDao = null;
    private static Payment payment = null;

    @BeforeClass
    public static void setUp() {
        paymentDao = mock(PaymentDaoImpl.class);
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

        when(paymentDao.create(payment)).thenReturn(payment.getPaymentId());
        when(paymentDao.findPaymentByPaymentId(payment.getPaymentId())).thenReturn(payment);
        when(paymentDao.findAllPaymentsByAccountId(payment.getAccountId())).thenReturn(Arrays.asList(payment));
    }

    @Test
    public void testCreatePayment() {
        Integer paymentId = paymentDao.create(payment);
        assertEquals(payment.getPaymentId(), paymentId);
    }

    @Test
    public void testFindPaymentByPaymentId() {
        Payment payment_1 = paymentDao.findPaymentByPaymentId(1);
        Payment payment_2 = paymentDao.findPaymentByPaymentId(3);
        assertNull(payment_2);
        assertEquals("11111000000000000000", payment_1.getRecipientNumber());
    }

    @Test
    public void testFindAllPaymentsByAccountId() {
        List<Payment> payments = paymentDao.findAllPaymentsByAccountId(1);
        assertEquals(1, payments.size());
        assertEquals(new BigDecimal("245.46"), payments.get(0).getRecipientAmount());
    }
}

