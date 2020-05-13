package com.system.persistence.factory;

import com.system.persistence.dao.*;
import com.system.persistence.dao.impl.*;

import java.sql.SQLException;

/**
 * A class that returns new instances of data access objects (DAO)
 *
 * @author Syniuk Valentyn
 */
public class DaoFactory {

    /**
     * @return UserDao
     */
    public static UserDao createUserDao() throws SQLException {
        return UserDaoImpl.getInstance();
    }

    /**
     * @return AccountDao
     */
    public static AccountDao createAccountDao() throws SQLException {
        return AccountDaoImpl.getInstance();
    }

    /**
     * @return BankCardDao
     */
    public static BankCardDao createBankCardDao() throws SQLException {
        return BankCardDaoImpl.getInstance();
    }

    /**
     * @return PaymentDao
     */
    public static PaymentDao createPaymentDao() throws SQLException {
        return PaymentDaoImpl.getInstance();
    }

    /**
     * @return LetterDao
     */
    public static LetterDao createLetterDao() throws SQLException {
        return LetterDaoImpl.getInstance();
    }

    /**
     * @return ActionLogDao
     */
    public static ActionLogDao createActionLogDao() throws SQLException {
        return ActionLogDaoImpl.getInstance();
    }

}
