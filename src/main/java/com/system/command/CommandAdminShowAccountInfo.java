package com.system.command;

import com.system.entity.Account;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.service.LetterService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminShowAccountInfo implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showAccountError", false);

        // Data
        String accountId = request.getParameter("accountId");

        // Check
        if (accountId == null) {
            request.setAttribute("showAccountError", true);
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
            request.setAttribute("showAccountError", true);
            return page;
        }

        // Data
        Integer accountIdInt = Integer.valueOf(accountId);

        // Set Attributes
        request.getSession().setAttribute("viewableAccount", AccountService.getInstance().findAccountByAccountId(accountIdInt));
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByAccountId(accountIdInt).isEmpty());
        request.setAttribute("cardsEmpty", BankCardService.getInstance().findCardsByAccountId(accountIdInt).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountIdInt));
        request.setAttribute("cards", BankCardService.getInstance().findCardsByAccountId(accountIdInt));

        return page;
    }

}
