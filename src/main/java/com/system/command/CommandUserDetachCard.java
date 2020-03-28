package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.BankCardService;
import com.system.service.PaymentService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserDetachCard implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER);

        request.setAttribute("detachCardError", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));

        String cardNumber = request.getParameter("cardNumber");

        if (cardNumber != null) {
            Integer accountId = BankCardService.getInstance().findCardByCardNumber(cardNumber).getAccountId();
            BankCardService.getInstance().deleteCardByNumber(cardNumber);

            request.setAttribute("showAccounts", true);
            request.setAttribute("showAccountInfo", true);
            request.setAttribute("accounts", AccountService.getInstance().findAllAccountsByUserId(user.getUserId()));
            request.setAttribute("cards", BankCardService.getInstance().findCardsByAccountId(accountId));
            request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        } else {
            request.setAttribute("detachCardError", true);
        }

        return page;
    }

}
