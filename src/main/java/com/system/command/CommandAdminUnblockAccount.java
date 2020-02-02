package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminUnblockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String userId = (String) request.getSession().getAttribute("userId");

        String accountId = request.getParameter("accountId");
        if (accountId != null) {
            AccountService.getInstance().unblockAccount(Integer.parseInt(accountId));
            request.setAttribute("showAccounts", true);
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ACCOUNTS_CONTROL);
    }

}
