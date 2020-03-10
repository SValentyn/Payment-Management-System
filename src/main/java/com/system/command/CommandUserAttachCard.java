package com.system.command;

import com.system.entity.BankCard;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.service.UserService;
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

        // Set Attributes
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));

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
                setRequestAttributes(request, accountId, number, CVV, month, year);
                return page;
            }

            // Check
            List<BankCard> cardsByAccountId = BankCardService.getInstance().findAllCardsByAccountId(Integer.valueOf(accountId));
            for (BankCard card : cardsByAccountId) {
                if (card.getNumber().equals(number)) {
                    setRequestAttributes(request, accountId, number, CVV, month, year);
                    request.setAttribute("cardNumberError", true);
                    return page;
                }
            }

            // Attach card
            int status = BankCardService.getInstance().addNewCard(accountId, number, CVV, month, year);
            if (status == 0) {
                setRequestAttributes(request, accountId, number, CVV, month, year);
                request.setAttribute("cardAttachError", true);
            } else {
                request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
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
        request.setAttribute("accountIdValue", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));
        request.setAttribute("numberValue", number);
        request.setAttribute("cvvValue", CVV);
        request.setAttribute("monthValue", month);
        request.setAttribute("yearValue", year);
    }

}
