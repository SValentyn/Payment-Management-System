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

public class CommandUserAttachCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_ATTACH_CARD);

        request.setAttribute("attached", false);
        request.setAttribute("cardNumberError", false);
        request.setAttribute("cardAttachError", false);

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
            if (checkValidity(request, month, year)) {
                request.setAttribute("accounts", accounts);
                setRequestAttributes(request, accountId, number, CVV, month, year);
                return page;
            }

            accounts.remove(AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountId)));
            request.setAttribute("accounts", accounts); // exclude the selected account number from the list of all accounts
            request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));

            // Check
            List<CreditCard> cardsByAccountId = CreditCardService.getInstance().findCardsByAccountId(Integer.valueOf(accountId));
            for (CreditCard card : cardsByAccountId) {
                if (card.getNumber().equals(number)) {
                    request.setAttribute("cardNumberError", true);
                    setRequestAttributes(request, accountId, number, CVV, month, year);
                    return page;
                }
            }

            // Create
            int status = CreditCardService.getInstance().addNewCard(accountId, number, CVV, month, year);
            if (status == 0) {
                setRequestAttributes(request, accountId, number, CVV, month, year);
                request.setAttribute("cardAttachError", true);
            } else {
                request.setAttribute("attached", true);
            }
        }

        return page;
    }

    private boolean checkValidity(HttpServletRequest request, String month, String year) {
        if (Validator.checkValidity(month, year)) {
            request.setAttribute("validityExpiredError", true);
            return true;
        }

        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String accountId, String number, String CVV, String month, String year) throws SQLException {
        request.setAttribute("accountId", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
        request.setAttribute("numberValue", number);
        request.setAttribute("cvvValue", CVV);
        request.setAttribute("monthValue", month);
        request.setAttribute("yearValue", year);
    }

}
