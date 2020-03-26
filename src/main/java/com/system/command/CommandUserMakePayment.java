package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.PaymentService;
import com.system.service.UserService;
import com.system.utils.Validator;

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
        request.setAttribute("paymentError", false);
        request.setAttribute("paymentToYourAccountError", false);
        request.setAttribute("recipientAccountNotExistError", false);
        request.setAttribute("senderAccountBlockedError", false);
        request.setAttribute("recipientAccountBlockedError", false);
        request.setAttribute("recipientCardNotExistOrBlockedError", false);
        request.setAttribute("insufficientFundsError", false);
        request.setAttribute("isRepeatCommandValue", "0");
        request.setAttribute("caseValue", "off");

        User user = (User) request.getSession().getAttribute("currentUser");

        if (user == null) {
            request.setAttribute("paymentError", true);
            return page;
        }

        // Set Attributes
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String accountId = request.getParameter("accountId");
            String recipientAccountNumber = request.getParameter("accountNumber");
            String recipientCardNumber = request.getParameter("cardNumber");
            String amount = request.getParameter("amount");
            String appointment = request.getParameter("appointment");
            BigDecimal exchangeRate = new BigDecimal("1.0");

            // Check
            if (!validation(accountId, recipientAccountNumber, recipientCardNumber, amount)) {
                setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                request.setAttribute("paymentError", true);
                return page;
            }

            // Data
            Integer accountIdInt = Integer.valueOf(accountId);
            List<Account> accounts = AccountService.getInstance().findAllAccounts();
            List<Integer> accountIds = new ArrayList<>();
            for (Account account : accounts) {
                accountIds.add(account.getAccountId());
            }

            // Check
            if (!accountIds.contains(accountIdInt)) {
                request.setAttribute("paymentError", true);
                return page;
            }

            // Check
            if (recipientAccountNumber != null) {
                Account senderAccount = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountId));
                if (senderAccount.getNumber().equals(recipientAccountNumber)) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("paymentToYourAccountError", true);
                    return page;
                }

                List<Account> allAccounts = AccountService.getInstance().findAllAccounts();
                List<String> allNumbersAccounts = new ArrayList<>();
                for (Account account : allAccounts) {
                    allNumbersAccounts.add(account.getNumber());
                }

                if (!allNumbersAccounts.contains(recipientAccountNumber)) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("recipientAccountNotExistError", true);
                    return page;
                }

                // [There will be a currency conversion module]
                // stub:
                exchangeRate = new BigDecimal("1.0");
            }

            // Forming Payment
            if (recipientAccountNumber != null) {
                request.setAttribute("caseValue", "off");

                int status = PaymentService.getInstance().makePaymentOnAccount(Integer.valueOf(accountId), recipientAccountNumber, new BigDecimal(amount), exchangeRate, appointment);
                if (status == -1) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("senderAccountBlockedError", true);
                } else if (status == -2) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("recipientAccountBlockedError", true);
                } else if (status == -3) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("insufficientFundsError", true);
                } else {
                    request.setAttribute("created", true);
                }
            } else {
                request.setAttribute("caseValue", "on");

                int status = PaymentService.getInstance().makePaymentOnCard(Integer.valueOf(accountId), recipientCardNumber, new BigDecimal(amount), appointment);
                if (status == -1) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("senderAccountBlockedError", true);
                } else if (status == -2) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("recipientCardNotExistOrBlockedError", true);
                } else if (status == -3) {
                    setRequestAttributes(request, accountId, recipientAccountNumber, recipientCardNumber, amount, appointment);
                    request.setAttribute("insufficientFundsError", true);
                } else {
                    request.setAttribute("created", true);
                }
            }
        }

        return page;
    }

    private boolean validation(String accountId, String accountNumber, String cardNumber, String amount) {
        if (accountId == null || Validator.isNegative(accountId) || amount == null || amount.equals("")) return false;
        if (accountNumber != null) return Validator.checkAccountNumber(accountNumber);
        if (cardNumber != null) return Validator.checkCardNumber(cardNumber);

        return true;
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
