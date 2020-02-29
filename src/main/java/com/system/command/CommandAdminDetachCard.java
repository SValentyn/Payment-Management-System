package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.LetterService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminDetachCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("detachCardError", false);

        String userId = (String) request.getSession().getAttribute("userId");
        String cardNumber = request.getParameter("cardNumber");
        Integer cardId = CreditCardService.getInstance().findCardByCardNumber(cardNumber).getCardId();
        Integer accountId = CreditCardService.getInstance().findCardByCardNumber(cardNumber).getAccountId();

        if (userId != null) {
            CreditCardService.getInstance().deleteCardById(cardId);

            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId)));
            request.setAttribute("cards", CreditCardService.getInstance().findAllCardsByAccountId(accountId));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        } else {
            request.setAttribute("detachCardError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ACCOUNTS_CONTROL);
    }

}
