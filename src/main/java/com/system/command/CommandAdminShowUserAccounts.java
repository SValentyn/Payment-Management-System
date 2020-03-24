package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminShowUserAccounts implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_ACCOUNTS);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUserAccountsError", false);

        // Data
        User user = (User) request.getSession().getAttribute("viewableUser");

        // Check
        if (user == null) {
            request.setAttribute("showUserAccountsError", true);
            return page;
        }

        // Data
        Integer userId = user.getUserId();
        List<User> users = UserService.getInstance().findAllUsers();
        List<Integer> usersIds = new ArrayList<>();
        for (User aUser : users) {
            usersIds.add(aUser.getUserId());
        }

        // Check
        if (!usersIds.contains(userId)) {
            request.setAttribute("showUserAccountsError", true);
            return page;
        }

        // Set Attributes
        request.setAttribute("accountsEmpty", AccountService.getInstance().findAllAccountsByUserId(userId).isEmpty());
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(userId));

        return page;
    }

}
