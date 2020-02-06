package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminCreateAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_CREATE_ACCOUNT);

        request.setAttribute("created", false);
        request.setAttribute("numberExistError", false);
        request.setAttribute("createAccountError", false);

        // Data
        String userId = request.getParameter("userId");
        String number = request.getParameter("number");

        // Check
        if (userId != null) {
            request.getSession().setAttribute("userId", userId);
            User user = UserService.getInstance().findUserById(Integer.valueOf(userId));
            String bio = user.getSurname() + " " + user.getName();
            request.setAttribute("userId", userId);
            request.setAttribute("bio", bio);
        } else {
            request.setAttribute("number", number);
            request.setAttribute("createAccountError", true);
            return page;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Check
            if (checkNumber(request, number)) {

                return page;
            }

            List<Account> allAccounts = AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId));
            for (Account account : allAccounts) {
                if (account.getNumber().equals(number)) {
                    request.setAttribute("number", number);
                    request.setAttribute("numberExistError", true);
                    return page;
                }
            }

            request.setAttribute("accounts", allAccounts);

            int status = AccountService.getInstance().createAccount(Integer.parseInt(userId), number);
            if (status == 0) {
                request.setAttribute("number", number);
                request.setAttribute("createAccountError", true);
            } else {
                request.setAttribute("accountId", status);
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private boolean checkNumber(HttpServletRequest request, String number) {
        if (number == null || number.isEmpty() || !Validator.checkAccountNumber(number)) {
            request.setAttribute("number", number);
            request.setAttribute("numberError", true);
            return true;
        }
        return false;
    }

}
