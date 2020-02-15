package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminAttachAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ATTACH_ACCOUNT);

        request.setAttribute("attached", false);
        request.setAttribute("attachAccountError", false);

        // Data
        String userId = request.getParameter("userId");
        String number = request.getParameter("number");
        String currency = request.getParameter("currency");

        // Check
        if (userId != null) {
            User user = UserService.getInstance().findUserById(Integer.valueOf(userId));
            String name = user.getName();
            String surname = user.getSurname();

            request.getSession().setAttribute("userId", userId);
            request.setAttribute("userId", userId);
            request.setAttribute("bio", name + " " + surname);
        } else {
            request.setAttribute("numberValue", number);
            request.setAttribute("currencyValue", currency);
            request.setAttribute("attachAccountError", true);
            return page;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Check
            List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(Integer.valueOf(userId));
            for (Account account : accounts) {
                if (account.getNumber().equals(number)) {
                    request.setAttribute("numberValue", number);
                    request.setAttribute("currencyValue", currency);
                    request.setAttribute("numberExistError", true);
                    return page;
                }
            }

            request.setAttribute("accounts", accounts);

            int status = AccountService.getInstance().createAccount(Integer.parseInt(userId), number, currency);
            if (status == 0) {
                request.setAttribute("numberValue", number);
                request.setAttribute("currencyValue", currency);
                request.setAttribute("attachAccountError", true);
            } else {
                request.setAttribute("accountId", status);
                request.setAttribute("attached", true);
            }
        }

        return page;
    }

}
