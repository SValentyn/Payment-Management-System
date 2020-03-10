package com.system.command;

import com.system.entity.Account;
import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.persistence.factory.DaoFactory;
import com.system.service.AccountService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class CommandUserRepeatPayment implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_MAKE_PAYMENT);

        // Data
        User user = (User) request.getSession().getAttribute("currentUser");
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));

        String paymentId = request.getParameter("paymentId");
        Payment payment = DaoFactory.createPaymentDao().findPaymentByPaymentId(Integer.parseInt(paymentId));
        String number = payment.getRecipientNumber();
        BigDecimal amount = payment.getSum();
        String appointment = payment.getAppointment();

        Integer accountId = payment.getAccountId();
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(user.getUserId());
        accounts.remove(AccountService.getInstance().findAccountByAccountId(accountId));

        // Set attributes
        request.setAttribute("accounts", accounts);
        request.setAttribute("accountIdValue", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(accountId));
        request.setAttribute("numberValue", number);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);
        request.setAttribute("isRepeatCommandValue", "1");

        return page;
    }

}
