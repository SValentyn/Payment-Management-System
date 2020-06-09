package com.system.persistence.dao;

import com.system.entity.Payment;

import java.util.List;

/**
 * The interface provides methods for retrieving data for a Payment entity
 *
 * @author Syniuk Valentyn
 */
public interface PaymentDao {

    /**
     * Inserts new entity into database
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

    /**
     * Retrieves all payments of account by user id
     */
    List<Payment> findAllPaymentsByUserId(Integer userId);

    /**
     * Retrieves last payments of account by user id
     */
    List<Payment> findLastPaymentsByUserId(Integer userId);

    /**
     * Retrieves all payments in the system
     */
    List<Payment> findAllPayments();

    /**
     * Searches all payments by criteria
     */
    List<Payment> searchByCriteria(Integer userId, Integer isOutgoing, String startDate, String finalDate);

    /**
     * Searches all payments by criteria without value of isOutgoing
     */
    List<Payment> searchByCriteria(Integer userId, String startDate, String finalDate);

}
