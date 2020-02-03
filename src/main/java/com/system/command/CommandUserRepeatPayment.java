package com.system.command;

import com.system.entity.Account;
import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.persistence.factory.DaoFactory;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class CommandUserRepeatPayment implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_MAKE_PAYMENT);

        request.setAttribute("created", false);
        request.setAttribute("numberNotExistError", false);
        request.setAttribute("accountFromBlockedError", false);
        request.setAttribute("receiverAccountOrCardBlockedError", false);
        request.setAttribute("insufficientFundsError", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        // Data
        String paymentId = request.getParameter("paymentId");
        Payment payment = DaoFactory.createPaymentDao().findPaymentByPaymentId(Integer.parseInt(paymentId));
        String number = payment.getCardNumber();
        BigDecimal amount = payment.getSum();
        String appointment = payment.getAppointment();

        Integer accountId = payment.getAccountId();
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(user.getUserId());
        accounts.remove(AccountService.getInstance().findAccountByAccountId(String.valueOf(accountId)));

        // Set attributes
        request.setAttribute("accounts", accounts);
        request.setAttribute("accountId", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(String.valueOf(accountId)));
        request.setAttribute("numberValue", number);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);

        return page;
    }

}
