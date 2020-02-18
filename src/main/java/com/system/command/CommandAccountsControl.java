package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAccountsControl implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String userId = (String) request.getSession().getAttribute("userId");
        String accountId = request.getParameter("accountId");

        if (userId != null) {
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
        }

        if (accountId != null) {
            request.setAttribute("cards", CreditCardService.getInstance().findAllCardsByAccountId(Integer.parseInt(accountId)));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.parseInt(accountId)));
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ACCOUNTS_CONTROL);
    }

}
