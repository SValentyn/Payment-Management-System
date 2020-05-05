package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandUserShowAccountCards implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNT_CARDS);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACCOUNT_CARDS);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNT_CARDS);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, user, accountIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, Integer.valueOf(accountIdParam));
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User user, String accountIdParam) throws SQLException {

        // Check
        if (user == null) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation accountId
        if (!Validator.checkAccountId(accountIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_ID);
            return false;
        }

        // Data
        Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

        // Checking that the account belongs to the user
        if (!account.getUserId().equals(user.getUserId())) {
            setRequestAttributes(request, ServerResponse.SHOW_ACCOUNT_ERROR);
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("viewableAccount", null);
        request.setAttribute("cardsEmpty", null);
        request.setAttribute("cards", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, Integer accountId) throws SQLException {
        Account viewableAccount = AccountService.getInstance().findAccountByAccountId(accountId);
        List<BankCard> cards = BankCardService.getInstance().findCardsByAccountId(accountId);

        if (cards != null) {
            request.setAttribute("viewableAccount", viewableAccount);
            request.setAttribute("cardsEmpty", cards.isEmpty());
            request.setAttribute("cards", cards);
        } else {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_CARDS);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
