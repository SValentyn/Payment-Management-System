package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminDeleteAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("deleteAccountError", false);

        String accountId = request.getParameter("accountId");
        String userId = (String) request.getSession().getAttribute("userId");

        if (userId != null & accountId != null) {
            AccountService.getInstance().deleteAccountByAccountId(Integer.valueOf(accountId));
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
        } else {
            request.setAttribute("deleteAccountError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ACCOUNTS_CONTROL);
    }

}
