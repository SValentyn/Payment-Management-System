package com.system.command;

import com.system.entity.Account;
import com.system.manager.ResourceManager;
import com.system.service.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminBlockAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        request.setAttribute("blockAccountError", false);
        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());

        // Data
        String accountId = request.getParameter("accountId");

        // Check
        if (accountId == null) {
            request.setAttribute("blockAccountError", true);
            return page;
        }

        // Data
        List<Account> accounts = AccountService.getInstance().findAllAccounts();
        List<String> accountsIds = new ArrayList<>();
        for (Account account : accounts) {
            accountsIds.add(String.valueOf(account.getAccountId()));
        }

        // Check
        if (!accountsIds.contains(accountId)) {
            request.setAttribute("blockAccountError", true);
            return page;
        }

        // Action
        AccountService.getInstance().blockAccount(Integer.parseInt(accountId));

        // Set Attributes
        Account account = AccountService.getInstance().findAccountByAccountId(Integer.parseInt(accountId));
        request.setAttribute("showAccountError", false);
        request.setAttribute("account", account);
        request.setAttribute("user", UserService.getInstance().findUserById(account.getUserId()));
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.parseInt(accountId)).isEmpty());
        request.setAttribute("cardsEmpty", BankCardService.getInstance().findAllCardsByAccountId(Integer.parseInt(accountId)).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(Integer.parseInt(accountId)));
        request.setAttribute("cards", BankCardService.getInstance().findAllCardsByAccountId(Integer.parseInt(accountId)));

        return page;
    }

}
