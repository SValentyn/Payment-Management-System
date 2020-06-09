package com.system.service;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.entity.Payment;
import com.system.persistence.dao.AccountDao;
import com.system.persistence.dao.PaymentDao;
import com.system.persistence.factory.DaoFactory;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 * Provides service methods for PaymentDao. Layout between DAO and Command.
 *
 * @author Syniuk Valentyn
 */
public class PaymentService {

    private static final Logger LOGGER = LogManager.getLogger(PaymentService.class);

    private static PaymentService instance = null;
    private final AccountDao accountDao = DaoFactory.createAccountDao();
    private final PaymentDao paymentDao = DaoFactory.createPaymentDao();

    private PaymentService() {
    }

    public static synchronized PaymentService getInstance() {
        if (instance == null) {
            instance = new PaymentService();
        }
        return instance;
    }

    /**
     * *** The logic of making payments ***
     * The system has two types of payments: Outgoing and Incoming.
     * They are inserted into the "payments" table one by one.
     * They have the same data, except for the fields: accountId, is_outgoing and newBalance.
     * It is made so that it is possible to correctly receive all types of payments.
     */

    /**
     * Formation and implementation of payment to the recipient's account
     * Checks all conditions, forms payments and adds them to the DB
     */
    public synchronized int makePaymentOnAccount(Integer accountId, String accountNumber, BigDecimal amount, BigDecimal exchangeRate, String appointment) {
        int status = 0;

        Account accountFrom = accountDao.findAccountById(accountId);
        Account accountTo = accountDao.findAccountByNumber(accountNumber);

        if (checkAvailableAccount(accountFrom)) {
            LOGGER.error("Sender account is blocked");
            return -1;
        }

        if (checkAvailableAccount(accountTo)) {
            LOGGER.error("Recipient account is blocked");
            return -2;
        }

        // Outgoing payment details
        Payment payment = new Payment();
        payment.setAccountId(accountId);
        payment.setIsOutgoing(true);
        payment.setSenderNumber(accountFrom.getNumber());
        payment.setSenderAmount(amount);
        payment.setSenderCurrency(accountFrom.getCurrency());
        payment.setRecipientNumber(accountNumber);
        payment.setRecipientAmount(amount.multiply(exchangeRate));
        payment.setRecipientCurrency(accountTo.getCurrency());
        payment.setExchangeRate(exchangeRate);
        payment.setAppointment(appointment);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        formatter.setTimeZone(TimeZone.getTimeZone("UTC"));
        payment.setDate(formatter.format(new Date()));

        if (checkAvailableAmount(accountFrom, amount)) {
            transaction(accountFrom, accountTo, amount);
            payment.setNewBalance(accountFrom.getBalance());
            payment.setCondition(true);
            paymentDao.create(payment);

            // Incoming payment details
            payment.setAccountId(accountTo.getAccountId());
            payment.setIsOutgoing(false);
            payment.setNewBalance(accountTo.getBalance());
            paymentDao.create(payment);
        } else {
            LOGGER.error("Payment arrangement error!");
            return -3;
        }

        return status;
    }

    /**
     * Formation and implementation of payment to the recipient's bank card
     * Checks all conditions, forms payment and adds is to database
     */
    public synchronized int makePaymentOnCard(Integer accountId, String cardNumber, BigDecimal amount, String appointment) {
        int status = 0;

        Account accountFrom = accountDao.findAccountById(accountId);

        if (checkAvailableAccount(accountFrom)) {
            LOGGER.error("Sender account is blocked");
            return -1;
        }

        // [Checking the existence of a bank card] -> return -2
        // [A money transfer to a bank card should be carried out, but so far, I am not able to implement it]

        Payment payment = new Payment();
        payment.setAccountId(accountId);
        payment.setIsOutgoing(true);
        payment.setSenderNumber(accountFrom.getNumber());
        payment.setSenderAmount(amount);
        payment.setSenderCurrency(accountFrom.getCurrency());
        payment.setRecipientNumber(cardNumber);
        payment.setExchangeRate(new BigDecimal("1.0"));
        payment.setAppointment(appointment);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        formatter.setTimeZone(TimeZone.getTimeZone("UTC"));
        payment.setDate(formatter.format(new Date()));

        if (checkAvailableAmount(accountFrom, amount)) {
            transaction(accountFrom, cardNumber, amount);
            payment.setNewBalance(accountFrom.getBalance());
            payment.setCondition(true);
            paymentDao.create(payment);
        } else {
            LOGGER.error("Payment arrangement error!");
            return -3;
        }

        return status;
    }

    /**
     * @return true, if account is blocked
     */
    private synchronized boolean checkAvailableAccount(Account account) {
        return account.getIsBlocked();
    }

    /**
     * @return true, if card is active
     */
    private synchronized boolean checkAvailableCard(BankCard card) {
        return card.getIsActive();
    }

    /**
     * @return true, if the account has enough funds to be debited
     */
    private synchronized boolean checkAvailableAmount(Account account, BigDecimal amount) {
        BigDecimal balance = account.getBalance();
        return balance.compareTo(amount) >= 0;
    }

    /**
     * Checks if accounts are locked and performs a transaction between them
     */
    private synchronized void transaction(Account accountFrom, Account accountTo, BigDecimal amount) {
        if (!accountFrom.getIsBlocked() && !accountTo.getIsBlocked()) {
            accountFrom.setBalance(accountFrom.getBalance().subtract(amount));
            accountTo.setBalance(accountTo.getBalance().add(amount));
            accountDao.update(accountFrom);
            accountDao.update(accountTo);
        } else {
            LOGGER.info("Trying to withdraw or add funds to a blocked account!");
        }
    }

    /**
     * Checks if an account is locked and performs a transaction
     */
    private synchronized void transaction(Account accountFrom, String cardNumber, BigDecimal amount) {
        if (!accountFrom.getIsBlocked()) {
            accountFrom.setBalance(accountFrom.getBalance().subtract(amount));
            accountDao.update(accountFrom);

            // [Add amount on bank card]
        } else {
            LOGGER.info("Trying to withdraw funds from a blocked account or or add funds to a non-existing card!");
        }
    }

    /**
     * Finds payment by payment id
     */
    public Payment findPaymentByPaymentId(Integer paymentId) {
        return paymentDao.findPaymentByPaymentId(paymentId);
    }

    /**
     * Finds all payments by account id
     */
    public List<Payment> findAllPaymentsByAccountId(Integer accountId) {
        return paymentDao.findAllPaymentsByAccountId(accountId);
    }

    /**
     * Finds all payments by user id
     */
    public List<Payment> findAllPaymentsByUserId(Integer userId) {
        return paymentDao.findAllPaymentsByUserId(userId);
    }

    /**
     * Finds last payments by user id
     */
    public List<Payment> findLastPaymentsByUserId(Integer userId) {
        return paymentDao.findLastPaymentsByUserId(userId);
    }

    /**
     * Finds all payments in system
     */
    public List<Payment> findAllPayments() {
        return paymentDao.findAllPayments();
    }

    /**
     * Searches all payments by criteria
     */
    public List<Payment> searchByCriteria(Integer userId, Integer isOutgoing, String startDate, String finalDate) {
        return paymentDao.searchByCriteria(userId, isOutgoing, startDate, finalDate);
    }

    /**
     * Searches all payments by criteria without value of isOutgoing
     */
    public List<Payment> searchByCriteria(Integer userId, String startDate, String finalDate) {
        return paymentDao.searchByCriteria(userId, startDate, finalDate);
    }

}
