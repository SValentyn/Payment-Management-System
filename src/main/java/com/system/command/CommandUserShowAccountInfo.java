package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserShowAccountInfo implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("unblockAccountAlert", false);
        request.setAttribute("unblockCardAlert", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.setAttribute("showAccounts", true);
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));

        String accountId = request.getParameter("accountId");
        if (accountId != null) {
            request.setAttribute("showAccountInfo", true);
            request.setAttribute("cards", CreditCardService.getInstance().findCardsByAccountId(Integer.parseInt(accountId)));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.parseInt(accountId)));
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.USER);
    }

}
