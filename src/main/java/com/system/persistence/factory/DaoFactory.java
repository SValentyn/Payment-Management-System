package com.system.persistence.factory;

import com.system.persistence.dao.*;
import com.system.persistence.dao.impl.*;

/**
 * Classes that returns new instances of data access objects (DAO)
 *
 * @author Syniuk Valentyn
 */
public class DaoFactory {

    /**
     * @return UserDao
     */
    public static UserDao createUserDao() {
        return UserDaoImpl.getInstance();
    }

    /**
     * @return AccountDao
     */
    public static AccountDao createAccountDao() {
        return AccountDaoImpl.getInstance();
    }

    /**
     * @return BankCardDao
     */
    public static BankCardDao createBankCardDao() {
        return BankCardDaoImpl.getInstance();
    }

    /**
     * @return PaymentDao
     */
    public static PaymentDao createPaymentDao() {
        return PaymentDaoImpl.getInstance();
    }

    /**
     * @return LetterDao
     */
    public static LetterDao createLetterDao() {
        return LetterDaoImpl.getInstance();
    }

    /**
     * @return ActionLogDao
     */
    public static ActionLogDao createActionLogDao() {
        return ActionLogDaoImpl.getInstance();
    }

}
