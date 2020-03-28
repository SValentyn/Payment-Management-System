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

public class CommandAdminDeleteAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showAccountError", false);
        request.setAttribute("accountHasFundsError", false);
        request.setAttribute("deleteAccountError", false);
        request.setAttribute("accountDeleted", false);

        // Data
        Account account = (Account) request.getSession().getAttribute("viewableAccount");

        // Check
        if (account == null) {
            request.setAttribute("deleteAccountError", true);
            return page;
        }

        // Data
        Integer accountId = account.getAccountId();

        // Action
        int status = AccountService.getInstance().deleteAccountByAccountId(accountId);
        if (status == -1) {
            request.setAttribute("accountHasFundsError", true);
        } else if (status == -2) {
            request.setAttribute("deleteAccountError", true);
        } else {
            request.setAttribute("showAccountError", true);
            request.setAttribute("accountDeleted", true);
            return page;
        }

        // Set Attributes
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByAccountId(accountId).isEmpty());
        request.setAttribute("cardsEmpty", BankCardService.getInstance().findCardsByAccountId(accountId).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        request.setAttribute("cards", BankCardService.getInstance().findCardsByAccountId(accountId));

        return page;
    }

}
