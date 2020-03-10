package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.PaymentService;
import com.system.service.UserService;

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
        request.setAttribute("accountNumberNotExistError", false);
        request.setAttribute("accountFromBlockedError", false);
        request.setAttribute("receiverAccountBlockedError", false);
        request.setAttribute("cardNotExistOrBlockedError", false);
        request.setAttribute("insufficientFundsError", false);
        request.setAttribute("isRepeatCommandValue", "0");
        request.setAttribute("caseValue", "off");

        User user = (User) request.getSession().getAttribute("currentUser");

        // Set Attributes
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String accountId = request.getParameter("accountId");
            String accountNumber = request.getParameter("accountNumber");
            String cardNumber = request.getParameter("cardNumber");
            String amount = request.getParameter("amount");
            String appointment = request.getParameter("appointment");

            // Check
            if (accountNumber != null) {
                Account accountByAccountId = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountId));
                if (accountByAccountId.getNumber().equals(accountNumber)) {
                    setRequestAttributes(request, accountId, accountNumber, cardNumber, amount, appointment);
                    request.setAttribute("paymentToYourAccountError", true);
                    return page;
                }

                List<Account> allAccounts = AccountService.getInstance().findAllAccounts();
                List<String> allNumbersAccounts = new ArrayList<>();
                for (Account account : allAccounts) {
                    allNumbersAccounts.add(account.getNumber());
                }

                if (!allNumbersAccounts.contains(accountNumber)) {
                    setRequestAttributes(request, accountId, accountNumber, cardNumber, amount, appointment);
                    request.setAttribute("accountNumberNotExistError", true);
                    return page;
                }
            }

            // Forming Payment
            if (accountNumber != null) {
                int status = PaymentService.getInstance().makePaymentOnAccount(Integer.valueOf(accountId), accountNumber, new BigDecimal(amount), appointment);
                if (status == -1) {
                    setRequestAttributes(request, accountId, accountNumber, null, amount, appointment);
                    request.setAttribute("accountFromBlockedError", true);
                } else if (status == -2) {
                    setRequestAttributes(request, accountId, accountNumber, null, amount, appointment);
                    request.setAttribute("receiverAccountBlockedError", true);
                } else if (status == -3) {
                    setRequestAttributes(request, accountId, accountNumber, null, amount, appointment);
                    request.setAttribute("insufficientFundsError", true);
                } else {
                    request.setAttribute("created", true);
                }
            } else {
                request.setAttribute("caseValue", "on");

                int status = PaymentService.getInstance().makePaymentOnCard(Integer.valueOf(accountId), cardNumber, new BigDecimal(amount), appointment);
                if (status == -1) {
                    setRequestAttributes(request, accountId, null, cardNumber, amount, appointment);
                    request.setAttribute("accountFromBlockedError", true);
                } else if (status == -2) {
                    setRequestAttributes(request, accountId, null, cardNumber, amount, appointment);
                    request.setAttribute("cardNotExistOrBlockedError", true);
                } else if (status == -3) {
                    setRequestAttributes(request, accountId, null, cardNumber, amount, appointment);
                    request.setAttribute("insufficientFundsError", true);
                } else {
                    request.setAttribute("caseValue", "off");
                    request.setAttribute("created", true);
                }
            }
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String accountId, String accountNumber, String cardNumber, String amount, String appointment) throws SQLException {
        request.setAttribute("accountIdValue", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
        request.setAttribute("accountNumberValue", accountNumber);
        request.setAttribute("cardNumberValue", cardNumber);
        request.setAttribute("amountValue", amount);
        request.setAttribute("appointmentValue", appointment);
    }

}
