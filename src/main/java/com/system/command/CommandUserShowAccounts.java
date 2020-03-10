package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandUserShowAccounts implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("noAccounts", false);
        request.setAttribute("showAccounts", false);
        request.setAttribute("unblockAccountAlert", false);
        request.setAttribute("unblockCardAlert", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));

        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(user.getUserId());
        if (!accounts.isEmpty()) {
            request.setAttribute("accounts", accounts);
            request.setAttribute("showAccounts", true);
        } else {
            request.setAttribute("noAccounts", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNTS);
    }

}
