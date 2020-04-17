package com.system.command;

import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminDeleteAccount implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNT_INFO);

            // Data
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!Validator.checkAccountId(accountIdParam)) {
                return pathRedirect;
            }

            pathRedirect += "&accountId=" + accountIdParam;

            // Data
            Integer accountId = Integer.valueOf(accountIdParam);

            // Action
            int status = AccountService.getInstance().deleteAccountByAccountId(accountId);
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_DELETED_ERROR.getResponse());
            } else if (status == -1) {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_HAS_FUNDS_ERROR.getResponse());
            } else {
                request.getSession().setAttribute("response", ServerResponse.ACCOUNT_DELETED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("response", "");
    }

}
