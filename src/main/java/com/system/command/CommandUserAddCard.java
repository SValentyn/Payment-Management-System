package com.system.command;

import com.system.entity.Account;
import com.system.entity.CreditCard;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandUserAddCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_ADD_CARD);

        request.setAttribute("created", false);
        request.setAttribute("cardCreateError", false);
        request.setAttribute("numberExistError", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(user.getUserId());
        request.setAttribute("accounts", accounts);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String accountId = request.getParameter("accountId");
            String number = request.getParameter("number");
            String CVV = request.getParameter("CVV");
            String month = request.getParameter("month");
            String year = request.getParameter("year");

            // Check
            if (!checkAccountId(request, accountId)) {
                accounts.remove(AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountId)));

                request.setAttribute("accounts", accounts); // exclude the selected account number from the list of all accounts
                request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
            } else {
                setRequestAttributes(request, accountId, number, CVV, month, year);
                return page;
            }

            // Check
            if (checkCardNumber(request, number) ||
                    checkCVV(request, CVV) ||
                    checkValidity(request, month, year)) {
                setRequestAttributes(request, accountId, number, CVV, month, year);
                return page;
            }

            // Check
            List<CreditCard> allCards = CreditCardService.getInstance().findAllCards();
            for (CreditCard card : allCards) {
                if (card.getNumber().equals(number)) {
                    request.setAttribute("numberExistError", true);
                    setRequestAttributes(request, accountId, number, CVV, month, year);
                    return page;
                }
            }

            // Create
            int status = CreditCardService.getInstance().addNewCard(accountId, number, CVV, month, year);
            if (status == 0) {
                setRequestAttributes(request, accountId, number, CVV, month, year);
                request.setAttribute("cardCreateError", true);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private boolean checkAccountId(HttpServletRequest request, String accountId) {
        if (accountId == null || accountId.isEmpty() || accountId.equals("0") || !Validator.isNumeric(accountId)) {
            request.setAttribute("accountIdError", true);
            return true;
        }
        return false;
    }

    private boolean checkCardNumber(HttpServletRequest request, String number) {
        if (number.isEmpty() || !Validator.checkCardNumber(number)) {
            request.setAttribute("numberError", true);
            return true;
        }
        return false;
    }

    private boolean checkCVV(HttpServletRequest request, String CVV) {
        if (CVV.isEmpty() || !Validator.checkCVV(CVV)) {
            request.setAttribute("cvvError", true);
            return true;
        }
        return false;
    }

    private boolean checkValidity(HttpServletRequest request, String month, String year) {
        if (month == null || month.isEmpty() || month.equals("0")
                || year == null || year.isEmpty() || year.equals("0")) {
            request.setAttribute("validityError", true);
            return true;
        }

        if (Validator.checkValidity(month, year)) {
            request.setAttribute("validityExpiredError", true);
            return true;
        }

        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String accountId, String number, String CVV, String month, String year) {
        request.setAttribute("accountId", accountId);
        request.setAttribute("numberValue", number);
        request.setAttribute("cvvValue", CVV);
        request.setAttribute("monthValue", month);
        request.setAttribute("yearValue", year);
    }

}
