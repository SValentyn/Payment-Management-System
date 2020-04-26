package com.system.command;

import com.system.entity.BankCard;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.BankCardService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminBlockCard implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNT_INFO);

            // Data
            String userIdParam = request.getParameter("userId");
            String cardNumber = request.getParameter("cardNumber");

            // Validation
            if (!validation(request, userIdParam, cardNumber)) {
                return pathRedirect;
            }

            // Data
            BankCard card = BankCardService.getInstance().findCardByCardNumber(cardNumber);

            // Action
            int status = BankCardService.getInstance().blockBankCard(card.getCardId());
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.CARD_BLOCKED_ERROR.getResponse());
            } else {
                request.getSession().setAttribute("response", ServerResponse.CARD_BLOCKED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String cardNumber) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Validation card number
        if (!Validator.checkCardNumber(cardNumber)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_CARD.getResponse());
            return false;
        }

        // Data
        Integer userId = Integer.valueOf(userIdParam);
        List<BankCard> cardsByUserId = BankCardService.getInstance().findCardsByUserId(userId);
        List<String> cardNumbers = new ArrayList<>();
        for (BankCard aCard : cardsByUserId) {
            cardNumbers.add(aCard.getNumber());
        }

        // Check
        if (!cardNumbers.contains(cardNumber)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_CARD_BY_USER_ID.getResponse());
            return false;
        }

        // Data
        BankCard card = BankCardService.getInstance().findCardByCardNumber(cardNumber);

        // Check
        if (card == null) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_CARD.getResponse());
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("response", "");
    }

}
