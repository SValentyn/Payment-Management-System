package com.system.command;

import com.system.entity.CreditCard;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminAddCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ADD_CARD);

        request.setAttribute("created", false);
        request.setAttribute("cardCreateError", false);
        request.setAttribute("numberExistError", false);

        // Data
        String accountId = request.getParameter("accountId");
        String number = request.getParameter("number");
        String CVV = request.getParameter("CVV");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        request.setAttribute("accountId", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(accountId));

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Check
            if (checkCardNumber(request, number) ||
                    checkCVV(request, CVV) ||
                    checkValidity(request, month, year)) {
                setRequestAttributes(request, number, CVV, month, year);
                return page;
            }

            List<CreditCard> allCards = CreditCardService.getInstance().findAllCards();
            for (CreditCard card : allCards) {
                if (card.getNumber().equals(number)) {
                    request.setAttribute("numberExistError", true);
                    setRequestAttributes(request, number, CVV, month, year);
                    return page;
                }
            }

            // Create
            int status = CreditCardService.getInstance().addNewCard(accountId, number, CVV, month, year);
            if (status == 0) {
                request.setAttribute("cardCreateError", true);
                setRequestAttributes(request, number, CVV, month, year);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
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

    private void setRequestAttributes(HttpServletRequest request, String number, String CVV, String month, String year) {
        request.setAttribute("numberValue", number);
        request.setAttribute("cvvValue", CVV);
        request.setAttribute("monthValue", month);
        request.setAttribute("yearValue", year);
    }

}
