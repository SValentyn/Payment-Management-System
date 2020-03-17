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

        request.setAttribute("showUserAccountsError", false);
        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());

        // Data
        String userId = request.getParameter("userId");

        // Check
        if (userId == null) {
            request.setAttribute("showUserAccountsError", true);
            return page;
        }

        // Data
        List<User> users = UserService.getInstance().findAllUsers();
        List<String> usersIds = new ArrayList<>();
        for (User user : users) {
            usersIds.add(String.valueOf(user.getUserId()));
        }

        // Check
        if (!usersIds.contains(userId)) {
            request.setAttribute("showUserAccountsError", true);
            return page;
        }

        // Set Attributes
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId)));

        return page;
    }

}
