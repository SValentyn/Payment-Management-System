package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminUnblockCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("unblockCardError", false);

        String userId = (String) request.getSession().getAttribute("userId");
        String cardNumber = request.getParameter("cardNumber");
        int accountId = CreditCardService.getInstance().findCardByCardNumber(cardNumber).getAccountId();

        if (cardNumber != null) {
            CreditCardService.getInstance().unblockCreditCard(cardNumber);

            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
            request.setAttribute("cards", CreditCardService.getInstance().findAllCardsByAccountId(accountId));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        } else {
            request.setAttribute("unblockCardError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ACCOUNTS_CONTROL);
    }

}
