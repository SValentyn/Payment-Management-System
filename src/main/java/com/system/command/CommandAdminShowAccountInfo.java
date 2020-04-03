package com.system.command;

import com.system.entity.Account;
import com.system.manager.ResourceManager;
import com.system.service.*;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminShowAccountInfo implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNT_INFO);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showAccountError", false);

        // Data
        String accountIdParam = request.getParameter("accountId");

        // Validation
        if (!Validator.checkAccountId(accountIdParam)) {
            request.setAttribute("showAccountError", true);
            return page;
        }

        // Data
        Integer accountId = Integer.valueOf(accountIdParam);

        // Set Attributes
        setRequestAttributes(request, accountId);

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, Integer accountId) throws SQLException {
        Account viewableAccount = AccountService.getInstance().findAccountByAccountId(accountId);
        request.setAttribute("viewableAccount", AccountService.getInstance().findAccountByAccountId(accountId));
        request.setAttribute("viewableUser", UserService.getInstance().findUserById(viewableAccount.getUserId()));
        request.setAttribute("paymentsEmpty", PaymentService.getInstance().findAllPaymentsByAccountId(accountId).isEmpty());
        request.setAttribute("cardsEmpty", BankCardService.getInstance().findCardsByAccountId(accountId).isEmpty());
        request.setAttribute("payments", PaymentService.getInstance().findAllPaymentsByAccountId(accountId));
        request.setAttribute("cards", BankCardService.getInstance().findCardsByAccountId(accountId));
    }

}
