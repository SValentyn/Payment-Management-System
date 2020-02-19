package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.LetterService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminUnblockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("unblockAccountError", false);

        String userId = (String) request.getSession().getAttribute("userId");
        String accountId = request.getParameter("accountId");

        if (accountId != null) {
            AccountService.getInstance().unblockAccount(Integer.parseInt(accountId));

            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
            request.setAttribute("cards", CreditCardService.getInstance().findAllCardsByAccountId(Integer.valueOf(accountId)));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.valueOf(accountId)));
        } else {
            request.setAttribute("unblockAccountError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ACCOUNTS_CONTROL);
    }

}
