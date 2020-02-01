package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandShowAccounts implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("noAccounts", false);
        request.setAttribute("showAccounts", false);
        request.setAttribute("unblockAccountAlert", false);
        request.setAttribute("unblockCardAlert", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        List<Account> allAccounts = AccountService.getInstance().findAllAccountsByUserId(user.getUserId());

        if (allAccounts.isEmpty()) {
            request.setAttribute("noAccounts", true);
        } else {
            request.setAttribute("showAccounts", true);
            request.setAttribute("showAccountInfo", false);
            request.setAttribute("accounts", allAccounts);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.HOME);
    }

}
