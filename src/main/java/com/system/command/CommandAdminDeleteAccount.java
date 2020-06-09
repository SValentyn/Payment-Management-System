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

public class CommandAdminDeleteAccount implements ICommand {

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

            // URL Data
            String userIdParam = request.getParameter("userId");
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, userIdParam, accountIdParam)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to delete account");
                return pathRedirect;
            }

            // Data
            Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

            // Action
            int status = AccountService.getInstance().deleteAccountByAccountId(account.getAccountId());
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to delete account [" + account.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_DELETED_ERROR);
            } else if (status == -1) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to delete account [" + account.getNumber() + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_HAS_FUNDS_ERROR);
            } else {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNT_INFO);
                pathRedirect += "&userId=" + userIdParam;
                logging(currentUser.getUserId(), "DELETED: Account [" + account.getNumber() + "] successfully deleted");
                setSessionAttributes(request, ServerResponse.ACCOUNT_DELETED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String accountIdParam) {

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

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
