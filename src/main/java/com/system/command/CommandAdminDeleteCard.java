package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;
import com.system.service.PaymentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminDeleteCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("deleteCardError", false);

        String cardId = request.getParameter("cardId");
        String userId = (String) request.getSession().getAttribute("userId");
        Integer accountId = CreditCardService.getInstance().findCardByCardId(Integer.valueOf(cardId)).getAccountId();

        if (userId != null) {
            CreditCardService.getInstance().deleteCardById(Integer.parseInt(cardId));

            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
            request.setAttribute("cards", CreditCardService.getInstance().findCardsByAccountId(accountId));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        } else {
            request.setAttribute("deleteCardError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ACCOUNTS_CONTROL);
    }

}
