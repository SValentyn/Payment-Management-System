package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandBlockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        User user = (User) request.getSession().getAttribute("currentUser");
        String accountId = request.getParameter("accountId");

        if (accountId != null) {
            AccountService.getInstance().blockAccount(Integer.parseInt(accountId));
        }

        request.setAttribute("showAccounts", true);
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        return ResourceManager.getInstance().getProperty(ResourceManager.HOME);
    }

}
