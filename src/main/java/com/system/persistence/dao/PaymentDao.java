package com.system.persistence.dao;

import com.system.entity.Payment;

import java.util.List;

/**
 * The PaymentDao interface provides methods for retrieving data for Payment entity
 *
 * @author Syniuk Valentyn
 */
public interface PaymentDao {

    /**
     * Inserts new entity into DB
     */
    int create(Payment entity);

    /**
     * Retrieves payment by payment id
     */
    Payment findPaymentByPaymentId(Integer paymentId);

    /**
     * Retrieves all payments of account by its id
     */
    List<Payment> findAllPaymentsByAccountId(Integer accountId);

}
