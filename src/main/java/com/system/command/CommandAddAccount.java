package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;

public class CommandAddAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Data
        String userId = request.getParameter("userId");
        String number = request.getParameter("number");
        String balance = request.getParameter("balance");

        // Checks and creates
        if (userId != null && number != null && balance != null) {
            AccountService.getInstance().createAccount(Integer.parseInt(userId), number, new BigDecimal(balance));
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
            request.getSession().setAttribute("userId", userId);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.SHOW_CARDS);
    }

}
