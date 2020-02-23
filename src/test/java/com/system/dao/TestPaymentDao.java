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
        payment.setRecipientAccountNumber("5450655032805450");
        payment.setSum(new BigDecimal("1000.00"));
        payment.setAppointment("Thank you for dinner!");

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
        assertEquals("5450655032805450", payment_1.getRecipientAccountNumber());
    }

    @Test
    public void testFindAllPaymentsByAccountId() {
        List<Payment> payments = paymentDao.findAllPaymentsByAccountId(1);
        assertEquals(1, payments.size());
        assertEquals(new BigDecimal("1000.00"), payments.get(0).getSum());
    }
}
