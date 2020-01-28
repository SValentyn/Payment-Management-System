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
    private CreditCardDao creditCardDao = DaoFactory.createCreditCardDao();
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
     * Checks all conditions, forms payment and adds is to database
     */
    public synchronized int formPayment(Integer accountId, String number, BigDecimal sum, Double percent, String appointment) {
        Payment payment = new Payment();
        payment.setAccountId(accountId);
        payment.setCardNumber(number);
        payment.setSum(sum);
        payment.setAppointment(appointment);
        payment.setDate(new Date().toString());

        Account accountFrom = accountDao.findAccountById(accountId);
        CreditCard receiverCard = checkAvailableCard(number);
        BigDecimal finalSum = checkAvailableSum(sum, accountFrom, percent);

        if (receiverCard != null && finalSum != null) {
            Account accountTo = accountDao.findAccountById(receiverCard.getAccountId());
            withdrawFunds(accountFrom, accountFrom.getBalance().subtract(finalSum));
            addFunds(accountTo, accountTo.getBalance().add(finalSum));
            payment.setCondition(true);
        } else {
            payment.setCondition(false);
            LOGGER.error("Payment arrangement error!");
        }
        return paymentDao.create(payment);
    }

    /**
     * Checks if card of receiver is available and returns it
     */
    private synchronized CreditCard checkAvailableCard(String number) {
        CreditCard creditCard = creditCardDao.findCreditCardByCardNumber(number);
        if (creditCard != null) {
            if (!creditCard.getIsActive())
                creditCard = null;
        }
        return creditCard;
    }

    /**
     * Checks and form final sum with percent for payment
     */
    private synchronized BigDecimal checkAvailableSum(BigDecimal paymentSum, Account account, Double percent) {
        BigDecimal finalSum = null;
        BigDecimal balance = account.getBalance();
        BigDecimal checkSum = paymentSum.add(paymentSum.multiply(BigDecimal.valueOf(percent)));
        if (checkSum.compareTo(balance) < 0 || checkSum.compareTo(balance) == 0) {
            finalSum = checkSum;
        }

        return finalSum;
    }

    /**
     * Checks if account isn't blocked and withdraw funds from account
     */
    private synchronized void withdrawFunds(Account account, BigDecimal balance) {
        if (!account.getIsBlocked()) {
            account.setBalance(balance);
            accountDao.update(account);
        } else {
            LOGGER.info("Attempt to withdraw funds in blocked account!");
        }
    }

    /**
     * Set new balance to account who receives funds
     */
    private synchronized void addFunds(Account account, BigDecimal balance) {
        account.setBalance(balance);
        accountDao.update(account);
    }

    /**
     * Finds all payments by account id
     */
    public List<Payment> findAllPaymentsByAccountId(Integer accountId) {
        return paymentDao.findAllPaymentsByAccountId(accountId);
    }
}
