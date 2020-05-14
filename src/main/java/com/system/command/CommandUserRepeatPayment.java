package com.system.command;

import com.system.entity.Account;
import com.system.entity.Payment;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.ActionLogService;
import com.system.service.PaymentService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandUserRepeatPayment implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_MAKE_PAYMENT);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_MAKE_PAYMENT);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            String paymentIdParam = request.getParameter("paymentId");

            // Validation
            if (!validation(request, currentUser, paymentIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setSessionAttributes(request, paymentIdParam);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_MAKE_PAYMENT);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            String caseValue = request.getParameter("caseValue");
            String accountIdParam = request.getParameter("accountId");
            String recipientAccountNumber = request.getParameter("accountNumber");
            String recipientCardNumber = request.getParameter("cardNumber");
            String amount = request.getParameter("amount");
            String appointment = request.getParameter("appointment");

            // Validation
            if (!validation(request, currentUser, caseValue, accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment)) {
                if (currentUser != null)
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to make a payment");
                return pathRedirect;
            }

            // Data
            Account senderAccount = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));
            if (recipientCardNumber != null) {
                recipientCardNumber = recipientCardNumber.replaceAll(" ", "");
            }

            // [There will be a currency conversion module]
            // stub:
            BigDecimal exchangeRate = new BigDecimal("1.0");

            // Action (forming payment)
            if (caseValue.equals("on")) {
                int status = PaymentService.getInstance().makePaymentOnAccount(Integer.valueOf(accountIdParam), recipientAccountNumber, new BigDecimal(amount), exchangeRate, appointment);
                if (status == -1) {
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to make a payment");
                    setSessionAttributes(request, "off", accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.SENDER_ACCOUNT_BLOCKED_ERROR);
                } else if (status == -2) {
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to make a payment");
                    setSessionAttributes(request, "off", accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.RECIPIENT_ACCOUNT_BLOCKED_ERROR);
                } else if (status == -3) {
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to make a payment");
                    setSessionAttributes(request, "off", accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.INSUFFICIENT_FUNDS_ERROR);
                } else {
                    logging(currentUser.getUserId(), "PAYMENT_COMPLETED: The payment was made from account [" + senderAccount.getNumber() + "] to account [" + recipientAccountNumber + "]");
                    setSessionAttributes(request, ServerResponse.PAYMENT_COMPLETED_SUCCESS);
                }
            } else if (caseValue.equals("off")) {
                int status = PaymentService.getInstance().makePaymentOnCard(Integer.valueOf(accountIdParam), recipientCardNumber, new BigDecimal(amount), appointment);
                if (status == -1) {
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to make a payment");
                    setSessionAttributes(request, "on", accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.SENDER_ACCOUNT_BLOCKED_ERROR);
                } else if (status == -2) {
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to make a payment");
                    setSessionAttributes(request, "on", accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.RECIPIENT_CARD_NOT_EXIST_OR_BLOCKED_ERROR);
                } else if (status == -3) {
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to make a payment");
                    setSessionAttributes(request, "on", accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.INSUFFICIENT_FUNDS_ERROR);
                } else {
                    logging(currentUser.getUserId(), "PAYMENT_COMPLETED: The payment was made from account [" + senderAccount.getNumber() + "] to card [" + recipientCardNumber + "]");
                    setSessionAttributes(request, ServerResponse.PAYMENT_COMPLETED_SUCCESS);
                }
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String paymentIdParam) throws SQLException {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation paymentId
        if (!Validator.checkPaymentId(paymentIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_PAYMENT_ID);
            return false;
        }

        // Data
        List<Payment> allPaymentsByUserId = PaymentService.getInstance().findAllPaymentsByUserId(currentUser.getUserId());
        List<Integer> paymentIds = new ArrayList<>();
        for (Payment payment : allPaymentsByUserId) {
            if (payment.getIsOutgoing()) {
                paymentIds.add(payment.getPaymentId());
            }
        }

        // Checking that the payment is outgoing and belongs to the user
        if (!paymentIds.contains(Integer.valueOf(paymentIdParam))) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_PAYMENT);
            return false;
        }

        return true;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String caseValue, String accountIdParam, String recipientAccountNumber, String recipientCardNumber, String amount, String appointment) throws SQLException {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation caseValue
        if (caseValue == null) {
            setSessionAttributes(request, "off", recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation recipient number
        if (caseValue.equals("on")) {

            // Validation accountId
            if (!Validator.checkAccountId(accountIdParam)) {
                setSessionAttributes(request, "off", recipientAccountNumber, null, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }

            // Data
            Integer accountId = Integer.valueOf(accountIdParam);
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(currentUser.getUserId());
            List<Integer> accountIds = new ArrayList<>();
            for (Account account : accounts) {
                accountIds.add(account.getAccountId());
            }

            // Checking that the account belongs to the user
            if (!accountIds.contains(accountId)) {
                setSessionAttributes(request, "off", recipientAccountNumber, null, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }

            // Validation recipient account number
            if (!Validator.checkRecipientAccountNumber(recipientAccountNumber)) {
                setSessionAttributes(request, "off", accountIdParam, recipientAccountNumber, null, amount, appointment, ServerResponse.RECIPIENT_ACCOUNT_NOT_EXIST_ERROR);
                return false;
            }

            // Checking that the user is making a payment to the account from which he pays
            Account senderAccount = AccountService.getInstance().findAccountByAccountId(accountId);
            if (senderAccount.getNumber().equals(recipientAccountNumber)) {
                setSessionAttributes(request, "off", accountIdParam, recipientAccountNumber, null, amount, appointment, ServerResponse.PAYMENT_TO_YOUR_ACCOUNT_ERROR);
                return false;
            }

            // Validation amount
            if (!Validator.checkAmount(amount)) {
                setSessionAttributes(request, "off", accountIdParam, recipientAccountNumber, null, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }
        } else if (caseValue.equals("off")) {

            // Validation accountId
            if (!Validator.checkAccountId(accountIdParam)) {
                setSessionAttributes(request, "on", null, recipientCardNumber, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }

            // Data
            Integer accountId = Integer.valueOf(accountIdParam);
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(currentUser.getUserId());
            List<Integer> accountIds = new ArrayList<>();
            for (Account account : accounts) {
                accountIds.add(account.getAccountId());
            }

            // Checking that the account belongs to the user
            if (!accountIds.contains(accountId)) {
                setSessionAttributes(request, "on", null, recipientCardNumber, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }

            // Validation recipient card number
            if (!Validator.checkCardNumber(recipientCardNumber)) {
                setSessionAttributes(request, "on", accountIdParam, null, recipientCardNumber, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }

            // [There will be a check of the possibility of making a payment to the specified card]

            // Validation amount
            if (!Validator.checkAmount(amount)) {
                setSessionAttributes(request, "on", accountIdParam, null, recipientCardNumber, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("accounts", null);
        request.setAttribute("isRepeatCommandValue", null);
        request.setAttribute("caseValue", null);
        request.setAttribute("accountIdValue", null);
        request.setAttribute("numberByAccountIdValue", null);
        request.setAttribute("accountNumberValue", null);
        request.setAttribute("cardNumberValue", null);
        request.setAttribute("amountValue", null);
        request.setAttribute("appointmentValue", null);
        request.setAttribute("response", "");
    }

    private void setSessionAttributes(HttpServletRequest request, String paymentIdParam) throws SQLException {
        Payment payment = PaymentService.getInstance().findPaymentByPaymentId(Integer.valueOf(paymentIdParam));
        Account account = AccountService.getInstance().findAccountByAccountId(payment.getAccountId());
        String recipientNumber = payment.getRecipientNumber();

        request.getSession().setAttribute("isRepeatCommandValue", "1");
        request.getSession().setAttribute("accountId", String.valueOf(account.getAccountId()));
        request.getSession().setAttribute("numberByAccountId", account.getNumber());
        request.getSession().setAttribute("amount", String.valueOf(payment.getSenderAmount()));
        request.getSession().setAttribute("appointment", payment.getAppointment());

        if (recipientNumber.length() == 20) {            // if recipient number is account number
            request.getSession().setAttribute("caseValue", "off");
            request.getSession().setAttribute("accountNumber", recipientNumber);
        } else {                                         // if recipient number is card number
            request.getSession().setAttribute("caseValue", "on");
            request.getSession().setAttribute("cardNumber", recipientNumber);
        }
    }

    private void setSessionAttributes(HttpServletRequest request, String caseValue, String accountNumber, String cardNumber,
                                      String amount, String appointment, ServerResponse serverResponse) {
        request.getSession().setAttribute("caseValue", caseValue);
        request.getSession().setAttribute("accountNumber", accountNumber);
        request.getSession().setAttribute("cardNumber", cardNumber);
        request.getSession().setAttribute("amount", amount);
        request.getSession().setAttribute("appointment", appointment);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String caseValue, String accountId, String accountNumber, String cardNumber,
                                      String amount, String appointment, ServerResponse serverResponse) throws SQLException {
        request.getSession().setAttribute("caseValue", caseValue);
        request.getSession().setAttribute("accountId", accountId);
        request.getSession().setAttribute("numberByAccountId", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
        request.getSession().setAttribute("accountNumber", accountNumber);
        request.getSession().setAttribute("cardNumber", cardNumber);
        request.getSession().setAttribute("amount", amount);
        request.getSession().setAttribute("appointment", appointment);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) throws SQLException {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
