package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserBlockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("blockCardError", false);
        request.setAttribute("blockAccountError", false);
        request.setAttribute("unblockCardAlert", false);
        request.setAttribute("unblockAccountAlert", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        String accountId = request.getParameter("accountId");

        if (accountId != null) {
            AccountService.getInstance().blockAccount(Integer.parseInt(accountId));

            request.setAttribute("showAccounts", true);
            request.setAttribute("showAccountInfo", true);
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
            request.setAttribute("cards", CreditCardService.getInstance().findCardsByAccountId(Integer.parseInt(accountId)));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.parseInt(accountId)));
        } else {
            request.setAttribute("blockAccountError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.USER);
    }

}
