package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.LetterService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
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
        Integer userId;
        String bio, number, currency;
        User user = (User) request.getSession().getAttribute("viewableUser");

        // Check
        if (user == null) {
            request.setAttribute("attachAccountError", true);
            return page;
        }

        // Data
        List<User> users = UserService.getInstance().findAllUsers();
        List<Integer> usersIds = new ArrayList<>();
        for (User aUser : users) {
            usersIds.add(aUser.getUserId());
        }

        // Check
        if (!usersIds.contains(user.getUserId())) {
            request.setAttribute("attachAccountError", true);
            return page;
        }

        // Data
        userId = user.getUserId();
        bio = user.getName() + " " + user.getSurname();
        number = request.getParameter("number");
        currency = request.getParameter("currency");

        // Set Attributes
        setRequestAttributes(request, bio, number, currency);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Server Validation
            if (number == null || number.length() < 20 || currency == null || currency.equals("")) {
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
                request.setAttribute("accountId", status);
                request.setAttribute("attached", true);
            }
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String bio, String number, String currency) {
        request.setAttribute("bioValue", bio);
        request.setAttribute("numberValue", number);
        request.setAttribute("currencyValue", currency);
    }

}
