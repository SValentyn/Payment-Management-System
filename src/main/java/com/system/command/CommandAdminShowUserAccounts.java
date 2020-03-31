package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminShowUserAccounts implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_ACCOUNTS);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUserAccountsError", false);

        // Data
        String userIdParam = request.getParameter("userId");

        // Validation
        if (!validation(userIdParam)) {
            request.setAttribute("showUserAccountsError", true);
            return page;
        }

        // Set Attributes
        setRequestAttributes(request, Integer.parseInt(userIdParam));

        return page;
    }

    private boolean validation(String userId) throws SQLException {
        return Validator.checkUserId(userId);
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId) throws SQLException {
        request.setAttribute("accountsEmpty", AccountService.getInstance().findAllAccountsByUserId(userId).isEmpty());
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(userId));
    }

}
