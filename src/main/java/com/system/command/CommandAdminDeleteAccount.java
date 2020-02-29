package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminDeleteAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("deleteAccountError", false);

        String userId = (String) request.getSession().getAttribute("userId");
        String accountNumber = request.getParameter("accountNumber");
        Integer accountId = AccountService.getInstance().findAccountByAccountNumber(accountNumber).getAccountId();

        if (userId != null & accountId != null) {
            AccountService.getInstance().deleteAccountByAccountId(accountId);
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
        } else {
            request.setAttribute("deleteAccountError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ACCOUNTS_CONTROL);
    }

}
