package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.ActionLogService;
import com.system.service.BankCardService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminDetachCard implements ICommand {

    private String pathRedirect;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNT_INFO);

            // Form Data
            String userIdParam = request.getParameter("userId");
            String accountIdParam = request.getParameter("accountId");
            String cardIdParam = request.getParameter("cardId");

            // Validation
            if (!validation(request, userIdParam, accountIdParam, cardIdParam)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to detach a card");
                return pathRedirect;
            }

            // Data
            BankCard card = BankCardService.getInstance().findCardByCardId(Integer.valueOf(cardIdParam));
            User user = UserService.getInstance().findUserById(Integer.valueOf(userIdParam));

            // Action (detach a card)
            int status = BankCardService.getInstance().deleteCardById(card.getCardId());
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to detach a card. User [" + user.getName() + " " + user.getSurname() + "]");
                setSessionAttributes(request, ServerResponse.CARD_DETACHED_ERROR);
            } else {
                logging(currentUser.getUserId(), "DETACHED: Card was successfully detached. User [" + user.getName() + " " + user.getSurname() + "]");
                setSessionAttributes(request, ServerResponse.CARD_DETACHED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String accountIdParam, String cardIdParam) {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Validation accountId
        if (!Validator.checkAccountId(accountIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_ID);
            return false;
        }

        // Data
        Integer accountId = Integer.valueOf(accountIdParam);
        Account account = AccountService.getInstance().findAccountByAccountId(accountId);
        List<BankCard> cardsByAccountId = BankCardService.getInstance().findCardsByAccountId(accountId);
        List<Integer> cardIds = new ArrayList<>();
        for (BankCard aCard : cardsByAccountId) {
            cardIds.add(aCard.getCardId());
        }

        // Checking that the account belongs to the user
        if (!account.getUserId().equals(Integer.valueOf(userIdParam))) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_BY_USER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&accountId=" + accountIdParam;

        // Validation cardId
        if (!Validator.checkCardId(cardIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_CARD_ID);
            return false;
        }

        // Checking that the card belongs to the user account
        if (!cardIds.contains(Integer.valueOf(cardIdParam))) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_CARD);
            return false;
        }

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
