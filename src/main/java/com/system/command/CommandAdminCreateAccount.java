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

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_ACCOUNT);

        request.setAttribute("attached", false);
        request.setAttribute("numberExistError", false);
        request.setAttribute("attachAccountError", false);

        // Data
        String userId = request.getParameter("userId");
        String number = request.getParameter("number");

        // Check
        if (userId != null) {
            request.getSession().setAttribute("userId", userId);
            request.setAttribute("userId", userId);
            User user = UserService.getInstance().findUserById(Integer.valueOf(userId));
            request.setAttribute("bio", user.getName() + " " + user.getSurname());
        } else {
            request.setAttribute("number", number);
            request.setAttribute("attachAccountError", true);
            return page;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Check
            if (checkNumber(request, number)) {
                request.setAttribute("number", number);
                return page;
            }

            // Check
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
                request.setAttribute("attachAccountError", true);
            } else {
                request.setAttribute("accountId", status);
                request.setAttribute("attached", true);
            }
        }

        return page;
    }

    private boolean checkNumber(HttpServletRequest request, String number) {
        if (number == null || number.isEmpty() || !Validator.checkAccountNumber(number)) {
            request.setAttribute("numberError", true);
            return true;
        }
        return false;
    }

}
