package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminCreateAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Data
        String userId = request.getParameter("userId");
        String number = request.getParameter("number");

        // Checks and creates
        if (userId != null && number != null) {
            AccountService.getInstance().createAccount(Integer.parseInt(userId), number);
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
            request.getSession().setAttribute("userId", userId);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_CREATE_ACCOUNT);
    }

}
