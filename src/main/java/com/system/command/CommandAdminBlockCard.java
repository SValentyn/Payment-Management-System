package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminBlockCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("blockCardError", false);

        String userId = (String) request.getSession().getAttribute("userId");
        String cardNumber = request.getParameter("cardNumber");
        Integer accountId = CreditCardService.getInstance().findCardByCardNumber(cardNumber).getAccountId();

        if (cardNumber != null) {
            CreditCardService.getInstance().blockCreditCard(cardNumber);

            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId)));
            request.setAttribute("cards", CreditCardService.getInstance().findAllCardsByAccountId(accountId));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        } else {
            request.setAttribute("blockCardError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ACCOUNTS_CONTROL);
    }

}
