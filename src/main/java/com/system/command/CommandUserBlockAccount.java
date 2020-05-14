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

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNT_SETTINGS);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACCOUNT_SETTINGS);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, user, accountIdParam)) {
                if (user.getUserId() != null)
                    logging(user.getUserId(), "ERROR: Unsuccessful attempt to block the account");
                return pathRedirect;
            }

            // Change redirect path
            pathRedirect += "&accountId=" + accountIdParam;

            // Data
            Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

            // Action (block account)
            int status = AccountService.getInstance().blockAccount(account.getAccountId());
            if (status == 0) {
                logging(user.getUserId(), "ERROR: Unsuccessful attempt to block account [" + account.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_BLOCKED_ERROR);
            } else {
                logging(user.getUserId(), "BLOCKED: Account [" + account.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_BLOCKED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User user, String accountIdParam) throws SQLException {

        // Check
        if (user == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation accountId
        if (!Validator.checkAccountId(accountIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_ID);
            return false;
        }

        // Data
        Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

        // Checking that the account belongs to the user
        if (!account.getUserId().equals(user.getUserId())) {
            setSessionAttributes(request, ServerResponse.SHOW_ACCOUNT_ERROR);
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("response", "");
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) throws SQLException {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
