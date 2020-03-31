package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminAttachAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_ACCOUNT);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("manyAccountWithThisCurrencyError", false);
        request.setAttribute("attachAccountError", false);
        request.setAttribute("attached", false);

        // Data
        String userIdParam = request.getParameter("userId");

        // Validation
        if (!Validator.checkUserId(userIdParam)) {
            request.setAttribute("attachAccountError", true);
            return page;
        }

        // Data
        Integer userId = Integer.parseInt(userIdParam);
        User user = UserService.getInstance().findUserById(userId);
        String bio = user.getName() + " " + user.getSurname();
        String number = request.getParameter("number");
        String currency = request.getParameter("currency");

        // Set Attributes
        setRequestAttributes(request, userId, bio, number, currency);

        // Actions depend on the method
        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Validation
            if (!validation(number, currency)) {
                request.setAttribute("attachAccountError", true);
                return page;
            }

            // Check
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(userId);
            for (Account account : accounts) {
                if (account.getNumber().equals(number)) {
                    request.setAttribute("attachAccountError", true);
                    return page;
                }
            }

            // Check
            // Condition: the user cannot have more than 3 accounts with a certain currency
            int count = 0;
            for (Account account : accounts) {
                if (account.getCurrency().equals(currency)) count++;
            }

            if (count == 3) {
                request.setAttribute("manyAccountWithThisCurrencyError", true);
                return page;
            }

            int status = AccountService.getInstance().createAccount(userId, number, currency);
            if (status == 0) {
                request.setAttribute("attachAccountError", true);
            } else {
                request.setAttribute("attached", true);
            }
        }

        return page;
    }

    private boolean validation(String number, String currency) {
        return Validator.checkAccountNumber(number) &&
                Validator.checkCurrency(currency);
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId, String bio, String number, String currency) {
        request.setAttribute("userId", userId);
        request.setAttribute("bioValue", bio);
        request.setAttribute("numberValue", number);
        request.setAttribute("currencyValue", currency);
    }

}
