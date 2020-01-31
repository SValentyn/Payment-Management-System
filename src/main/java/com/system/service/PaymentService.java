package com.system.service;

import com.system.entity.Account;
import com.system.entity.CreditCard;
import com.system.entity.Payment;
import com.system.persistence.dao.AccountDao;
import com.system.persistence.dao.CreditCardDao;
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

    private AccountDao accountDao = DaoFactory.createAccountDao();
    private CreditCardDao creditCardDao = DaoFactory.createCreditCardDao();
    private PaymentDao paymentDao = DaoFactory.createPaymentDao();

    private PaymentService() throws SQLException {
    }

    private static PaymentService instance = null;

    public static synchronized PaymentService getInstance() throws SQLException {
        if (instance == null) {
            instance = new PaymentService();
        }
        return instance;
    }

    /**
     * Checks all conditions, forms payment and adds is to database
     */
    public synchronized int formingPayment(Integer accountId, String number, BigDecimal amount, String appointment) {
        int status;
        Payment payment = new Payment();
        payment.setAccountId(accountId);
        payment.setCardNumber(number);
        payment.setSum(amount);
        payment.setAppointment(appointment);
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        payment.setDate(formatter.format(new Date()));

        Account accountFrom = accountDao.findAccountById(accountId);
        if (checkAvailableAccount(accountFrom)) {
            LOGGER.error("Payment arrangement error!");
            payment.setCondition(false);
            return -1;
        }

        CreditCard cardTo = creditCardDao.findCreditCardByCardNumber(number);
        Account accountTo = accountDao.findAccountById(cardTo.getAccountId());
        if (checkAvailableAccount(accountTo) || !checkAvailableCard(cardTo)) {
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
    private synchronized boolean checkAvailableCard(CreditCard card) {
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
     * Finds all payments by account id
     */
    public List<Payment> findAllPaymentsByAccountId(Integer accountId) {
        return paymentDao.findAllPaymentsByAccountId(accountId);
    }
}
