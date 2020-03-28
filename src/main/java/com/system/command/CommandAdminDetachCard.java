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

public class CommandAdminDetachCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showAccountError", false);
        request.setAttribute("detachCardError", false);
        request.setAttribute("cardDetached", false);

        // Data
        String cardNumber = request.getParameter("cardNumber");

        // Check
        if (cardNumber == null) {
            request.setAttribute("detachCardError", true);
            return page;
        }

        // Data
        Account account = (Account) request.getSession().getAttribute("viewableAccount");

        // Check
        if (account == null) {
            request.setAttribute("detachCardError", true);
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
            request.setAttribute("detachCardError", true);
            return page;
        }

        // Data
        Integer cardId = BankCardService.getInstance().findCardByCardNumber(cardNumber).getCardId();

        // Action
        int status = BankCardService.getInstance().deleteCardById(cardId);
        if (status == 0) {
            request.setAttribute("detachCardError", true);
        } else {
            request.setAttribute("cardDetached", true);
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
