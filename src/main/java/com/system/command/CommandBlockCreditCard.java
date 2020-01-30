package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandBlockCreditCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        User user = (User) request.getSession().getAttribute("currentUser");
        String cardNumber = request.getParameter("cardNumber");
        if (cardNumber != null) {
            CreditCardService.getInstance().blockCreditCard(cardNumber);
        }

        request.setAttribute("showAccounts", true);
        request.setAttribute("showAccountInfo", true);
        request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
        int accountId = CreditCardService.getInstance().findCardByCardNumber(cardNumber).getAccountId();
        request.setAttribute("cards", CreditCardService.getInstance().findCardsByAccountId(accountId));
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));

        return ResourceManager.getInstance().getProperty(ResourceManager.HOME);
    }

}
