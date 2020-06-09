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
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandUserUnblockCard implements ICommand {

    private String pathRedirect;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNT_CARDS);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACCOUNT_CARDS);

            // Form Data
            String accountIdParam = request.getParameter("accountId");
            String cardIdParam = request.getParameter("cardId");

            // Validation
            if (!validation(request, currentUser, accountIdParam, cardIdParam)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to unblock the card");
                return pathRedirect;
            }

            // Data
            BankCard card = BankCardService.getInstance().findCardByCardId(Integer.valueOf(cardIdParam));

            // Action (unblock a card)
            int status = BankCardService.getInstance().unblockBankCard(card.getCardId());
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to unblock card [" + card.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.CARD_UNBLOCKED_ERROR);
            } else {
                logging(currentUser.getUserId(), "UNBLOCKED: Card [" + card.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.CARD_UNBLOCKED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String accountIdParam, String cardIdParam) {

        // Validation accountId
        if (!Validator.checkAccountId(accountIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_ID);
            return false;
        }

        // Data
        Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

        // Checking that the account belongs to the user
        if (!account.getUserId().equals(currentUser.getUserId())) {
            setSessionAttributes(request, ServerResponse.SHOW_ACCOUNT_ERROR);
            return false;
        }

        // Change redirect path
        pathRedirect += "&accountId=" + accountIdParam;

        // Validation cardId
        if (!Validator.checkCardId(cardIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_CARD_ID);
            return false;
        }

        // Data
        List<BankCard> cardsByAccountId = BankCardService.getInstance().findCardsByAccountId(Integer.valueOf(accountIdParam));
        List<Integer> cardIds = new ArrayList<>();
        for (BankCard card : cardsByAccountId) {
            cardIds.add(card.getCardId());
        }

        // Checking that the card belongs to the user account
        if (!cardIds.contains(Integer.valueOf(cardIdParam))) {
            setSessionAttributes(request, ServerResponse.CARD_UNBLOCKED_ERROR);
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
