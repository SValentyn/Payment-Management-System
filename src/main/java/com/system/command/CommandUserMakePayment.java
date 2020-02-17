package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandUserMakePayment implements ICommand {

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
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String accountId = request.getParameter("accountId");
            String number = request.getParameter("number");
            String amount = request.getParameter("amount");
            String appointment = request.getParameter("appointment");

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

            // Forming Payment
            int status = PaymentService.getInstance().formingPayment(Integer.valueOf(accountId), number, Double.valueOf(amount), appointment);
            if (status == -1) {
                setRequestAttributes(request, accountId, number, amount, appointment);
                request.setAttribute("accountFromBlockedError", true);
            } else if (status == -2) {
                setRequestAttributes(request, accountId, number, amount, appointment);
                request.setAttribute("receiverAccountBlockedError", true);
            } else if (status == -3) {
                setRequestAttributes(request, accountId, number, amount, appointment);
                request.setAttribute("insufficientFundsError", true);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String accountId, String number, String amount, String appointment) throws SQLException {
        request.setAttribute("accountIdValue", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
        request.setAttribute("numberValue", number);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);
    }

}
