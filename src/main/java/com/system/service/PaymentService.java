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
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Provides service methods for PaymentDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class PaymentService {

    private static final Logger LOGGER = LogManager.getLogger(PaymentService.class);

    private static PaymentService instance = null;
    private AccountDao accountDao = DaoFactory.createAccountDao();
    private PaymentDao paymentDao = DaoFactory.createPaymentDao();

    private PaymentService() throws SQLException {
    }

    public static synchronized PaymentService getInstance() throws SQLException {
        if (instance == null) {
            instance = new PaymentService();
        }
        return instance;
    }

    /**
     * Formation and implementation of payment to the recipient's account
     * Checks all conditions, forms payment and adds is to database
     */
    public synchronized int makePaymentOnAccount(Integer accountId, String accountNumber, BigDecimal amount, String appointment) {
        int status;

        Account accountFrom = accountDao.findAccountById(accountId);
        Account accountTo = accountDao.findAccountByNumber(accountNumber);

        Payment payment = new Payment();
        payment.setAccountId(accountId);
        payment.setSenderNumber(accountFrom.getNumber());
        payment.setRecipientNumber(accountNumber);
        payment.setSum(amount);
        payment.setAppointment(appointment);
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
        payment.setDate(formatter.format(new Date()));

        if (checkAvailableAccount(accountFrom)) {
            LOGGER.error("Payment arrangement error!");
            payment.setCondition(false);
            return -1;
        }

        if (checkAvailableAccount(accountTo)) {
            LOGGER.error("Payment arrangement error!");
            payment.setCondition(false);
            return -2;
        }

        if (checkAvailableSum(accountFrom, amount)) {
            transaction(accountFrom, accountTo, amount);
            payment.setCondition(true);
            status = paymentDao.create(payment);
        } else {
            LOGGER.error("Payment arrangement error!");
            payment.setCondition(false);
            return -3;
        }

        return status;
    }

    /**
     * Formation and implementation of payment to the recipient's bank card
     * Checks all conditions, forms payment and adds is to database
     */
    public synchronized int makePaymentOnCard(Integer accountId, String cardNumber, BigDecimal amount, String appointment) {
        int status;

        Payment payment = new Payment();
        payment.setAccountId(accountId);
        payment.setRecipientNumber(cardNumber);
        payment.setSum(amount);
        payment.setAppointment(appointment);
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
        payment.setDate(formatter.format(new Date()));

        Account accountFrom = accountDao.findAccountById(accountId);
        if (checkAvailableAccount(accountFrom)) {
            LOGGER.error("Payment arrangement error!");
            payment.setCondition(false);
            return -1;
        }

        // [Checking the existence of a bank card] -> return -2
        // [A money transfer to a bank card should be carried out, but so far, I am not able to implement it]

        if (checkAvailableSum(accountFrom, amount)) {
            transaction(accountFrom, cardNumber, amount);
            payment.setCondition(true);
            status = paymentDao.create(payment);
        } else {
            LOGGER.error("Payment arrangement error!");
            payment.setCondition(false);
            return -3;
        }

        return status;
    }

    /**
     * Check account blocking
     *
     * @return true, if account is blocked
     */
    private synchronized boolean checkAvailableAccount(Account account) {
        return account.getIsBlocked();
    }

    /**
     * Checks the activity of the card
     *
     * @return true, if card is active
     */
    private synchronized boolean checkAvailableCard(BankCard card) {
        return card.getIsActive();
    }

    /**
     * Checks and form final sum with percent for payment
     */
    private synchronized boolean checkAvailableSum(Account account, BigDecimal paymentSum) {
        BigDecimal balance = account.getBalance();
        return balance.compareTo(paymentSum) >= 0;
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
            // [Add amount on bank card]
            accountDao.update(accountFrom);
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

}
