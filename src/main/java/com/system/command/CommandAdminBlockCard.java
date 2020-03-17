package com.system.command;

import com.system.entity.Account;
import com.system.manager.ResourceManager;
import com.system.service.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminBlockCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        request.setAttribute("blockCardError", false);
        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());

        // Data
        String cardNumber = request.getParameter("cardNumber");
        Integer accountId = BankCardService.getInstance().findCardByCardNumber(cardNumber).getAccountId();

        // Check
        if (cardNumber == null) {
            request.setAttribute("blockCardError", true);
            return page;
        }

        // Data
        List<Account> accounts = AccountService.getInstance().findAllAccounts();
        List<Integer> accountsIds = new ArrayList<>();
        for (Account account : accounts) {
            accountsIds.add(account.getAccountId());
        }

        // Check
        if (!accountsIds.contains(accountId)) {
            request.setAttribute("blockCardError", true);
            return page;
        }

        // Action
        BankCardService.getInstance().blockBankCard(cardNumber);

        // Set Attributes
        Account account = AccountService.getInstance().findAccountByAccountId(accountId);
        request.setAttribute("account", account);
        request.setAttribute("user", UserService.getInstance().findUserById(account.getUserId()));
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByAccountId(accountId).isEmpty());
        request.setAttribute("cardsEmpty", BankCardService.getInstance().findAllCardsByAccountId(accountId).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        request.setAttribute("cards", BankCardService.getInstance().findAllCardsByAccountId(accountId));
        request.setAttribute("showAccountError", false);

        return page;
    }

}
