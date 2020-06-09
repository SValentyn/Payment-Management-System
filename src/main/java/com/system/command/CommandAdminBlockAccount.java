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

public class CommandAdminBlockAccount implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNT_INFO);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            String userIdParam = request.getParameter("userId");
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, currentUser, userIdParam, accountIdParam)) {
                if (currentUser != null)
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to block account");
                return pathRedirect;
            }

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

    private boolean validation(HttpServletRequest request, User currentUser, String userIdParam, String accountIdParam) throws SQLException {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation userId
        if (!Validator.checkUserId(userIdParam)) {
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
        Integer userId = Integer.valueOf(userIdParam);
        Integer accountId = Integer.valueOf(accountIdParam);
        Account account = AccountService.getInstance().findAccountByAccountId(accountId);

        // Checking that the account belongs to the user
        if (!account.getUserId().equals(userId)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_BY_USER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&accountId=" + accountIdParam;

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
