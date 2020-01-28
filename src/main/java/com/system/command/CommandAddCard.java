package com.system.command;

import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.utils.StringValidator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAddCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String accountId = request.getParameter("accountId");
        String method = request.getMethod();

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADD_CARD);

        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            request.setAttribute("accountId", accountId);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String number = request.getParameter("number");
            String CVV = request.getParameter("cvv");
            String validity = request.getParameter("validity");

            // Check
            if (checkCardNumber(request, accountId, number, CVV, validity) ||
                    checkCVV(request, accountId, number, CVV, validity) ||
                    checkValidity(request, accountId, number, CVV, validity)) {
                return page;
            }

            // Create
            int status = CreditCardService.getInstance().addNewCard(accountId, number, CVV, validity);
            if (status == 0) {
                cardCreateError(request, accountId, number, CVV, validity);
            } else {
                // change page (ADD_CARD -> SHOW_CARDS) and set attributes
                page = ResourceManager.getInstance().getProperty(ResourceManager.SHOW_CARDS);
                String userId = (String) request.getSession().getAttribute("userId");
                if (userId != null)
                    request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
                if (accountId != null)
                    request.setAttribute("cards", CreditCardService.getInstance().findCardsByAccountId(Integer.parseInt(accountId)));
            }
        }

        return page;
    }

    private boolean checkCardNumber(HttpServletRequest request, String accountId, String number, String CVV, String validity) {
        if (number.isEmpty() || !StringValidator.checkCardNumber(number)) {
            request.setAttribute("numberError", true);
            request.setAttribute("accountId", accountId);
            request.setAttribute("numberValue", number);
            request.setAttribute("cvvValue", CVV);
            request.setAttribute("validityValue", validity);
            return true;
        }
        return false;
    }

    private boolean checkCVV(HttpServletRequest request, String accountId, String number, String CVV, String validity) {
        if (CVV.isEmpty() || !StringValidator.checkCVV(CVV)) {
            request.setAttribute("cvvError", true);
            request.setAttribute("accountId", accountId);
            request.setAttribute("numberValue", number);
            request.setAttribute("cvvValue", CVV);
            request.setAttribute("validityValue", validity);
            return true;
        }
        return false;
    }

    private boolean checkValidity(HttpServletRequest request, String accountId, String number, String CVV, String validity) {
        if (validity.isEmpty()) {
            request.setAttribute("validityError", true);
            request.setAttribute("accountId", accountId);
            request.setAttribute("numberValue", number);
            request.setAttribute("cvvValue", CVV);
            request.setAttribute("validityValue", validity);
            return true;
        }
        return false;
    }

    private void cardCreateError(HttpServletRequest request, String accountId, String number, String CVV, String validity) {
        request.setAttribute("cardError", true);
        request.setAttribute("accountId", accountId);
        request.setAttribute("numberValue", number);
        request.setAttribute("cvvValue", CVV);
        request.setAttribute("validityValue", validity);
    }

}
