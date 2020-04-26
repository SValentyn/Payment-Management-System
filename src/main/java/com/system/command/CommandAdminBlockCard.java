package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
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
            String accountIdParam = request.getParameter("accountId");
            String cardIdParam = request.getParameter("cardId");

            // Validation
            if (!validation(request, userIdParam, accountIdParam, cardIdParam)) {
                return pathRedirect;
            }

            // Action
            int status = BankCardService.getInstance().blockBankCard(Integer.valueOf(cardIdParam));
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.CARD_BLOCKED_ERROR.getResponse());
            } else {
                request.getSession().setAttribute("response", ServerResponse.CARD_BLOCKED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String accountIdParam, String cardIdParam) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Validation accountId
        if (!Validator.checkAccountId(accountIdParam)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_ACCOUNT_ID.getResponse());
            return false;
        }

        // Change redirect path
        pathRedirect += "&accountId=" + accountIdParam;

        // Validation cardId
        if (!Validator.checkCardId(cardIdParam)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_CARD_ID.getResponse());
            return false;
        }

        // Data
        Integer userId = Integer.valueOf(userIdParam);
        Integer accountId = Integer.valueOf(accountIdParam);
        Integer cardId = Integer.valueOf(cardIdParam);
        Account account = AccountService.getInstance().findAccountByAccountId(accountId);

        // Check that the userId by account matches the received
        if (!account.getUserId().equals(userId)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_ACCOUNT_BY_USER_ID.getResponse());
            return false;
        }

        // Data
        List<BankCard> cardsByAccountId = BankCardService.getInstance().findCardsByAccountId(accountId);
        List<Integer> cardIds = new ArrayList<>();
        for (BankCard aCard : cardsByAccountId) {
            cardIds.add(aCard.getCardId());
        }

        // Check that the card belongs to the user account
        if (!cardIds.contains(cardId)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_CARD.getResponse());
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("response", "");
    }

}
