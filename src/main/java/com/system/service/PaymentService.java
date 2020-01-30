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
    public synchronized int formPayment(Integer accountId, String number, BigDecimal amount, String appointment) {
        int status = 0;
        Payment payment = new Payment();
        payment.setAccountId(accountId);
        payment.setCardNumber(number);
        payment.setSum(amount);
        payment.setAppointment(appointment);
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        payment.setDate(formatter.format(new Date()));

        Account accountFrom = accountDao.findAccountById(accountId);
        CreditCard receiverCard = checkAvailableCard(number);

        if (receiverCard != null && checkAvailableSum(accountFrom, amount)) {
            Account accountTo = accountDao.findAccountById(receiverCard.getAccountId());
            transaction(accountFrom, accountTo, amount);
            payment.setCondition(true);
            status = paymentDao.create(payment);
        } else {
            payment.setCondition(false);
            LOGGER.error("Payment arrangement error!");
            return status;
        }

        return status;
    }

    /**
     * Checks if card of receiver is available and returns it
     */
    private synchronized CreditCard checkAvailableCard(String number) {
        CreditCard creditCard = creditCardDao.findCreditCardByCardNumber(number);
        if (creditCard != null) {
            if (!creditCard.getIsActive()) // blocked
                creditCard = null;
        }
        return creditCard;
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
