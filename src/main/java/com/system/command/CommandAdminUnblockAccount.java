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

public class CommandAdminUnblockAccount implements ICommand {

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
            int status = AccountService.getInstance().unblockAccount(Integer.valueOf(accountIdParam));
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_UNBLOCKED_ERROR.getResponse());
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("response", "");
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String accountIdParam) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam)) {
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

        // Data
        Integer userId = Integer.valueOf(userIdParam);
        Integer accountId = Integer.valueOf(accountIdParam);
        Account account = AccountService.getInstance().findAccountByAccountId(accountId);

        // Check that the userId by account matches the received
        if (!account.getUserId().equals(userId)) {
            request.getSession().setAttribute("response", ServerResponse.UNABLE_GET_ACCOUNT_BY_USER_ID.getResponse());
            return false;
        }

        return true;
    }

}
