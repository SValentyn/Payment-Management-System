package com.system.persistence.factory;

import com.system.persistence.dao.AccountDao;
import com.system.persistence.dao.CreditCardDao;
import com.system.persistence.dao.PaymentDao;
import com.system.persistence.dao.UserDao;
import com.system.persistence.dao.impl.AccountDaoImpl;
import com.system.persistence.dao.impl.CreditCardDaoImpl;
import com.system.persistence.dao.impl.PaymentDaoImpl;
import com.system.persistence.dao.impl.UserDaoImpl;

import java.sql.SQLException;

/**
 * A class that returns new instances of data access objects (DAO)
 *
 * @author Syniuk Valentyn
 */
public class DaoFactory {

    /**
     * @return AccountDao
     */
    public static AccountDao createAccountDao() throws SQLException {
        return AccountDaoImpl.getInstance();
    }

    /**
     * @return CreditCardDao
     */
    public static CreditCardDao createCreditCardDao() throws SQLException {
        return CreditCardDaoImpl.getInstance();
    }

    /**
     * @return PaymentDao
     */
    public static PaymentDao createPaymentDao() throws SQLException {
        return PaymentDaoImpl.getInstance();
    }

    /**
     * @return UserDao
     */
    public static UserDao createUserDao() throws SQLException {
        return UserDaoImpl.getInstance();
    }

}
