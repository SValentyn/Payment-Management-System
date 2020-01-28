package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandShowUserCards implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String userId = (String) request.getSession().getAttribute("userId");
        if (userId != null) {
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
        }

        String accountId = request.getParameter("accountId");
        if (accountId != null) {
            request.setAttribute("cards", CreditCardService.getInstance().findCardsByAccountId(Integer.parseInt(accountId)));
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.SHOW_CARDS);
    }

}
