package com.system.command;

import com.system.entity.BankCard;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.service.LetterService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminAttachCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_CARD);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("attached", false);
        request.setAttribute("cardNumberError", false);
        request.setAttribute("cardAttachError", false);

        // Data
        String accountId = request.getParameter("accountId");
        String number = request.getParameter("number");
        String CVV = request.getParameter("CVV");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        request.setAttribute("accountId", accountId);
        request.setAttribute("numberByAccountIdValue", AccountService.getInstance().findAccountNumberByAccountId(Integer.valueOf(accountId)));

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Check
            if (checkValidity(request, month, year)) {
                setRequestAttributes(request, number, CVV, month, year);
                return page;
            }

            // Check
            List<BankCard> cardsByAccountId = BankCardService.getInstance().findAllCardsByAccountId(Integer.valueOf(accountId));
            for (BankCard card : cardsByAccountId) {
                if (card.getNumber().equals(number)) {
                    request.setAttribute("cardNumberError", true);
                    setRequestAttributes(request, number, CVV, month, year);
                    return page;
                }
            }

            // Attach Card
            int status = BankCardService.getInstance().addNewCard(accountId, number, CVV, month, year);
            if (status == 0) {
                setRequestAttributes(request, number, CVV, month, year);
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

    private void setRequestAttributes(HttpServletRequest request, String number, String CVV, String month, String year) {
        request.setAttribute("numberValue", number);
        request.setAttribute("cvvValue", CVV);
        request.setAttribute("monthValue", month);
        request.setAttribute("yearValue", year);
    }

}
