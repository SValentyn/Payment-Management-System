package com.system.command;

import com.system.entity.Account;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
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
            String userIdParam = request.getParameter("userId");
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, userIdParam, accountIdParam)) {
                return pathRedirect;
            }

            // Action
            int status = AccountService.getInstance().blockAccount(Integer.valueOf(accountIdParam));
            if (status == 0) {
                setSessionAttributes(request, ServerResponse.ACCOUNT_BLOCKED_ERROR);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String accountIdParam) throws SQLException {

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

        // Change redirect path
        pathRedirect += "&accountId=" + accountIdParam;

        // Data
        Integer userId = Integer.valueOf(userIdParam);
        Integer accountId = Integer.valueOf(accountIdParam);
        Account account = AccountService.getInstance().findAccountByAccountId(accountId);

        // Checking that the account belongs to the user
        if (!account.getUserId().equals(userId)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_BY_USER_ID);
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

}
