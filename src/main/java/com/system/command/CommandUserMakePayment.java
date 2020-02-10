package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.PaymentService;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandUserMakePayment implements ICommand {

    private static final org.apache.log4j.Logger LOGGER = Logger.getLogger(CommandUserMakePayment.class);


    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_MAKE_PAYMENT);

        request.setAttribute("created", false);
        request.setAttribute("paymentToYourAccountError", false);
        request.setAttribute("numberNotExistError", false);
        request.setAttribute("accountFromBlockedError", false);
        request.setAttribute("receiverAccountBlockedError", false);
        request.setAttribute("insufficientFundsError", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(user.getUserId());

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            request.setAttribute("accounts", accounts);
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String accountId = request.getParameter("accountId");
            String number = request.getParameter("number");
            String amount = request.getParameter("amount");
            String appointment = request.getParameter("appointment");

            accounts.remove(AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountId)));
            request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));

            // Check
            Account accountByAccountId = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountId));
            if (accountByAccountId.getNumber().equals(number)) {
                setRequestAttributes(request, accountId, number, amount, appointment);
                request.setAttribute("paymentToYourAccountError", true);
                return page;
            }

            // Check
            List<Account> allAccounts = AccountService.getInstance().findAllAccounts();
            List<String> allNumbersAccounts = new ArrayList<>();
            for (Account account : allAccounts) {
                allNumbersAccounts.add(account.getNumber());
            }

            if (!allNumbersAccounts.contains(number)) {
                setRequestAttributes(request, accountId, number, amount, appointment);
                request.setAttribute("numberNotExistError", true);
                return page;
            }

            // Create
            int status = PaymentService.getInstance().formingPayment(Integer.valueOf(accountId), number, new BigDecimal(amount), appointment);
            if (status == -1) {
                request.setAttribute("accountFromBlockedError", true);
                setRequestAttributes(request, accountId, number, amount, appointment);
            } else if (status == -2) {
                request.setAttribute("receiverAccountBlockedError", true);
                setRequestAttributes(request, accountId, number, amount, appointment);
            } else if (status == -3) {
                request.setAttribute("insufficientFundsError", true);
                setRequestAttributes(request, accountId, number, amount, appointment);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String accountId, String number, String amount, String appointment) {
        request.setAttribute("accountId", accountId);
        request.setAttribute("numberValue", number);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);
    }

}