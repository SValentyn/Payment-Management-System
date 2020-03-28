package com.system.command;

import com.system.entity.Account;
import com.system.entity.BankCard;
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

public class CommandAdminBlockCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showAccountError", false);
        request.setAttribute("blockCardError", false);
        request.setAttribute("cardBlocked", false);

        // Data
        String cardNumber = request.getParameter("cardNumber");

        // Check
        if (cardNumber == null) {
            request.setAttribute("blockCardError", true);
            return page;
        }

        // Data
        Account account = (Account) request.getSession().getAttribute("viewableAccount");

        // Check
        if (account == null) {
            request.setAttribute("blockCardError", true);
            return page;
        }

        // Data
        Integer accountId = account.getAccountId();
        List<BankCard> cards = BankCardService.getInstance().findCardsByAccountId(accountId);
        List<String> cardNumbers = new ArrayList<>();
        for (BankCard card : cards) {
            cardNumbers.add(card.getNumber());
        }

        // Check
        if (!cardNumbers.contains(cardNumber)) {
            request.setAttribute("blockCardError", true);
            return page;
        }

        // Data
        Integer cardId = BankCardService.getInstance().findCardByCardNumber(cardNumber).getCardId();

        // Action
        int status = BankCardService.getInstance().blockBankCard(cardId);
        if (status == 0) {
            request.setAttribute("blockCardError", true);
        } else {
            request.setAttribute("cardBlocked", true);
        }

        // Set Attributes
        request.getSession().setAttribute("viewableAccount", AccountService.getInstance().findAccountByAccountId(account.getAccountId()));
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByAccountId(accountId).isEmpty());
        request.setAttribute("cardsEmpty", BankCardService.getInstance().findCardsByAccountId(accountId).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        request.setAttribute("cards", BankCardService.getInstance().findCardsByAccountId(accountId));

        return page;
    }

}
