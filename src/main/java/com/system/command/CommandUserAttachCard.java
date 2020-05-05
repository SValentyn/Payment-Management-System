package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandUserAttachCard implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_ATTACH_CARD);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_ATTACH_CARD);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");

            // Check and set attributes
            if (user != null) {
                request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
            } else {
                request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            }

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_ATTACH_CARD);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");
            String accountIdParam = request.getParameter("accountId");
            String cardNumber = request.getParameter("number");
            String CVV = request.getParameter("CVV");
            String month = request.getParameter("month");
            String year = request.getParameter("year");

            // Validation
            if (!validation(request, user, accountIdParam, cardNumber, CVV, month, year)) {
                return pathRedirect;
            }

            // Data
            cardNumber = cardNumber.replaceAll(" ", "");

            // Action (attach card)
            int status = BankCardService.getInstance().addNewBankCard(Integer.valueOf(accountIdParam), cardNumber, CVV, month, year);
            if (status == 0) {
                setSessionAttributes(request, accountIdParam, cardNumber, CVV, month, year, ServerResponse.CARD_ATTACHED_ERROR);
            } else {
                setSessionAttributes(request, ServerResponse.CARD_ATTACHED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User user, String accountIdParam, String cardNumber, String CVV, String month, String year) throws SQLException {

        // Check
        if (user == null) {
            setSessionAttributes(request, accountIdParam, cardNumber, CVV, month, year, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation accountId
        if (!Validator.checkAccountId(accountIdParam)) {
            setSessionAttributes(request, cardNumber, CVV, month, year, ServerResponse.INVALID_DATA);
            return false;
        }

        // Data
        Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

        // Checking that the account belongs to the user
        if (account == null || !account.getUserId().equals(user.getUserId())) {
            setSessionAttributes(request, cardNumber, CVV, month, year, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation card number
        if (!Validator.checkCardNumber(cardNumber)) {
            setSessionAttributes(request, accountIdParam, cardNumber, CVV, month, year, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation CVV
        if (!Validator.checkCVV(CVV)) {
            setSessionAttributes(request, accountIdParam, cardNumber, CVV, month, year, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation expiry date
        if (!Validator.checkDate(month, year)) {
            setSessionAttributes(request, accountIdParam, cardNumber, CVV, month, year, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation expiry date
        if (Validator.checkValidity(month, year)) {
            setSessionAttributes(request, accountIdParam, cardNumber, CVV, month, year, ServerResponse.VALIDITY_EXPIRED_ERROR);
            return false;
        }

        // Checking that a card with this number has not yet been attached to the account
        cardNumber = cardNumber.replaceAll(" ", "");
        List<BankCard> cardsByAccountId = BankCardService.getInstance().findCardsByAccountId(Integer.valueOf(accountIdParam));
        for (BankCard card : cardsByAccountId) {
            if (card.getNumber().equals(cardNumber)) {
                setSessionAttributes(request, accountIdParam, cardNumber, CVV, month, year, ServerResponse.CARD_ALREADY_ATTACHED_ERROR);
                return false;
            }
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("accountIdValue", null);
        request.setAttribute("numberByAccountIdValue", null);
        request.setAttribute("numberValue", null);
        request.setAttribute("cvvValue", null);
        request.setAttribute("monthValue", null);
        request.setAttribute("yearValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

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

        String number = (String) session.getAttribute("number");
        if (number != null) {
            request.setAttribute("numberValue", number);
            session.removeAttribute("number");
        }

        String cvv = (String) session.getAttribute("cvv");
        if (cvv != null) {
            request.setAttribute("cvvValue", cvv);
            session.removeAttribute("cvv");
        }

        String month = (String) session.getAttribute("month");
        if (month != null) {
            request.setAttribute("monthValue", month);
            session.removeAttribute("month");
        }

        String year = (String) session.getAttribute("year");
        if (year != null) {
            request.setAttribute("yearValue", year);
            session.removeAttribute("year");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setSessionAttributes(HttpServletRequest request, String cardNumber, String CVV,
                                      String month, String year, ServerResponse serverResponse) {
        request.getSession().setAttribute("number", cardNumber);
        request.getSession().setAttribute("cvv", CVV);
        request.getSession().setAttribute("month", month);
        request.getSession().setAttribute("year", year);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String accountId, String cardNumber, String CVV,
                                      String month, String year, ServerResponse serverResponse) throws SQLException {
        request.getSession().setAttribute("accountId", accountId);
        request.getSession().setAttribute("numberByAccountId", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
        request.getSession().setAttribute("number", cardNumber);
        request.getSession().setAttribute("cvv", CVV);
        request.getSession().setAttribute("month", month);
        request.getSession().setAttribute("year", year);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
