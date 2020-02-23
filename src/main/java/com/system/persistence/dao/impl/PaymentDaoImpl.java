package com.system.persistence.dao.impl;

import com.system.entity.Payment;
import com.system.persistence.dao.PaymentDao;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
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
    private static final String CREATE_PAYMENT = "INSERT INTO payments(account_id, recipient_account_number, sum, appointment, date, `condition`) VALUES(?, ?, ?, ?, ?, ?)";
    private static final String FIND_PAYMENT_BY_ID = "SELECT * FROM payments WHERE payment_id = ?";
    private static final String FIND_ALL_PAYMENTS_BY_ACCOUNT_ID = "SELECT * FROM payments WHERE account_id = ?";

    private static PaymentDaoImpl instance = null;
    private QueryExecutor executor = QueryExecutor.getInstance();

    private PaymentDaoImpl() throws SQLException {
    }

    public static synchronized PaymentDaoImpl getInstance() throws SQLException {
        if (instance == null) {
            instance = new PaymentDaoImpl();
        }
        return instance;
    }

    @Override
    public int create(Payment entity) {
        Object[] args = {entity.getAccountId(), entity.getRecipientAccountNumber(), entity.getSum(), entity.getAppointment(), entity.getDate(), entity.getCondition()};
        return executor.executeStatement(CREATE_PAYMENT, args);
    }

    @Override
    public Payment findPaymentByPaymentId(Integer paymentId) {
        Payment payment = null;
        try {
            ResultSet rs = executor.getResultSet(FIND_PAYMENT_BY_ID, paymentId);
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
            ResultSet rs = executor.getResultSet(FIND_ALL_PAYMENTS_BY_ACCOUNT_ID, accountId);
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
            payment.setRecipientAccountNumber(rs.getString("recipient_account_number"));
            payment.setSum(rs.getBigDecimal("sum"));
            payment.setAppointment(rs.getString("appointment"));
            payment.setDate(rs.getString("date"));
            payment.setCondition(rs.getBoolean("condition"));
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return payment;
    }

}
