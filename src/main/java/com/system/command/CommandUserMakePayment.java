package com.system.command;

import com.system.entity.Account;
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
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.SQLException;

public class CommandUserMakePayment implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_MAKE_PAYMENT);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_MAKE_PAYMENT);

            // Form Data
            String caseValue = request.getParameter("caseValue");
            String accountIdParam = request.getParameter("accountId");
            String recipientAccountNumber = request.getParameter("accountNumber");
            String recipientCardNumber = request.getParameter("cardNumber");
            String amount = request.getParameter("amount");
            String appointment = request.getParameter("appointment");

            // Validation
            if (!validation(request, currentUser, caseValue, accountIdParam, recipientAccountNumber, recipientCardNumber, amount, appointment)) {
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
                int status = PaymentService.getInstance().makePaymentOnAccount(senderAccount.getAccountId(), recipientAccountNumber, new BigDecimal(amount), exchangeRate, appointment);
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
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_MAKE_PAYMENT);

            // Set attributes obtained from the session
            setRequestAttributes(request, currentUser);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String caseValue, String accountIdParam,
                               String recipientAccountNumber, String recipientCardNumber, String amount, String appointment) {

        // Validation caseValue
        if (caseValue == null) {
            setSessionAttributes(request, "off", recipientAccountNumber, recipientCardNumber, amount, appointment, ServerResponse.INVALID_DATA);
            return false;
        }

        if (caseValue.equals("on")) {

            // Validation accountId
            if (!Validator.checkAccountId(accountIdParam)) {
                setSessionAttributes(request, "off", recipientAccountNumber, null, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }

            // Checking that the account belongs to the user
            Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));
            if (!account.getUserId().equals(currentUser.getUserId())) {
                setSessionAttributes(request, "off", recipientAccountNumber, null, amount, appointment, ServerResponse.INVALID_DATA);
                return false;
            }

            // Validation recipient account number
            if (!Validator.checkRecipientAccountNumber(recipientAccountNumber)) {
                setSessionAttributes(request, "off", accountIdParam, recipientAccountNumber, null, amount, appointment, ServerResponse.RECIPIENT_ACCOUNT_NOT_EXIST_ERROR);
                return false;
            }

            // Checking that the user is making a payment to the account from which he pays
            if (account.getNumber().equals(recipientAccountNumber)) {
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

            // Checking that the account belongs to the user
            Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));
            if (!account.getUserId().equals(currentUser.getUserId())) {
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

    private void setRequestAttributes(HttpServletRequest request, User currentUser) {
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(currentUser.getUserId()));
        request.setAttribute("isRepeatCommandValue", "0");
        request.setAttribute("caseValue", "off");

        HttpSession session = request.getSession();

        String isRepeatCommandValue = (String) session.getAttribute("isRepeatCommandValue");
        if (isRepeatCommandValue != null) {
            request.setAttribute("isRepeatCommandValue", isRepeatCommandValue);
            session.removeAttribute("isRepeatCommandValue");
        }

        String caseValue = (String) session.getAttribute("caseValue");
        if (caseValue != null) {
            request.setAttribute("caseValue", caseValue);
            session.removeAttribute("caseValue");
        }

        String accountId = (String) session.getAttribute("accountId");
        if (accountId != null) {
            request.setAttribute("accountIdValue", accountId);
            session.removeAttribute("accountId");
        }

        String numberByAccountId = (String) session.getAttribute("numberByAccountId");
        if (numberByAccountId != null) {
            request.setAttribute("numberByAccountIdValue", numberByAccountId);
            session.removeAttribute("numberByAccountId");
        }

        String accountNumber = (String) session.getAttribute("accountNumber");
        if (accountNumber != null) {
            request.setAttribute("accountNumberValue", accountNumber);
            session.removeAttribute("accountNumber");
        }

        String cardNumber = (String) session.getAttribute("cardNumber");
        if (cardNumber != null) {
            request.setAttribute("cardNumberValue", cardNumber);
            session.removeAttribute("cardNumber");
        }

        String amount = (String) session.getAttribute("amount");
        if (amount != null) {
            request.setAttribute("amountValue", amount);
            session.removeAttribute("amount");
        }

        String appointment = (String) session.getAttribute("appointment");
        if (appointment != null) {
            request.setAttribute("appointmentValue", appointment);
            session.removeAttribute("appointment");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
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
                                      String amount, String appointment, ServerResponse serverResponse) {
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

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
