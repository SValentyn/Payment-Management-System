package com.system.command;

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

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADD_CARD);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        request.setAttribute("created", false);
        request.setAttribute("cardCreateError", false);
        request.setAttribute("numberExistError", false);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String accountId = request.getParameter("accountId");
            String number = request.getParameter("number");
            String CVV = request.getParameter("CVV");
            String validity = request.getParameter("validity");

            // Check
            if (checkAccountId(request, accountId) ||
                    checkCardNumber(request, number) ||
                    checkCVV(request, CVV) ||
                    checkValidity(request, validity)) {
                setRequestAttributes(request, number, CVV, validity);
                return page;
            }

            List<CreditCard> allCards = CreditCardService.getInstance().findAllCards();
            for (CreditCard card : allCards) {
                if (card.getNumber().equals(number)) {
                    request.setAttribute("numberExistError", true);
                    setRequestAttributes(request, number, CVV, validity);
                    return page;
                }
            }

            // Create
            int status = CreditCardService.getInstance().addNewCard(accountId, number, CVV, validity);
            if (status == 0) {
                request.setAttribute("cardCreateError", true);
                setRequestAttributes(request, number, CVV, validity);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private boolean checkAccountId(HttpServletRequest request, String accountId) {
        if (accountId == null || accountId.isEmpty() || !Validator.isNumeric(accountId)) {
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

    private boolean checkValidity(HttpServletRequest request, String validity) {
        if (validity == null || validity.isEmpty()) {
            request.setAttribute("validityError", true);
            return true;
        }

        if (Validator.checkValidity(validity)) {
            request.setAttribute("validityExpiredError", true);
            return true;
        }

        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String number, String CVV, String validity) {
        request.setAttribute("numberValue", number);
        request.setAttribute("cvvValue", CVV);
        request.setAttribute("validityValue", validity);
    }

}
