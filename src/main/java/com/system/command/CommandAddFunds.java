package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;

public class CommandAddFunds implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        AccountService accountService = AccountService.getInstance();

        // Data
        String userId = (String) request.getSession().getAttribute("userId");
        String accountId = request.getParameter("accountId");
        String sum = request.getParameter("summa");

        // Checks and adds funds
        if (accountId != null) {
            accountService.addFunds(Integer.parseInt(accountId), new BigDecimal(sum));
        }

        if (userId != null) {
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.SHOW_CARDS);
    }

}
