package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.service.LetterService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminBlockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("blockAccountError", false);

        String userId = (String) request.getSession().getAttribute("userId");
        String accountId = request.getParameter("accountId");

        if (accountId != null) {
            AccountService.getInstance().blockAccount(Integer.parseInt(accountId));

            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId)));
            request.setAttribute("cards", BankCardService.getInstance().findAllCardsByAccountId(Integer.parseInt(accountId)));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.parseInt(accountId)));
        } else {
            request.setAttribute("blockAccountError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ACCOUNTS_CONTROL);
    }

}
