package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.ActionLogService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserBlockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNT_SETTINGS);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACCOUNT_SETTINGS);

            // Form Data
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, currentUser, accountIdParam)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to block the account");
                return pathRedirect;
            }

            // Change redirect path
            pathRedirect += "&accountId=" + accountIdParam;

            // Data
            Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

            // Action (block account)
            int status = AccountService.getInstance().blockAccount(account.getAccountId());
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to block account [" + account.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_BLOCKED_ERROR);
            } else {
                logging(currentUser.getUserId(), "BLOCKED: Account [" + account.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_BLOCKED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String accountIdParam) {

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

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
