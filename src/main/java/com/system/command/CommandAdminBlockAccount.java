package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminBlockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String userId = (String) request.getSession().getAttribute("userId");
        String accountId = request.getParameter("accountId");
        request.setAttribute("blockAccountError", false);

        if (accountId != null) {
            AccountService.getInstance().blockAccount(Integer.parseInt(accountId));

            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId)));
            request.setAttribute("cards", CreditCardService.getInstance().findCardsByAccountId(Integer.parseInt(accountId)));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.parseInt(accountId)));
        } else {
            request.setAttribute("blockAccountError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.SHOW_USER_ACCOUNTS);
    }
}
