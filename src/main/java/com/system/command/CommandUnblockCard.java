package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.CreditCardService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUnblockCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        String cardNumber = request.getParameter("cardNumber");
        if (cardNumber != null) {
            CreditCardService.getInstance().unblockCreditCard(cardNumber);
        }

        request.setAttribute("showAccounts", true);
        String userId = (String) request.getSession().getAttribute("userId");
        if (userId != null) {
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(Integer.parseInt(userId)));
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.SHOW_USER_ACCOUNTS);
    }

}
