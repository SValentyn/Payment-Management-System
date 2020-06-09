package com.system.persistence.dao.impl;

import com.system.entity.Payment;
import com.system.persistence.dao.PaymentDao;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from PaymentDao interface
 *
 * @author Syniuk Valentyn
 */
public class PaymentDaoImpl implements PaymentDao {

    private static final Logger LOGGER = LogManager.getLogger(PaymentDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_PAYMENT =
            "INSERT INTO payments(account_id, is_outgoing, senderNumber, senderAmount, senderCurrency, recipientNumber, recipientAmount, recipientCurrency, exchangeRate, newBalance, appointment, `date`, `condition`) " +
                    "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String FIND_ALL_PAYMENTS = "SELECT * FROM payments";
    private static final String FIND_PAYMENT_BY_ID = "SELECT * FROM payments WHERE payment_id = ?";
    private static final String FIND_ALL_PAYMENTS_BY_ACCOUNT_ID =
            "SELECT * FROM payments " +
                    "WHERE account_id = ? ORDER BY payment_id DESC";
    private static final String FIND_ALL_PAYMENTS_BY_USER_ID =
            "SELECT payments.* FROM payments " +
                    "INNER JOIN accounts ON payments.account_id = accounts.account_id " +
                    "WHERE accounts.user_id = ? ORDER BY payment_id DESC";
    private static final String FIND_ALL_PAYMENTS_BY_USER_ID_LIMIT_3 =
            "SELECT payments.* FROM payments " +
                    "INNER JOIN accounts ON payments.account_id = accounts.account_id " +
                    "WHERE accounts.user_id = ? ORDER BY payment_id DESC LIMIT 3";
    private static final String SEARCH_BY_CRITERIA =
            "SELECT payments.* FROM payments " +
                    "INNER JOIN accounts ON payments.account_id = accounts.account_id " +
                    "WHERE accounts.user_id = ? AND is_outgoing = ? AND " +
                    "date BETWEEN STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s)') ORDER BY date DESC;";
    private static final String SEARCH_BY_CRITERIA_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP =
            "SELECT payments.* FROM payments " +
                    "INNER JOIN accounts ON payments.account_id = accounts.account_id " +
                    "WHERE accounts.user_id = ? AND is_outgoing = ? AND date BETWEEN " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND " +
                    "CURRENT_TIMESTAMP() ORDER BY date DESC;";
    private static final String SEARCH_BY_CRITERIA_WITHOUT_ISOUTGOING =
            "SELECT payments.* FROM payments " +
                    "INNER JOIN accounts ON payments.account_id = accounts.account_id " +
                    "WHERE accounts.user_id = ? AND date BETWEEN " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s)') ORDER BY date DESC;";
    private static final String SEARCH_BY_CRITERIA_WITHOUT_ISOUTGOING_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP =
            "SELECT payments.* FROM payments " +
                    "INNER JOIN accounts ON payments.account_id = accounts.account_id " +
                    "WHERE accounts.user_id = ? AND date BETWEEN " +
                    "STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') AND " +
                    "CURRENT_TIMESTAMP() ORDER BY date DESC;";

    private static PaymentDaoImpl instance = null;
    private final QueryExecutor executor = QueryExecutor.getInstance();

    private PaymentDaoImpl() {
    }

    public static synchronized PaymentDaoImpl getInstance() {
        if (instance == null) {
            instance = new PaymentDaoImpl();
        }
        return instance;
    }

    @Override
    public int create(Payment entity) {
        entity.setAppointment(StringEscapeUtils.escapeJava(entity.getAppointment()));

        Object[] args = {
                entity.getAccountId(),
                entity.getIsOutgoing(),
                entity.getSenderNumber(),
                entity.getSenderAmount(),
                entity.getSenderCurrency(),
                entity.getRecipientNumber(),
                entity.getRecipientAmount(),
                entity.getRecipientCurrency(),
                entity.getExchangeRate(),
                entity.getNewBalance(),
                entity.getAppointment(),
                entity.getDate(),
                entity.getCondition()
        };
        return executor.executeStatement(CREATE_PAYMENT, args);
    }

    @Override
    public Payment findPaymentByPaymentId(Integer paymentId) {
        Payment payment = new Payment();
        try {
            ResultSet rs = executor.executeQuery(FIND_PAYMENT_BY_ID, paymentId);
            if (rs.next()) {
                payment = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payment;
    }

    @Override
    public List<Payment> findAllPaymentsByAccountId(Integer accountId) {
        List<Payment> payments = new ArrayList<>();
        try {
            ResultSet rs = executor.executeQuery(FIND_ALL_PAYMENTS_BY_ACCOUNT_ID, accountId);
            while (rs.next()) {
                payments.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payments;
    }

    @Override
    public List<Payment> findAllPaymentsByUserId(Integer userId) {
        List<Payment> payments = new ArrayList<>();
        try {
            ResultSet rs = executor.executeQuery(FIND_ALL_PAYMENTS_BY_USER_ID, userId);
            while (rs.next()) {
                payments.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payments;
    }

    @Override
    public List<Payment> findLastPaymentsByUserId(Integer userId) {
        List<Payment> payments = new ArrayList<>();
        try {
            ResultSet rs = executor.executeQuery(FIND_ALL_PAYMENTS_BY_USER_ID_LIMIT_3, userId);
            while (rs.next()) {
                payments.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payments;
    }

    @Override
    public List<Payment> findAllPayments() {
        List<Payment> payments = new ArrayList<>();
        try {
            ResultSet rs = executor.executeQuery(FIND_ALL_PAYMENTS);
            while (rs.next()) {
                payments.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payments;
    }

    @Override
    public List<Payment> searchByCriteria(Integer userId, Integer isOutgoing, String startDate, String finalDate) {
        List<Payment> payments = new ArrayList<>();
        try {
            if (startDate.equals("")) {
                startDate = "01/01/2020 00:00:00";
            } else {
                startDate += " 00:00:00";
            }

            ResultSet rs;
            if (finalDate.equals("")) {
                rs = executor.executeQuery(SEARCH_BY_CRITERIA_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP, userId, isOutgoing, startDate);
            } else {
                finalDate += " 23:59:59";
                rs = executor.executeQuery(SEARCH_BY_CRITERIA, userId, isOutgoing, startDate, finalDate);
            }

            while (rs.next()) {
                payments.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payments;
    }

    @Override
    public List<Payment> searchByCriteria(Integer userId, String startDate, String finalDate) {
        List<Payment> payments = new ArrayList<>();
        try {
            if (startDate.equals("")) {
                startDate = "01/01/2020 00:00:00";
            } else {
                startDate += " 00:00:00";
            }

            ResultSet rs;
            if (finalDate.equals("")) {
                rs = executor.executeQuery(SEARCH_BY_CRITERIA_WITHOUT_ISOUTGOING_AND_FINAL_DATE_AS_CURRENT_TIMESTAMP, userId, startDate);
            } else {
                finalDate += " 23:59:59";
                rs = executor.executeQuery(SEARCH_BY_CRITERIA_WITHOUT_ISOUTGOING, userId, startDate, finalDate);
            }

            while (rs.next()) {
                payments.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payments;
    }

    /**
     * Creates entity from result set
     */
    private Payment createEntity(ResultSet rs) {
        Payment payment = new Payment();
        try {
            payment.setPaymentId(rs.getInt("payment_id"));
            payment.setAccountId(rs.getInt("account_id"));
            payment.setIsOutgoing(rs.getBoolean("is_outgoing"));
            payment.setSenderNumber(rs.getString("senderNumber"));
            payment.setSenderAmount(rs.getBigDecimal("senderAmount"));
            payment.setSenderCurrency(rs.getString("senderCurrency"));
            payment.setRecipientNumber(rs.getString("recipientNumber"));
            payment.setRecipientAmount(rs.getBigDecimal("recipientAmount"));
            payment.setRecipientCurrency(rs.getString("recipientCurrency"));
            payment.setExchangeRate(rs.getBigDecimal("exchangeRate"));
            payment.setNewBalance(rs.getBigDecimal("newBalance"));
            payment.setAppointment(StringEscapeUtils.unescapeJava(rs.getString("appointment")));
            Timestamp timestamp = rs.getTimestamp("date");
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
            payment.setDate(formatter.format(timestamp));
            payment.setCondition(rs.getBoolean("condition"));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payment;
    }

}
